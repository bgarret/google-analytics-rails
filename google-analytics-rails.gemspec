# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "google-analytics/version"

Gem::Specification.new do |s|
  s.name                  = "google-analytics-rails"
  s.version               = GoogleAnalytics::VERSION
  s.platform              = Gem::Platform::RUBY
  s.authors               = ["Benoit Garret", "Ufuk Kayserilioglu"]
  s.email                 = ["benoit.garret@gadz.org", "ufuk@paralaus.com"]
  s.homepage              = "https://github.com/bgarret/google-analytics-rails"
  s.summary               = %q{Rails helpers to manage google analytics tracking}
  s.description           = %q{Rails helpers to manage google analytics tracking}
  s.required_ruby_version = '>= 1.9.3'
  s.files                 = `git ls-files`.split("\n")
  s.test_files            = `git ls-files -- {test}/*`.split("\n")
  s.require_paths         = ["lib"]
end
