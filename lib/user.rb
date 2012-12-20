require 'ohm'
require 'csv'

class User < Ohm::Model

  attribute :name
  attribute :clarity_screen_name
  attribute :twitter_screen_name
  attribute :aliases

  unique :clarity_screen_name
  index :clarity_screen_name
  index :twitter_screen_name

  def search_terms
    Array(self.name) + Array(self.aliases)
  end

  def self.import
    CSV.foreach("/Users/kenzie/Dropbox/Development/Clarity/Members\ URL\ Monitor/clarity_members.csv") do |row|
      if find(:clarity_screen_name => row[1]).size == 0
        import = create(:name => row[0], :clarity_screen_name => row[1], :twitter_screen_name => row[2])
        puts "IMPORTED USER: #{import.name}, #{import.twitter_screen_name}"
      end
    end
  end

end