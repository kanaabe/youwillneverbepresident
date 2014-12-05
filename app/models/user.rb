class User

  attr_accessor :twitter_handle, :old_email, :facebook

  def get_twitter_dirt
    twitter_user = TwitterDirt.new(@twitter_handle)
    twitter_user.obscene_tweets
  end

  def self.koala(auth)
  	access_token = auth['token']
  	facebook = FacebookDirt.new(access_token)
  end

  def get_facebook_status_dirt(auth)
  	@facebook = FacebookDirt.new(auth['token'])
  	@facebook.obscene_statuses
  end

  def get_facebook_photo_dirt
    @facebook.obscene_photos
  end

  def get_myspace_photo
    myspace_user = Myspace.new(@old_email)
    myspace_user.scrape_myspace_for_profile_photo
  end
end
