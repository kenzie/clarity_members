require_relative '../../lib/page'
require 'fakeweb'

page = File.join(File.dirname(__FILE__), '..', 'fixtures', 'crunchbase.curl')
FakeWeb.register_uri(:get, %r|http://www\.crunchbase\.com/|, :response => page)

describe Page do
  describe "#fetch" do
    it "gets content from a web page" do
      page = Page.new("http://www.crunchbase.com/person/dan-martell")
      expect(page.fetch).to include 'crunchbase'
    end
    it "can handle a url with spaces" do
      page2 = Page.new("http://www.crunchbase.com/person/dan martell")
      expect(page2.url).to eq 'http://www.crunchbase.com/person/dan%20martell'
    end
  end
  describe "#search" do
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
  describe "#==" do
    it "is true when two pages have the same url" do
      page1 = Page.new("http://www.crunchbase.com/person/dan-martell")
      page2 = Page.new("http://www.crunchbase.com/person/dan-martell")
      expect(page1).to eq page2
    end
  end
end