require 'csv'

class User < ActiveRecord::Base

  has_many :links, :foreign_key => 'screen_name', :primary_key => 'twitter_screen_name'

  def search_terms
    Array(self.name) + Array(self.aliases)
  end

  def clarity_url
    "https://clarity.fm/#/#{clarity_screen_name}"
  end

  def avatar_url_or_default
    return avatar_url unless avatar_url.nil?
    "/images/avatar-48-default.gif"
  end

  def self.import
    file = File.join(File.dirname(__FILE__), '..', '..', '..', 'db', 'import', 'users.csv')
    CSV.foreach(file) do |row|
      # TODO update existing users?
      if where(:clarity_screen_name => row[1]).size == 0
        import = create(:name => row[0], :clarity_screen_name => row[1], :twitter_screen_name => row[2])
        puts "IMPORTED USER: #{import.name}, #{import.twitter_screen_name}"
      end
    end
  end

  # Background Processing

  def self.perform(twitter_user_id, screen_name, avatar_url)
    user = where(:twitter_screen_name => screen_name).first
    user.update_attributes({:twitter_user_id => twitter_user_id, :avatar_url => avatar_url}) unless user.nil?
  end

end