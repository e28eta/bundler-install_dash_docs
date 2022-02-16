require 'thor'
require "bundler/install_dash_docs"

module Bundler
  module InstallDashDocs
    class CLI < ::Thor

      desc "install", "Install docsets for all gems in this bundle into Dash.app"
      method_option :quiet, type: :boolean, default: false, aliases: '-q', desc: "Supresses normal output of the gem names and versions"
      method_option :dry_run, type: :boolean, default: false, aliases: '-n', desc: "Print out what would be performed, but do not install docsets in Dash"
      method_option :gemfile_lock, type: :string, lazy_default: "", aliases: '-G', desc: "Provide custom path to the Gemfile.lock to parse"
      method_option :trace, type: :boolean, default: false, desc: "Print commands executed"
      method_option :dependencies_only, type: :boolean, default: false, desc: "Default behavior is to install all gems from the Gemfile.lock. This option only installs those found in the Dependencies section, which are the ones explicitly listed in the Gemfile"
      def install
        quiet = options[:quiet]

        lockfile_contents = read_custom_gemfile_lock(options[:gemfile_lock], quiet)
        lockfile = Lockfile.new(lockfile_contents)
        gems = if options[:dependencies_only]
          puts "Only processing gems from Dependencies section" unless quiet
          lockfile.dependencies
        else
          puts "Processing all gems" unless quiet
          lockfile.all_gems
        end
        puts

        gems.map { |name, version| DashUrl.new(name, version) }
        .each { |url|
          puts "Installing docs for #{url.gem_name} #{url.version}" unless quiet
          command = [
            "open",
            "-g",
            url.to_str
          ]
          puts("+ " + command.join(" ")) if options[:trace]
          unless options[:dry_run]
            system(*command)
            sleep 2
          end
        }
      end

      desc "version", "Prints bundler-install_dash_docs version"
      def version
        puts "bundler-install_dash_docs #{VERSION}"
      end

      private

      def read_custom_gemfile_lock(gemfile, quiet)
        if gemfile.nil?
          nil
        elsif gemfile.empty?
          raise(ArgumentError, "--gemfile_lock/-G requires a path")
        elsif !File.exist?(gemfile)
          raise(FileNotFound, "custom Gemfile.lock file not found: #{gemfile}")
        else
          puts "Reading custom Gemfile.lock from `#{gemfile}`" unless quiet
          Bundler.read_file(gemfile)
        end
      end
    end
  end
end
