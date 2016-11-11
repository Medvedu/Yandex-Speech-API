# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  class Speaker

    #
    # Allowed speed: :standard, :slow, :fast, OR any (real) number
    # from [1..3] range.
    #
    attr_reader :speed

    # allowed voices:
    #
    # female: :jane,  :oksana, :alyss, :omazh
    # male:   :zahar, :ermil
    #
    attr_reader :voice

    #
    # allowed emotions: :good, :evil, :neutral
    #
    attr_reader :emotion

    #
    # available languages: :russian, :english, :ukrain, :turkey
    #
    attr_reader :language

    #
    # preferable audio file format: :mp3, :wav, :opus
    #
    attr_reader :format

    #
    # This code defines setters methods for +@voice+, +@language+,
    # +@format+, +@emotion+ +@speed+, +@key+ attributes.
    #
    %i(voice language format emotion speed key).each do |symbol|
      define_method "#{symbol}=" do |other|
        method_name = __method__.to_s.chop
        klass = YandexSpeechApi.const_get method_name.capitalize
        variable =
          if other.is_a? klass
            other
          else
            klass.respond_to?(:init) ? klass.init(other) : klass.new(other)
          end
        instance_variable_set "@#{method_name}", variable
      end
    end

    #
    # input:
    #
    #   text [string] something that should be said.
    #
    # result: if <ok> you hear the voice o_0
    #         if <error> exception
    #
    def say(text)
      filename = save_to_file text
      `xdg-open #{filename}; sleep 1; rm #{filename}`
    end

    #
    # input:
    #
    #   text     [string] something that should be said.
    #   filename [string] path to file (without file extension)
    #
    # result: if <ok> filename with recorded message
    #         if <error> exception
    #
    # output: filename
    #
    def save_to_file(text, filename = 'temporary')
      binary_data = request text

      fn_tmp = "#{File.expand_path(filename)}.#{format.type}"
      File.open(fn_tmp, "w") { |f| f.write binary_data }

      fn_tmp.to_s
    end

    private

    #
    # Key is not something that should be shared with any other
    # class. Setter method still available to call from public zone thought.
    #
    attr_reader :key

    def initialize(settings)
      @key      = Key.new settings[:key]
      @voice    = Voice.new settings[:voice]
      @speed    = Speed.new settings[:speed]
      @emotion  = Emotion.new settings[:emotion]
      @language = Language.init settings[:language]
      @format   = Format.new settings[:format]
    end

    #
    # output: if <ok> memoized binary file (format depends from +@format+
    #                                       variable)
    #
    #         if <error> an exception.
    #
    # note: +text+ length limited: only 2000 chars per one request.
    #
    def request(text)
      raise KeyNotDefined if @key.value == :unknown

      tmp = text.dup.encode(Encoding::UTF_8,
                            :invalid => :replace,
                            :undef   => :replace,
                            :replace => '' )

      raise TextTooBig if tmp.length > 2000

      Connection.send({
        text: tmp, format: format.type, lang: language.code,
        speaker: voice.name, key: key.value, emotion: emotion.type,
        speed: speed.value })
    end

    #
    # This is supposed to been raised when user tries to #says too big text.
    #
    class TextTooBig < StandardError
      def initialize; super 'Text message length limited by 2000 symbols per request' end; end

    #
    # This is supposed to been raised when user tries to call #says method
    # without any key.
    #
    class KeyNotDefined < StandardError
      def initialize; super Key.warn_message end; end
  end # class Speaker
end # module YandexSpeechApi
