class UsersController < ApplicationController
  
  def new  
  end

  def index
    @user = User.new
    @user.twitter_handle = params[:twitter_handle]
    @user.email = params[:email]
    @tweets = @user.get_twitter_dirt
    @facebook_statuses = @user.get_facebook_status_dirt(session[:fb_auth])
  end

  def login
    session[:fb_auth] = request.env['omniauth.auth']['credentials']
    redirect_to root_path
  end

  def logout
    reset_session
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:twitter)
  end
end
