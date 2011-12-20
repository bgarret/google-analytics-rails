This gem need the google_analytics_tools found at: https://github.com/bgarret/google_analytics_tools.

In `config/environments/production.rb` :

    # replace this with your tracker code
    GAR.tracker = "UA-xxxxxx-x"

In your layout, in the `<head>` tag :

		<%= analytics_init %>
