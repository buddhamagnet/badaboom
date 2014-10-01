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
        feed = Feedjira::Feed.fetch_and_parse(user.feed << "?page=#{page}")
        sleep 2
        if feed && feed.entries.any?
          feed.entries.each do |entry|
            puts "Processing boo: #{entry.title}"
            user.feed_items.create!(
              title: entry.title,
              link: entry.url,
              description: entry.summary,
              published: entry.published
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