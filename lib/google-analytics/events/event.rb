# coding: utf-8

module GoogleAnalytics
  class Event
    attr_reader :action, :name, :params

    def initialize(action, name, *params)
      @action = action
      @name = name
      @params = params
    end
  end
  class SingleEvent
    attr_reader :action, :params
    def initialize(action, *params)
      @action = action
      @params = params
    end
  end
end
