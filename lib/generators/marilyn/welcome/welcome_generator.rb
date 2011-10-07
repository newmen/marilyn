require 'rails/generators/base'

module Marilyn
  module Generators
    class WelcomeGenerator < Rails::Generators::Base
      desc "Installs welcome controller into application"
      source_root File.dirname(__FILE__)

      def copy_controller_files
        fish_copy('app/controllers/welcome_controller.rb')
        fish_copy('test/functional/welcome_controller_test.rb')
        fish_copy('app/helpers/welcome_helper.rb')
        fish_copy('test/unit/helpers/welcome_helper_test.rb')
        fish_copy('app/views/welcome/index.html.erb')
      end

      def set_root_route
        #begin_regex = /^.*::Application.routes.draw do\n$/
        #inject_into_file('config/routes.rb', "\n  root :to => 'welcome#index'\n", :after => begin_regex)
        route "root :to => 'welcome#index'"
      end

      def remove_default_index_html
        remove_file('public/index.html')
      end
    end
  end
end
