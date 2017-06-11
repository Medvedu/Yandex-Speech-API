# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  class Speaker
    private

    # @param [String] text
    #   Something that should been said.
    #
    # @return [String]

    def request(text)
      params = generate_params text

      response = if key
                   Connection.send params
                 else
                   raise StandardError, "Request cannot been completed without key."
                 end

      return response
    end

    ##
    # Generates params for request.
    #
    # @param [String] text
    #
    # @exception TextTooBig
    #   Raised when param +text+ too big (>2000 symbols)
    #
    # @return [Hash]

    def generate_params(text)
      txt = text.dup.encode(Encoding::UTF_8, invalid: :replace,
                            undef: :replace, replace: '')

      if txt.length > 2000
        raise TextTooBig, 'Text too big. Only 2000 symbols per request are allowed.'
      end

      tmp = {
        text:    txt,
        format:  format,
        lang:    language,
        speaker: voice,
        key:     key,
        emotion: emotion,
        speed:   speed
      }

      return tmp
    end

    def generate_path
      dir_path = Dir.pwd
      filename = "yandex_speech_audio_#{Time.now.strftime "%Y-%m-%d_%H-%M-%S"}"

      return File.join(dir_path, filename)
    end
  end # class Speaker
end # module YandexSpeechApi
