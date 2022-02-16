require "addressable/uri"

module Bundler
  module InstallDashDocs
    class DashUrl
      attr_reader :gem_name, :version

      def initialize(gem_name, version)
        @gem_name = gem_name
        @version = version
      end

      def to_str
        enc_name = Addressable::URI.encode_component(@gem_name, Addressable::URI::CharacterClasses::UNRESERVED)
        enc_version = Addressable::URI.encode_component(@version, Addressable::URI::CharacterClasses::UNRESERVED)

        "dash-install://repo_name=Ruby%20Docsets&entry_name=#{enc_name}&version=#{enc_version}"
      end
    end
  end
end
