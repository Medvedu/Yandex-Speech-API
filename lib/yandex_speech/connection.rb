# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  module Connection # no-doc

    # @param [Hash] params
    #
    # @exception ConnectionError
    #   Raised when responce is not successful.
    #
    # @return [String]
    #   Response as binary data.

    def self.send(**params)
      uri = URI.parse(ENDPOINT_OFFICIAL)
      uri.query = URI.encode_www_form params
      response = Net::HTTP.get_response uri

      unless response.is_a? Net::HTTPSuccess
        raise ConnectionError.new(response.code, response.message)
      end

      return response.body
    end

    ENDPOINT_OFFICIAL     = "https://tts.voicetech.yandex.net/generate"
    #ENDPOINT_NON_OFFICIAL = "https://tts.voicetech.yandex.net/tts?&platform=web&application=translate"

    private_constant :ENDPOINT_OFFICIAL

    class ConnectionError < StandardError
      def initialize(code, message); super "Connection refused by remote server. Error code: '#{code}', Exception message: '#{message}'." end; end
  end # module Connection
end # module YandexSpeechApi
