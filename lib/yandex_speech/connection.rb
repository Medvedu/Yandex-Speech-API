# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  #
  # all connections going throw this module.
  #
  module Connection
    class << self
      #
      # +params+ hash mapping
      #
      # params[:text]     # ==> text
      # params[:format]   # ==> format
      # params[:lang]     # ==> language
      # params[:speaker]  # ==> voice
      # params[:key]      # ==> key
      # params[:emotion]  # ==> emotion
      # params[:speed]    # ==> text
      #
      def send(params)
       uri = Addressable::URI.parse URL
       uri.query_values = params


       with_exception_control do
         return RestClient::Request.execute(:method => :get, :url => uri.to_s, :timeout => 10, :open_timeout => 10)
       end
      end

      private

      #
      # todo: add more exceptions
      #
      def with_exception_control
        yield
      rescue RestClient::Locked => exception
        raise ConnectionRefused.new exception
        return nil
      end

      URL = "https://tts.voicetech.yandex.net/generate".freeze

      class ConnectionRefused < StandardError
        def initialize(exception); super "Connection refused by remote server. Probably something wrong with your key. Anyway exception message was '#{exception.message}''" end; end
    end # class << self
  end # module Connection
end # module YandexSpeechApi
