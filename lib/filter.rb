require 'twitter'

class Filter

  attr_reader :tweet

  def initialize(raw_tweet)
    @tweet = Twitter::Tweet.new(MultiJson.load(raw_tweet, :symbolize_keys => true))
  end

  def get_links
    return false if @tweet.urls.empty?
    screen_name = @tweet.user.screen_name
    links = @tweet.urls.map { |url| url.expanded_url }
    [screen_name, links]
  end

end