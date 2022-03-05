# frozen_string_literal: true

require "test_helper"
require "bundler/install_dash_docs"

class Bundler::TestInstallDashDocs < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Bundler::InstallDashDocs::VERSION
  end

  [
    # basic case
    ["foo", "1.0.0", "dash-install://repo_name=Ruby%20Docsets&entry_name=foo&version=1.0.0"],
    # percent encodes ampersand
    ["foo&bar", "abc&def", "dash-install://repo_name=Ruby%20Docsets&entry_name=foo%26bar&version=abc%26def"]
  ].each do |(name, version, expected_string)|
    define_method("test_#{name}_#{version}") do
      assert_equal expected_string, ::Bundler::InstallDashDocs::DashInstallUrl.new(name, version).to_str
    end
  end

  def test_this_projects_gemfile
    fake_gemfile = Bundler.read_file("test/fixtures/Gemfile-1.lock")
    lockfile = ::Bundler::InstallDashDocs::Lockfile.new(fake_gemfile)

    assert_equal 4, lockfile.dependencies.count, "number of explicitly requested gems"
    assert_equal 17, lockfile.all_gems.count, "including transitive dependencies"
  end

  def test_multiple_versions_for_gem
    fake_gemfile = Bundler.read_file("test/fixtures/Gemfile-2.lock")
    lockfile = ::Bundler::InstallDashDocs::Lockfile.new(fake_gemfile)

    assert_equal 2, lockfile.dependencies.count, "two different nokogiri versions"
    assert_equal 3, lockfile.all_gems.count, "including transitive dependencies"

    # code returns these sorted by name and then version, so this should be stable
    assert_equal ["nokogiri", "1.13.0"], lockfile.dependencies[0]
    assert_equal ["nokogiri", "1.13.1"], lockfile.dependencies[1]

    assert_equal ["nokogiri", "1.13.0"], lockfile.all_gems[0]
    assert_equal ["nokogiri", "1.13.1"], lockfile.all_gems[1]
    assert_equal ["racc", "1.6.0"], lockfile.all_gems[2]
  end

  def test_install_method
    dash_class = ::Bundler::InstallDashDocs::Dash

    # Check the parameters to `system`
    dash_class.stub :system, ->(*args) {
      assert_equal args[0], "open", "Uses open command for custom url scheme execution"
      assert_equal args[1], "-g", "does so in the background"
      assert args[2].start_with?("dash-install://"), "3rd arg is custom url"
    } do
      # turn `sleep` into no-op
      dash_class.stub :sleep, 0 do
        dash_class.install("foo", "1", quiet: true)
      end
    end

    # Check puts call for quiet: false
    dash_class.stub :puts, ->(s) {
      assert_equal s, "Installing docs for foo 1"
    } do
      dash_class.install("foo", "1", dry_run: true)
    end

    # Check puts call for trace: true
    dash_class.stub :puts, ->(s) {
      assert_equal s, "+ open -g #{::Bundler::InstallDashDocs::DashInstallUrl.new("foo", "1").to_str}"
    } do
      dash_class.install("foo", "1", quiet: true, trace: true, dry_run: true)
    end
  end
end
