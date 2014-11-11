# coding: utf-8

module GoogleAnalytics
  class AsyncTrackingQueue
    def initialize
      @events = []
    end

    def <<(event)
      push(event)
    end

    def push(event, tracker_id = nil)
      @events << renderer_for_event(event, tracker_id)
    end

    def to_s
<<-JAVASCRIPT
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script',#{GoogleAnalytics.script_source},'ga');
#{@events.map { |event| event.to_s }.join("\n")}
</script>
JAVASCRIPT
    end

    private

    def renderer_for_event(event, tracker_id)
      case event
      when SingleEvent then EventRenderer.new(event, tracker_id)
      when Event then EventRenderer.new(event, tracker_id)
      when EventCollection then EventCollectionRenderer.new(event, tracker_id)
      end
    end
  end
end

# Alias for {GoogleAnalytics::AsyncTrackingQueue}
GAQ = GoogleAnalytics::AsyncTrackingQueue
