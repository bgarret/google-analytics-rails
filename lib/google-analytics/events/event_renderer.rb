module GoogleAnalytics
  class EventRenderer
    def initialize(event, tracker_id)
      @event = event
      @tracker_id = tracker_id
    end

    def to_s
      "_gaq.push(#{[@tracker_id ? "#{@tracker_id}.#{@event.name}" : @event.name, *@event.params].to_json});"
    end
  end
end
