module Coinigy
  # Represents an Account of a user subscription to Coinigy
  class Account < Coinigy::Model
    attr_accessor :auth_id, :auth_key, :auth_optional1, :auth_nickname, :exch_name,
                  :auth_secret, :auth_updated, :auth_active, :auth_trade,
                  :exch_trade_enabled, :exch_id

    # Relations
    attr_accessor :subscription

    # Deletes this account
    def delete
      response = subscription.client.delete_api_key(auth_id)
      add_error(response.error) if response.error?
      !response.error?
    rescue Exception => e
      false
    end
  end
end
