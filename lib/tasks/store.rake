require 'open-uri'
require 'tempfile'

namespace :bada do
  desc 'Export data and files from Audioboo(m)'
  task :store, [:uid] => [:environment] do |t, args|
    user = User.where("uid = :uid", uid: args[:uid]).first

    if user && user.feed_items.any?
      puts "Downloading files at endpoint: #{user.feed}"
      user.feed_items.each do |feed_item|
        puts "Processing file #{feed_item.file}"
        open(feed_item.file) do |file|
          puts "File fetched from #{file.base_uri}"
          puts "Content type: #{file.content_type}"
          tempfile = Tempfile.new('boo', Dir.tmpdir, 'wb+')
          tempfile.binmode
          tempfile.write(file.read)
          tempfile.flush
          tempfile.close
          puts "File stored at #{tempfile.path}"
        end
      end
    else
      puts "No feed items found"
    end
  end
end
