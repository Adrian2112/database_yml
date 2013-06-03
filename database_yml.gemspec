# encoding: utf-8
Gem::Specification.new do |s|
  s.name        = 'database_yml'
  s.version     = '0.0.1'
  s.date        = '2013-06-03'
  s.summary     = "Generate database yml for rails projects"
  s.description = "Generate database yml for rails projects"
  s.authors     = ["Adrián González"]
  s.email       = 'adrian@icalialabs.com'
  s.files       = ["lib/database_yml.rb"] + Dir['lib/templates/*']
  s.homepage    = 'http://rubygems.org/gems/database_yml'

  s.executables << 'database_yml'
  
end
