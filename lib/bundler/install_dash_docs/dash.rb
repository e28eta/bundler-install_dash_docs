module Bundler
  module InstallDashDocs
    ##
    # Methods for interacting with Dash.app
    class Dash
      ##
      # Installs the provided gem documentation into Dash.app
      #
      # @param [String] gem_name the name of the gem
      # @param [String] version the specific version of the gem
      # @param [Boolean] quiet if set to true, informative log messages are suppressed
      # @param [Boolean] trace if set to true, the `open` command that's executed is logged
      # @param [Boolean] dry_run if set to true, `open` command is not executed (but might be printed if trace == true)
      def self.install(gem_name, version, quiet: false, trace: false, dry_run: false)
        puts "Installing docs for #{gem_name} #{version}" unless quiet
        url = DashInstallUrl.new(gem_name, version)
        command = [
          "open",
          "-g",
          url.to_str
        ]
        puts("+ " + command.join(" ")) if trace
        unless dry_run
          system(*command)
          sleep 2
        end
      end
    end
  end
end
