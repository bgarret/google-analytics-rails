In `config/environments/production.rb` :

    # replace this with your tracker code
    GAR.tracker = "UA-xxxxxx-x"

In your layout, in the `<head>` tag :

		<%= analytics_init %>
