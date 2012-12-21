require_relative './spec_helper'

describe User do
  describe "#new" do
    user = User.new(:name => 'Kenzie Campbell', :clarity_screen_name => 'kenzie', :twitter_screen_name => 'kenziecampbell')
    it "has a name" do
      expect(user.name).to eq 'Kenzie Campbell'
    end
    it "has a Clarity screen name" do
      expect(user.clarity_screen_name).to eq 'kenzie'
    end
    it "has a Twitter screen name" do
      expect(user.twitter_screen_name).to eq 'kenziecampbell'
    end
  end
  describe "#new with aliases array" do
    user = User.new(:name => 'Kenzie Campbell', :clarity_screen_name => 'kenzie', :twitter_screen_name => 'kenziecampbell', :aliases => ['one', 'two', 'three'])
    it "has an array of aliases" do
      expect(user.aliases).to eq ['one', 'two', 'three']
    end
  end
  describe ".search_terms" do
    user = User.new(:name => 'Kenzie Campbell', :clarity_screen_name => 'kenzie', :twitter_screen_name => 'kenziecampbell')
    it "returns an array of search terms" do
      expect(user.search_terms).to eq ['Kenzie Campbell']
    end
    it "returns an array of search terms including aliases" do
      user.aliases = ['one', 'two', 'three']
      expect(user.search_terms).to eq ['Kenzie Campbell', 'one', 'two', 'three']
    end
  end
end