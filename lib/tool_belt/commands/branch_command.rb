module ToolBelt
  module Command
    class BranchCommand < Clamp::Command

      parameter "config_file", "Release configuration file"

      def execute
        config = ToolBelt::Config.new(config_file)
        if File.exist?("repos/#{config.options.namespace}")
          repositories = ToolBelt::Repository.parse(config)
          repositories.each do |repo|
            repo.create_or_checkout_branch
          end
        else
          puts "You must run `setup-environment` before `branch`."
        end
      end
    end
  end
end
