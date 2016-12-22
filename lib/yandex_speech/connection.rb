# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  module Connection # no-doc
    class << self

      ##
      # Sends :get request.
      #
      # @param [Hash] params
      # @option params [String] :text
      # @option params [Symbol] :format
      # @option params [String] :lang
      # @option params [String] :speaker
      # @option params [Symbol] :emotion
      # @option params [Float]  :speed
      # @option params [String, Symbol] :key
      #
      # @exception ConnectionError
      #   Raised when responce is not successful.
      #
      # @return [String]
      #   Binary data.

      def send(**params)
        uri = URI.parse URL
        uri.query = URI.encode_www_form params
        response = Net::HTTP.get_response uri

        case response
        when Net::HTTPSuccess
          return response.body
        else
          raise ConnectionError.new response.code, response.message
        end
      end

      private

      ##
      # YandexAPI endpoint.

      URL = "https://tts.voicetech.yandex.net/generate"
    end # class << self

    ##
    # Raised when connection failed.

    class ConnectionError < YandexSpeechError
      def initialize(code, message); super "Connection refused by remote server. Error code: '#{code}', Exception message: '#{message}'." end; end
  end # module Connection
end # module YandexSpeechApi
