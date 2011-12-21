require 'google-analytics/async_tracking_queue'
require 'google-analytics/events'

module GoogleAnalytics
  # @private
  PLACEHOLDER_TRACKER = "UA-xxxxxx-x"

  # Get the current tracker id (*UA-xxxxxx-x*).
  # @return [String]
  def self.tracker
    @@tracker ||= PLACEHOLDER_TRACKER
  end

  # Set the current tracker id.
  # @param [String] tracker The tracker id (ie. "*UA-xxxxxx-x*").
  def self.tracker=(tracker)
    @@tracker = tracker
  end

  # @return [Boolean]
  def self.valid_tracker?
    tracker.nil? || tracker == "" || tracker == PLACEHOLDER_TRACKER ? false : true
  end
end

# Alias for {GoogleAnalytics}
GA = GoogleAnalytics

if defined?(Rails)
  require 'google-analytics/rails/railtie'

  # Alias for {GoogleAnalytics::Rails}
  GAR = GoogleAnalytics::Rails
end
