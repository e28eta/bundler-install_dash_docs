require "addressable/uri"

module Bundler
  module InstallDashDocs
    ##
    # A dash-specific URL for installing the given gem's documentation at specified version
    #
    # documentation https://kapeli.com/dash_install
    class DashInstallUrl
      attr_reader :gem_name, :version

      ##
      # @param [String] gem_name the name of the gem
      # @param [String] version the specific version of the gem
      def initialize(gem_name, version)
        @gem_name = gem_name
        @version = version
      end

      ##
      # @return [String] properly encoded URL to tell Dash.app to install this gem's documentation
      def to_str
        enc_name = Addressable::URI.encode_component(@gem_name, Addressable::URI::CharacterClasses::UNRESERVED)
        enc_version = Addressable::URI.encode_component(@version, Addressable::URI::CharacterClasses::UNRESERVED)

        "dash-install://repo_name=Ruby%20Docsets&entry_name=#{enc_name}&version=#{enc_version}"
      end
    end
  end
end
