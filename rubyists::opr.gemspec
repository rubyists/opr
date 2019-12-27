require_relative 'lib/rubyists::opr/version'

Gem::Specification.new do |spec|
  spec.name          = 'opr'
  spec.version       = Rubyists::Opr::VERSION
  spec.authors       = ['Tj (bougyman) Vanderpoel']
  spec.license       = 'MIT'
  spec.email         = ['tj@rubyists.com']

  spec.summary       = 'A wrapper for the `op` 1password cli.'
  spec.description   = 'This utility/library exposes the 1password `op` cli in an easier to digest form.'
  spec.homepage      = 'https://gitlab.com/rubyists/opr.'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://gitlab.com/rubyists/opr.'
  spec.metadata['changelog_uri'] = 'https://gitlab.com/rubyists/opr/CHANGELOG.md.'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'highline'
  spec.add_dependency 'pry'
  spec.add_dependency 'thor'
  spec.add_dependency 'tty'
  spec.add_dependency 'tty-command'
  spec.add_dependency 'tty-prompt'
  spec.add_development_dependency 'bundler', '< 2.0'
  spec.add_development_dependency 'overcommit'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop-performance'
end
