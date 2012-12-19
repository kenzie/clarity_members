class Link
  attr_reader :screen_name, :url
  attr_accessor :state
  def initialize(opts = {})
    @screen_name = opts[:screen_name]
    @url = opts[:url]
    @state = :new
  end
end