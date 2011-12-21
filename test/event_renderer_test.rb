require 'test_helper'

class EventRendererTest < Test::Unit::TestCase
  def test_event_renderer_yield_proper_javascript_snippit_for_default_tracker
    er = GA::EventRenderer.new(GA::Event.new('_someEvent', 1, 2, 3), nil)
    assert_equal("_gaq.push(['_someEvent',1,2,3]);", er.to_s)
  end

  def test_event_renderer_yield_proper_javascript_snippit_for_custom_tracker
    er = GA::EventRenderer.new(GA::Event.new('_someEvent', 1, 2, 3), 't2')
    assert_equal("_gaq.push(['t2._someEvent',1,2,3]);", er.to_s)
  end
end
