class TwitterDirt
  attr_accessor :twitter_client
  def initialize(handle)
    p "TwitterDirt.new"
    @twitter_client = initialize_twitter_client
    @tweets_per_page = 100.0
    @handle = handle
    Obscenity::Base.whitelist   = ["aids", "baller", "balling", 
        "big baller", "bigballer", "cocaine", "condom", 
        "crap", "devil", "eggplant", "drugs", "flip",
        "hell", "genocide", "ho", "kill", "lsd", "marijuana",
        "murder", "pcp", "psilocybin", "redneck", "slope",
        "suicide", "transvestite", "transexual", "#yolo", "yolo",
        "drunk","wasted","#wasted","weed","bong", "funnel", "kegstand",
        "keg stand","party","21st birthday", "hipster", "pimp"]
  end

  def number_of_pages
    p "TwitterDirt#number_of_pages"
    (((twitter_client.user(@handle).tweets_count)/@tweets_per_page)).ceil
  end

  def get_user_timeline
    p 'TwitterDirt#get_user_timeline'
    tweets = twitter_client.user_timeline(@handle, :count => @tweets_per_page)
    last_tweet = tweets.last.id
    i=0
    (number_of_pages - 1).times do
      p 'TwitterDirt#get_user_timeline loop'
      i+=1
      tweet_batch = twitter_client.user_timeline(@handle, :count => @tweets_per_page, :max_id => last_tweet )
      tweets << tweet_batch
      last_tweet = tweets.flatten.last.id
    end
    p "TwitterDirt#get_user_timeline loop count: #{i}"
    tweets.flatten.uniq
  end

  def obscene_tweets
    p 'TwitterDirt#obscene_tweets'
    embedded_tweets = []
    i=0
    get_user_timeline.each do |tweet|
      p 'TwitterDirt#obscene_tweets loop'
      i+=1
      if Obscenity.profane?(tweet.text)
        embedded_tweets << tweet
      end
    end
    p "TwitterDirt#obscene_tweets loop count: #{i}"
    embedded_tweets
  end


  def twitter_client
    p '! Hit Twiter API'
    @twitter_client
  end

  private
    def initialize_twitter_client
      p "!!! TwitterDirt#initialize_twitter_client"
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['CONSUMER_KEY']
        config.consumer_secret     = ENV['CONSUMER_SECRET']
        config.access_token        = ENV['ACCESS_TOKEN']
        config.access_token_secret = ENV['ACCESS_SECRET']
      end 
    end
end