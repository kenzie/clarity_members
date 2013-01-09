require 'httparty'
require 'cgi'

class Page

  attr_accessor :url, :content, :title, :embedly_description, :embedly_provider, :embedly_type

  def initialize(url)
    @url = URI.encode(url) # Twitter can return poorly formatted URLs
  end

  def fetch
    # TODO handle or rescue URI::InvalidURIError
    response = HTTParty.get(@url)
    @content = response.body
    @title = (/<title>(.*?)<\/title>/im).match(@content).try(:[],1)
    self
  end

  def fetch_embedly
    response = HTTParty.get("http://api.embed.ly/1/oembed?url=#{CGI.escape(@url)}&key=#{ENV['EMBEDLY_KEY']}")
    @embedly_description = response['description']
    @embedly_provider = response['provider_name']
    @embedly_type = response['type']
    @title = response['title'] unless response['title'].nil?
    @url = response['url'] unless response['url'].nil?
    self
  end

  def search(*terms)
    # TODO handle or rescue Encoding::CompatibilityError
    !!(@content =~ /#{terms.join('|')}/i)
  end

  def ==(page)
    self.url == page.url
  end

end