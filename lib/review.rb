require 'sinatra/base'
require 'sinatra/activerecord'
require 'active_support/core_ext/string'

class Review < Sinatra::Base

  register Sinatra::ActiveRecordExtension

  configure do
    set :views, settings.root + '/review/views'
    set :public_folder, settings.root + '/review/public'
    set :haml, { :format => :html5 }
  end

  configure :production do
    set :database_extras, {:pool => 8}
    set :database, ENV['DATABASE_URL']
  end

  configure :development do
    require 'sinatra/reloader'
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
    # TODO eager load the links' users
    @links = Link.includes(:user).recent.matches.fifty
    haml :index
  end

  require_relative './review/models/user'
  require_relative './review/models/link'
  require_relative './review/models/page'

end