require_relative 'lib/git_clerk/version'

Gem::Specification.new do |spec|
  spec.name          = 'git_clerk'
  spec.version       = GitClerk::VERSION
  spec.authors       = ['Nicolai Stoianov']
  spec.email         = ['stoianovnk@gmail.com']

  spec.summary       = 'Ruby gem for batch checking local git branches and statuses.'
  spec.description   = 'Uses git commands to iterate through folders and collect info about git branches and statuses.'
  spec.homepage      = 'https://github.com/ston1x/git_clerk'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/ston1x/git_clerk'
  # spec.metadata['changelog_uri'] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  spec.files         = Dir['lib/**/*.rb']
  spec.bindir        = 'bin'
  spec.executables   = ['git_clerk']
  spec.require_paths = ['lib']

  # Specify development dependencies
  spec.add_development_dependency 'pry', '~> 0.13.1'
  spec.add_development_dependency 'rspec', '~> 3.9.0'
  spec.add_development_dependency 'rubocop', '0.88.0'

  # Specify runtime dependencies
  spec.add_runtime_dependency 'colorize', '~> 0.8.1'
end
