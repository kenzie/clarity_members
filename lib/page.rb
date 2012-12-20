require 'httparty'

class Page

  attr_reader :url, :content

  def initialize(url)
    @url = url.gsub(/\s/, '%20') # Twitter can return poorly formatted URLs
  end

  def fetch
    response = HTTParty.get(@url)
    @content = response.body
  end

  def search(*terms)
    !!(@content =~ /#{terms.join('|')}/i)
  end

  def ==(page)
    self.url == page.url
  end

end