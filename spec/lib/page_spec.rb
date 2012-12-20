require_relative '../../lib/page'
require 'fakeweb'

page = File.join(File.dirname(__FILE__), '..', 'fixtures', 'crunchbase.curl')
FakeWeb.register_uri(:get, "http://www.crunchbase.com/person/dan-martell", :response => page)

describe Page do
  describe "#fetch" do
    it "gets content from a web page" do
      page = Page.new("http://www.crunchbase.com/person/dan-martell")
      expect(page.fetch).to include 'crunchbase'
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
end