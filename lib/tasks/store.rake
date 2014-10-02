require 'open-uri'

namespace :bada do
  desc 'Export data and files from Audioboo(m)'
  task :store, [:uid] => [:environment] do |t, args|
    user = User.where("uid = :uid", uid: args[:uid]).first

    if user && user.feed_items.any?
      puts "Downloading files at endpoint: #{user.feed}"
      user.feed_items.each do |feed_item|
        puts "Processing file #{feed_item.file}"
        processed_filename = "#{feed_item.published.strftime}-#{feed_item.title.parameterize}.mp3"
        tempfile = File.new("tmp/#{processed_filename}", 'wb');

        File.open(tempfile, 'wb') do |file|
          open(feed_item.file, "rb") do |remote|
            file.write(remote.read)
          end
        end
        feed_item.update_attributes(processed_filename: processed_filename)
      end
    else
      puts "No feed items found"
    end
  end
end
