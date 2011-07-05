module GoogleAnalytics
  module Rails
    PLACEHOLDER_TRACKER = "UA-xxxxxx-x"

    mattr_accessor :tracker
    @@tracker = PLACEHOLDER_TRACKER

    def self.valid_tracker?
      tracker.blank? || tracker == PLACEHOLDER_TRACKER ? false : true
    end
  end
end

GAR = GoogleAnalytics::Rails

require 'google-analytics-rails/railtie' if defined?(Rails)
