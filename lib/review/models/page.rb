require 'httparty'

class Page

  attr_reader :url
  attr_accessor :content, :final_url

  def initialize(url)
    @url = url.gsub(/\s/, '%20') # Twitter can return poorly formatted URLs
  end

  def fetch
    # TODO handle or rescue URI::InvalidURIError
    response = HTTParty.get(@url)
    @final_url = response.request.last_uri.to_s
    @content = response.body
  end

  def search(*terms)
    # TODO handle or rescue Encoding::CompatibilityError
    !!(@content =~ /#{terms.join('|')}/i)
  end

  def title
    /<title>(.*?)<\/title>/.match(@content).try([],1)
  end

  def ==(page)
    self.url == page.url
  end

end