In config/environments/production.rb :

    GAR.tracker = "UA-xxxxxx-x"

In your layout, between the `<head>` tag :

		<%= analytics_init %>
