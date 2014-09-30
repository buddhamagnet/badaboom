class User < ActiveRecord::Base

  def feed
    "https://audioboom.com/users/#{uid}/boos.rss"
  end

  validates :uid, presence: true
  validates :username, presence: true
end
