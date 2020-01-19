Gem::Specification.new do |s|
  s.name        = 'cli_key_fetcher'
  s.version     = '0.0.3'
  s.date        = '2017-12-14'
  s.summary     = "A common library to capture keys and secret kes on the command line"
  s.description = "CLI Key Fetcher"
  s.authors     = ["Steve Vanspall"]
  s.email       = 'steve@vanspall.id.au'
  s.files       = ["lib/cli_key_fetcher.rb"]
  s.add_dependency "activesupport"
  s.add_development_dependency "byebug"
  s.license       = 'MIT'
end
