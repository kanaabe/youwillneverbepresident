class UsersController < ApplicationController
  def new
    
  end

  def index
    @user = User.new
    @user.twitter_handle = params[:twitter_handle]
    @tweets = @user.get_twitter_dirt
  end

  def login
    @user = User.koala(request.env['omniauth.auth']['credentials'])
  end


  private
  def user_params
    params.require(:user).permit(:twitter)
  end
end
