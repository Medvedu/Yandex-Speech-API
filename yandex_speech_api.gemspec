# encoding: utf-8

Gem::Specification.new do |s|
  s.name          = "yandex_speech_api"
  s.version       = "0.1.0"
  s.summary       = ""
  s.authors       = ["Kuzichev Michael"]
  s.email         = 'kMedvedu@gmail.com'
  s.homepage      = ""
  s.license       = "MIT"
  s.files         = Dir['readme.md', 'LICENSE', 'lib/**/*', 'Rakefile', 'Gemfile']
  s.test_files    = Dir["spec/**/*.rb"]
  s.require_paths = ["lib"]

  s.required_ruby_version = ">= 2.0.0"
end
