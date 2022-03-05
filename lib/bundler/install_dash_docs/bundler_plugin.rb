require "bundler"

module Bundler
  module InstallDashDocs
    ##
    # Glue between Bundler Plugin system and Thor executable provided by the gem
    class BundlerPlugin < ::Bundler::Plugin::API
      command "install_dash_docs"

      def exec(command_name, args)
        # I do not know why https://bundler.io/v2.3/guides/bundler_plugins.html
        # tells you to create a gem, use a Thor command, and then doesn't include docs
        # on using that Thor command. However, this seems to be correct
        CLI.start(args)
      end
    end
  end
end
