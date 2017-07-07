require 'test_helper'
require 'google-analytics/rails/view_helpers'

class ViewHelpersTest < Test::Unit::TestCase
  include GoogleAnalytics::Rails::ViewHelpers

  VALID_JS_INCLUDE = <<-JAVASCRIPT
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
  JAVASCRIPT

  VALID_INIT = <<-JAVASCRIPT
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga("create","TEST","auto");
ga("send","pageview");
</script>
  JAVASCRIPT

  def test_analytics_init
    assert_equal(VALID_INIT, analytics_init)
  end

  def test_analytics_init_with_special_name
    str = analytics_init(:name => 't2').to_s
    assert(str.include?(VALID_JS_INCLUDE))
    assert_match(/.+ga\("create","TEST",\{.+\}\);.+/m, str)
    assert_match(/.+"cookieDomain":"auto".+/m, str)
    assert_match(/.+"name":"t2".+/m, str)
    assert_match(/.+ga\("t2.send","pageview"\);.+/m, str)
  end

  def test_analytics_init_with_virtual_pageview
    str = analytics_init(:page => '/some/virtual/url').to_s
    assert(str.include?(VALID_JS_INCLUDE))
    assert_match(/.+ga\("create","TEST","auto"\);.+/m, str)
    assert_match(/.+ga\("send","pageview","\/some\/virtual\/url"\);.+/m, str)
  end

  def test_analytics_init_with_virtual_pageview_and_custom_title
    str = analytics_init(:page => '/some/virtual/url', :title => 'Hello World').to_s
    assert(str.include?(VALID_JS_INCLUDE))
    assert_match(/.+ga\("create","TEST","auto"\);.+/m, str)
    assert_match(/.+ga\("send","pageview".+/m, str)
    assert_match(/.+"page":"\/some\/virtual\/url".+/m, str)
    assert_match(/.+"title":"Hello World".+/m, str)
  end

  def test_analytics_init_with_custom_tracker
    str = analytics_init(:tracker => 'UA-CUSTOM-XX').to_s
    assert(str.include?(VALID_JS_INCLUDE))
    assert_match(/.+ga\("create","UA-CUSTOM-XX","auto"\);.+/m, str)
    assert_match(/.+ga\("send","pageview"\);.+/m, str)
  end

  def test_analytics_init_with_custom_domain
    str = analytics_init(:domain => 'example.com').to_s
    assert(str.include?(VALID_JS_INCLUDE))
    assert_match(/.+ga\("create","TEST",\{"cookieDomain":"example.com"\}\);.+/m, str)
    assert_match(/.+ga\("send","pageview"\);.+/m, str)
  end

  def test_local_analytics_init
    str = analytics_init(:local => true).to_s
    assert(str.include?(VALID_JS_INCLUDE))
    assert_match(/.+ga\("create","TEST",\{.+\}\);.+/m, str)
    assert_match(/.+"cookieDomain":"none".+/m, str)
    assert_match(/.+"allowLinker":true.+/m, str)
    assert_match(/.+ga\("send","pageview"\);.+/m, str)
  end

  def test_analytics_init_with_anonymized_ip
    str = analytics_init(:anonymize => true).to_s
    assert(str.include?(VALID_JS_INCLUDE))
    assert_match(/.+ga\("create","TEST","auto"\);.+/m, str)
    assert_match(/.+ga\("set","anonymizeIp",true\);.+/m, str)
    assert_match(/.+ga\("send","pageview"\);.+/m, str)
  end

  def test_analytics_init_with_link_attribution
    str = analytics_init(:enhanced_link_attribution => true).to_s
    assert(str.include?(VALID_JS_INCLUDE))
    assert_match(/.+ga\("create","TEST","auto"\);.+/m, str)
    assert_match(/.+ga\("require","linkid"\);.+/m, str)
    assert_match(/.+ga\("send","pageview"\);.+/m, str)
  end

  def test_analytics_init_with_events
    str = analytics_init(:add_events => GA::Events::SetAllowLinker.new(true)).to_s
    assert(str.include?(VALID_JS_INCLUDE))
    assert_match(/.+ga\("create","TEST",\{.+\}\);.+/m, str)
    assert_match(/.+"cookieDomain":"auto".+/m, str)
    assert_match(/.+"allowLinker":true.+/m, str)
    assert_match(/.+ga\("send","pageview"\);.+/m, str)
  end

  def test_analytics_init_with_samplerate_events
    str = analytics_init(:add_events => GA::Events::SetSiteSpeedSampleRate.new(5)).to_s
    assert(str.include?(VALID_JS_INCLUDE))
    assert_match(/.+ga\("create","TEST",\{.+\}\);.+/m, str)
    assert_match(/.+"cookieDomain":"auto".+/m, str)
    assert_match(/.+"siteSpeedSampleRate":5.+/m, str)
    assert_match(/.+ga\("send","pageview"\);.+/m, str)
  end

  def test_analytics_init_with_custom_vars
    str = analytics_init(:custom_vars => GA::Events::SetCustomVar.new(1, 'test', 'hoge',1)).to_s
    assert(str.include?(VALID_JS_INCLUDE))
    assert_match(/.+ga\("create","TEST","auto"\);.+/m, str)
    assert_match(/.+ga\("set","dimension1","hoge"\);.+/m, str)
    assert_match(/.+ga\("send","pageview"\);.+/m, str)
  end

  def test_analytics_init_with_custom_dimension
    str = analytics_init(:custom_vars => GA::Events::SetCustomDimension.new(1, 'hoge')).to_s
    assert(str.include?(VALID_JS_INCLUDE))
    assert_match(/.+ga\("create","TEST","auto"\);.+/m, str)
    assert_match(/.+ga\("set","dimension1","hoge"\);.+/m, str)
    assert_match(/.+ga\("send","pageview"\);.+/m, str)
  end

  VALID_TRACK_EVENT = %{ga("send","event","Videos","Play","Gone With the Wind",null);}

  def test_analytics_track_event
    event = analytics_track_event("Videos", "Play", "Gone With the Wind")
    assert_equal(VALID_TRACK_EVENT, event)
  end
end
