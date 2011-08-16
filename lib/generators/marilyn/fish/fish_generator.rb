require 'rails/generators/base'

module Marilyn
  module Generators
    class FishGenerator < Rails::Generators::Base
      source_root File.dirname(__FILE__)

      def copy_templates
        directory('templates', 'lib/templates')
      end

      def replace_application_helper
        copy_file('app/helpers/application_helper.rb', 'app/helpers/application_helper.rb', :force => true)
      end

      def replace_layouts
        copy_file('app/layouts/application.html.erb', 'app/views/layouts/application.html.erb', :force => true)
        copy_file('app/layouts/_form_errors.html.erb', 'app/views/layouts/_form_errors.html.erb')
      end

      def replace_locales
        copy_file('app/locales/en.yml', 'config/locales/en.yml', :force => true)
        copy_file('app/locales/ru.yml', 'config/locales/ru.yml')
      end
    end
  end
end
