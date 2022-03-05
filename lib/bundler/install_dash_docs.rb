# frozen_string_literal: true

require_relative "install_dash_docs/version"
require_relative "install_dash_docs/bundler_plugin"
require_relative "install_dash_docs/cli"
require_relative "install_dash_docs/dash"
require_relative "install_dash_docs/dash_install_url"
require_relative "install_dash_docs/lockfile"

module Bundler
  module InstallDashDocs
    class ArgumentError < StandardError; end

    class FileNotFound < StandardError; end
  end
end
