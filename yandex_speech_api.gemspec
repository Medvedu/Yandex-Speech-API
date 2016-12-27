# encoding: utf-8

Gem::Specification.new do |s|
  s.name          =  'yandex_speech_api'
  s.version       =  '1.1.2'
  s.date          =  '2016-11-11'
  s.authors       = ['Kuzichev Michael']
  s.license       = 'MIT'
  s.email         = 'kMedvedu@gmail.com'
  s.files         = Dir['README.md', 'Gemfile', 'LICENSE', 'lib/**/*']

  s.homepage      = 'https://github.com/Medvedu/Yandex-Speech-API'
  s.test_files    = Dir['spec/**/*.rb']
  s.require_paths = ['lib']

  s.summary     = 'Text to speech translation'
  s.description = 'Text to speech translation. Supports next languages: english, turkey, ukrain, russian. Supports speaker, emotion, speech speed selection. Based on Yandex Speech API (about technology: https://tech.yandex.ru/speechkit/).'

  s.required_ruby_version = '>= 2.0'

  s.requirements << 'mpg123'
end
