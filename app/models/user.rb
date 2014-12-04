class User
  attr_accessor :twitter_handle, :old_email

  def get_twitter_dirt
    twitter_user = TwitterDirt.new(@twitter_handle)
    twitter_user.obscene_tweets
  end

  def self.koala(auth)
  	#access_token = auth['token']
  	access_token = 'CAACEdEose0cBAJatZCfE36xorDARF0xKGoIplYhiBqMVpThOVVpjZCFrMZAQb76faWG9lPG49Ake2Or4ZAjRd7HPoJ7pQwliaE34dkAiccJIM7tk3AZAAh5aPbRoYXVsRfMK69SLXiKOqWrCgGBLoGKR2Ydtan6T2h78SJjxZCvYojtmm5UZCDXdwgEydKZAgVqAO2feaNy9FLQmnZBbq66RCAOnQlrvpBZB4ZD'
  	facebook = Koala::Facebook::API.new(access_token)
  	facebook.get_object("me?fields=name,picture")
  end


  def get_myspace_photo
    myspace_user = Myspace.new(@old_email)
    myspace_user.scrape_myspace_for_profile_photo
  end
end
