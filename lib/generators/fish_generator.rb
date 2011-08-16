require 'rails/generators/base'

module Marilyn
  module Generators
    class FishGenerator < Rails::Generators::Base
      source_root File.dirname(__FILE__)

      def copy_templates
        directory('templates', 'lib/templates')
      end
    end
  end
end
