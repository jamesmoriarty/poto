begin
  require 'bundler/gem_tasks'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  task default: :spec
rescue LoadError => e
  puts e.message
end
