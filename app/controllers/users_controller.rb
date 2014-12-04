class UsersController < ApplicationController
  def new
    
  end

  def index
    @user = User.new
    @user.twitter_handle = params[:twitter_handle]
    @user.email = params[:email]
    @tweets = @user.get_twitter_dirt
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
