module Coinigy
  # Represents the Preferences of a user subscription to Coinigy
  class Preferences < Coinigy::Model
    attr_accessor :alert_email, :alert_sms,
                  :trade_email, :trade_sms,
                  :balance_email

    # Other objects
    attr_accessor :subscription

    def attributes
      { "alert_email" => alert_email, "alert_sms" => alert_sms,
        "trade_email" => trade_email, "trade_sms" => trade_sms,
        "balance_email" => balance_email }
    end

    private
    
    # Saves the actual data to the server
    def save_to_api(data)
      subscription.client.save_notifications_preferences(data)
    end
  end
end
