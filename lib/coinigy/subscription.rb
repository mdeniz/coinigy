module Coinigy
  # Represents the Subscription to Coinigy, it holds all the info related
  class Subscription < Coinigy::Model
    attr_accessor :email, :active, :last_active, :last_login, :chat_enabled, :chat_nick,
                  :ticker_enabled, :ticker_indicator_time_type, :custom_ticker, :first_name,
                  :last_name, :pref_subscription_expires, :pref_alert_email, :pref_alert_sms,
                  :pref_trade_email, :pref_trade_sms, :pref_alert_mobile, :pref_trade_mobile,
                  :pref_balance_email, :pref_referral_code, :created_on, :company, :phone,
                  :street1, :street2, :city, :state, :zip, :country, :newsletter, :two_factor,
                  :subscription_status, :referral_balance, :pref_app_device_id

    # Relationships  and other objects
    attr_accessor :client, :preferences, :accounts, :open_orders, :order_history

    def attributes
      { "first_name" => first_name, "last_name" => last_name,
        "company" => company, "phone" => phone,
        "street1" => street1, "street2" => street2,
        "city" => city, "state" => state,
        "zip" => zip, "country" => country }
    end

    # Connects to the API with the credentials given and returns an instance of Subscription with the data of the user
    def self.find(key, secret)
      client = Coinigy::Client.new(key: key, secret: secret)
      attributes = client.user_info.data
      attributes[:client] = client
      new(attributes)
    end

    # Preferences relation
    def preferences
      @preferences ||= Coinigy::Preferences.new(alert_email: pref_alert_email, alert_sms: pref_alert_sms,
                                                trade_email: pref_trade_email, trade_sms: pref_trade_sms,
                                                balance_email: pref_balance_email, subscription: self)
    end

    # Accounts relation
    def accounts(reload = false)
      @accounts = nil  if reload
      @accounts ||= client.accounts.data.map { |account_info| Coinigy::Account.new(account_info.merge({ subscription: self })) }
    end

    # Registers a new account in the subscription and returns it
    def add_account(name, exchange, key, secret)
      new_attributes = { 'api_key' => key, 'api_secret' => secret, 'api_exch_id' => exchange, 'api_nickname' => name }
      response = client.add_api_key(new_attributes)
      return nil if response.error?
      accounts(true).find { |account| account.auth_id.to_i == response.data.to_i }
    rescue Exception => e
      nil
    end

    # Return all exchanges supported at Coinigy
    def all_exchanges
      @all_exchanges ||= client.exchanges.data.map { |exchange_info| Coinigy::Exchange.new(exchange_info.merge({ subscription: self })) }
    end

    # Exchanges relation
    def exchanges(reload = false)
      @exchanges = nil  if reload
      exchanges_ids_in_accounts = accounts.map(&:exch_id).uniq
      @exchanges ||= all_exchanges.select {|exchange| exchanges_ids_in_accounts.include?(exchange.exch_id) }
    end

    # Returns the balances for the provided account ids
    def balances(ids = [], show_nils = 0)
      client.balances(ids.join(','), show_nils).data
    end

    # Returns the mixed balance of the whole subscription
    def balance(show_nils = 0)
      balances([], show_nils)
    end

    # Returns the balance history for the provided date (separated per account)
    def balance_history(date = Date.today.to_s)
      client.balance_history(date)
    end

    # Returns the list of order and price types
    def order_and_price_types
      @order_and_price_types ||= client.order_types.data
    end

    # Open orders relation
    def open_orders(reload = false)
      load_orders(reload || @open_orders.nil?)
      @open_orders
    end

    # Order history relation
    def order_history(reload = false)
      load_orders(reload || @order_history.nil?)
      @order_history
    end

    # Open alerts relation
    def open_alerts(reload = false)
      load_alerts(reload || @open_alerts.nil?)
      @open_alerts
    end

    # Alert history relation
    def alert_history(reload = false)
      load_alerts(reload || @alert_history.nil?)
      @alert_history
    end

    private

    # Orders relation loading
    def load_orders(reload = false)
      if reload
        data = client.orders.data
        @open_orders = data['open_orders'].map { |info| Coinigy::Order.new(info.merge({ subscription: self })) }
        @order_history = data['order_history'].map { |info| Coinigy::Order.new(info.merge({ subscription: self })) }
      end
    end

    # Alerts relation loading
    def load_alerts(reload = false)
      if reload
        data = client.alerts.data
        @open_alerts = data['open_alerts'].map { |info| Coinigy::Alert.new(info.merge({ subscription: self })) }
        @alert_history = data['alert_history'].map { |info| Coinigy::Alert.new(info.merge({ subscription: self })) }
      end
    end

    # Saves the actual attributes to the server
    def save_to_api(data)
      client.update_user(data)
    end
  end
end
