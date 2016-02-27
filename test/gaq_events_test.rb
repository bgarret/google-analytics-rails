require 'test_helper'

class GAEventsTest < Test::Unit::TestCase
  def setup
    GA.premium_account = false
  end

  def test_default_account_creation
    event = GA::Events::SetupAnalytics.new('ABC123')
    assert_equal('create', event.action)
    assert_equal('ABC123', event.name)
    assert_equal(['auto'], event.params)
  end
  def test_account_creation_with_cookie_domain
    event = GA::Events::SetupAnalytics.new('ABC123', 'example.com')
    assert_equal('create', event.action)
    assert_equal('ABC123', event.name)
    assert_equal([{:cookieDomain=>"example.com"}], event.params)
  end

  def test_account_creation_with_user_id
    event = GA::Events::SetupAnalytics.new('ABC123', {:cookieDomain => 'example.com', :userId => 10})
    assert_equal('create', event.action)
    assert_equal('ABC123', event.name)
    assert_equal([{:cookieDomain=>"example.com", :userId => 10}], event.params)
  end

  def test_account_creation_with_using_uid_for_user
    event = GA::Events::SetupAnalytics.new('ABC123', {:cookieDomain => 'example.com', :uid => 10})
    assert_equal('create', event.action)
    assert_equal('ABC123', event.name)
    assert_equal([{:cookieDomain=>"example.com", :userId => 10}], event.params)
  end

  def test_account_creation_with_no_cookie_domain
    event = GA::Events::SetupAnalytics.new('ABC123', 'none')
    assert_equal('create', event.action)
    assert_equal('ABC123', event.name)
    assert_equal(['none'], event.params)
  end

  def test_require_statement
    event = GA::Events::Require.new('ecommerce', 'ecommerce.js')
    assert_equal('require', event.action)
    assert_equal('ecommerce', event.name)
    assert_equal(['ecommerce.js'], event.params)
  end

  def test_track_pageview_event
    event = GA::Events::TrackPageview.new
    assert_equal('send', event.action)
    assert_equal('pageview', event.name)
    assert_equal([], event.params)
  end

  def test_track_pageview_event_with_virtual_page
    event = GA::Events::TrackPageview.new('/foo/bar')
    assert_equal('send', event.action)
    assert_equal('pageview', event.name)
    assert_equal(['/foo/bar'], event.params)
  end

  def test_track_event_without_category_or_label
    event = GA::Events::TrackEvent.new('Search', 'Executed')
    assert_equal('send', event.action)
    assert_equal('event', event.name)
    assert_equal(['Search', 'Executed'], event.params)
  end

  def test_track_event_with_label
    event = GA::Events::TrackEvent.new('Search', 'Executed', 'Son of Sam')
    assert_equal('send', event.action)
    assert_equal('event', event.name)
    assert_equal(['Search', 'Executed', 'Son of Sam', nil], event.params)
  end

  def test_track_event_with_value
    event = GA::Events::TrackEvent.new('Search', 'Executed', nil, 1)
    assert_equal('send', event.action)
    assert_equal('event', event.name)
    assert_equal(['Search', 'Executed', nil, 1], event.params)
  end

  def test_track_event_with_label_and_value
    event = GA::Events::TrackEvent.new('Search', 'Executed', 'Son of Sam', 1)
    assert_equal('send', event.action)
    assert_equal('event', event.name)
    assert_equal(['Search', 'Executed', 'Son of Sam', 1], event.params)
  end

  def test_max_custom_indices_regular
    assert_equal(GA::MAX_REGULAR_INDICES, GA.max_custom_indices)
  end

  def test_premium_account_defaults_to_false
    GA.premium_account = nil
    assert_equal(false, GA.premium_account?)
  end

  def test_max_custom_indices_defaults_to_regular
    GA.premium_account = nil
    assert_equal(GA::MAX_REGULAR_INDICES, GA.max_custom_indices)
  end

  def test_max_custom_indices_premium
    GA.premium_account = true
    assert_equal(GA::MAX_PREMIUM_INDICES, GA.max_custom_indices)
  end

  def test_set_custom_dimension
    event = GA::Events::SetCustomDimension.new(1, 2)
    assert_equal('set', event.action)
    assert_equal("dimension1", event.name)
    assert_equal(['2'], event.params)
  end

  def test_set_max_custom_dimension
    assert_nothing_raised do
      GA::Events::SetCustomDimension.new(GA::MAX_REGULAR_INDICES, 1)
    end
  end

  def test_set_custom_dimension_with_invalid_index
    assert_raise ArgumentError do
      GA::Events::SetCustomDimension.new(GA::MAX_REGULAR_INDICES + 1, 1)
    end
  end

  def test_set_max_custom_dimension_premium_account
    GA.premium_account = true
    assert_nothing_raised do
      GA::Events::SetCustomDimension.new(GA::MAX_PREMIUM_INDICES, 1)
    end
  end

  def test_set_custom_dimension_with_invalid_index_premium_account
    GA.premium_account = true
    assert_raise ArgumentError do
      GA::Events::SetCustomDimension.new(GA::MAX_PREMIUM_INDICES + 1, 1)
    end
  end

  def test_set_custom_metric
    event = GA::Events::SetCustomMetric.new(1, 2)
    assert_equal('set', event.action)
    assert_equal("metric1", event.name)
    assert_equal(['2'], event.params)
  end

  def test_set_max_custom_metric
    assert_nothing_raised do
      GA::Events::SetCustomMetric.new(GA::MAX_REGULAR_INDICES, 1)
    end
  end

  def test_set_custom_metric_with_invalid_index
    assert_raise ArgumentError do
      GA::Events::SetCustomMetric.new(GA::MAX_REGULAR_INDICES + 1, 1)
    end
  end

  def test_set_max_custom_metric_premium_account
    GA.premium_account = true
    assert_nothing_raised do
      GA::Events::SetCustomDimension.new(GA::MAX_PREMIUM_INDICES, 1)
    end
  end

  def test_set_custom_metric_with_invalid_index_premium_account
    GA.premium_account = true
    assert_raise ArgumentError do
      GA::Events::SetCustomDimension.new(GA::MAX_PREMIUM_INDICES + 1, 1)
    end
  end

  def test_anonymize_ip_event
    event = GA::Events::AnonymizeIp.new
    assert_equal('set', event.action)
    assert_equal('anonymizeIp', event.name)
    assert_equal([true], event.params)
  end

  def test_ecommerce_add_transaction_event_old_format
    event = GA::Events::Ecommerce::AddTransaction.new(1, 'ACME', 123.45, 13.27, 75.35, 'Dallas', 'TX', 'USA')
    assert_equal('ecommerce:addTransaction', event.action)
    assert_equal({
      :id => '1',
      :affiliation => 'ACME',
      :revenue => '123.45',
      :tax => '13.27',
      :shipping => '75.35'
    }, event.name)
  end

  def test_ecommerce_add_transaction_event_new_format
    event = GA::Events::Ecommerce::AddTransaction.new(1, 'ACME', 123.45, 13.27, 75.35)
    assert_equal('ecommerce:addTransaction', event.action)
    assert_equal({
      :id => '1',
      :affiliation => 'ACME',
      :revenue => '123.45',
      :tax => '13.27',
      :shipping => '75.35'
    }, event.name)
  end

  def test_ecommerce_add_item_event
    event = GA::Events::Ecommerce::AddItem.new(1, 123, 'Bacon', 'Chunky', 5.00, 42)
    assert_equal('ecommerce:addItem', event.action)
    assert_equal({
      :id => '1',
      :sku => '123',
      :name => 'Bacon',
      :category => 'Chunky',
      :price => '5.0',
      :quantity => '42'
    }, event.name)
  end

  def test_ecommerce_track_trans_event
    event = GA::Events::Ecommerce::TrackTransaction.new
    assert_equal('ecommerce:send', event.action)
    assert_equal([], event.params)
  end
end
