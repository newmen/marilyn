require 'rails/generators'

module Marilyn
  module Generators
    class Templater < Rails::Generators::Base

      def self.source_root
        File.dirname(__FILE__)
      end

      def copy_templates
        directory('templates', 'lib/templates')
      end
    end
  end
end
