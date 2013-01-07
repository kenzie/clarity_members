require 'twitter'
require 'multi_json'
require 'qu'
require 'qu-redis'

require_relative './review/models/link'

class Filter

  def self.harvest_links(raw_response)
    tweet_json = MultiJson.load(raw_response, :symbolize_keys => true)
    return false unless tweet_json.has_key?(:text) # not a tweet
    tweet = Twitter::Tweet.new(tweet_json)
    links = tweet.urls.map { |url| url.expanded_url }
    return false if links.empty?
    Qu.enqueue(Link, tweet.user.screen_name, tweet.id, links)
    Qu.enqueue(User, tweet.user.screen_name, tweet.user.profile_image_url)
    true
  end

end