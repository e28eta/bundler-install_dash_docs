## [Unreleased]

## [0.1.2] - 2022-03-05

- Require MFA for rubygems
- Update gemspec's description, requirements

## [0.1.1] - 2022-03-05

- Probably fixed the issues getting the bundler plugin system to work with this gem.

## [0.1.0] - 2022-03-04

- Initial release. Invokes `dash-install://` for gems in the lockfile
- Broken: cannot execute as a bundler plugin because bundler uses `exec`, but Thor uses `start`.
