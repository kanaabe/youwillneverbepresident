class User

  attr_accessor :old_email, :facebook

  def self.koala(auth)
  	access_token = auth['token']
  	facebook = FacebookDirt.new(access_token)
  end

  def fb_username
    @facebook = FacebookDirt.new(auth['token'])
  end

  def get_facebook_status_dirt(auth)
  	@facebook = FacebookDirt.new(auth['token'])
  	@facebook.obscene_statuses
  end

  def get_facebook_photo_dirt
    @facebook.obscene_photos
  end

  def total_fb_photo_count
    FacebookDirt.total_photos 
  end

  def get_name
    @facebook.get_name
  end

  def get_myspace_photo
    myspace_user = Myspace.new(@old_email)
    myspace_user.scrape_myspace_for_profile_photo
  end
end
