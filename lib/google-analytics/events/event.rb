# coding: utf-8

module GoogleAnalytics
  class Event
    attr_reader :action, :name, :params

    def initialize(action, name, *params)
      @action = action
      @name = name
      @params = params
    end

    def single_event?
      false
    end
  end
  class SingleEvent
    attr_reader :action, :name, :params
    def initialize(action, *params)
      @action = action
      @params = params
    end
    def single_event?
      true
    end
  end
end
