# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  class Speaker
    private

    #
    # @sample Block syntax
    #
    #   key = 'Your secret key'#
    #   message = "one two three. one two three. one two three four."
    #
    #   speaker = YandexSpeechApi::Speaker.init do |s|
    #     s.key      = key
    #     s.voice    = :jane
    #     s.language = :english
    #     s.speed    = :slow
    #     s.emotion  = :good
    #   end
    #
    #   speaker.say message
    #
    # @return [Speaker] object instance
    #
    def initialize(settings)
      yield self if block_given?

      @key      ||= Key.new settings[:key]
      @voice    ||= Voice.new settings[:voice]
      @speed    ||= Speed.new settings[:speed]
      @emotion  ||= Emotion.new settings[:emotion]
      @language ||= Language.init settings[:language]
      @format   ||= Format.new settings[:format]
    end

    ##
    # Prepares and sends request on Yandex Servers.
    #
    # @param [String] text something that should been said.
    # @param [Hash] params overrides object state (only for _this_ request)
    #
    # @return [Array] memoized binary file.
    #
    def request(text, params = {})
      tmp_params = generate_params_for_request text, params
      Connection.send tmp_params
    end

    ##
    # Generates params for request.
    #
    # @param [String] text
    #
    # @param [Hash] params ({})
    # @option [Format]   :format   (nil).
    # @option [Language] :language (nil).
    # @option [Voice]    :voice    (nil).
    # @option [Key]      :key      (nil).
    # @option [Emotion]  :emotion  (nil).
    # @option [Speed]    :speed    (nil).
    #
    # @exception TextTooBig
    #   raised when param +text+ too big (>2000 symbols)
    #
    # @return [Hash]
    #
    def generate_params_for_request(text, params = {})
      tmp_text = text.dup.encode(Encoding::UTF_8, invalid: :replace,
                                 undef: :replace, replace: '')
      raise TextTooBig if tmp_text.length > 2000

      tmp = {
        text:    tmp_text,
        format:  params[:format]   ? params[:format].type   : format.type,
        lang:    params[:language] ? params[:language].code : language.code,
        speaker: params[:voice]    ? params[:voice].name    : voice.name,
        key:     params[:key]      ? params[:key].get       : key.get,
        emotion: params[:emotion]  ? params[:emotion].type  : emotion.type,
        speed:   params[:speed]    ? params[:speed].value   : speed.value
      }

      return tmp
    end

    ##
    # This is supposed to been raised when user tries to #say too big text.
    #
    class TextTooBig < StandardError
      def initialize; super 'Text message length limited by 2000 symbols per request'; end; end
  end # class Speaker
end # module YandexSpeechApi
