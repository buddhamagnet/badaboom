namespace :bada do
  desc 'Export data and files from Audioboo(m)'
  task :boom, [:uid,:pages] => [:environment] do |t, args|
    user = User.where("uid = :uid", uid: args[:uid]).first

    if user && user.feed_items.any?
      puts 'Deleting stale feed entries'
      user.feed_items.delete_all
    end

    if user
      puts "Processing feed at endpoint: #{user.feed}"
      Pusher.trigger('bada_channel', 'bada_event', {message: "EXPORT IN PROGRESS..."})
      1.upto(args[:pages].to_i) do |page|
        puts "Processing page #{page}"
        metadata_for_feed
        feed = Feedjira::Feed.fetch_and_parse(user.feed << "?page=#{page}")
        sleep 2
        if feed && feed.entries.any?
          feed.entries.each do |entry|
            puts "Processing boo: #{entry.title}"
            feed_item = create_entry(user, entry)
            Pusher.trigger('bada_channel', 'count_event', {uid: user.uid, count: user.feed_items.count})
          end
        else
          puts "No more entries found"
          exit
        end
      end
      user.save
    else
      puts "No user found"
    end
  end
end

def create_entry(user, entry)
  user.feed_items.create!(
    dc_creator: entry.dc_creator,
    description: entry.summary,
    file: entry.enclosure_url,
    geo: entry.geo,
    itunes_author: entry.itunes_author,
    itunes_duration: entry.itunes_duration,
    itunes_explicit: entry.itunes_explicit,
    itunes_keywords: entry.itunes_keywords,
    keywords: entry.media_keywords,
    link: entry.url,
    media_rights: entry.media_rights,
    published: entry.published,
    title: entry.title
  )
end

def metadata_for_feed
  elements = {
    'georss:point' => :geo,
    'itunes:keywords' => :itunes_keywords,
    'itunes:author' => :itunes_author,
    'itunes:explicit' => :itunes_explcit,
    'itunes:keywords' => :itunes_keywords,
    'itunes:duration' => :itunes_duration,
    'dc:creator' => :dc_creator,
    'media:keywords' => :media_keywords,
    'media:rights' => :media_rights
  }
  elements.each do |key, value|
    Feedjira::Feed.add_common_feed_entry_element(key, :as => value)
  end
end
