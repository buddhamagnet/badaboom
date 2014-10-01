xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Badaboom feed for #{@user.username}"
    xml.description "Extracted boo metadata suck that up"
    xml.link @user.feed
    for entry in @feed_items
      xml.item do
        xml.title entry.title
        xml.link entry.link
        xml.description entry.description
        xml.pubDate entry.published.to_s(:rfc822)
        xml.enclosure(url: entry.file)
      end
    end
  end
end