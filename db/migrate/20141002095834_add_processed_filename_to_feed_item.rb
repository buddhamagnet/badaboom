class AddProcessedFilenameToFeedItem < ActiveRecord::Migration
  def change
    add_column :feed_items, :processed_filename, :string
  end
end
