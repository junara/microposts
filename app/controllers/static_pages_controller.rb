class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build if logged_in?
      @feed_items = current_user.feed_items.includes(:user)
        .order(created_at: :desc)
        .paginate(:page => params[:page], :per_page => 5) #will_paginateを使用し、5投稿毎にページ訳
    end
  end
end
