class User < ActiveRecord::Base
  has_many :feed_items

  def feed
    "https://audioboom.com/users/#{uid}/boos.rss"
  end

  validates :uid, presence: true
  validates :username, presence: true
end
