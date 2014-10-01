class AddMetadataToFeeItem < ActiveRecord::Migration
  def change
    add_column :feed_items, :dc_creator, :string
    add_column :feed_items, :itunes_author, :string
    add_column :feed_items, :itunes_duration, :string
    add_column :feed_items, :itunes_explicit, :boolean
    add_column :feed_items, :itunes_keywords, :string
    add_column :feed_items, :media_rights, :string
  end
end
