# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  #
  # samples: Language.init 'Turkey' ==> instance of Language::Turkey
  #          Language.init :russian ==> instance of Language::Russian
  #          Language.init 'ops'    ==> UnknownLanguageError exception
  #
  class Language
    class << self
      def init(language = :english)
        klass = const_get language.capitalize.to_sym
        klass.build
      rescue NameError
        raise UnknownLanguageError, language
      end

      #
      # Proxy method. Used to call private #new constructor in valid +self+
      #
      # Do not use Language#build method. It will raise an exception!
      #
      def build
        if to_s.split('::').last == 'Language'
          raise AbstractClassCreationError
        else
          new
        end
      end

      #
      # List of allowed languages:
      #
      def list
        @cached_list ||=
          constants.select { |name| const_get(name).class === Class }
                   .reject { |name| name =~ /Error/}
      end
    end # class << self

    private_class_method :new

    # ----------------------------------------------------

    #
    # Pretty format.
    #
    def to_s
      self.class.to_s.split('::').last
    end

    #
    # Override this in child class.
    #
    def code
      raise 'abstract method called'
    end

    private

    #
    # This is supposed to been raised when someone tries to call constructor
    # for abstract +Language+ class.
    #
    class AbstractClassCreationError < StandardError
      def initialize; super "You are not allowed to call constructor for 'Language' class!" end; end

    #
    # This is supposed to been raised when unknown language has been selected.
    #
    class UnknownLanguageError < StandardError
      def initialize(lang); super "Unknown language selected: '#{lang}'. See Language#list for list of allowed languages"; end; end
  end # class Language

  #
  # list of languages:
  #

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
