require 'test_helper'

class EventCollectionRendererTest < Test::Unit::TestCase
  def test_event_collection_renderer_yield_proper_javascript_snippit_for_default_tracker
    event_collection = GA::EventCollection.new
    event_collection << GA::Event.new('send', 'evt', '1')
    event_collection << GA::Event.new('send', 'evt', '2')
    event_collection << GA::Event.new('send', 'evt', '3')

    ecr = GA::EventCollectionRenderer.new(event_collection, nil)
    assert_equal(%{ga("send","evt","1");\nga("send","evt","2");\nga("send","evt","3");}, ecr.to_s)
  end

  def test_event_collection_renderer_escapes_quotes
    event_collection = GA::EventCollection.new
    event_collection << GA::Event.new('send', 'evt', "foo'sbar")
    event_collection << GA::Event.new('send', 'evt', "foo\"sbar")

    ecr = GA::EventCollectionRenderer.new(event_collection, nil)
    assert_equal(%{ga("send","evt","foo'sbar");\nga("send","evt","foo\\"sbar");}, ecr.to_s)
  end

  def test_event_collection_renderer_yield_proper_javascript_snippit_for_custom_tracker
    event_collection = GA::EventCollection.new
    event_collection << GA::Event.new('send', 'evt', 1)
    event_collection << GA::Event.new('send', 'evt', 2)
    event_collection << GA::Event.new('send', 'evt', 3)

    ecr = GA::EventCollectionRenderer.new(event_collection, 't2')
    assert_equal(%{ga("t2.send","evt",1);\nga("t2.send","evt",2);\nga("t2.send","evt",3);}, ecr.to_s)
  end
end
