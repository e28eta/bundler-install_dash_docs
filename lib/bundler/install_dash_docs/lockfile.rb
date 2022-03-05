require "bundler"

module Bundler
  module InstallDashDocs
    ##
    # Reads & parses a Gemfile.lock Lockfile, to extract the gems listed in it
    #
    # Note that some gems may be listed multiple times, with different versions
    class Lockfile
      ##
      # Array of [gem_name, version] pairs that are listed in the Dependencies section. Most likely ones that're specifically requested
      # by the Gemfile
      attr_reader :dependencies
      ##
      # Array of [gem_name, version] pairs that includes all gems from the Lockfile
      attr_reader :all_gems

      ##
      # Constructor that parses gem names and versions from the Lockfile
      #
      # @param [String, nil] lockfile_contents if non-nil, this string's contents are used instead of the Bundler.default_lockfile
      def initialize(lockfile_contents = nil)
        lockfile_contents ||= Bundler.default_lockfile.read
        @parser = Bundler::LockfileParser.new(lockfile_contents)

        # dictionary of gem name to array of Bundler::LazySpecification
        @specs = @parser.specs.group_by(&:name)

        # create arrays of [name, version] pairs for all specs,
        # and only for dependencies from Gemfile
        @all_gems, @dependencies = [
          @specs,
          @parser.dependencies
        ].map { |hash|
          hash.keys
            .sort
            .flat_map { |name|
            versions_for_name(name).map { |version| [name, version] }
          }
        }
      end

      private

      # Returns an array of version strings
      def versions_for_name(name)
        @specs[name]
          .map(&:version).map(&:to_s) # pull version from LazySpecification
          .sort
          .uniq
      end
    end
  end
end
