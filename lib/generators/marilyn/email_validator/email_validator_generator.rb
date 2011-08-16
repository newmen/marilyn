require 'rails/generators/base'

module Marilyn
  module Generators
    class EmailValidatorGenerator < Rails::Generators::Base
      source_root File.dirname(__FILE__)

      def copy_validator_file
        copy_file('lib/email_format_validator.rb')
      end

      def extend_environment
        append_to_file('config/environment.rb', "require File.dirname(__FILE__) + '/../lib/email_format_validator'")
      end
    end
  end
end
