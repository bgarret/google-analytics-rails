# coding: utf-8
begin
  require 'rails/railtie'
rescue LoadError
else
  require 'google-analytics/rails/view_helpers'

  module GoogleAnalytics::Rails
    # @private
    class Railtie < ::Rails::Railtie
      initializer 'google-analytics-rails' do
        ActionView::Base.send :include, ViewHelpers
      end
    end
  end
# Alias for {GoogleAnalytics::Rails}
  GAR = GoogleAnalytics::Rails
end
