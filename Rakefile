# encoding: utf-8

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new

task default: :spec

desc 'Launches Guard (docs --> https://github.com/guard/guard)'
task :launch_guard do
  Kernel.system "bundle exec guard --clear"
end

