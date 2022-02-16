require "bundler"

module Bundler
  module InstallDashDocs
    class Lockfile
      attr_reader :dependencies, :all_gems

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
