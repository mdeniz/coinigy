module Coinigy
  # Represents an Account of a user subscription to Coinigy
  class Account < Coinigy::Model
    attr_accessor :auth_id, :auth_key, :auth_optional1, :auth_nickname, :exch_name,
                  :auth_secret, :auth_updated, :auth_active, :auth_trade,
                  :exch_trade_enabled, :exch_id

    alias_attribute :id, :auth_id
    alias_attribute :key, :auth_key
    alias_attribute :secret, :auth_secret
    alias_attribute :nickname, :auth_nickname
    alias_attribute :updated, :auth_updated
    alias_attribute :active, :auth_active
    alias_attribute :trade, :auth_trade

    # Relations
    attr_accessor :subscription, :exchange

    def attributes
      { "auth_id" => auth_id, "auth_key" => auth_key,
        "auth_optional1" => auth_optional1, "auth_nickname" => auth_nickname,
        "exch_name" => exch_name, "auth_secret" => auth_secret,
        "auth_active" => auth_active, "auth_updated" => auth_updated,
        "auth_trade" => auth_trade, "exch_trade_enabled" => exch_trade_enabled,
        "exch_id" => exch_id }
    end

    # Exchange relation
    def exchange
      @exchange ||= subscription.all_exchanges.find { |exchange| exchange.exch_id == exch_id}
    end

    # Activates or deactivates the trading flag for the account
    def trading(flag = true)
      send_to_server { subscription.client.activate_trading_key(auth_id, flag ? 1 : 0) }
    end

    # Activates or deactivates the account
    def activate(flag = true)
      send_to_server { subscription.client.activate_api_key(auth_id, flag ? 1 : 0) }
    end

    # Deletes this account
    def delete
      send_to_server { subscription.client.delete_api_key(auth_id) }
    end

    # Returns the balance of this account
    def balance(refresh = false)
      return subscription.client.refresh_balance(auth_id).data if refresh
      subscription.balances([auth_id])
    end

    def buy(market_pair, limit_price, quantity)
      place_order(Coinigy::Order::BUY, market_pair, limit_price, quantity)
    end

    def sell(market_pair, limit_price, quantity)
      place_order(Coinigy::Order::SELL, market_pair, limit_price, quantity)
    end

    private

    def place_order(type, market_pair, limit_price, quantity)
      Coinigy::Order.new('auth_id' => auth_id,
                         'exch_code' => exchange.exch_code,
                         'mkt_name' => market_pair,
                         'order_type' => type == Coinigy::Order::BUY ? 'Buy' : 'Sell',
                         'price_type_id' => Coinigy::Order::LIMIT,
                         'limit_price' => limit_price,
                         'quantity' => quantity,
                         'subscription' => subscription).place
    end
  end
end
