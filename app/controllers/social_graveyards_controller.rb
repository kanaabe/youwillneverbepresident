class SocialGraveyardsController < ApplicationController
  def index
    @user = User.new
    if session[:old_email] != ""
      @user.old_email = session[:old_email]
      @myspace_photo = @user.get_myspace_photo
    end

    if session[:fb_auth] != nil
      @facebook_statuses = @user.get_facebook_status_dirt(session[:fb_auth])
      @facebook_photos = @user.get_facebook_photo_dirt
      @facebook_name = @user.get_name
      @fb_percentage = (@user.get_facebook_photo_dirt.size / @user.total_fb_photo_count.to_f).round(3)
    end
  end

  def results
    session[:old_email] = params[:old_email]
  end
end
