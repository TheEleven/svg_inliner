module TheEleven
  module SvgInliner
    class << self
      attr_accessor :configuration
    end

    def self.configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    class Configuration
      attr_accessor :css_class
      attr_accessor :file
      attr_accessor :path
      attr_accessor :aria
      attr_accessor :role
      attr_accessor :fallback

      def initialize
        self.css_class = 'icon'
        self.path = "/lib/assets/images/"
        self.file = 'iconset.svg'
        self.role = 'img'
        self.aria = true
        self.fallback = false
      end
    end

    self.configuration = Configuration.new if self.configuration.blank?

    def self.defaultOptions
      {
        class: TheEleven::SvgInliner.configuration.css_class, #svg tag classes
        path: TheEleven::SvgInliner.configuration.path,
        file: TheEleven::SvgInliner.configuration.file, #path to svg file
        role: TheEleven::SvgInliner.configuration.role, #add accessiablity attributes
        aria: TheEleven::SvgInliner.configuration.aria,
        fallback: TheEleven::SvgInliner.configuration.fallback
      }
    end
  end
end
