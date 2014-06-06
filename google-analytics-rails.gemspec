# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "google-analytics/version"

Gem::Specification.new do |s|
  s.name        = "google-analytics-rails"
  s.version     = GoogleAnalytics::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Benoit Garret", "Ufuk Kayserilioglu"]
  s.email       = ["benoit.garret@gadz.org", "ufuk@paralaus.com"]
  s.homepage    = "https://github.com/bgarret/google-analytics-rails"
  s.summary     = %q{Rails 3 helpers to manage google analytics tracking}
  s.description = %q{Rails 3 helpers to manage google analytics tracking}

  s.rubyforge_project = "google-analytics-rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
