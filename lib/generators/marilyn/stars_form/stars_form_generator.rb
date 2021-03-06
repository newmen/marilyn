require 'rails/generators/base'

module Marilyn
  module Generators
    class StarsFormGenerator < Rails::Generators::Base
      desc "Installs stars from builder into application"
      source_root File.dirname(__FILE__)

      def copy_form_builder_file
        fish_copy('lib/stars_form_builder.rb')
      end

      def extend_environment
        append_to_file('config/environment.rb', "require File.dirname(__FILE__) + '/../lib/stars_form_builder'\n")
      end
    end
  end
end
