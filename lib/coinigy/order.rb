module Coinigy
  # Represents an Account of a user subscription to Coinigy
  class Order < Coinigy::Model
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
      order_type_id = (order_type == 'Buy') ? 1 : 2
      send_to_server do
        subscription.client.add_order('auth_id' => auth_id,
                                      'exch_id' => exchange.exch_id,
                                      'mkt_id' => market.mkt_id,
                                      'order_type_id' => order_type_id,
                                      'price_type_id' => price_type_id,
                                      'limit_price' => limit_price,
                                      'order_quantity' => quantity)
      end
    end

    def replace(changes = {})
      return nil if changes.empty?
      cancel
      changes.each { |key, value| self.send("#{key}=", value) }
      place
    end

    def cancel
      subscription.client.cancel_order(order_id)
    end
  end
end
