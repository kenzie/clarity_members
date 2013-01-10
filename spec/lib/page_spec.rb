require_relative './spec_helper'
require 'fakeweb'

crunchbase = File.join(File.dirname(__FILE__), '..', 'fixtures', 'crunchbase.curl')
embedly    = File.join(File.dirname(__FILE__), '..', 'fixtures', 'embedly-crunchbase.curl')
FakeWeb.register_uri(:get, %r|http://www\.crunchbase\.com/|, :response => crunchbase)
FakeWeb.register_uri(:get, %r|http://api\.embed\.ly/|, :response => embedly)

describe Page do

  describe ".fetch" do
    it "gets content from a web page" do
      page = Page.new("http://www.crunchbase.com/person/dan-martell")
      expect(page.fetch.title).to eq 'Dan Martell | CrunchBase Profile'
    end
    it "can handle a url with spaces" do
      page2 = Page.new("http://www.crunchbase.com/person/dan martell")
      expect(page2.url).to eq 'http://www.crunchbase.com/person/dan%20martell'
    end
  end

  describe ".fetch_embedly" do
    it "has a embedly description, provider, type" do
      page = Page.new("http://www.crunchbase.com/person/dan-martell")
      page.fetch_embedly
      expect(page.embedly_description).to eq "Dan Martell skydives and snowboards and believes running is among the secrets to a fruitful life. But the 29-year-old Moncton,"
      expect(page.embedly_provider).to eq "Crunchbase"
      expect(page.embedly_type).to eq "link"
      expect(page.title).to eq "Dan Martell | CrunchBase Profile"
    end
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
      page.fetch
      page.fetch_embedly
      expect(page.title).to eq "Dan Martell | CrunchBase Profile"
    end
  end

  describe ".==" do
    it "is true when two pages have the same url" do
      page1 = Page.new("http://www.crunchbase.com/person/dan-martell")
      page2 = Page.new("http://www.crunchbase.com/person/dan-martell")
      expect(page1).to eq page2
    end
  end

  describe ".blacklisted?" do
    it "returns true for blacklisted domains" do
      stub_const("Page::BLACKLIST", ['crunchbase.com'])
      page = Page.new("http://www.crunchbase.com/person/dan-martell")
      page.fetch_embedly
      expect(page.blacklisted?).to eq true
    end
    it "returns false for non-blacklisted domains" do
      stub_const("Page::BLACKLIST", ['path.com','instagram.com'])
      page = Page.new("http://www.crunchbase.com/person/dan-martell")
      page.fetch_embedly
      expect(page.blacklisted?).to eq false
    end
  end

end