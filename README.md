### Samples

### Sample 1

```ruby
# encoding: utf-8

require_relative '../lib/yandex_speech'

key = File.open('secret key/key').readline.strip

speaker = YandexSpeechApi::Speaker.init key: key
speaker.save_to_file "в 2016 году в 11 месяц в 11 день в 16:55 произошел котоапокалипсис, а cтранная робо-женщина научились говорить."
```

### Sample 2

```ruby
# encoding: utf-8

require_relative '../lib/yandex_speech'

key = File.open('secret key/key').readline.strip

message = "Don't trouble trouble until trouble troubles you"

speaker = YandexSpeechApi::Speaker.init({ key: key, language: 'english', voice: :zahar, speed: 0.23 })
speaker.say message
```

### Sample 3

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
