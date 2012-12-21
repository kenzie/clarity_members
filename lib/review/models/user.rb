require 'csv'

class User < ActiveRecord::Base

  def search_terms
    Array(self.name) + Array(self.aliases)
  end

  def self.import
    CSV.foreach("/Users/kenzie/Dropbox/Development/Clarity/Members\ URL\ Monitor/clarity_members.csv") do |row|
      if where(:clarity_screen_name => row[1]).size == 0
        import = create(:name => row[0], :clarity_screen_name => row[1], :twitter_screen_name => row[2])
        puts "IMPORTED USER: #{import.name}, #{import.twitter_screen_name}"
      end
    end
  end

end