# coding: utf-8

module GoogleAnalytics
  module Events
    class SetAccount < Event
      def initialize(account_id)
        super('_setAccount', account_id)
      end
    end

    class SetDomainName < Event
      def initialize(domain_name)
        super('_setDomainName', domain_name)
      end
    end

    class SetAllowLinker < Event
      def initialize(allow)
        super('_setAllowLinker', allow)
      end
    end

    class Require < Event
      def initialize(name, url)
        super('_require', name, url)
      end
    end

    class SetSiteSpeedSampleRate < Event
      # @param sample_rate [Integer] the percentage of page views that should be used
      #   for page speed metrics - defaults to 1 (aka 1%) if the event is missing.
      # @see http://code.google.com/apis/analytics/docs/gaJS/gaJSApiBasicConfiguration.html#_gat.GA_Tracker_._setSiteSpeedSampleRate
      def initialize(sample_rate)
        super('_setSiteSpeedSampleRate', sample_rate)
      end
    end

    class TrackPageview < Event
      # @param page [String] optional virtual pageview tracking
      # @see http://code.google.com/apis/analytics/docs/tracking/asyncMigrationExamples.html#VirtualPageviews
      def initialize(page = nil)
        page && page != '' ? super('_trackPageview', page) : super('_trackPageview')
      end
    end

    class TrackEvent < Event
      def initialize(category, action, label = nil, value = nil)
        if label || value
          super('_trackEvent', category.to_s, action.to_s, label ? label.to_s : nil, value ? value.to_i : nil)
        else
          super('_trackEvent', category.to_s, action.to_s)
        end
      end
    end

    class SetCustomVar < Event
      def initialize(index, name, value, opt_scope)
        raise ArgumentError, "The index has to be between 1 and 5" unless (1..5).include?(index.to_i)
        super('_setCustomVar', index.to_i, name.to_s, value.to_s, opt_scope.to_i)
      end
    end

    class DeleteCustomVar < Event
      def initialize(index)
        raise ArgumentError, "The index has to be between 1 and 5" unless (1..5).include?(index.to_i)
        super('_deleteCustomVar', index.to_i)
      end
    end

    # @see https://developers.google.com/analytics/devguides/collection/gajs/methods/gaJSApi_gat#_gat._anonymizeIp
    #
    # Anonymize the visitor IP address. This seems to be mandatory for European websites and actively enforced
    # for German ones.
    #
    # See the following comment by Roland Moriz for more information:
    # https://github.com/bgarret/google-analytics-rails/pull/6#issuecomment-5946066
    #
    # JavaScript equivalent:
    #
    #     _gaq.push(['_gat._anonymizeIp']);
    #
    class AnonymizeIp < Event
      def initialize
        super('_gat._anonymizeIp')
      end
    end

    # @see http://code.google.com/apis/analytics/docs/tracking/gaTrackingEcommerce.html
    module Ecommerce
      # JavaScript equivalent:
      #
      #     _gaq.push(['_addTrans',
      #       '1234',           // order ID - required
      #       'Acme Clothing',  // affiliation or store name
      #       '11.99',          // total - required
      #       '1.29',           // tax
      #       '5',              // shipping
      #       'San Jose',       // city
      #       'California',     // state or province
      #       'USA'             // country
      #     ]);
      #
      class AddTransaction < Event
        def initialize(order_id, store_name, total, tax, shipping, city, state_or_province, country)
          super('_addTrans', order_id.to_s, store_name.to_s, total.to_s, tax.to_s, shipping.to_s, city.to_s, state_or_province.to_s, country.to_s)
        end
      end

      # JavaScript equivalent:
      #
      #     _gaq.push(['_addItem',
      #       '1234',           // order ID - required
      #       'DD44',           // SKU/code - required
      #       'T-Shirt',        // product name
      #       'Green Medium',   // category or variation
      #       '11.99',          // unit price - required
      #       '1'               // quantity - required
      #     ]);
      #
      class AddItem < Event
        def initialize(order_id, product_id, product_name, product_variation, unit_price, quantity)
          super('_addItem', order_id.to_s, product_id.to_s, product_name.to_s, product_variation.to_s, unit_price.to_s, quantity.to_s)
        end

      end

      # JavaScript equivalent:
      #
      #     _gaq.push(['_trackTrans']);
      #
      class TrackTransaction < Event
        def initialize
          super('_trackTrans')
        end
      end
    end
  end
end
