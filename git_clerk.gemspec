require_relative 'lib/git_clerk/version'

Gem::Specification.new do |spec|
  spec.name          = 'git_clerk'
  spec.version       = GitClerk::VERSION
  spec.authors       = ['Nicolai Stoianov']
  spec.email         = ['stoianovnk@gmail.com']

  spec.summary       = %q{TODO: Write a short summary, because RubyGems requires one.}
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = 'https://github.com/ston1x/git_clerk'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/ston1x/git_clerk'
  spec.metadata['changelog_uri'] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Specify development dependencies
  spec.add_development_dependency 'rspec', '~> 3.9.0'

  # Specify runtime dependencies
  spec.add_runtime_dependency 'colorize', '~> 0.8.1'
end
