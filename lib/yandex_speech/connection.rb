# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  module Connection # no-doc

    ##
    # Sends HTTP request to Yandex API Endpoint
    #
    # @param [Hash] params
    #   Each key/value pair from Hash used for query generation.
    #
    # @exception ConnectionError
    #   Raised when responce is not successful.
    #
    # @return [String]
    #   Binary data.

    def self.send(**params)
      uri = URI.parse ENDPOINT
      uri.query = URI.encode_www_form params
      response = Net::HTTP.get_response uri

      case response
      when Net::HTTPSuccess
        return response.body
      else
        raise ConnectionError.new response.code, response.message
      end
    end

    ##
    # YandexAPI endpoint.

    ENDPOINT = "https://tts.voicetech.yandex.net/generate"
    private_constant :ENDPOINT

    ##
    # Raised when connection failed.

    class ConnectionError < YandexSpeechError
      def initialize(code, message); super "Connection refused by remote server. Error code: '#{code}', Exception message: '#{message}'." end; end
  end # module Connection
end # module YandexSpeechApi
