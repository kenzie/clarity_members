require 'ohm'

require_relative './user'
require_relative './page'

class Link < Ohm::Model

  attribute :screen_name
  attribute :tweet_id
  attribute :url
  attribute :state

  index :screen_name
  index :state

  def search!
    user = User.find(:twitter_screen_name => screen_name).first
    if user.nil?
      self.state = 'nouser'
      self.save
      puts "NO MATCHING USER!!! #{screen_name}"
    else
      page = Page.new(url)
      page.fetch
      terms = user.search_terms
      match = page.search(terms)
      self.state = (match) ? 'match' : 'nomatch'
      puts "NAME MATCH!!! #{terms.join(',')} /// #{url}" if match
      self.save
    end
  end

  def ==(link)
    self.screen_name == link.screen_name && self.url == link.url
  end

  # Background Processing

  def self.perform(screen_name, tweet_id, urls)
    puts "PROCESSING LINKS: #{screen_name}, ##{tweet_id}, [#{urls.join(',')}]"
    links = urls.map{ |url| Link.create(:screen_name => screen_name, :tweet_id => tweet_id, :url => url) }
    links.each{ |link| link.search! }
  end

end