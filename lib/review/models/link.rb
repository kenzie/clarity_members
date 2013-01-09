class Link < ActiveRecord::Base

  scope :matches, where(:state => 'match')
  scope :fifty, limit(50)
  scope :recent, order('updated_at DESC')

  belongs_to :user, :foreign_key => 'screen_name', :primary_key => 'twitter_screen_name'

  def search!
    set_link_as_nouser and return if user.nil?
    page = Page.new(url)
    page.fetch
    terms = user.search_terms
    match = page.search(terms)
    self.state = (match) ? 'match' : 'nomatch'
    page.fetch_embedly if match
    self.title               = page.title
    self.url                 = page.url
    self.embedly_description = page.embedly_description
    self.embedly_provider    = page.embedly_provider
    self.embedly_type        = page.embedly_type
    self.save
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

  def set_link_as_nouser
    self.state = 'nouser'
    self.save
  end

  # Background Processing

  def self.perform(twitter_user_id, screen_name, tweet_id, urls)
    links = urls.map{ |url| Link.create(:twitter_user_id => twitter_user_id, :screen_name => screen_name, :tweet_id => tweet_id, :url => url) }
    links.each{ |link| link.search! }
  end

end