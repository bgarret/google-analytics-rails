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
      raise InvalidEventError.new(event) unless event.is_a?(Event)

      @events << event
    end

    def each
      @events.each { |e| yield e }
    end

    def size
      @events.size
    end

  end
end
