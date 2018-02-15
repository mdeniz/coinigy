module Coinigy
  # Represents an Account of a user subscription to Coinigy
  class Account < Coinigy::Model
    attr_accessor :auth_id, :auth_key, :auth_optional1, :auth_nickname, :exch_name,
                  :auth_secret, :auth_updated, :auth_active, :auth_trade,
                  :exch_trade_enabled, :exch_id

    # Relations
    attr_accessor :subscription

    def attributes
      { "first_name" => first_name, "last_name" => last_name,
        "company" => company, "phone" => phone,
        "street1" => street1, "street2" => street2,
        "city" => city, "state" => state,
        "zip" => zip, "country" => country }
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
  end
end
