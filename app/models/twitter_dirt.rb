class TwitterDirt
  attr_accessor :twitter_client
  def initialize(handle)
    @twitter_client = initialize_twitter_client
    @tweets_per_page = 200
    @handle = handle
  end

  # returns the number of pages we need to iterate through in get_user_timeline
  def number_of_pages
    ((@twitter_client.user(@handle).tweets_count)/@tweets_per_page).ceil
  end

  def get_user_timeline
    tweets = @twitter_client.user_timeline(@handle, :count => @tweets_per_page)
    last_tweet = tweets.last.id
    (number_of_pages - 1).times do
      
      tweet_batch = @twitter_client.user_timeline(@handle, :count => @tweets_per_page, :max_id => last_tweet )
      last_tweet = tweet_batch.last.id
      tweets << tweet_batch
    end
    tweets.flatten.uniq
  end

  def obscene_tweets
    get_user_timeline.select do |tweet|
      Obscenity.profane?(tweet.text)
    end
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