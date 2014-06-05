Fast Google Analytics setup for Rails 3. This gem is mostly intended for small to medium websites with a simple analytics strategy.

[![Build Status](https://travis-ci.org/bgarret/google-analytics-rails.png?branch=master)](https://travis-ci.org/bgarret/google-analytics-rails)

Installation
============

Add the following to your `Gemfile`:

    gem 'google-analytics-rails'

Then run:

    bundle install

Documentation
=============

http://rubydoc.info/github/bgarret/google-analytics-rails

Example configurations
======================

Production only
---------------

`config/environments/production.rb`:

    # replace this with your tracker code
    GA.tracker = "UA-xxxxxx-x"

`app/views/layout/application.html.erb`, in the `<head>` tag :

		<%= analytics_init if Rails.env.production? %>

With DoubleClick instead of vanilla Google Analytics script
-----------------------------------------------------------

`config/environments/production.rb`:

    # replace this with your tracker code
    GA.tracker = "UA-xxxxxx-x"
    GA.script_source = :doubleclick

`app/views/layout/application.html.erb`, in the `<head>` tag :

		<%= analytics_init if Rails.env.production? %>

Different accounts for development and production
-------------------------------------------------

`config/environments/production.rb`:

    # replace this with your production tracker code
    GA.tracker = "UA-xxxxxx-x"

`config/environments/development.rb`:

    # replace this with your development tracker code
    GA.tracker = "UA-xxxxxx-x"

`app/views/layout/application.html.erb`, in the `<head>` tag :

		<%= analytics_init :local => Rails.env.development? %>

License
=======

[google-analytics-rails](https://github.com/bgarret/google-analytics-rails) is released under the MIT license:

* http://www.opensource.org/licenses/MIT

Thanks
======

Many thanks to [the people that took time to submit patches](https://github.com/bgarret/google-analytics-rails/contributors).

