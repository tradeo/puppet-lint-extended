Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-extended'
  spec.version     = '1.0.1'
  spec.homepage    = 'https://github.com/tradeo/puppet-lint-extended'
  spec.license     = 'MIT'
  spec.author      = 'Tradeo'
  spec.email       = 'opensource@tradeo.com'
  spec.files       = Dir[
    'README.md',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.test_files  = Dir['spec/**/*']
  spec.summary     = 'Additional checks for puppet-lint'
  spec.description = <<-EOF
    Extends puppet-lint with additional checks.
  EOF

  spec.add_dependency             'puppet-lint', '>= 2.3.1'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-its'
  spec.add_development_dependency 'rspec-collection_matchers'
  spec.add_development_dependency 'rspec-json_expectations'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
end
