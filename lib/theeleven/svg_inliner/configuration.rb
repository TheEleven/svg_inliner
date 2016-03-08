module Theeleven
  module SvgInliner
    class << self
      attr_accessor :configuration
    end

    def self.configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    class Configuration
      attr_accessor :class
      attr_accessor :path
      attr_accessor :aria

      def initialize
        @class = 'icon'
        @path = "#{Rails.root}/app/assets/images/iconset.svg"
        @aria = true
      end
    end
  end
end
