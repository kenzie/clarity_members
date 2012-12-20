class Filter

  attr_reader :tweet

  def initialize(tweet)
    @tweet = tweet
  end

  def get_links
    screen_name = @tweet.user.screen_name
    links = @tweet.urls.map { |url| url.expanded_url }
    { :screen_name => screen_name, :links => links }
  end

end