# frozen_string_literal: true

require_relative "install_dash_docs/version"
require_relative "install_dash_docs/dash_url"
require_relative "install_dash_docs/lockfile"

module Bundler
  module InstallDashDocs
    class Error < StandardError; end
    # Your code goes here...
  end
end
