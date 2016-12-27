# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'webmock/rspec'

require_relative '../lib/yandex_speech'

RSpec.configure do |config|
  WebMock.disable_net_connect! allow_localhost: true

  config.filter_run_excluding :disabled => true
end

SimpleCov.coverage_dir("spec/coverage")
