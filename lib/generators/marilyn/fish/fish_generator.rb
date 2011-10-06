require 'rails/generators/base'

module Marilyn
  module Generators
    class FishGenerator < Rails::Generators::Base
      include FileUtils

      desc "Installs advanced templates for Rails generators and adding some functional files"
      source_root File.dirname(__FILE__)

      def support_ruby192
        support_str = "\n# Supporting Ruby 1.9.2\nrequire 'yaml'\nYAML::ENGINE.yamler = 'syck'\n"
        inject_into_file('config/boot.rb', support_str, :after => /require 'rubygems'\n/)
      end

      def copy_templates
        directory('lib/templates')
      end

      def replace_application_helper
        copy_file('app/helpers/application_helper.rb')
      end

      def replace_layout
        copy_file('app/views/layouts/application.html.erb')
      end

      def copy_error_messages_partial
        copy_file('app/views/shared/_error_messages.html.erb')
      end

      def copy_locales
        copy_file('config/locales/en.yml')
        copy_file('config/locales/ru.yml')
      end

      def invoke_stars_form_generator
        log :invoke, 'marilyn:stars_form'
        invoke('marilyn:stars_form')
      end

      def copy_reset_css
        copy_file('app/assets/stylesheets/application.css')
        copy_file('app/assets/stylesheets/reset.css')
      end

      def invoke_welcome_controller_generator
        log :invoke, 'marilyn:welcome'
        invoke('marilyn:welcome')
      end

      def install_russian_game
        install_gem_into_gemfile('russian')
      end

      def invoke_devise_install
        log :invoke, 'marilyn:devise'
        invoke('marilyn:devise')
      end

      def say_than_need_bundle
        say "Fish successfully installed."
        say "Now you need to run bundle install.", :red
      end

    end
  end
end
