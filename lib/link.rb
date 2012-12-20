require 'ohm'

class Link < Ohm::Model

  attribute :screen_name
  attribute :tweet_id
  attribute :url
  attribute :state

  def ==(link)
    self.screen_name == link.screen_name && self.url == link.url
  end

end