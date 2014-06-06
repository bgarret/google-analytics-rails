# coding: utf-8

require 'google-analytics/async_tracking_queue'
require 'google-analytics/events'

module GoogleAnalytics
  # @private
  PLACEHOLDER_TRACKER = "UA-xxxxxx-x"
  # GA sources.
  # Allowing easy switch between DEFAULT and DoubleClick scripts.
  # @see http://support.google.com/analytics/bin/answer.py?hl=en&answer=2444872 for more info
  #
  # @private
  SCRIPT_SOURCES = {
    :default     => "('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js'",
    :doubleclick => "('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js'",
  }

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

  # @return [String]
  def self.script_source
    @@src ||= SCRIPT_SOURCES[:default]
  end

  # Set the current ga src.
  # @return [String]
  def self.script_source=(src)
    if SCRIPT_SOURCES.has_key?(src)
      @@src = SCRIPT_SOURCES[src]
    else
      @@src = src
    end
  end
end

# Alias for {GoogleAnalytics}
GA = GoogleAnalytics

if defined?(Rails)
  require 'google-analytics/rails/railtie'

  # Alias for {GoogleAnalytics::Rails}
  GAR = GoogleAnalytics::Rails
end
