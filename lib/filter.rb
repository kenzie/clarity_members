require 'twitter'

class Filter

  attr_reader :tweet

  def initialize(tweet_json)
    @tweet = Twitter::Tweet.new(tweet_json)
  end

  def get_links
    screen_name = @tweet.user.screen_name
    links = @tweet.urls.map { |url| url.expanded_url }
    { :screen_name => screen_name, :links => links }
  end

end