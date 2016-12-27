# YandexSpeechApi [![Gem Version](https://badge.fury.io/rb/yandex_speech_api.svg)](https://badge.fury.io/rb/yandex_speech_api) [![Build Status](https://travis-ci.org/Medvedu/Yandex-Speech-API.svg?branch=master)](https://travis-ci.org/Medvedu/Yandex-Speech-API) [![Code Climate](https://codeclimate.com/github/Medvedu/Yandex-Speech-API/badges/gpa.svg)](https://codeclimate.com/github/Medvedu/Yandex-Speech-API) [![Inline docs](http://inch-ci.org/github/Medvedu/Yandex-Speech-API.svg?branch=master)](http://inch-ci.org/github/Medvedu/Yandex-Speech-API) [![Coverage Status](https://coveralls.io/repos/github/Medvedu/Yandex-Speech-API/badge.svg?branch=master)](https://coveralls.io/github/Medvedu/Yandex-Speech-API?branch=master)

## Описание

Wrapper для синтезатора речи, основанного на технологиях Yandex SpeechKit Cloud API.  Предоставляет собой интерфейс для перевода машинного текста (на русском,  английском, украинском или турецком язык) в речь. Может использоваться как для прямого  воспроизведения текста, так и для записи речи в файл.

## Установка

1. Перед использованием необходимо получить ключ разработчика. Подробнее на официальном сайте: https://tech.yandex.ru/speechkit/cloud
2. Добавьте yandex_speech_api в Gemfile.
3. bundle install 
4. Добавьте в проект:

```ruby
  # ...
  require 'yandex_speech'  
  # ... 
````

Воспроизведение звука поддерживается для UNIX-подобных операционных систем (Mac + Linux). 

### Примеры использования

### Пример 1

_Для начала работы с api достаточно указать ключ:_

```ruby
key = File.open('secret key/key').readline.strip

speaker = YandexSpeechApi::Speaker.init key: key, language: 'russian'
speaker.save_to_file "Не будите спящего кота."
```

### Пример 2

```ruby
YandexSpeechApi::Key.global_key = File.open('secret key/key').readline.strip

message = "Don't trouble trouble until trouble troubles you"
speaker = YandexSpeechApi::Speaker.init(voice: :zahar, speed: 0.23)
speaker.say message
```

Обратите внимание, передавать key каждый раз нет никакой необходимости. Достаточно один раз установить YandexSpeechApi::Key.global_key.  

### Пример 3

_Также поддерживаются геттеры и сеттеры:_

```ruby
key = File.open('secret key/key').readline.strip

message = "Як поїдеш в об'їзд, то будеш і на обід, а як навпростець, то увечері."

speaker = YandexSpeechApi::Speaker.init
speaker.key      = key
speaker.voice    = 'Alyss'
speaker.language = 'Ukrain'
speaker.speed    = 1.2
speaker.emotion  = 'good'
speaker.save_to_file message, '~/downloads/sound'
```

### Пример 4

_И, наконец, установка параметров через блок:_

```ruby
key = File.open('secret key/key').readline.strip
message = "one two three. one two three. one two three four."

speaker = YandexSpeechApi::Speaker.init do |s|
  s.key      = key
  s.voice    = :jane
  s.language = :english
  s.speed    = :slow
  s.emotion  = :good
end

speaker.say message
```

## Примечания

1. За один запрос озвучивается текст, длинной до 2000 знаков.
2. Выбирая язык, учтите: вы ограничены его фонетикой, так, например, английский переводчик не умеет озвучивать русские тексты и т.п. (На самом деле это не совсем точно — хотя официальная документация и не рекомендует выставлять некорректные пары язык-текст, в то же время, _русский_ переводчик фактически может воспроизводить английские тексты)

## Зависимости

* Ruby 2.0.0 или выше

### Linux-специфичные зависимости:

* mpg123

## Лицензия

Данный код распространяется под лицензией MIT, подробнее смотрите [LICENSE](./LICENSE). Остальные права принадлежат их владельцам.
