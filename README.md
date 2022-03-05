# Bundler::InstallDashDocs

A [bundler plugin](https://bundler.io/bundle_plugin.html) that reads your Gemfile.lock and installs the matching documentation into
[Dash.app](https://kapeli.com/dash).

This only makes sense on macOS, and due to limitations in the APIs provided by Dash.app, it can only install the current versions. In the future, I'd love if this could manage a docset for a project, but Dash.app doesn't support that yet.

Requires Dash v3.1.0 per https://kapeli.com/dash_install

## Installation

You probably want to install this at the system level, so it's available for any project that uses bundler. Perhaps:

    $ gem install bundler-install_dash_docs

## Usage

    $ bundle install_dash_docs install

👆 is the most likely usage you'll want. Instead of `install` you can ask for the `version`, or get `help`. Flags to `install` can change the verbosity level: `-q` or `--trace`; can ask for a `--dry-run`; or change the subset of gems installed.

`bundle install_dash_docs help install` will show all the options available.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To test the bundler plugin command, after installing it on the local machine with `rake`, `bundle plugin install bundler-install_dash_docs` will work. Even if the plugin isn't installed, `bundle install_dash_docs` will work, because it uses the Thor CLI executable from your PATH directly.

To release a new version, update the version number with `gem bump`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/e28eta/bundler-install_dash_docs. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/e28eta/bundler-install_dash_docs/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Bundler::InstallDashDocs project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/bundler-install_dash_docs/blob/main/CODE_OF_CONDUCT.md).
