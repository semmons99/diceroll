Gem::Specification.new do |s|
  s.name        = "diceroll"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Shane Emmons"]
  s.email       = ["semmons99@gmail.com"]
  s.summary     = "Awesome diceroll game!"
  s.description = "Awesome diceroll game!"

  s.required_ruby_version     = ">= 1.9.2"
  s.required_rubygems_version = ">= 1.8.5"

  s.add_dependency "highline", "~> 1.6.2"
  s.add_dependency "pry", "~> 0.9.6.2"

  s.add_development_dependency "minitest", "~> 2.6.1"

  s.files =  Dir.glob("{lib,specs}/**/*")
  s.files += %w(diceroll.gemspec)

  s.require_path = "lib"
end
