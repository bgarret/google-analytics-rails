require 'test_helper'
require 'google-analytics/rails/view_helpers'

class ViewHelpersTest < Test::Unit::TestCase
  include GoogleAnalytics::Rails::ViewHelpers

  VALID_INIT = <<-JAVASCRIPT
<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push([\"_setAccount\",\"TEST\"]);
_gaq.push([\"_trackPageview\"]);
_gaq.push([\"_trackPageLoadTime\"]);
(function() {
var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
</script>
  JAVASCRIPT

  def test_analytics_init
    assert_equal(VALID_INIT, analytics_init)
  end

  VALID_LOCAL_INIT = <<-JAVASCRIPT
<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push([\"_setAccount\",\"TEST\"]);
_gaq.push([\"_trackPageview\"]);
_gaq.push([\"_trackPageLoadTime\"]);
_gaq.push([\"_setDomainName\",\"none\"]);
_gaq.push([\"_setAllowLinker\",true]);
(function() {
var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
</script>
  JAVASCRIPT

  def test_local_analytics_init
    assert_equal(VALID_LOCAL_INIT, analytics_init(:local => true))
  end

  VALID_EVENT_INIT = <<-JAVASCRIPT
<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push([\"_setAccount\",\"TEST\"]);
_gaq.push([\"_trackPageview\"]);
_gaq.push([\"_trackPageLoadTime\"]);
_gaq.push([\"_setAllowLinker\",true]);
(function() {
var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
</script>
  JAVASCRIPT

  def test_analytics_init_with_events
    assert_equal(VALID_EVENT_INIT, analytics_init(:add_events => GA::Events::SetAllowLinker.new(true)))
  end

  VALID_TRACK_EVENT = <<-JAVASCRIPT
<script type="text/javascript">
  _gaq.push(["_trackEvent","Videos","Play","Gone With the Wind",null]);
</script>
  JAVASCRIPT

  def test_analytics_track_event
    event = analytics_track_event("Videos", "Play", "Gone With the Wind")
    assert_equal(VALID_TRACK_EVENT, event)
  end
end
