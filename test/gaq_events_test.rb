require 'test_helper'

class GAEventsTest < Test::Unit::TestCase
  def test_set_account_event
    event = GA::Events::SetAccount.new('ABC123')
    assert_equal('_setAccount', event.name)
    assert_equal(['ABC123'], event.params)
  end

  def test_set_domain_name_event
    event = GA::Events::SetDomainName.new('foo.com')
    assert_equal('_setDomainName', event.name)
    assert_equal(['foo.com'], event.params)
  end

  def test_set_site_speed_sample_rate_event
    event = GA::Events::SetSiteSpeedSampleRate.new(5)
    assert_equal('_setSiteSpeedSampleRate', event.name)
    assert_equal([5], event.params)
  end

  def test_track_pageview_event
    event = GA::Events::TrackPageview.new
    assert_equal('_trackPageview', event.name)
    assert_equal([], event.params)
  end

  def test_track_pageview_event_with_virtual_page
    event = GA::Events::TrackPageview.new('/foo/bar')
    assert_equal('_trackPageview', event.name)
    assert_equal(['/foo/bar'], event.params)
  end

  def test_track_event_without_category_or_label
    event = GA::Events::TrackEvent.new('Search', 'Executed')
    assert_equal('_trackEvent', event.name)
    assert_equal(['Search', 'Executed'], event.params)
  end

  def test_track_event_with_label
    event = GA::Events::TrackEvent.new('Search', 'Executed', 'Son of Sam')
    assert_equal('_trackEvent', event.name)
    assert_equal(['Search', 'Executed', 'Son of Sam', nil], event.params)
  end

  def test_track_event_with_value
    event = GA::Events::TrackEvent.new('Search', 'Executed', nil, 1)
    assert_equal('_trackEvent', event.name)
    assert_equal(['Search', 'Executed', nil, 1], event.params)
  end

  def test_track_event_with_label_and_value
    event = GA::Events::TrackEvent.new('Search', 'Executed', 'Son of Sam', 1)
    assert_equal('_trackEvent', event.name)
    assert_equal(['Search', 'Executed', 'Son of Sam', 1], event.params)
  end

  def test_set_custom_var
    event = GA::Events::SetCustomVar.new(1, 'VarName1', 'VarVal1', 1)
    assert_equal('_setCustomVar', event.name)
    assert_equal([1, 'VarName1', 'VarVal1', 1], event.params)
  end

  def test_set_custom_var_with_invalid_index
    assert_raise ArgumentError do
      GA::Events::SetCustomVar.new(6, 'VarName1', 'VarVal1', 1)
    end
  end

  def test_delete_custom_var
    event = GA::Events::DeleteCustomVar.new(1)
    assert_equal('_deleteCustomVar', event.name)
    assert_equal([1], event.params)
  end

  def test_delete_custom_var_with_invalid_index
    assert_raise ArgumentError do
      GA::Events::DeleteCustomVar.new(6)
    end
  end

  def test_anonymize_ip_event
    event = GA::Events::AnonymizeIp.new
    assert_equal('_gat._anonymizeIp', event.name)
    assert_equal([], event.params)
  end

  def test_ecommerce_add_transaction_event
    event = GA::Events::Ecommerce::AddTransaction.new(1, 'ACME', 123.45, 13.27, 75.35, 'Dallas', 'TX', 'USA')
    assert_equal('_addTrans', event.name)
    assert_equal(['1', 'ACME', '123.45', '13.27', '75.35', 'Dallas', 'TX', 'USA'], event.params)
  end

  def test_ecommerce_add_item_event
    event = GA::Events::Ecommerce::AddItem.new(1, 123, 'Bacon', 'Chunky', 5.00, 42)
    assert_equal('_addItem', event.name)
    assert_equal(['1', '123', 'Bacon', 'Chunky', '5.0', '42'], event.params)
  end

  def test_ecommerce_track_trans_event
    event = GA::Events::Ecommerce::TrackTransaction.new
    assert_equal('_trackTrans', event.name)
    assert_equal([], event.params)
  end
end
