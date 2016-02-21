class UsersController < ApplicationController

  def results
    session[:twitter_handle] = params[:twitter_handle]
  end

  def index
    @user = User.new
    if session[:twitter_handle] != ""
      dirt = TwitterDirt.new(session[:twitter_handle])
      @tweets = dirt.obscene_tweets
      @all_tweets = dirt.timeline_size
      @all_tweets.size > 0 ? @twitter_percentage = (@tweets.size.to_f/@all_tweets.size.to_f).round(3) : @twitter_percentage = 0
      @twitter_photo = dirt.get_twitter_photo
    end

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
