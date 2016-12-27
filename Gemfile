# encoding: utf-8

source 'https://rubygems.org'

gem 'rake'

gemspec

group :development do
  gem 'webmock',                        '~> 2.3.1'
  gem 'rspec',                          '~> 3.5.0'
end

group :guard do
  gem 'rb-readline',                    '~> 0.5.3', require: false
  gem 'guard-rspec',                    '~> 4.7.3', require: false
end

group :test do
  gem 'coveralls', require: false
end
