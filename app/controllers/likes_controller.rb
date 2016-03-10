class LikesController < ApplicationController
    before_action :logged_in_user
    
    def create
        @micropost = Micropost.find(params[:likedmicropost_id])
        current_user.like_add(@micropost)
    end

    def destroy
        @micropost = Micropost.find(params[:likedmicropost_id])
        current_user.like_del(@micropost)
    end
end
