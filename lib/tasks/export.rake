namespace :bada do
  desc 'Export data and files from Audioboo(m)'
  task :boom, [:uid] => [:environment] do |t, args|
    user = User.where("uid = :uid", uid: args[:uid]).first
    
    if user.feed_items.any?
      puts 'Deleting stale feed entries'
      user.feed_items.delete_all
    end
    
    if user
      Pusher.trigger('bada_channel', 'bada_event', message: 'EXPORT IN PROGRESS')
      puts "Processing feed at endpoint: #{user.feed}"
      feed = Feedjira::Feed.fetch_and_parse(user.feed)
      puts "Complete parsing"
      puts "Feed title: #{feed.title}"
      puts "Number of entries: #{feed.entries.size}"
      puts "Processing feed entries"
      feed.entries.each do |entry|
        puts "TITLE: #{entry.title}"
        puts "URL: #{entry.url}"
        puts "PUBLISHED: #{entry.published}"
        puts "FILE: #{entry.enclosure_url}"
        user.feed_items.create!(
          title: entry.title,
          link: entry.url,
          description: entry.summary,
          published: entry.published
        )
      end
      user.save
    else
      puts "No user found"
    end
  end
end