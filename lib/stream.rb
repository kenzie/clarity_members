require 'em-twitter'
require 'multi_json'

require_relative './filter'
require_relative './link'

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
    # TODO clean up this mess
    tweet_json = MultiJson.load(raw_response, :symbolize_keys => true)
    if tweet_json.has_key?(:text)
      data  = Filter.new(tweet_json).get_links # TODO get_links could return a struct with screen_name, id, links array
      unless data[:links].empty?
        puts "LINK SPOTTED!!! Screen Name: #{data[:screen_name]} /// Links: #{data[:links].join(', ')}"
        data[:links].each do |link|
          link = Link.create(:screen_name => data[:screen_name], :tweet_id => tweet_json[:id], :url => link)
          link.async_search
        end
      end
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