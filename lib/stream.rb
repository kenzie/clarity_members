require 'em-twitter'
require 'multi_json'
require 'twitter'
require_relative './filter'

$stdout.sync = true

EM::run do

  options = {
    :host   => 'userstream.twitter.com',
    :path   => '/1.1/user.json',
    :params => { :followings => 'true' },
    :oauth  => {
      :consumer_key     => ENV['TWITTER_KEY'],
      :consumer_secret  => ENV['TWITTER_SECRET'],
      :token            => ENV['OAUTH_TOKEN'],
      :token_secret     => ENV['OAUTH_TOKEN_SECRET']
    }
  }

  client = EM::Twitter::Client.connect(options)

  client.each do |raw_response|
    # puts "DEBUG: #{raw_response}"
    tweet_json = MultiJson.load(raw_response, :symbolize_keys => true)
    if tweet_json.has_key?(:text)
      tweet = Twitter::Tweet.new(tweet_json)
      data  = Filter.new(tweet).get_links
      puts "LINK SPOTTED!!! Screen Name: #{data[:screen_name]} /// Links: #{data[:links].join(', ')}" unless data[:links].empty?
    end
  end

  client.on_error do |message|
    puts "TWITTER ERROR: #{message}"
  end

  client.on_unauthorized do
    puts "TWITTER ERROR: Unauthorized"
  end

  client.on_forbidden do
    puts "TWITTER ERROR: Forbidden"
  end

  client.on_not_found do
    puts "TWITTER ERROR: Not found"
  end

  client.on_not_acceptable do
    puts "TWITTER ERROR: Not acceptable"
  end

  client.on_too_long do
    puts "TWITTER ERROR: Too long"
  end

  client.on_range_unacceptable do
    puts "TWITTER ERROR: Range unacceptable"
  end

  client.on_enhance_your_calm do
    puts "TWITTER ERROR: Enhance your calm"
  end

end