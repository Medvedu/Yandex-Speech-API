# YandexSpeechApi [![Gem Version](https://badge.fury.io/rb/yandex_speech_api.svg)](https://badge.fury.io/rb/yandex_speech_api) [![Build Status](https://travis-ci.org/Medvedu/Yandex-Speech-API.svg?branch=master)](https://travis-ci.org/Medvedu/Yandex-Speech-API) [![Code Climate](https://codeclimate.com/github/Medvedu/Yandex-Speech-API/badges/gpa.svg)](https://codeclimate.com/github/Medvedu/Yandex-Speech-API) [![Inline docs](http://inch-ci.org/github/Medvedu/Yandex-Speech-API.svg?branch=master)](http://inch-ci.org/github/Medvedu/Yandex-Speech-API) [![Coverage Status](https://coveralls.io/repos/github/Medvedu/Yandex-Speech-API/badge.svg?branch=master)](https://coveralls.io/github/Medvedu/Yandex-Speech-API?branch=master)
  
## Description
  Converts English, Ukrain, Russian or Turkey text to speech. Solution based on Yandex SpeechKit Cloud technology.
  
## About Key
  
  Before usage you need to get an api key.
  Official site: https://developer.tech.yandex.ru (look for SpeechKit Cloud key)

## Usage

```ruby
  require 'yandex_speech'
  
  key = File.open('secret key/key').readline.strip
  
  speaker = YandexSpeechApi::Speaker.new key: key, language: 'russian'
  speaker.save_to_file 'Не будите спящего кота.'
```

```ruby 
  YandexSpeechApi.key = File.open('secret key/key').readline.strip
  
  message = "Don't trouble trouble until trouble troubles you"
  speaker = YandexSpeechApi::Speaker.new voice: :zahar, speed: 1.1
  speaker.say message
```
    
```ruby
  key = File.open('secret key/key').readline.strip
  message = 'one two three. one two three. one two three four.'
  
  speaker = YandexSpeechApi::Speaker.new do |s|
    s.key      = key
    s.voice    = :jane
    s.language = :english
    s.emotion  = :good
  end
  
  speaker.say message
```
  
## Notes

2000 symbols per request.

## Dependencies

* Ruby 2.0.0 or higher. 
* mpg123

## License

Released under the MIT License. See the [LICENSE](./LICENSE) file for further details.
