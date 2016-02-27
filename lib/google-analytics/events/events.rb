# coding: utf-8

module GoogleAnalytics
  module Events
    class SetupAnalytics < Event

      def initialize(account_id, opts={})
        if ['auto','none'].include?(opts) || opts.empty?
          super('create', account_id, opts.empty? ? 'auto' : opts)
        elsif opts.is_a?(Hash)
          super('create', account_id, attributes_hash(opts))
        else
          super('create', account_id, {:cookieDomain => opts})
        end
      end

    private
      def attributes_hash(opts={})
        {
          :cookieDomain => opts.delete(:cookieDomain) || 'auto',
          :allowLinker => opts.delete(:allowLinker),
          :cookieName => opts.delete(:cookieName),
          :cookieExpires => opts.delete(:cookieExpires),
          :sampleRate => opts.delete(:sampleRate),
          :siteSpeedSampleRate => opts.delete(:siteSpeedSampleRate),
          :name => opts.delete(:name),
          :userId => opts.delete(:userId) || opts.delete(:uid)
        }.reject{|k,v| !v }
      end
    end

    class SetAccount
      def initialize(account_id)
        warn "[REMOVED] `SetAccount` is being removed. Universal Analytics does not support this any longer. Please see GoogleAnalytics::Events::SetupAnalytics"
      end
    end

    class SetDomainName
      def initialize(domain_name)
        warn "[REMOVED] `SetDomainName` is being removed. Universal Analytics does not support this any longer. Please see GoogleAnalytics::Events::SetupAnalytics"
      end
    end

    class SetAllowLinker
      def initialize(allow)
        warn "[REMOVED] `SetAllowLinker` is being removed. Universal Analytics does not support this any longer. Please see GoogleAnalytics::Events::SetupAnalytics"
      end
    end

    class Require < Event
      def initialize(name, url=nil)
        if url
          super('require', name, url)
        else
          super('require', name)
        end
      end
    end

    class SetSiteSpeedSampleRate
      # @param sample_rate [Integer] the percentage of page views that should be used
      #   for page speed metrics - defaults to 1 (aka 1%) if the event is missing.
      attr_accessor :sample_rate
      def initialize(sample_rate)
        @sample_rate = sample_rate
        warn "[REMOVED] `SetSiteSpeedSampleRate` is being removed. Universal Analytics does not support this any longer. Please see GoogleAnalytics::Events::SetupAnalytics"
      end
    end

    # http://misterphilip.com/universal-analytics/migration/basics
    class TrackPageview < Event
      # @param page [String] optional virtual pageview tracking
      # @see http://code.google.com/apis/analytics/docs/tracking/asyncMigrationExamples.html#VirtualPageviews
      def initialize(opts = {})
        # Just use default pageview if no page was given
        if opts.is_a?(Hash) && opts.fetch(:page, nil) == nil
          super('send', 'pageview')
        # Provide only the page string if a title was not given but a page was
        elsif opts.is_a?(Hash) && opts.fetch(:page, false)
          super('send', 'pageview', opts.fetch(:title, false) ? opts : opts[:page])
        # Print out a JSON Value for the pageview
        else
          super('send', 'pageview', opts)
        end
      end
    end

    class TrackEvent < Event
      def initialize(category, action, label = nil, value = nil)
        if label || value
          super('send', 'event', category.to_s, action.to_s, label ? label.to_s : nil, value ? value.to_i : nil)
        else
          super('send', 'event', category.to_s, action.to_s)
        end
      end
    end

    class ExperimentId < Event
      def initialize(id)
        super('set', 'expId', id.to_s)
      end
    end

    class ExperimentVariation < Event
      def initialize(variation_id)
        super('set', 'expVar', variation_id.to_i)
      end
    end

    # Custom Vars no longer exist in Universal Analytics
    # Transfer to dimensions & metrics
    # ga('set', 'dimension1', 953);
    # ga('set', 'metric5', 953);
    #

    # Deprecated: Please use `SetCustomDimension` or `SetCustomMetric` instead
    #
    class SetCustomVar < Event
      def initialize(index, name, value, opt_scope)
        raise ArgumentError, "The index has to be between 1 and 5" unless (1..5).include?(index.to_i)
        warn "[DEPRECATION] `SetCustomVar` is deprecated.  Please use `SetCustomDimension` or `SetCustomMetric` instead"
        super('set', "dimension#{index}", value.to_s)
      end
    end

    class SetCustomDimension < Event
      def initialize(index, value)
        raise ArgumentError, "The index has to be between 1 and #{GA.max_custom_indices}" unless (1..GA.max_custom_indices).include?(index.to_i)
        super('set', "dimension#{index}", value.to_s)
      end
    end
    class SetCustomMetric < Event
      def initialize(index, value)
        raise ArgumentError, "The index has to be between 1 and #{GA.max_custom_indices}" unless (1..GA.max_custom_indices).include?(index.to_i)
        super('set', "metric#{index}", value.to_s)
      end
    end

    # Removed: There are no longer Custom Variables
    class DeleteCustomVar < Event
      def initialize(index)
        warn "[REMOVED] `DeleteCustomVar` is being removed. Universal Analytics does not support Custom Variables."
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
    #     ga('set', 'anonymizeIp', true);
    #
    class AnonymizeIp < Event
      def initialize
        super('set', 'anonymizeIp', true)
      end
    end

    # @see http://code.google.com/apis/analytics/docs/tracking/gaTrackingEcommerce.html
    module Ecommerce
      # JavaScript equivalent:
      #
      # ga('ecommerce:addTransaction', {
      #   'id': '1234',
      #   'affiliation': 'Acme Clothing',
      #   'revenue': '11.99',
      #   'shipping': '5',
      #   'tax': '1.29',
      #   'currency': 'EUR'  // local currency code.
      # });
      #
      class AddTransaction < Event
        def initialize(order_id, store_name, total, tax, shipping, city=nil, state_or_province=nil, country=nil)
          # city.to_s, state_or_province.to_s, country.to_s

          super('ecommerce:addTransaction', {
            :id => order_id.to_s,
            :affiliation => store_name.to_s,
            :revenue => total.to_s,
            :tax => tax.to_s,
            :shipping => shipping.to_s
          })
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
          super('ecommerce:addItem', {
            :id => order_id.to_s,
            :sku => product_id.to_s,
            :name => product_name.to_s,
            :category => product_variation.to_s,
            :price => unit_price.to_s,
            :quantity => quantity.to_s
          })
        end
      end

      # JavaScript equivalent:
      #
      #     ga('ecommerce:send');
      #
      class TrackTransaction < SingleEvent
        def initialize
          super('ecommerce:send')
        end
      end
      class ClearTransaction < SingleEvent
        def initialize
          super('ecommerce:clear')
        end
      end
    end
  end
end
