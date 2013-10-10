require 'test_helper'
require 'google-analytics/rails/view_helpers'

class ViewHelpersTest < Test::Unit::TestCase
  include GoogleAnalytics::Rails::ViewHelpers

  VALID_INIT = <<-JAVASCRIPT
<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push(['_setAccount','TEST']);
_gaq.push(['_setDomainName','auto']);
_gaq.push(['_trackPageview']);
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

  VALID_INIT_WITH_VIRTUAL_PAGEVIEW = <<-JAVASCRIPT
<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push(['_setAccount','TEST']);
_gaq.push(['_setDomainName','auto']);
_gaq.push(['_trackPageview','/some/virtual/url']);
(function() {
var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
</script>
  JAVASCRIPT

  def test_analytics_init_with_virtual_pageview
    assert_equal(VALID_INIT_WITH_VIRTUAL_PAGEVIEW, analytics_init(:page => '/some/virtual/url'))
  end

  VALID_INIT_WITH_CUSTOM_TRACKER = <<-JAVASCRIPT
<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push(['_setAccount','UA-CUSTOM-XX']);
_gaq.push(['_setDomainName','auto']);
_gaq.push(['_trackPageview']);
(function() {
var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
</script>
  JAVASCRIPT

  def test_analytics_init_with_custom_tracker
    assert_equal(VALID_INIT_WITH_CUSTOM_TRACKER, analytics_init(:tracker => 'UA-CUSTOM-XX'))
  end

  VALID_INIT_WITH_CUSTOM_DOMAIN = <<-JAVASCRIPT
<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push(['_setAccount','TEST']);
_gaq.push(['_setDomainName','example.com']);
_gaq.push(['_trackPageview']);
(function() {
var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
</script>
  JAVASCRIPT

  def test_analytics_init_with_custom_domain
    assert_equal(VALID_INIT_WITH_CUSTOM_DOMAIN, analytics_init(:domain => 'example.com'))
  end

  VALID_LOCAL_INIT = <<-JAVASCRIPT
<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push(['_setAccount','TEST']);
_gaq.push(['_setAllowLinker',true]);
_gaq.push(['_setDomainName','none']);
_gaq.push(['_trackPageview']);
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

  VALID_INIT_WITH_ANONYMIZED_IP = <<-JAVASCRIPT
<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push(['_setAccount','TEST']);
_gaq.push(['_setDomainName','auto']);
_gaq.push(['_gat._anonymizeIp']);
_gaq.push(['_trackPageview']);
(function() {
var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
</script>
  JAVASCRIPT

  def test_analytics_init_with_anonymized_ip
    assert_equal(VALID_INIT_WITH_ANONYMIZED_IP, analytics_init(:anonymize => true))
  end

  VALID_INIT_WITH_LINK_ATTRIBUTION = <<-JAVASCRIPT
<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push(['_require','inpage_linkid','//www.google-analytics.com/plugins/ga/inpage_linkid.js']);
_gaq.push(['_setAccount','TEST']);
_gaq.push(['_setDomainName','auto']);
_gaq.push(['_trackPageview']);
(function() {
var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
</script>
  JAVASCRIPT

  def test_analytics_init_with_link_attribution
    assert_equal(VALID_INIT_WITH_LINK_ATTRIBUTION, analytics_init(:enhanced_link_attribution => true))
  end

  VALID_EVENT_INIT = <<-JAVASCRIPT
<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push(['_setAccount','TEST']);
_gaq.push(['_setDomainName','auto']);
_gaq.push(['_trackPageview']);
_gaq.push(['_setAllowLinker',true]);
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

  VALID_EVENT_INIT_WITH_CUSTOM_VARS = <<-JAVASCRIPT
<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push(['_setAccount','TEST']);
_gaq.push(['_setDomainName','auto']);
_gaq.push(['_setCustomVar',1,'test','hoge',1]);
_gaq.push(['_trackPageview']);
(function() {
var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
</script>
  JAVASCRIPT

  def test_analytics_init_with_custom_vars
    assert_equal(VALID_EVENT_INIT_WITH_CUSTOM_VARS, analytics_init(:custom_vars => GA::Events::SetCustomVar.new(1, 'test', 'hoge',1)))
  end

  VALID_TRACK_EVENT = "_gaq.push(['_trackEvent','Videos','Play','Gone With the Wind',null]);"

  def test_analytics_track_event
    event = analytics_track_event("Videos", "Play", "Gone With the Wind")
    assert_equal(VALID_TRACK_EVENT, event)
  end
end
