require 'open-uri'

namespace :bada do
  desc 'Export data and files from Audioboo(m)'
  task :store, [:uid] => [:environment] do |t, args|
    user = User.where("uid = :uid", uid: args[:uid]).first

    if user && user.feed_items.any?

      connection = Fog::Storage.new({
        provider: 'AWS',
        aws_access_key_id: 'AKIAIXTL5E32YBBDWICQ',
        aws_secret_access_key: '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'
      })

      puts "Downloading files at endpoint: #{user.feed}"
      user.feed_items.each do |feed_item|
        puts "Processing file #{feed_item.file}"
        processed_filename = "#{feed_item.published.strftime}-#{feed_item.title.parameterize}.mp3"
        tempfile = File.new("tmp/#{processed_filename}", 'wb');

        File.open(tempfile, 'wb') do |file|
          open(feed_item.file, "rb") do |remote|
            data = remote.read
            file.write(data)
            #directory = connection.directories.get('audioboom')
            #directory.files.create(
            #  key: processed_filename,
            #  body: data,
            #  public: true
            #)
          end
        end
        feed_item.update_attributes(processed_filename: processed_filename)
      end
    else
      puts "No feed items found"
    end
  end
end
