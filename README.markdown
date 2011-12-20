Fast Google Analytics setup for Rails.

This gem needs the google_analytics_tools found at: https://github.com/bgarret/google_analytics_tools.

Example configurations
======================

Production only
---------------

`config/environments/production.rb`:

    # replace this with your tracker code
    GAR.tracker = "UA-xxxxxx-x"

`app/views/layout/application.html.erb`, in the `<head>` tag :

		<%= analytics_init if Rails.env.production? %>


Different acocunts for development and production
-------------------------------------------------

`config/environments/production.rb`:

    # replace this with your production tracker code
    GAR.tracker = "UA-xxxxxx-x"

`config/environments/development.rb`:

    # replace this with your development tracker code
    GAR.tracker = "UA-xxxxxx-x"

`app/views/layout/application.html.erb`, in the `<head>` tag :

		<%= analytics_init :local => Rails.env.development? %>
