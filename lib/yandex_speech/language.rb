# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  #
  # @sample #1
  #   Language.init 'Turkey' ==> instance of Language::Turkey
  #
  # @sample #2
  #   Language.init :russian ==> instance of Language::Russian
  #
  # @sample #3
  #   Language.init 'ops' ==> UnknownLanguageError exception
  #
  class Language
    class << self
      ##
      # Determines class by +language+ param and creates instance for
      # that class.
      #
      # @exception UnknownLanguageError
      #   raised when language is unknown.
      #
      # @return [Russian, English, Turkey, Ukrain] object instance
      #
      def init(language = :english)
        klass = const_get language.capitalize.to_sym
        klass.build
      rescue NameError
        raise UnknownLanguageError, language
      end

      ##
      # Language object constructor.
      #
      # @exception AbstractClassCreationError
      #   raised when Language#build called
      #
      # @return [Russian, English, Turkey, Ukrain] object instance
      #
      def build
        if to_s.split('::').last == 'Language'
          raise AbstractClassCreationError
        else
          new
        end
      end

      ##
      # List of allowed languages
      #
      # @return [Array<Classes>]
      #
      def list
        @cached_list ||=
          constants.select { |name| const_get(name).class === Class }
                   .reject { |name| name =~ /Error/}

      end
    end # class << self

    private_class_method :new

    # ----------------------------------------------------

    ##
    # Pretty format.
    #
    def to_s
      self.class.to_s.split('::').last
    end

    ##
    # Abstract. Child should override this and return language code.
    #
    # @sample #1
    #   lang = Language.init('Turkey')
    #   lang.code # ==> 'tr-TR'
    #
    # @return [String]
    #
    def code
      raise 'abstract method called'
    end

    private

    ##
    # This is supposed to been raised when someone called constructor for
    # abstract +Language+ class.
    #
    class AbstractClassCreationError < StandardError
      def initialize; super "You are not allowed to call constructor for 'Language' class!" end; end

    ##
    # This is supposed to been raised when unknown language has been selected.
    #
    class UnknownLanguageError < StandardError
      def initialize(lang); super "Unknown language selected: '#{lang}'. See Language#list for list of allowed languages"; end; end
  end # class Language

  # ----------------- add languages here ---------------

  class Language::Russian < Language
    def code
      'ru‑RU'
    end
  end # class Language::Russian

  class Language::English < Language
    def code
      'en-US'
    end
  end # class Language::English

  class Language::Turkey < Language
    def code
      'tr-TR'
    end
  end # class Language::Turkey

  class Language::Ukrain < Language
    def code
      'uk-UK'
    end
  end # class Language::Ukrain
end # module YandexSpeechApi
