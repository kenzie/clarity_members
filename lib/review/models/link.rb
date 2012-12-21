require_relative '../../page.rb'

class Link < ActiveRecord::Base

  def search!
    user = User.where(:twitter_screen_name => screen_name).first
    if user.nil?
      self.state = 'nouser'
      self.save
    else
      page = Page.new(url)
      page.fetch
      terms = user.search_terms
      match = page.search(terms)
      self.state = (match) ? 'match' : 'nomatch'
      self.save
    end
  end

  def ==(link)
    self.screen_name == link.screen_name && self.url == link.url
  end

  # Background Processing

  def self.perform(screen_name, tweet_id, urls)
    links = urls.map{ |url| Link.create(:screen_name => screen_name, :tweet_id => tweet_id, :url => url) }
    links.each{ |link| link.search! }
  end

end