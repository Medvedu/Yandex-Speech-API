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
      # @exceptions
      #   @see Connection#with_exception_control
      #
      # @return [RestClient::Response]

      def send(**params)
        with_exception_control do
          return RestClient.get URL, params: params
        end
      end

      private

      ##
      # Holds exceptions for Connection#send.
      #
      # @exception RestClient::Exception
      #   Raised when request is unsuccessful.

      def with_exception_control
        yield
      rescue RestClient::Exception => exception
        raise ConnectionRefused, exception
      end

      ##
      # YandexAPI endpoint.

      URL = "https://tts.voicetech.yandex.net/generate"
    end # class << self

    ##
    # Raised when RestClient::Exception failed for some reason.

    class ConnectionRefused < StandardError
      def initialize(exception); super "Connection refused by remote server. Exception message: '#{exception.message}'" end; end
  end # module Connection
end # module YandexSpeechApi
