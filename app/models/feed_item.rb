class FeedItem < ActiveRecord::Base

  belongs_to :user

  def uid
    user.uid
  end
end
