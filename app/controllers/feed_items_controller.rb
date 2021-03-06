class FeedItemsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @feed_items = @user.feed_items
    respond_to do |format|
      format.html
      format.rss { render layout: false }
    end
  end

  def show
    @user = User.find(params[:user_id])
    @feed_item = @user.feed_items.find(params[:id])
  end
end
