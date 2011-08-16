require 'rails/generators/base'

module Marilyn
  module Generators
    class FishGenerator < Rails::Generators::Base
      source_root File.dirname(__FILE__)

      def copy_templates
        directory('templates', 'lib/templates')
      end

      def replace_application_helper
        app_helper_file = 'app/helpers/application_helper.rb'
        remove_file(app_helper_file)
        copy_file('helpers/application_helper.rb', app_helper_file)
      end

      def replace_layouts
        app_layout_file = 'app/views/layouts/application.html.erb'
        remove_file(app_layout_file)
        copy_file('layouts/application.html.erb', app_layout_file)
        copy_file('layouts/_form_errors.html.erb', 'app/views/layouts/_form_errors.html.erb')
      end

      def replace_locales
        remove_file('config/locales/en.yml')
        copy_file('locales/en.yml', 'config/locales/en.yml')
        copy_file('locales/ru.yml', 'config/locales/ru.yml')
      end
    end
  end
end
