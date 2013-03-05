# coding: utf-8

require 'json'

module GoogleAnalytics
  class EventRenderer
    def initialize(event, tracker_id)
      @event = event
      @tracker_id = tracker_id
    end

    def to_s
      "_gaq.push(#{array_to_json([@tracker_id ? "#{@tracker_id}.#{@event.name}" : @event.name, *@event.params])});"
    end

    private

    def array_to_json(array)
      "[" << array.map {|string| string_to_json(string) } .join(',') << "]"
    end

    def string_to_json(string)
      # replace double quotes with single ones
      string.to_json.gsub(/^"/, "'").gsub(/"$/, "'")
    end
  end
end
