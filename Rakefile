require 'bundler/gem_tasks'
require 'rake'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:test) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
  t.verbose = false
end

task default: :test
