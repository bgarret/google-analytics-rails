# coding: utf-8

module GoogleAnalytics
  class EventCollection
    include Enumerable
    
    class InvalidEventError < StandardError
      def initialize(non_event)
        super("EventCollection#<< expects instances of Event, you passed #{non_event}")
      end
    end
    
    def initialize
      @events = []
    end
    
    def <<(event)
      raise InvalidEventError.new(event) unless event.is_a?(Event) || event.is_a?(SingleEvent)

      @events << event
    end

    def each
      @events.each { |e| yield e }
    end

    def length
      @events.length
    end
    alias_method :size, :length

  end
end
