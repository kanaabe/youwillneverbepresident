class User
  attr_accessor :twitter_handle, :email

  def get_twitter_dirt
    twitter_user = TwitterDirt.new(@twitter_handle)
    twitter_user.obscene_tweets
  end

  def self.koala(auth)
  	access_token = auth['token']
  	facebook = Koala::Facebook::API.new(access_token)
  	facebook.get_object("me?fields=name,picture")
  end

end
