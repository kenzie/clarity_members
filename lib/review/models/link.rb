class Link < ActiveRecord::Base

  scope :matches, where(:state => 'match')
  scope :fifty, limit(50)
  scope :recent, order('updated_at DESC')

  belongs_to :user, :foreign_key => 'screen_name', :primary_key => 'twitter_screen_name'

  def search!
    if user.nil?
      self.state = 'nouser'
      self.save
    else
      page = Page.new(url)
      page.fetch
      terms = user.search_terms
      match = page.search(terms)
      self.state = (match) ? 'match' : 'nomatch'
      self.title = page.title
      self.url   = page.final_url
      self.save
    end
  end

  def source
    URI.parse(url).host.downcase
  end

  def tweet_url
    "http://twitter.com/#{screen_name}/status/#{tweet_id}"
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