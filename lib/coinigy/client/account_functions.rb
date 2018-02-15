module Coinigy
  class Client
    # Private account methods - place alerts, orders, refresh balances
    module AccountFunctions
      # Update your account information on record
      def update_user(options = {})
        request('updateUser', options.slice('first_name', 'last_name', 'company', 'phone', 'street1', 'street2', 'city', 'state', 'zip', 'country'))
      end

      # Update your notification preferences (alerts, trades, balances) via (email, sms)
      def save_notifications_preferences(options = {})
        request('savePrefs', options.slice('alert_email', 'alert_sms', 'trade_email', 'trade_sms', 'balance_email'))
      end

      # Update your favorite markets/tickers based on exch_mkt_id
      def update_tickers(ids = [])
        request('updateTickers', { exch_mkt_ids: ids.join(',') })
      end

      # Returns a list of supported order and price types
      def order_types
        request('orderTypes')
      end

      # Refresh balances on specified auth_id
      def refresh_balance(id = nil)
        request('refreshBalance', { auth_id: id })
      end

      # Add a new price alert
      def add_alert(options = {})
        request('addAlert', options.slice('exch_code', 'market_name', 'alert_price', 'alert_note'))
      end

      # Delete existing price alert by alert_id
      def delete_alert(id = nil)
        request('deleteAlert', { alert_id: id })
      end

      # Add a new Exchange API Key to your account. Returns newly-generated auth_id in 'data' block.
      # After adding a new key, it must still be both activated and activated for trading.
      def add_api_key(options = {})
        request('addApiKey', options.slice('api_key', 'api_secret', 'api_exch_id', 'api_nickname'))
      end

      # Delete specified Exchange API Account by auth_id
      def delete_api_key(id = nil)
        request('deleteApiKey', { auth_id: id })
      end

      # Activate/Enable API Key usage (enables automatic balance monitoring)
      def activate_api_key(id = nil, auth_active = 1)
        request('activateApiKey', { auth_id: id, auth_active: auth_active })
      end

      # Activate/Enable Trading on specified API key
      def activate_trading_key(id = nil, auth_active = 1)
        request('activateTradingKey', { auth_id: id, auth_trade: auth_active })
      end

      # Create a new exchange order. Returns internal_order_id upon success
      def add_order(options = {})
        request('addOrder', options.slice('auth_id', 'exch_id', 'mkt_id', 'order_type_id', 'price_type_id', 'limit_price', 'order_quantity'))
      end

      # Cancel an outstanding exchange order
      def cancel_order(id = nil)
        request('cancelOrder', { internal_order_id: id })
      end
    end
  end
end
