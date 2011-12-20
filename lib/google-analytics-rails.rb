module GoogleAnalytics
  module Rails
    # @private
    PLACEHOLDER_TRACKER = "UA-xxxxxx-x"

    # The current tracker id (*UA-xxxxxx-x*).
    mattr_accessor :tracker
    # @private
    @@tracker = PLACEHOLDER_TRACKER

    # @return [Boolean]
    def self.valid_tracker?
      tracker.blank? || tracker == PLACEHOLDER_TRACKER ? false : true
    end
  end
end

# Alias for GoogleAnalytics::Rails
GAR = GoogleAnalytics::Rails

require 'google-analytics-rails/railtie' if defined?(Rails)
