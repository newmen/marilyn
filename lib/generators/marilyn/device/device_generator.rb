require 'rails/generators/base'
require 'devise'

module Marilyn
  module Generators
    class DeviceGenerator < Rails::Generators::Base
      include FileUtils

      desc "Installs default device and cancan configuration into application"
      source_root File.dirname(__FILE__)

      def install_devise
        log :invoke, 'devise'
        invoke('devise:install')
        invoke('devise', ['User'])
        install_gem_into_gemfile('devise')
      end

      def insert_mail_configurations
        inject_into_file('config/environments/development.rb', action_mailer_str('localhost:3000'),
                         :after => /config\.assets\.debug = true\n/)

        inject_into_file('config/environments/production.rb', action_mailer_str('black-sheep.ru'),
                         :after => /config\.active_support\.deprecation = :notify\n/)
      end

      def copy_default_user_migration
        migration_path = 'db/migrate/'
        migration_file = 'add_default_user.rb'
        copy_file("#{migration_path}#{migration_file}",
                  "#{migration_path}#{Time.now.strftime('%Y%m%d%H%M%S')}_#{migration_file}")
      end

      def copy_locales
        fish_copy('config/locales/devise.en.yml')
        fish_copy('config/locales/devise.ru.yml')
      end

      def invoke_cancan_ability
        log :invoke, 'cancan:ability'
        invoke('cancan:ability')
        install_gem_into_gemfile('cancan')
      end

      protected

      def action_mailer_str(host)
        "\n  config.action_mailer.default_url_options = { :host => '#{host}' }\n"
      end

    end
  end
end
