module Coinigy
  # Represents the Subscription to Coinigy, it holds all the info related
  class Subscription
    include ActiveModel::Model

    attr_accessor :email, :active, :last_active, :last_login, :chat_enabled, :chat_nick,
                  :ticker_enabled, :ticker_indicator_time_type, :custom_ticker, :first_name,
                  :last_name, :pref_subscription_expires, :pref_alert_email, :pref_alert_sms,
                  :pref_trade_email, :pref_trade_sms, :pref_alert_mobile, :pref_trade_mobile,
                  :pref_balance_email, :pref_referral_code, :created_on, :company, :phone,
                  :street1, :street2, :city, :state, :zip, :country, :newsletter, :two_factor,
                  :subscription_status, :referral_balance, :pref_app_device_id

    # Other objects
    attr_accessor :preferences, :client

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

    # Saves the actual data to the server
    def save
      new_data = { "first_name" => first_name, "last_name" => last_name,
                   "company" => company, "phone" => phone,
                   "street1" => street1, "street2" => street2,
                   "city" => city, "state" => state,
                   "zip" => zip, "country" => country }
      response = client.update_user(new_data)
      !response.error?
    rescue Exception => e
      false
    end
  end
end
