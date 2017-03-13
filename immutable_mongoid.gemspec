$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "immutable_mongoid/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "immutable_mongoid"
  s.version     = ImmutableMongoid::VERSION
  s.authors     = ["Renan Mendes"]
  s.email       = ["renan.mendes@cerc.inf.br"]
  s.homepage    = "https://immutable-mongoid.github.com"
  s.summary     = "Adds immutable functionality to mongoid."
  s.description = "Adds immutable functionality to mongoid. On update actions, create new record, activating newest record for all other operations."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.1"
  s.add_dependency 'activesupport', '>= 4.0'
  s.add_dependency "mongoid", "~> 6.0"

  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "faker"
  s.add_development_dependency "database_cleaner"

end
