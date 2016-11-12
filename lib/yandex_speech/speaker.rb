# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  class Speaker
    #
    # encapsulated methods (we are going inside the cat)
    #
    private

    def initialize(settings)
      @key      = Key.new settings[:key]
      @voice    = Voice.new settings[:voice]
      @speed    = Speed.new settings[:speed]
      @emotion  = Emotion.new settings[:emotion]
      @language = Language.init settings[:language]
      @format   = Format.new settings[:format]
    end

    #
    # input:
    #
    #   text   [string] something that should be said.
    #   params [hash][optional] overrides object state only for _this_ request.
    #
    # output: if <ok> memoized binary file (format depends from +@format+
    #                                       variable)
    #
    #         if <error> an exception.
    #
    # note: +text+ length limited: only 2000 chars per one request.
    #
    def request(text, params = {})
      raise KeyNotDefined if @key.value == :unknown

      tmp_text = text.dup.encode(Encoding::UTF_8,
                            :invalid => :replace,
                            :undef   => :replace,
                            :replace => '')
      raise TextTooBig if tmp_text.length > 2000

      tmp_params = generate_params_for_request tmp_text, params
      Connection.send tmp_params
    end

    #
    # REVIEW rewrite this?
    #
    def generate_params_for_request(text, params = {})
      tmp = {
        text: text, format: format.type, lang: language.code,
        speaker: voice.name, key: key.value, emotion: emotion.type,
        speed: speed.value }

      tmp[:format]  = params[:format].type  if params[:format]
      tmp[:lang]    = params[:lang].code    if params[:lang]
      tmp[:speaker] = params[:speaker].name if params[:speaker]
      tmp[:emotion] = params[:emotion].type if params[:emotion]
      tmp[:speed]   = params[:speed].value  if params[:speed]

      tmp
    end

    #
    # This is supposed to been raised when user tries to #say too big text.
    #
    class TextTooBig < StandardError
      def initialize; super 'Text message length limited by 2000 symbols per request' end; end

    #
    # This is supposed to been raised when user tries to call #say method
    # without +key+.
    #
    class KeyNotDefined < StandardError
      def initialize; super Key.warn_message end; end
  end # class Speaker
end # module YandexSpeechApi
