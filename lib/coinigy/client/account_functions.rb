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
    end
  end
end
