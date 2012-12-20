require 'open-uri'

class Page

  attr_reader :url, :content

  def initialize(url)
    @url = url
  end

  def fetch
    @content = open(@url) { |f| f.read }
  end

  def search(*terms)
    !!(@content =~ /#{terms.join('|')}/i)
  end

end