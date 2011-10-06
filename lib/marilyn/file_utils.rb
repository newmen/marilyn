module Marilyn
  module FileTools

    protected

    def install_gem_into_gemfile(gem_name)
      inject_into_file('Gemfile', "gem '#{gem_name}'\n", :after => /gem..marilyn..*\n/)
    end

  end
end