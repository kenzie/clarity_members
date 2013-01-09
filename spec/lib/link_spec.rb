require_relative './spec_helper'

describe Link do

  link  = Link.new(:screen_name => 'kenziecampbell', :tweet_id => 123, :url => 'http://route19.com/')
  link2 = Link.new(:screen_name => 'kenziecampbell', :tweet_id => 123, :url => 'http://clarity.fm/')

  describe "#new" do
    it "has a screen name" do
      expect(link.screen_name).to eq 'kenziecampbell'
    end
    it "has a url" do
      expect(link.url).to eq 'http://route19.com/'
    end
    it "has a tweet id" do
      expect(link.tweet_id).to eq 123
    end
  end

  describe ".state" do
    it "can be updated" do
      link.state = :fetched
      expect(link.state).to eq :fetched
    end
  end

  describe "#perform" do
    it "creates a Link for each url" do
      Link.any_instance.stub(:search!)
      Link.stub(:create).and_return(link)
      links = Link.perform(2884181, 'kenziecampbell', 123, ['http://route19.com/'])
      expect(links.size).to eq 1
      expect(links.first.screen_name).to eq 'kenziecampbell'
    end
  end

  describe ".source" do
    it "returns the domain" do
      expect(link.source).to eq "route19.com"
    end
  end

  describe "set_state" do
    pending
  end

  describe "populate_with_embedly" do
    pending
  end

  describe "search" do
    pending
  end

end