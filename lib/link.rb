require 'ohm'
require 'qu'
require 'qu-redis'

require_relative './user'
require_relative './page'

class Link < Ohm::Model

  attribute :screen_name
  attribute :tweet_id
  attribute :url
  attribute :state

  def ==(link)
    self.screen_name == link.screen_name && self.url == link.url
  end

  # Background Processing

  $stdout.sync = true

  def async_search
    job = Qu.enqueue(Link, self.id)
    puts "ADDING PAGE TO QUEUE... #{self.url}"
  end

  def self.perform(link_id)
    link = Link[link_id.to_i]
    puts "SEARCHING PAGE... #{link.url}"
    user = User.find(:twitter_screen_name => link.screen_name).first
    if user.nil?
      link.state = 'nouser'
      link.save
      puts "NO MATCHING USER!!! #{link.screen_name}"
    else
      page = Page.new(link.url)
      page.fetch
      terms = user.search_terms
      match = page.search(terms)
      link.state = (match) ? 'match' : 'nomatch'
      puts "NAME MATCH!!! #{terms.join(',')} /// #{link.url}" if match
      link.save
    end
  end

end