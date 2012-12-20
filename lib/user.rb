class User

  attr_reader :name, :clarity_screen_name, :twitter_screen_name
  attr_accessor :aliases

  def initialize(opts = {})
    @name = opts[:name]
    @clarity_screen_name = opts[:clarity_screen_name]
    @twitter_screen_name = opts[:twitter_screen_name]
    @aliases = Array(opts[:aliases])
  end

  def search_terms
    [@name] + @aliases
  end

end