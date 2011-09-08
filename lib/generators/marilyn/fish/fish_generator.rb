require 'rails/generators/base'
require 'devise'
#require 'jquery-rails'

module Marilyn
  module Generators
    class FishGenerator < Rails::Generators::Base
      desc "Installs advanced templates for Rails generators and adding some functional files"
      source_root File.dirname(__FILE__)

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

      def copy_locales
        en_locale_file = 'config/locales/en.yml'
        copy_file(en_locale_file, :force => force_change?(en_locale_file))
        copy_file('config/locales/ru.yml')
      end

      def invoke_stars_form_generator
        log :invoke, 'marilyn:stars_form'
        invoke('marilyn:stars_form')
      end

      def copy_reset_css
        copy_file('app/assets/stylesheets/reset.css')
      end

      def invoke_welcome_controller_generator
        log :invoke, 'marilyn:welcome'
        invoke('marilyn:welcome')
      end

      def install_russian_game
        install_gem_into_gemfile('russian')
      end

      #def invoke_jquery_rails
      #  log :invoke, 'jquery:install'
      #  invoke('jquery:install', [], :ui => true)
      #  install_gem_into_gemfile('jquery-rails')
      #end

      def invoke_devise
        log :invoke, 'devise'
        invoke('devise:install')
        invoke('devise', ['User'])
        install_gem_into_gemfile('devise')

        action_mailer_str = "\nconfig.action_mailer.default_url_options = { :host => 'localhost:3000' }\n"
        last_line_regexp = /config\.assets\.debug = true\n/
        inject_into_file('config/environments/development.rb', action_mailer_str, :after => last_line_regexp)

        action_mailer_str = "\nconfig.action_mailer.default_url_options = { :host => 'black-sheep.ru' }\n"
        last_line_regexp = /config\.active_support\.deprecation = :notify\n/
        inject_into_file('config/environments/production.rb', action_mailer_str, :after => last_line_regexp)
      end

      def copy_default_user_migration
        migration_path = 'db/migrate/'
        migration_file = 'add_default_user.rb'
        copy_file("#{migration_path}#{migration_file}",
                  "#{migration_path}#{Time.now.strftime('%Y%m%d%H%M%S')}_#{migration_file}")
      end

      def invoke_cancan_ability
        log :invoke, 'cancan:ability'
        invoke('cancan:ability')
        install_gem_into_gemfile('cancan')
      end

      def say_than_need_bundle
        say "Fish successfully installed."
        say "Now you need run bundle install.", :green
      end

      protected

      def force_change?(file_name)
        result = ask("replace #{file_name}? [Yn]", :green)
        result == '' || result.downcase == 'y' || result.downcase == 'yes'
      end

      def install_gem_into_gemfile(gem_name)
        marilyn_gem_regexp = /gem..marilyn..*\n/
        inject_into_file('Gemfile', "gem '#{gem_name}'\n", :after => marilyn_gem_regexp)
      end
    end
  end
end
