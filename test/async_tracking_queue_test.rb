require 'test_helper'

class AsyncTrackingQueueTest < Test::Unit::TestCase
  def teardown
    GoogleAnalytics.script_source = nil
  end

  VALID_SNIPPET = <<-JAVASCRIPT
<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push(['event1',1]);
_gaq.push(['event2',2]);
_gaq.push(['t2.event1',1]);
_gaq.push(['t2.event2',2]);
(function() {
var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
</script>
  JAVASCRIPT

  def test_queue_renders_valid_javascript_snippit
    gaq = GAQ.new

    # Add 2 events to the default tracker
    gaq << GA::Event.new('event1', 1)
    gaq << GA::Event.new('event2', 2)

    # Add 2 events for an alternate tracker
    gaq.push(GA::Event.new('event1', 1), 't2')
    gaq.push(GA::Event.new('event2', 2), 't2')

    assert_equal(VALID_SNIPPET, gaq.to_s)
  end

  VALID_DOUBLECLICK_SNIPPET = <<-JAVASCRIPT
<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push(['event1',1]);
_gaq.push(['event2',2]);
_gaq.push(['t2.event1',1]);
_gaq.push(['t2.event2',2]);
(function() {
var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
</script>
  JAVASCRIPT

  def test_queue_renders_valid_javascript_snippit_with_doubleclick_src
    GoogleAnalytics.script_source = :doubleclick
    gaq = GAQ.new

    # Add 2 events to the default tracker
    gaq << GA::Event.new('event1', 1)
    gaq << GA::Event.new('event2', 2)

    # Add 2 events for an alternate tracker
    gaq.push(GA::Event.new('event1', 1), 't2')
    gaq.push(GA::Event.new('event2', 2), 't2')

    assert_equal(VALID_DOUBLECLICK_SNIPPET, gaq.to_s)
  end

  VALID_CUSTOM_SNIPPET = <<-JAVASCRIPT
<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push(['event1',1]);
_gaq.push(['event2',2]);
_gaq.push(['t2.event1',1]);
_gaq.push(['t2.event2',2]);
(function() {
var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = 'http://127.0.0.1/custom.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
</script>
  JAVASCRIPT

  def test_queue_renders_valid_javascript_snippit_with_custom_src
    GoogleAnalytics.script_source = "'http://127.0.0.1/custom.js'"
    gaq = GAQ.new

    # Add 2 events to the default tracker
    gaq << GA::Event.new('event1', 1)
    gaq << GA::Event.new('event2', 2)

    # Add 2 events for an alternate tracker
    gaq.push(GA::Event.new('event1', 1), 't2')
    gaq.push(GA::Event.new('event2', 2), 't2')

    assert_equal(VALID_CUSTOM_SNIPPET, gaq.to_s)
  end
end
