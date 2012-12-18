namespace :jobs do
  desc "Worker"
  task :work do
    exec('ruby ./lib/stream.rb')
  end
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => :spec