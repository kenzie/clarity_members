require_relative './spec_helper'
require 'fakeweb'

page1 = File.join(File.dirname(__FILE__), '..', 'fixtures', 'crunchbase.curl')
FakeWeb.register_uri(:get, %r|http://www\.crunchbase\.com/|, :response => page1)

describe Page do
  describe ".fetch" do
    it "gets content from a web page" do
      page = Page.new("http://www.crunchbase.com/person/dan-martell")
      expect(page.fetch).to include 'crunchbase'
    end
    it "can handle a url with spaces" do
      page2 = Page.new("http://www.crunchbase.com/person/dan martell")
      expect(page2.url).to eq 'http://www.crunchbase.com/person/dan%20martell'
    end
    # COMMENTED OUT FOR SPEED
    # it "saves the final redirect url" do
    #   page3 = Page.new('http://buff.ly/UejBux')
    #   page3.fetch
    #   expect(page3.final_url).to eq 'http://www.slideshare.net/poornimav/when-to-build-and-when-to-buy'
    # end
  end
  describe ".search" do
    page = Page.new("http://www.crunchbase.com/person/dan-martell")
    page.fetch
    it "returns true for matched search terms" do
      expect(page.search('Dan Martell')).to be_true
    end
    it "returns false for unmatched search terms" do
      expect(page.search('Dan Martin')).to be_false
    end
    it "can match on multiple terms" do
      expect(page.search('Dan Martell', 'Daniel Martell')).to be_true
      expect(page.search('Daniel Martell', 'Dan Martell')).to be_true
      expect(page.search('Richard Martell', 'Dan Martin')).to be_false
    end
  end
  describe ".title" do
    it "returns the html title attribute text" do
      page = Page.new("http://www.crunchbase.com/person/dan-martell")
      page.content = "<html><title>Test Title</title><body>More Content</body></html>"
      expect(page.title).to eq "Test Title"
    end
    it "returns nil when there is no title attribute" do
      page = Page.new("http://www.crunchbase.com/person/dan-martell")
      page.content = "<html><body>More Content</body></html>"
      expect(page.title).to eq nil
    end
  end
  describe ".==" do
    it "is true when two pages have the same url" do
      page1 = Page.new("http://www.crunchbase.com/person/dan-martell")
      page2 = Page.new("http://www.crunchbase.com/person/dan-martell")
      expect(page1).to eq page2
    end
  end
end