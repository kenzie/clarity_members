$stdout.sync = true

require './lib/review.rb'
require 'sinatra/activerecord/rake'

namespace :jobs do
  desc "Worker"
  task :stream do
    exec('ruby ./lib/stream.rb')
  end
end

require_relative './lib/filter'
require 'qu-redis'
require 'qu/tasks'

# require 'rspec/core/rake_task'
# RSpec::Core::RakeTask.new(:spec)
# task :default => :spec

desc "Start IRB session via Foreman with app env"
task :console do
  exec('foreman run irb -r ./lib/review.rb')
end