# coding: utf-8

require 'google-analytics/rails/view_helpers'

module GoogleAnalytics::Rails
  # @private
  class Railtie < ::Rails::Railtie
    initializer "google-analytics-rails" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
