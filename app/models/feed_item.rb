class FeedItem < ActiveRecord::Base

  belongs_to :user

  mount_uploader :remote_file, BooUploader

  def uid
    user.uid
  end
end
