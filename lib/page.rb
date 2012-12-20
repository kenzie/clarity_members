require 'httparty'

class Page

  attr_reader :url, :content

  def initialize(url)
    @url = url
  end

  def fetch
    response = HTTParty.get(@url)
    @content = response.body
  end

  def search(*terms)
    !!(@content =~ /#{terms.join('|')}/i)
  end

end