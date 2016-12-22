# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'webmock/rspec'

require_relative '../lib/yandex_speech'

RSpec.configure do |_config|
  WebMock.disable_net_connect! allow_localhost: true
end

SimpleCov.coverage_dir("spec/coverage")
