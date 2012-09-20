require 'google-analytics/async_tracking_queue'
require 'google-analytics/events'

module GoogleAnalytics
  # @private
  PLACEHOLDER_TRACKER = "UA-xxxxxx-x"
  # @private
  DEFAULT_SCRIPT_SOURCE = "('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js'"

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

  # Get the current ga src.
  # This allows for example to use the compatible doubleclick code :
  # ```
  #   ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js'
  # ```
  # @see http://support.google.com/analytics/bin/answer.py?hl=en&answer=2444872 for more info
  #
  # @return [String]
  def self.script_source
    @@src ||= DEFAULT_SCRIPT_SOURCE
  end

  # Set the current ga src.
  # @return [String]
  def self.script_source=(src)
    @@src = src
  end
end

# Alias for {GoogleAnalytics}
GA = GoogleAnalytics

if defined?(Rails)
  require 'google-analytics/rails/railtie'

  # Alias for {GoogleAnalytics::Rails}
  GAR = GoogleAnalytics::Rails
end
