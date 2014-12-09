class UsersController < ApplicationController
  
  def new  
  end

  def results
    session[:twitter_handle] = params[:twitter_handle]
    session[:old_email] = params[:old_email]
  end

  def index
    @user = User.new
    if session[:twitter_handle] != ""
      @user.twitter_handle = session[:twitter_handle]
      @tweets = @user.get_twitter_dirt
    end
    
    if session[:old_email] != ""
      @user.old_email = session[:old_email]
      @myspace_photo = @user.get_myspace_photo
    end

    if session[:fb_auth] != nil
      @facebook_statuses = @user.get_facebook_status_dirt(session[:fb_auth])
      @facebook_photos = @user.get_facebook_photo_dirt
    end
    render :results
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
