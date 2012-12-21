class Review < Sinatra::Base
  get '/' do
    @links = Link.recent.matches.hundred
    haml :index
  end
end