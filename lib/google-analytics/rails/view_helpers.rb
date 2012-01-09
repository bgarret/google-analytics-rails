require 'active_support/core_ext/string/output_safety'

module GoogleAnalytics::Rails
  # All the helper methods output raw javascript with single quoted strings. This allows more flexbility in choosing when the event gets sent (on page load, on user action, etc).
  #
  # The only exception is {#analytics_init}, which is wrapped in a `<script>` tag.
  #
  # @example This event is always sent on page load
  #
  #     <script>
  #       <%= analytics_track_event "Videos", "Play", "Gone With the Wind" %>
  #     </script>
  #
  # @example This event is sent when the visitor clicks on the link
  #
  #     # note the double quotes around the onclick attribute,
  #     # they are necessary because the javascript is single quoted
  #     <a href="my_url" onclick="<%= analytics_track_event "Videos", "Play", "Gone With the Wind" %>">Link</a>
  #
  # @example Full ecommerce example
  #
  #     # create a new transaction
  #     analytics_add_transaction(
  #       '1234',           # order ID - required
  #       'Acme Clothing',  # affiliation or store name
  #       '11.99',          # total - required
  #       '1.29',           # tax
  #       '5',              # shipping
  #       'San Jose',       # city
  #       'California',     # state or province
  #       'USA'             # country
  #     )
  #
  #     # add an item to the transaction
  #     analytics_add_item(
  #       '1234',           # order ID - required
  #       'DD44',           # SKU/code - required
  #       'T-Shirt',        # product name
  #       'Green Medium',   # category or variation
  #       '11.99',          # unit price - required
  #       '1'               # quantity - required
  #     )
  #
  #     # submit the transaction
  #     analytics_track_transaction
  #
  module ViewHelpers
    # Initializes the Analytics javascript. Put it in the `<head>` tag.
    #
    # @param options [Hash]
    # @option options [Boolean] :local (false) Sets the local development mode.
    #   See http://www.google.com/support/forum/p/Google%20Analytics/thread?tid=741739888e14c07a&hl=en
    # @option options [Array, GoogleAnalytics::Event] :add_events ([])
    #   The page views are tracked by default, additional events can be added here.
    # @options options [String] :page
    #   The optional virtual page view to track through {GA::Events::TrackPageview.new}
    #
    # @example Set the local bit in development mode
    #   analytics_init :local => Rails.env.development?
    #
    # @example Allow links across domains
    #   analytics_init :add_events => Events::SetAllowLinker.new(true)
    #
    # @return [String] a `<script>` tag, containing the analytics initialization sequence.
    #
    def analytics_init(options = {})
      raise ArgumentError, "Tracker must be set! Did you set GA.tracker ?" unless GA.valid_tracker?

      local = options.delete(:local) || false
      events = options.delete(:add_events) || []
      events = [events] unless events.is_a?(Array)

      queue = GAQ.new

      # unshift => reverse order
      events.unshift GA::Events::TrackPageview.new(options[:page])
      events.unshift GA::Events::SetAccount.new(GA.tracker)

      if local
        events.push GA::Events::SetDomainName.new('none')
        events.push GA::Events::SetAllowLinker.new(true)
      end

      events.each do |event|
        queue << event
      end

      queue.to_s.html_safe
    end

    # Track a custom event
    # @see http://code.google.com/apis/analytics/docs/tracking/eventTrackerGuide.html
    #
    # @example
    #
    #     analytics_track_event "Videos", "Play", "Gone With the Wind"
    #
    def analytics_track_event(category, action, label = nil, value = nil)
      analytics_render_event(GA::Events::TrackEvent.new(category, action, label, value))
    end

    # Track an ecommerce transaction
    # @see http://code.google.com/apis/analytics/docs/tracking/gaTrackingEcommerce.html
    def analytics_add_transaction(order_id, store_name, total, tax, shipping, city, state_or_province, country)
      analytics_render_event(GA::Events::Ecommerce::AddTransaction.new(order_id, store_name, total, tax, shipping, city, state_or_province, country))
    end

    # Add an item to the current transaction
    # @see http://code.google.com/apis/analytics/docs/tracking/gaTrackingEcommerce.html
    def analytics_add_item(order_id, product_id, product_name, product_variation, unit_price, quantity)
      analytics_render_event(GA::Events::Ecommerce::AddItem.new(order_id, product_id, product_name, product_variation, unit_price, quantity))
    end

    # Flush the current transaction
    # @see http://code.google.com/apis/analytics/docs/tracking/gaTrackingEcommerce.html
    def analytics_track_transaction
      analytics_render_event(GA::Events::Ecommerce::TrackTransaction.new)
    end

    private

    def analytics_render_event(event)
      raise ArgumentError, "Tracker must be set! Did you set GA.tracker ?" unless GA.valid_tracker?
      GA::EventRenderer.new(event, nil).to_s.html_safe
    end
  end
end
