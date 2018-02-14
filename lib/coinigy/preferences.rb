module Coinigy
  # Represents the Preferences of a user subscription to Coinigy
  class Preferences
    include ActiveModel::Model

    attr_accessor :alert_email, :alert_sms,
                  :trade_email, :trade_sms,
                  :balance_email

    # Other objects
    attr_accessor :subscription

    # Saves the actual data to the server
    def save
      new_preferences = { "alert_email" => alert_email, "alert_sms" => alert_sms,
                          "trade_email" => trade_email, "trade_sms" => trade_sms,
                          "balance_email" => balance_email }
      response = subscription.client.save_notifications_preferences(new_preferences)
      !response.error?
    rescue Exception => e
      false
    end
  end
end
