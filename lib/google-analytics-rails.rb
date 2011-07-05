module GoogleAnalytics
  module Rails
    mattr_accessor :tracker
    @@tracker = ""
  end
end

GAR = GoogleAnalytics::Rails

require 'google-analytics-rails/railtie' if defined?(Rails)
