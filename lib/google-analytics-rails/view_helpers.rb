require 'google_analytics_tools'

module GoogleAnalytics::Rails
  module ViewHelpers
    def analytics_init
      raise ArgumentError, "Tracker must be set! Run 'rake google-analytics:install' to create the initializer." if GAR.tracker.blank?

      queue = GAQ.new
      queue << GAQ::Events::SetAccount.new(GAR.tracker)
      queue << GAQ::Events::TrackPageView.new
      queue << GAQ::Events::TrackPageLoadTime.new

      queue.to_s
    end

    def analytics_track_event(category, action, label, value)
      analytics_render_event(GAQ::Events::TrackEvent.new(category, action, label, value))
    end

    private

    def analytics_render_event(event)
      raise ArgumentError, "Tracker must be set! Run 'rake google-analytics:install' to create the initializer." if GAR.tracker.blank?
      GAQ::EventRenderer.new(event, GAR.tracker).to_s
    end
  end
end
