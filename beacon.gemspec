$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "beacon/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "sc-beacon"
  s.version = Beacon::VERSION
  s.authors = ["beacon_test"]
  s.email = ["mohit.khandelwal@flipkart.com"]

  s.summary = " Summary of Beacon."
  s.description = " Description of Beacon."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.1.3"
  # s.add_dependency "jquery-rails"
  s.add_dependency "sc-metrics"
  s.add_dependency "actionpack"

  s.add_development_dependency "mysql2"
end
