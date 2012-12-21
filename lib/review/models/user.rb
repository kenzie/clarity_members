require 'csv'

class User < ActiveRecord::Base

  def links
    Link.where(:screen_name => twitter_screen_name)
  end

  def search_terms
    Array(self.name) + Array(self.aliases)
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

end