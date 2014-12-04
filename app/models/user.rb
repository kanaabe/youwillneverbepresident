class User
  attr_accessor :twitter_handle, :email, :facebook

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

end
