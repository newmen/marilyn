require 'rails/generators/base'

module Marilyn
  module Generators
    class FishGenerator < Rails::Generators::Base
      desc "Installs advanced templates for Rails generators and adding some functional files"
      source_root File.dirname(__FILE__)

      def invoke_devise
        log :invoke, 'devise User'
        invoke('devise', ['User'])
      end

      def invoke_cancan_ability
        log :invoke, 'cancan:ability'
        invoke('cancan:ability')
      end

      def invoke_stars_form_generator
        log :invoke, 'marilyn:stars_form'
        invoke('marilyn:stars_form')
      end

      def invoke_welcome_controller_generator
        log :invoke, 'marilyn:welcome'
        invoke('marilyn:welcome')
      end

      def copy_templates
        directory('lib/templates')
      end

      def replace_application_helper
        application_helper_file = 'app/helpers/application_helper.rb'
        copy_file(application_helper_file, :force => force_change?(application_helper_file))
      end

      def replace_layout
        application_layout_file = 'app/views/layouts/application.html.erb'
        copy_file(application_layout_file, :force => force_change?(application_layout_file))
      end

      def copy_error_messages_partial
        copy_file('app/views/shared/_error_messages.html.erb')
      end

      def replace_locales
        en_locale_file = 'config/locales/en.yml'
        copy_file(en_locale_file, :force => force_change?(en_locale_file))
        copy_file('config/locales/ru.yml')
      end

      protected

      def force_change?(file_name)
        yes?("replace #{file_name}? [Yn]", :green)
      end
    end
  end
end
