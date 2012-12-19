require_relative '../../lib/link'

describe Link do
  link  = Link.new(:screen_name => 'kenziecampbell', :url => 'http://route19.com/')
  link2 = Link.new(:screen_name => 'kenziecampbell', :url => 'http://clarity.fm/')
  describe "#new" do
    it "has a screen name" do
      expect(link.screen_name).to eq 'kenziecampbell'
    end
    it "has a url" do
      expect(link.url).to eq 'http://route19.com/'
    end
    it "has a default state of new" do
      expect(link.state).to eq :new
    end
  end
  describe ".state" do
    it "can be updated" do
      link.state = :fetched
      expect(link.state).to eq :fetched
    end
  end
end