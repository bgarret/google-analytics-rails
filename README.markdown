Fast Universal Google Analytics setup for Rails. This gem is mostly intended for small to medium websites with a simple analytics strategy.

[![Build Status](https://travis-ci.org/bgarret/google-analytics-rails.png?branch=master)](https://travis-ci.org/bgarret/google-analytics-rails)

_if you require older analytics, use `0.0.6`_

Installation
============

Add the following to your `Gemfile`:

    gem 'google-analytics-rails', '1.1.1'

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
    GA.tracker = "UA-112233-4"

`app/views/layout/application.html.erb`, in the `<head>` tag :

		<%= analytics_init if GoogleAnalytics.valid_tracker? %>

With DoubleClick instead of vanilla Google Analytics script
-----------------------------------------------------------

`config/environments/production.rb`:

    # replace this with your tracker code
    GA.tracker = "UA-556677-8"
    GA.script_source = :doubleclick

`app/views/layout/application.html.erb`, in the `<head>` tag :

		<%= analytics_init if GoogleAnalytics.valid_tracker? %>

Different accounts for staging and production
-------------------------------------------------

`config/environments/production.rb`:

    # replace this with your production tracker code
    GA.tracker = "UA-990011-2"

`config/environments/staging.rb`:

    # replace this with your staging tracker code
    GA.tracker = "UA-334455-66"

`app/views/layout/application.html.erb`, in the `<head>` tag :

		<%= analytics_init if GoogleAnalytics.valid_tracker? %>

Premium Google Analytics accounts
---------------------------------

`config/environments/production.rb`:

    # add this if you have a premium account and need to use the additional dimension/metric indices
    # - premium accounts are allowed to have 200 custom dimensions/metrics
    # - regular accounts are allowed 20
    # see also: https://support.google.com/analytics/answer/2709828?hl=en#Limits
    GA.premium_account = true

License
=======

[google-analytics-rails](https://github.com/bgarret/google-analytics-rails) is released under the MIT license:

* http://www.opensource.org/licenses/MIT

Thanks
======

Many thanks to [the people that took time to submit patches](https://github.com/bgarret/google-analytics-rails/contributors).

