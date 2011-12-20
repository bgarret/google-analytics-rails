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

    class TrackPageview < Event
      def initialize
        super('_trackPageview')
      end
    end

    class TrackPageLoadTime < Event
      def initialize
        super('_trackPageLoadTime')
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

    module Ecommerce
      class AddTransaction < Event

        # _gaq.push(['_addTrans',
        #   '1234',           // order ID - required
        #   'Acme Clothing',  // affiliation or store name
        #   '11.99',          // total - required
        #   '1.29',           // tax
        #   '5',              // shipping
        #   'San Jose',       // city
        #   'California',     // state or province
        #   'USA'             // country
        # ]);
        #
        def initialize(order_id, store_name, total, tax, shipping, city, state_or_province, country)
          super('_addTrans', order_id.to_s, store_name.to_s, total.to_s, tax.to_s, shipping.to_s, city.to_s, state_or_province.to_s, country.to_s)
        end
      end

      class AddItem < Event

        # _gaq.push(['_addItem',
        #   '1234',           // order ID - required
        #   'DD44',           // SKU/code - required
        #   'T-Shirt',        // product name
        #   'Green Medium',   // category or variation
        #   '11.99',          // unit price - required
        #   '1'               // quantity - required
        # ]);
        #
        def initialize(order_id, product_id, product_name, product_variation, unit_price, quantity)
          super('_addItem', order_id.to_s, product_id.to_s, product_name.to_s, product_variation.to_s, unit_price.to_s, quantity.to_s)
        end

      end

      class TrackTransaction < Event
        # _gaq.push(['_trackTrans']); // submits transaction to the Analytics servers
        def initialize
          super('_trackTrans')
        end
      end
    end
  end
end
