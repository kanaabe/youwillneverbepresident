class User
  attr_accessor :twitter_handle

  def get_twitter_dirt
    twitter_user = TwitterDirt.new(@twitter_handle)
    twitter_user.obscene_tweets
  end
end
