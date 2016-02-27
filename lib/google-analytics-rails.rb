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
    :default     => "'//www.google-analytics.com/analytics.js'",
    :doubleclick => "'//stats.g.doubleclick.net/dc.js'",
  }
  # @private
  MAX_REGULAR_INDICES = 20
  # @private
  MAX_PREMIUM_INDICES = 200

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

  # @return [Boolean]
  def self.premium_account?
    @@premium_account ||= false
  end

  # Set whether or not the property is held under a premium account
  # @param [Boolean]
  def self.premium_account=(value)
    @@premium_account = value
  end

  # Return the maximum number of custom dimension/metric indices for this type of account
  # @return [Integer]
  def self.max_custom_indices
    premium_account? ? MAX_PREMIUM_INDICES : MAX_REGULAR_INDICES
  end
end

# Alias for {GoogleAnalytics}
GA = GoogleAnalytics

require 'google-analytics/rails/railtie'
