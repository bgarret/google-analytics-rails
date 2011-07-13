require 'google_analytics_tools'

module GoogleAnalytics::Rails
  module ViewHelpers
    def analytics_init
      raise ArgumentError, "Tracker must be set! Did you set GAR.tracker ?" unless GAR.valid_tracker?

      queue = GAQ.new
      queue << GAQ::Events::SetAccount.new(GAR.tracker)
      queue << GAQ::Events::TrackPageview.new
      queue << GAQ::Events::TrackPageLoadTime.new

      queue.to_s.html_safe
    end

    def analytics_track_event(category, action, label, value)
      analytics_render_event(GAQ::Events::TrackEvent.new(category, action, label, value))
    end

    def analytics_add_transaction(order_id, store_name, total, tax, shipping, city, state_or_province, country)
      analytics_render_event(GAQ::Events::ECommerce::AddTransaction.new(order_id, store_name, total, tax, shipping, city, state_or_province, country))
    end

    def analytics_add_item(order_id, product_id, product_name, product_variation, unit_price, quantity)
      analytics_render_event(GAQ::Events::ECommerce::AddItem.new(order_id, product_id, product_name, product_variation, unit_price, quantity))
    end

    def analytics_track_transaction
      analytics_render_event(GAQ::Events::ECommerce::TrackTransaction.new)
    end

    private

    def analytics_render_event(event)
      raise ArgumentError, "Tracker must be set! Did you set GAR.tracker ?" unless GAR.valid_tracker?
      GAQ::EventRenderer.new(event, GAR.tracker).to_s.html_safe
    end
  end
end
