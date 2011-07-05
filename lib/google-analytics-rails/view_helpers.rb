require 'google_analytics_tools'

module GoogleAnalytics::Rails
  module ViewHelpers
    def analytics_init
      raise ArgumentError, "Tracker must be set! Did you set GAR.tracker ?" unless GAR.valid_tracker?

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
      raise ArgumentError, "Tracker must be set! Did you set GAR.tracker ?" unless GAR.valid_tracker?
      GAQ::EventRenderer.new(event, GAR.tracker).to_s
    end
  end
end
