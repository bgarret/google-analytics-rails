# coding: utf-8

module GoogleAnalytics
  class Event
    attr_reader :name, :params
    
    def initialize(name, *params)
      @name = name
      @params = params
    end
  end
end
