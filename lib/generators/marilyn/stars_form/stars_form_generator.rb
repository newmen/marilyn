require 'rails/generators/base'

module Marilyn
  module Generators
    class StarsFormGenerator < Rails::Generators::Base
      source_root File.dirname(__FILE__)

      def copy_form_builder_file
        copy_file('lib/stars_form_builder.rb')
      end

      def extend_environment
        append_to_file('config/environment.rb', "require File.dirname(__FILE__) + '/../lib/stars_form_builder'")
      end
    end
  end
end
