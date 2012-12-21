require 'httparty'

class Page

  attr_reader :url, :content

  def initialize(url)
    @url = url.gsub(/\s/, '%20') # Twitter can return poorly formatted URLs
  end

  def fetch
    # TODO handle or rescue URI::InvalidURIError
    response = HTTParty.get(@url)
    @content = response.body
  end

  def search(*terms)
    # TODO handle or rescue Encoding::CompatibilityError
    !!(@content =~ /#{terms.join('|')}/i)
  end

  def ==(page)
    self.url == page.url
  end

end