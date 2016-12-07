# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  module Connection # no-doc
    class << self
      ##
      # Sends :get request to +URL+
      #
      # @param [Hash] params
      # @option [String]         :text
      # @option [Symbol]         :format
      # @option [String]         :lang
      # @option [String]         :speaker
      # @option [String, Symbol] :key
      # @option [Symbol]         :emotion
      # @option [Float]          :speed
      #
      # @exceptions see Connection#with_exception_control
      #
      # @return [binary data, nil]
      #
      def send(params)
        uri = Addressable::URI.parse URL
        uri.query_values = params

        with_exception_control do
          return RestClient::Request.execute :method       => :get,
                                             :url          => uri.to_s,
                                             :timeout      => 10,
                                             :open_timeout => 10
        end
      end

      private

      ##
      # Holds exceptions for Connection#send.
      #
      # @exception RestClient::Locked
      #   raised when request refused by remote server
      #
      def with_exception_control
        yield
      rescue RestClient::Locked => exception
        raise ConnectionRefused, exception
      end

      ##
      # YandexAPI endpoint.
      #
      URL = "https://tts.voicetech.yandex.net/generate"
    end # class << self

    # ----------------------------------------------------

    ##
    # This is supposed to been raised when RestClient::Request failed for
    # some reason.
    #
    class ConnectionRefused < StandardError
      def initialize(exception); super "Connection refused by remote server. Exception message: '#{exception.message}'" end; end
  end # module Connection
end # module YandexSpeechApi
