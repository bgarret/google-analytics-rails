# coding: utf-8

module GoogleAnalytics
  class EventCollectionRenderer
    def initialize(event_collection, tracker_id)
      @event_collection = event_collection
      @tracker_id = tracker_id
    end

    def to_s
      @event_collection.map { |event| EventRenderer.new(event, @tracker_id).to_s }.join("\n")
    end
  end
end
