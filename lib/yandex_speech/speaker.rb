# encoding: utf-8

module YandexSpeechApi
  class Speaker

    #
    #
    #
    attr_reader :key

    # allowed voices:
    #
    # female: :jane,  :oksana, :alyss, :omazh
    # male:   :zahar, :ermil
    #
    attr_reader :voice

    def voice=(other)
      @voice = other.is_a?(Voice) ? other : Voice.init(other)
    end

    #
    #
    #
    attr_reader :sound_quality

    #
    #
    #
    attr_reader :character

    #
    # available languages: :russian, :english, :ukrain, :turkey
    #
    attr_reader :language

    def language=(other)
      @language = other.is_a?(Language) ? other : Language.init(other)
    end

    #
    # preferable audio file format: :mp3, :wav, :opus
    #
    attr_reader :format



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
      @voice = Voice.new settings[:voice]
      @format = Format.new settings[:audio_format]
    end
  end # class Speaker
end # module YandexSpeechApi
