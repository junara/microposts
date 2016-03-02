class UsersController < ApplicationController
  before_action :logged_in_current_user, only: [:edit, :update]
  
  def show 
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end

  def new
    @user = User.new #モデルは大文字単数
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id]) #モデルは大文字単数

  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Update success"
      render 'show'
    else
      flash[:success] = "Update failed"
      render 'edit'
    end
  end

  def followings #userがフォローしている人を取得する
    @user = User.find(params[:id])
    @followings = @user.following_users.order(created_at: :desc)

    render 'followings'
  end
  
  def followers #userがフォローされている人を取得する
    @user = User.find(params[:id])
    @followers = @user.follower_users.order(created_at: :desc)
  end
  
  

  private

  def user_params
    params.require(:user).permit( :name , :email , :password , :password_confirmation , :profile , :location)
  end
  
  def logged_in_current_user
      logged_in_user # @current_userがnilの場合は以下は実行しない。
      @current_user ||= User.find_by(id: session[:user_id]) #edit updateでは不要。showでは必要
      unless @current_user.id.to_s == params[:id] #@current_userがnilの時はerrorが出る。
        store_location
        flash[:danger] = "Invalid access !"
        redirect_to root_url
      end
  end  
end
