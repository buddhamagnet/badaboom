class AddRemoteFileToFeedItems < ActiveRecord::Migration
  def change
    add_column :feed_items, :remote_file, :string
  end
end
