# encoding: utf-8

Gem::Specification.new do |s|
  s.name          =  'yandex_speech_api'
  s.version       =  '0.9.0'
  s.date          =  '2016-11-11'
  s.authors       = ['Kuzichev Michael']
  s.license       = 'MIT'
  s.email         = 'kMedvedu@gmail.com'
  s.files         = Dir['README.md', 'Gemfile', 'LICENSE', 'lib/**/*']

  s.homepage      = 'https://github.com/Medvedu/Yandex-Speech-API'
  s.test_files    = Dir['spec/**/*.rb']
  s.require_paths = ['lib']

  s.summary     = 'Text to speech translator'
  s.description = 'Gem for text to speech translation. It works for next languages: english, turkey, ukrain, russian. Supports speaker selection and much more... Based on Yandex Speech API (for more details see: https://tech.yandex.ru/speechkit/).'

  s.add_dependency 'rake',        '~> 10.4.2'
  s.add_dependency 'rest-client', '~> 2.0.0'
  s.add_dependency 'addressable', '~> 2.4.0'
end
