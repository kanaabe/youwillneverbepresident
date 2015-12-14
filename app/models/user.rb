class User

  attr_accessor :twitter_handle, :old_email, :facebook

  def get_all_tweets
    puts "User#get_all_tweets"
    twitter_user = TwitterDirt.new(@twitter_handle)
    puts "back in User#get_all_tweets"
    twitter_user.get_user_timeline
  end

  def get_twitter_dirt
    puts 'User#get_twitter_dirt'
    twitter_user = TwitterDirt.new(@twitter_handle)
    twitter_user.obscene_tweets
  end

  def get_twitter_photo
    puts 'User#get_twitter_photo'
    twitter_user = TwitterDirt.new(@twitter_handle)
    twitter_user.twitter_client.user(@twitter_handle).profile_image_url.to_s.gsub("_normal","")
  end

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
