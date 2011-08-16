require 'rails/generators/base'

module Marilyn
  module Generators
    class EmailValidatorGenerator < Rails::Generators::Base
      desc "Installs email format validator into application"
      source_root File.dirname(__FILE__)

      def copy_validator_file
        copy_file('lib/email_format_validator.rb')
      end

      def extend_environment
        append_to_file('config/environment.rb', "require File.dirname(__FILE__) + '/../lib/email_format_validator'\n")
      end
    end
  end
end
