class CreateFeedItems < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.references :user, index: true
      t.string :title
      t.string :link
      t.text :description
      t.date :published
      t.string :file
      t.string :geo
      t.text :keywords

      t.timestamps
    end
  end
end
