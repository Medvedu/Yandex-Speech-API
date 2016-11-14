# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  #
  # all connections going throw this module.
  #
  module Connection
    class << self
      #
      # sensible key/value pairs for +params+ [hash]
      #
      # params[:text]     # ==> normalized unicode (utf-8) text
      # params[:format]   # ==> sound format (wav, mp3 or opus)
      # params[:lang]     # ==> language
      # params[:speaker]  # ==> voice
      # params[:key]      # ==> your key
      # params[:emotion]  # ==> emotion. Evil, Neutral or Good.
      # params[:speed]    # ==> how fast dictor speaks
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

      #
      # todo: add more exceptions
      #
      def with_exception_control
        yield
      rescue RestClient::Locked => exception
        raise ConnectionRefused, exception
      end

      URL = "https://tts.voicetech.yandex.net/generate"
    end # class << self

    # ----------------------------------------------------

    class ConnectionRefused < StandardError
      def initialize(exception); super "Connection refused by remote server. Probably something wrong with your key. Anyway original exception message: '#{exception.message}''" end; end
  end # module Connection
end # module YandexSpeechApi
