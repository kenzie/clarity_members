require 'ohm'

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

end