source "http://rubygems.org"

gem 'rake'
gem 'yard'
gem 'activesupport', "~> 3.0"

group :development do
  gem 'pry'
  platforms :ruby_19, :ruby_20, :ruby_21 do
    gem 'pry-stack_explorer'
    gem 'redcarpet'
  end
end

group :test do
  gem 'json'
end

# Specify your gem's dependencies in google-analytics-rails.gemspec
gemspec

