require 'test_helper'
require 'google-analytics/rails/view_helpers'

class ViewHelpersTest < Test::Unit::TestCase
  include GoogleAnalytics::Rails::ViewHelpers

  VALID_INIT = <<-JAVASCRIPT
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create','TEST','auto');
ga('send','pageview');
</script>
  JAVASCRIPT

  def test_analytics_init
    assert_equal(VALID_INIT, analytics_init)
  end

  VALID_EVENT_WITH_NAME_INIT = <<-JAVASCRIPT
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create','TEST',{"cookieDomain":"auto","name":"t2"});
ga('t2.send','pageview');
</script>
  JAVASCRIPT

  def test_analytics_init_with_special_name
    assert_equal(VALID_EVENT_WITH_NAME_INIT, analytics_init(name: 't2'))
  end

  VALID_INIT_WITH_VIRTUAL_PAGEVIEW = <<-JAVASCRIPT
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create','TEST','auto');
ga('send','pageview','/some/virtual/url');
</script>
  JAVASCRIPT

  def test_analytics_init_with_virtual_pageview
    assert_equal(VALID_INIT_WITH_VIRTUAL_PAGEVIEW, analytics_init(:page => '/some/virtual/url'))
  end

  VALID_INIT_WITH_VIRTUAL_PAGEVIEW_AND_TITLE = <<-JAVASCRIPT
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create','TEST','auto');
ga('send','pageview',{"page":"/some/virtual/url","title":"Hello World"});
</script>
  JAVASCRIPT

  def test_analytics_init_with_virtual_pageview
    assert_equal(VALID_INIT_WITH_VIRTUAL_PAGEVIEW_AND_TITLE, analytics_init(:page => '/some/virtual/url', title: 'Hello World'))
  end

  VALID_INIT_WITH_CUSTOM_TRACKER = <<-JAVASCRIPT
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create','UA-CUSTOM-XX','auto');
ga('send','pageview');
</script>
  JAVASCRIPT

  def test_analytics_init_with_custom_tracker
    assert_equal(VALID_INIT_WITH_CUSTOM_TRACKER, analytics_init(:tracker => 'UA-CUSTOM-XX'))
  end

  VALID_INIT_WITH_CUSTOM_DOMAIN = <<-JAVASCRIPT
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create','TEST',{"cookieDomain":"example.com"});
ga('send','pageview');
</script>
  JAVASCRIPT

  def test_analytics_init_with_custom_domain
    assert_equal(VALID_INIT_WITH_CUSTOM_DOMAIN, analytics_init(:domain => 'example.com'))
  end

  VALID_LOCAL_INIT = <<-JAVASCRIPT
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create','TEST',{"cookieDomain":"none","allowLinker":true});
ga('send','pageview');
</script>
  JAVASCRIPT

  def test_local_analytics_init
    assert_equal(VALID_LOCAL_INIT, analytics_init(:local => true))
  end

  VALID_INIT_WITH_ANONYMIZED_IP = <<-JAVASCRIPT
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create','TEST','auto');
ga('set','anonymizeIp',true);
ga('send','pageview');
</script>
  JAVASCRIPT

  def test_analytics_init_with_anonymized_ip
    assert_equal(VALID_INIT_WITH_ANONYMIZED_IP, analytics_init(:anonymize => true))
  end

  VALID_INIT_WITH_LINK_ATTRIBUTION = <<-JAVASCRIPT
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create','TEST','auto');
ga('require','linkid');
ga('send','pageview');
</script>
  JAVASCRIPT

  def test_analytics_init_with_link_attribution
    assert_equal(VALID_INIT_WITH_LINK_ATTRIBUTION, analytics_init(:enhanced_link_attribution => true))
  end

  VALID_EVENT_INIT = <<-JAVASCRIPT
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create','TEST',{"cookieDomain":"auto","allowLinker":true});
ga('send','pageview');
</script>
  JAVASCRIPT

  def test_analytics_init_with_events
    assert_equal(VALID_EVENT_INIT, analytics_init(:add_events => GA::Events::SetAllowLinker.new(true)))
  end

  VALID_EVENT_INIT_WITH_SAMPLE_RATE = <<-JAVASCRIPT
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create','TEST',{"cookieDomain":"auto","siteSpeedSampleRate":5});
ga('send','pageview');
</script>
  JAVASCRIPT

  def test_analytics_init_with_samplerate_events
    assert_equal(VALID_EVENT_INIT_WITH_SAMPLE_RATE, analytics_init(:add_events => GA::Events::SetSiteSpeedSampleRate.new(5)))
  end

  VALID_EVENT_INIT_WITH_CUSTOM_VARS = <<-JAVASCRIPT
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create','TEST','auto');
ga('set','dimension1','hoge');
ga('send','pageview');
</script>
  JAVASCRIPT

  def test_analytics_init_with_custom_vars
    assert_equal(VALID_EVENT_INIT_WITH_CUSTOM_VARS, analytics_init(:custom_vars => GA::Events::SetCustomVar.new(1, 'test', 'hoge',1)))
  end

  def test_analytics_init_with_custom_dimension
    assert_equal(VALID_EVENT_INIT_WITH_CUSTOM_VARS, analytics_init(:custom_vars => GA::Events::SetCustomDimension.new(1, 'hoge')))
  end

  VALID_TRACK_EVENT = "ga('send','event','Videos','Play','Gone With the Wind',null);"

  def test_analytics_track_event
    event = analytics_track_event("Videos", "Play", "Gone With the Wind")
    assert_equal(VALID_TRACK_EVENT, event)
  end
end
