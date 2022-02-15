# frozen_string_literal: true

require "test_helper"

class Bundler::TestInstallDashDocs < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Bundler::InstallDashDocs::VERSION
  end

  [
    # basic case
    ["foo", "1.0.0", "dash-install://repo_name=Ruby%20Docsets&entry_name=foo&version=1.0.0"],
    # percent encodes ampersand
    ["foo&bar", "abc&def", "dash-install://repo_name=Ruby%20Docsets&entry_name=foo%26bar&version=abc%26def"],
  ].each do |(name, version, expected_string)|
    define_method("test_#{name}_#{version}") do
        assert_equal expected_string, ::Bundler::InstallDashDocs::DashUrl.new(name, version).to_str
      end
  end
end
