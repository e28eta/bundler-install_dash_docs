# frozen_string_literal: true

require_relative "lib/bundler/install_dash_docs/version"

Gem::Specification.new do |spec|
  spec.name = "bundler-install_dash_docs"
  spec.version = Bundler::InstallDashDocs::VERSION
  spec.authors = ["Dan Jackson"]
  spec.email = ["dan@djackson.org"]

  spec.summary = "Bundler plugin to install gem documentation into the macOS documentation browser Dash https://kapeli.com/dash"
  spec.homepage = "https://github.com/e28eta/bundler-install_dash_docs"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"
  spec.platform = "universal-darwin" # Dash.app is macOS-only, this plugin is broken on other platforms

  spec.metadata["rubygems_mfa_required"] = "true"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/e28eta/bundler-install_dash_docs"
  spec.metadata["changelog_uri"] = "https://github.com/e28eta/bundler-install_dash_docs/blob/main/CHANGELOG.md"
  spec.metadata["funding_uri"] = "https://github.com/sponsors/e28eta"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "addressable", "~> 2.2"
  spec.add_dependency "thor", "~> 1.2"
end
