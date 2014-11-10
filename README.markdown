Fast Google Analytics setup for Rails 3. This gem is mostly intended for small to medium websites with a simple analytics strategy.

[![Build Status](https://travis-ci.org/bgarret/google-analytics-rails.png?branch=master)](https://travis-ci.org/bgarret/google-analytics-rails)

Installation
============

Add the following to your `Gemfile`:

    gem 'google-analytics-rails'

Then run:

    bundle install

Upgrade Notes
============

__Upgrading this gem from 0.0.6?__

Use `analytics_init` to send submissions to Analytics if you are using multiple trackers. You can supply a name to tracker by passing `:name` option.

**GoogleAnalytics::Events::SetAllowLinker** is no longer supported as an external variable being set. You can submit as normal in the `:add_events` array, but using the new `:setup` config is preferable so no extra array searching has to happen.

**GoogleAnalytics::Events::SetCustomVar** is no longer supported by Universal Analytics. These have been changed to SetCustomDimension & SetCustomMetric. By default if you use SetCustomVar, it applies as a Dimension

**GoogleAnalytics::Events::DeleteCustomVar** has been removed

**Added Event Helpers**

  - GoogleAnalytics::Events::ExperimentId
  - GoogleAnalytics::Events::ExperimentVariation

**TODO:** Add Double Click Snippet Support
While the code is there, and it looks like it is simply changing the end path to the JS, this feature has not been tested.



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

