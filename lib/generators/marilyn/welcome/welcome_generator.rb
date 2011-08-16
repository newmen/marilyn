require 'rails/generators/base'

module Marilyn
  module Generators
    class WelcomeGenerator < Rails::Generators::Base
      desc "Installs welcome controller into application"
      source_root File.dirname(__FILE__)

      def copy_controller_files
        copy_file('app/controllers/welcome_controller.rb')
        copy_file('test/functional/welcome_controller_test.rb')
        copy_file('app/helpers/welcome_helper.rb')
        copy_file('test/unit/helpers/welcome_helper_test.rb')
        copy_file('app/views/welcome/index.html.erb')
      end

      def set_root_route
        begin_regex = /^.*::Application.routes.draw do\n$/
        inject_into_file('config/routes.rb', "\n  root :to => 'welcome#index'\n", :after => begin_regex)
      end
    end
  end
end
