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
      1.upto(args[:pages].to_i) do |page|
        puts "Processing page #{page}"
        metadata_for_feed
        feed = Feedjira::Feed.fetch_and_parse(user.feed << "?page=#{page}")
        sleep 2
        if feed && feed.entries.any?
          feed.entries.each do |entry|
            puts "Processing boo: #{entry.title}"
            user.feed_items.create!(
              title: entry.title,
              link: entry.url,
              description: entry.summary,
              published: entry.published,
              file: entry.enclosure_url,
              keywords: entry.media_keywords,
              geo: entry.geo
            )
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

def metadata_for_feed
  elements = {
    'georss:point' => :geo,
    'itunes:keywords' => :itunes_keywords,
    'itunes:author' => :itunes_author,
    'itunes:explicit' => :itunes_explcit,
    'itunes:keywords' => :itunes_keywords,
    'dc:creator' => :dc_creator,
    'media:keywords' => :media_keywords,
    'media:rights' => :media_rights
  }
  elements.each do |key, value|
    Feedjira::Feed.add_common_feed_entry_element(key, :as => value)
  end
end
