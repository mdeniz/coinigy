module Coinigy
  # Represents an Order in an account
  class Order < Coinigy::Model
    # Order types
    BUY = 1.freeze
    SELL = 2.freeze

    # Price types
    LIMIT = 3.freeze
    STOP_LIMIT = 6.freeze
    LIMIT_MARGIN = 8.freeze
    STOP_LIMIT_MARGIN = 9.freeze

    attr_accessor :exch_id, :exch_code, :exch_name,
                  :mkt_name, :limit_price, :operator, :order_id, :order_type, :order_price_type,
                  :order_status, :quantity, :order_time, :foreign_order_id, :auth_nickname, :auth_id,
                  :quantity_remaining, :stop_price, :price_type_id, :display_name, :executed_price,
                  :last_updated, :unixtime

    # Relations
    attr_accessor :subscription

    def attributes
      { 'exch_id' => exch_id,
        'exch_code' => exch_code,
        'exch_name' => exch_name,
        'mkt_name' => mkt_name,
        'limit_price' => limit_price,
        'operator' => operator,
        'order_id' => order_id,
        'order_type' => order_type,
        'order_price_type' => order_price_type,
        'order_status' => order_status,
        'quantity' => quantity,
        'order_time' => order_time,
        'foreign_order_id' => foreign_order_id,
        'auth_nickname' => auth_nickname,
        'auth_id' => auth_id,
        'quantity_remaining' => quantity_remaining,
        'stop_price' => stop_price,
        'price_type_id' => price_type_id,
        'display_name' => display_name,
        'executed_price' => executed_price,
        'last_updated' => last_updated,
        'unixtime' => unixtime }
    end

    def place
      exchange = subscription.exchanges.find { |exchange| exchange.exch_code == exch_code }
      market = exchange.markets.find { |market| market.mkt_name == mkt_name }
      order_type_id = (order_type == 'Buy') ? BUY : SELL
      subscription.client.add_order('auth_id' => auth_id,
                                    'exch_id' => exchange.exch_id,
                                    'mkt_id' => market.mkt_id,
                                    'order_type_id' => order_type_id,
                                    'price_type_id' => price_type_id,
                                    'limit_price' => limit_price,
                                    'order_quantity' => quantity)
    end

    def replace(changes = {})
      return nil if changes.nil? || changes.empty?
      cancel
      assign_attributes(changes.slice(:limit_price, :quantity))
      place
    end

    def cancel
      subscription.client.cancel_order(order_id)
    end
  end
end
