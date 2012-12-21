class Review < Sinatra::Base
  get '/' do
    @user = User.first
    haml :index
  end
end