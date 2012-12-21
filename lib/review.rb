require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'active_support/core_ext/string'

class Review < Sinatra::Base

  use Rack::Auth::Basic, "Clarity Monitor" do |username, password|
    [username, password] == ['admin', 'admin']
  end

  register Sinatra::ActiveRecordExtension

  configure do
    set :views, settings.root + '/review/views'
    set :public_folder, settings.root + '/review/public'
    set :haml, { :format => :html5 }
  end

  configure :production do
    set :database, ENV['DATABASE_URL']
  end

  configure :development do
    register Sinatra::Reloader
    enable :logging, :dump_errors, :raise_errors
    ENV["LOG_LEVEL"] = "DEBUG"
    set :database, 'sqlite3:///db/review_development.sqlite3'
  end

  configure :test do
    enable :logging, :dump_errors, :raise_errors
    set :database, 'sqlite3:///db/review_test.sqlite3'
  end

  get '/' do
    @links = Link.recent.matches.hundred
    haml :index
  end

  require_relative './review/models/user'
  require_relative './review/models/link'
  require_relative './review/models/page'

end