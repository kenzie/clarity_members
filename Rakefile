$stdout.sync = true

namespace :jobs do
  desc "Worker"
  task :stream do
    exec('ruby ./lib/stream.rb')
  end
end

require_relative './lib/filter'
require 'qu-redis'
require 'qu/tasks'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => :spec