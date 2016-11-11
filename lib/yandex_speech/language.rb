# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  #
  # samples: Language.init 'Turkey' ==> instance of language class
  #          Language.init :russian ==> instance of language class
  #          Language.init 'ops'    ==> UnknownLanguageError exception
  #
  class Language
    class << self
      def init(language)
        klass = const_get language.capitalize.to_sym
        klass.send :new
      rescue NameError
        raise UnknownLanguageError.new language
      end

      #
      # List of allowed languages:
      #
      def list
        @cached_list ||=
          constants.select do |name|
            const_get(name).class === Class && name != :UnknownLanguageError
          end
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
