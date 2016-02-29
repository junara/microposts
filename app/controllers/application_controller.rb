class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :logged_in_user, only: [:edit, :update ]
  before_action :logged_in_current_user, only: [:edit, :update]


private
    def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
    end
    
    def logged_in_current_user
        logged_in_user # @current_userがnilの場合は以下は実行しない。
        @current_user ||= User.find_by(id: session[:user_id]) #edit updateでは不要。showでは必要
        unless @current_user.id.to_s == params[:id] #@current_userがnilの時はerrorが出る。
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
        
    end
end
