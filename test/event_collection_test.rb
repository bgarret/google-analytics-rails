require 'test_helper'

class EventCollectionTest < Test::Unit::TestCase
  def test_event_collection_raises_on_non_event_insertion
    ec = GA::EventCollection.new
    assert_raise(GA::EventCollection::InvalidEventError) { ec << "This is invalid" }
  end

  def test_event_collection_is_enumerable_and_iterates_in_insertion_order
    ec = GA::EventCollection.new

    assert(ec.respond_to?(:each))

    ec << (event0 = GA::Event.new('sample', 'test'))
    ec << (event1 = GA::Event.new('sample2', 'test2'))
    ec << (event3 = GA::Event.new('sample3', 'test3'))

    items = ec.map { |e| e }

    assert_equal(event0, items[0])
    assert_equal(event1, items[1])
    assert_equal(event3, items[2])
  end

  def test_event_collection_delegates_size_and_length
    ec = GA::EventCollection.new

    assert(ec.respond_to?(:size))
    assert(ec.respond_to?(:length))

    assert_equal(0, ec.size)
    assert_equal(ec.size, ec.length)

    ec << GA::Event.new('sample', 'test')
    assert_equal(1, ec.size)
    assert_equal(ec.size, ec.length)

    ec << GA::Event.new('sample2', 'test2')
    assert_equal(2, ec.size)
    assert_equal(ec.size, ec.length)
  end
end
