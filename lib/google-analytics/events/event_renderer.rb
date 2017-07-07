# coding: utf-8

require 'json'

module GoogleAnalytics
  class EventRenderer
    def initialize(event, tracker_id)
      @event = event
      @tracker_id = tracker_id
    end

    def to_s
      if @event.class.name == 'GoogleAnalytics::Events::SetupAnalytics'
        %{ga("#{@event.action}",#{array_to_json([@event.name, *@event.params])});}
      elsif @event.single_event?
        %{ga("#{@tracker_id ? [@tracker_id, @event.action].join('.') : @event.action}");}
      else
        %{ga("#{@tracker_id ? [@tracker_id, @event.action].join('.') : @event.action}",#{array_to_json([@event.name, *@event.params])});}
      end
    end

    private

    def array_to_json(array)
      array.map {|val| val.to_json } .join(',')
    end
  end
end
