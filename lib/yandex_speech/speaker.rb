# encoding: utf-8

module YandexSpeechApi
  class Speaker

    #
    #
    #
    attr_reader :key

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
    # +@format+, +@emotion+ +@speed+ attributes.
    #
    %i(voice language format emotion speed).each do |symbol|
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
    # notes:
    #
    # +text+ length limited: only 2000 chars per one request.
    #
    def says(text)
    end

    private

    def initialize(settings)
      @language = Language.init settings[:language]
      @voice    = Voice.new settings[:voice]
      @format   = Format.new settings[:audio_format]
      @emotion  = Emotion.new settings[:emotion]
      @speed    = Speed.new settings[:speed]
      #@sound_sound_quality =
    end
  end # class Speaker
end # module YandexSpeechApi
