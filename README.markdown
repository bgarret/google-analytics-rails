Fast Google Analytics setup for Rails.

Installation
============

Add the following to your `Gemfile`:

    gem 'google-analytics-rails', :git => 'git://github.com/bgarret/google-analytics-rails.git'

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


Different accounts for development and production
-------------------------------------------------

`config/environments/production.rb`:

    # replace this with your production tracker code
    GAR.tracker = "UA-xxxxxx-x"

`config/environments/development.rb`:

    # replace this with your development tracker code
    GAR.tracker = "UA-xxxxxx-x"

`app/views/layout/application.html.erb`, in the `<head>` tag :

		<%= analytics_init :local => Rails.env.development? %>
