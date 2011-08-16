module Marilyn
  module Generators
    class Templater < Thor
      include Thor::Actions

      def self.source_root
        File.dirname(__FILE__)
      end

      desc 'install', 'install the templates and partial files'
      def install
        directory('templates', 'lib/templates')
      end
    end
  end
end
