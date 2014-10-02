class FeedItem < ActiveRecord::Base

  belongs_to :user

  def uid
    user.uid
  end

  def file_date
    published.strftime
  end

  def file_title
    title.parameterize
  end
end
