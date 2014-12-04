class UsersController < ApplicationController
  def new
    
  end

  def index
    @user = User.new
    @user.twitter_handle = params[:twitter_handle]
    @user.old_email = params[:old_email]
    @tweets = @user.get_twitter_dirt
    @myspace_photo = @user.get_myspace_photo
  end

  def login
    #@user = User.koala(request.env['omniauth.auth']['credentials'])
    @user = User.koala('')
    redirect_to root_path
  end


  private
  def user_params
    params.require(:user).permit(:twitter)
  end
end
