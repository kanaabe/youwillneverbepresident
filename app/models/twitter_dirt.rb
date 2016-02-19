class TwitterDirt
  attr_accessor :twitter_client, :timeline_size
  def initialize(handle)
    @twitter_client = initialize_twitter_client; puts "Hit the initialize"
    @tweets_per_page = 200.0
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

  def twitter_client
    puts "! Request to Twitter API"
    @twitter_client
  end

  def number_of_pages
    puts 'Hit #number_of_pages'
    page_count = (((twitter_client.user(@handle).tweets_count)/@tweets_per_page)).ceil
    # Twitter only allows access to the 3200 most recent tweets 3200/200 = 16 pages
    page_count > 16 ? 16 : page_count
  end

  def get_user_timeline
    tweets = twitter_client.user_timeline(@handle, :count => @tweets_per_page); puts 'Hit #get_user_timeline'
    last_tweet = tweets.last.id
    (number_of_pages - 1).times do
      puts 'Hit #get_user_timeline/loop'
      tweet_batch = twitter_client.user_timeline(@handle, :count => @tweets_per_page, :max_id => last_tweet )
      tweets << tweet_batch
      last_tweet = tweets.flatten.last.id
    end
    self.timeline_size = tweets.flatten.uniq.size
    tweets.flatten.uniq
  end

  def obscene_tweets
    arr_of_tweets = []
    loop_count = 0
    puts 'Begin #obscene_tweets/loop'
    get_user_timeline.each do |tweet|
      if Obscenity.profane?(tweet.text)
        arr_of_tweets << tweet
      end
      loop_count += 1
    end
    puts "obscene_tweets loop: #{loop_count}"
    arr_of_tweets
  end

  def get_twitter_photo
    puts "Model: get twitter photo"
    twitter_client.user(@twitter_handle).profile_image_url.to_s.gsub("_normal","")
  end


  private
    def initialize_twitter_client
      puts '!!! Twitter#initialize_twitter_client'
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['CONSUMER_KEY']
        config.consumer_secret     = ENV['CONSUMER_SECRET']
        config.access_token        = ENV['ACCESS_TOKEN']
        config.access_token_secret = ENV['ACCESS_SECRET']
      end 
    end
end