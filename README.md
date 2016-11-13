# YandexSpeechApi

[![Build Status](https://travis-ci.org/Medvedu/Yandex-Speech-API.svg?branch=master)](https://travis-ci.org/Medvedu/Yandex-Speech-API)
[![Code Climate](https://codeclimate.com/github/Medvedu/Yandex-Speech-API/badges/gpa.svg)](https://codeclimate.com/github/Medvedu/Yandex-Speech-API)

## Описание

Wrapper для синтезатора речи, основанного на технологиях Yandex SpeechKit Cloud API.  Предоставляет собой интерфейс для перевода машинного текста (на русском,  английском, украинском или турецком язык) в речь. Может использоваться как для прямого  воспроизведения текста, так и для записи речи в файл.

## Установка

Перед использованием необходимо получить ключ разработчика. Подробнее на официальном сайте: https://tech.yandex.ru/speechkit/cloud

## TODO Дополнить описание установки

В настоящий момент воспроизведение звука напрямую поддерживается для UNIX-подобных операционных систем. 

### Примеры использования

### Пример 1

_Для начала работы с api достаточно указать ключ:_

```ruby
# encoding: utf-8

require_relative '../lib/yandex_speech'

key = File.open('secret key/key').readline.strip

speaker = YandexSpeechApi::Speaker.init key: key
speaker.save_to_file "в 2016 году в 11 месяц в 11 день в 16:55 произошел котоапокалипсис, а cтранная робо-женщина научились говорить."
```

### Пример 2

_Когда это неоходимо, конструктор позволяет переписывать параметры по умолчанию, например, так можно выбрать язык:_

```ruby
# encoding: utf-8

require_relative '../lib/yandex_speech'

key = File.open('secret key/key').readline.strip

message = "Don't trouble trouble until trouble troubles you"

speaker = YandexSpeechApi::Speaker.init({ key: key, language: 'english', voice: :zahar, speed: 0.23 })
speaker.say message
```

### Пример 3

_Также поддерживаются геттеры и сеттеры:_

```ruby
# encoding: utf-8

require_relative '../lib/yandex_speech'

key = File.open('secret key/key').readline.strip

message = "Як поїдеш в об'їзд, то будеш і на обід, а як навпростець, то увечері."

speaker = YandexSpeechApi::Speaker.init
speaker.key      = key
speaker.voice    = 'Alyss'
speaker.language = 'Ukrain'
speaker.speed    = 1.2
speaker.emotion  = 'good'
speaker.save_to_file message, "~/downloads/sound"
```

## Зависимости

> Ruby 2.0.0 или выше

> rake          '~> 10.4.2'

> rest-client   '~> 2.0.0'

> addressable   '~> 2.4.0'

### Linux-специфичные зависимости:

> mpg123

## Лицензия

Данный код распространяется под лицензией MIT, подробнее смотрите [LICENSE](./LICENSE). Остальные права принадлежат их владельцам.
