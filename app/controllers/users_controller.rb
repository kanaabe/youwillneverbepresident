class UsersController < ApplicationController

  def results
    session[:twitter_handle] = params[:twitter_handle]
  end

  def index
    @user = User.new
    @user.twitter_handle = session[:twitter_handle]
    @tweets = @user.get_twitter_dirt
    @all_tweets = @user.get_all_tweets
    @all_tweets.size > 0 ? @twitter_percentage = (@tweets.size.to_f/@all_tweets.size.to_f).round(3) : @twitter_percentage = 0
    @twitter_photo = @user.get_twitter_photo
    
    render :results
  end

  def login
    session[:fb_auth] = request.env['omniauth.auth']['credentials']
    redirect_to beta_path
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
