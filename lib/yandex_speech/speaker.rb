# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  class Speaker
    private

    #
    # @param [Proc] callback
    #   Used to set object attributes throw {do...end} block.
    #
    # @example Block syntax
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
    #   speaker.say message
    #
    # @return [Speaker]

    def initialize(settings, &callback)
      yield self if block_given?

      @key      ||= Key.new      settings[:key]       || :unknown
      @voice    ||= Voice.new    settings[:voice]     || :jane
      @speed    ||= Speed.new    settings[:speed]     || :standard
      @emotion  ||= Emotion.new  settings[:emotion]   || :neutral
      @language ||= Language.new settings[:language]  || :english
      @format   ||= Format.new   settings[:format]    || :mp3
    end

    ##
    # Prepares and sends request on Yandex Servers.
    #
    # @param [String] text
    #   Something that should been said.
    # @param [Hash] params
    #   Overrides object settings (only for this request)
    #
    # @return [String]

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
    # @option params [Format]   :format   (nil).
    # @option params [Language] :language (nil).
    # @option params [Voice]    :voice    (nil).
    # @option params [Key]      :key      (nil).
    # @option params [Emotion]  :emotion  (nil).
    # @option params [Speed]    :speed    (nil).
    #
    # @exception TextTooBig
    #   Raised when param +text+ too big (>2000 symbols)
    #
    # @return [Hash]

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

    def generate_path # no-doc
      dir_path = File.join ENV['HOME'], 'downloads'

      Dir.mkdir(dir_path) unless Dir.exist?(dir_path)
      filename = "yandex_speech_audio_#{Time.now.strftime "%Y-%m-%d_%H-%M-%S"}"

      return File.join(dir_path, filename)
    end

    ##
    # Raised when user tries to #say too big text.

    class TextTooBig < YandexSpeechError
      def initialize; super 'Text message length limited by 2000 symbols per request' end; end
  end # class Speaker
end # module YandexSpeechApi
