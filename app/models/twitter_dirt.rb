require "benchmark"
require "timeout"

class TwitterDirt
  attr_accessor :twitter_client, :handle, :tweets_per_page, :timeline_size, :timeline
  def initialize(handle)
    @twitter_client = initialize_twitter_client
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

  def number_of_pages
    page_count = (((twitter_client.user(handle).tweets_count)/tweets_per_page)).ceil
    page_count > 16 ? 16 : page_count
  end

  def get_user_timeline
    tweets = twitter_client.user_timeline(handle, :count => tweets_per_page)
    last_tweet = tweets.last.id
    (number_of_pages - 1).times do
      tweet_batch = twitter_client.user_timeline(handle, :count => tweets_per_page, :max_id => last_tweet )
      tweets << tweet_batch
      last_tweet = tweets.flatten.last.id
    end
    self.timeline_size = tweets.flatten.uniq.size 
    self.timeline = tweets.flatten.uniq
  end


  def obscene_tweets
    embedded_tweets = []
    get_user_timeline
    begin
      Timeout::timeout(13) do
        timeline.each do |tweet|
          if Obscenity.profane?(tweet.text)
            embedded_tweets << tweet
          end
        end
      end
    rescue Timeout::Error
      embedded_tweets
    end
    embedded_tweets
  end

  def get_twitter_photo
    twitter_client.user(handle).profile_image_url.to_s.gsub("_normal","")
  end


  def twitter_client
    @twitter_client
  end

  private
    def initialize_twitter_client
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['CONSUMER_KEY']
        config.consumer_secret     = ENV['CONSUMER_SECRET']
        config.access_token        = ENV['ACCESS_TOKEN']
        config.access_token_secret = ENV['ACCESS_SECRET']
      end 
    end
end