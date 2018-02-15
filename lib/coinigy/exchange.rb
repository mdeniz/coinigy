module Coinigy
  # Represents an Account of a user subscription to Coinigy
  class Exchange < Coinigy::Model
    attr_accessor :exch_id, :exch_name, :exch_code, :exch_fee, :exch_trade_enabled,
                  :exch_balance_enabled, :exch_url

    # Relations
    attr_accessor :subscription, :accounts, :markets

    def attributes
      { 'exch_id' => exch_id,
        'exch_name' => exch_name,
        'exch_code' => exch_code,
        'exch_fee' => exch_fee,
        'exch_trade_enabled' => exch_trade_enabled,
        'exch_balance_enabled' => exch_balance_enabled,
        'exch_url' => exch_url }
    end

    # Accounts relation
    def accounts
      @accounts ||= subscription.accounts.select { |account| account.exch_id == exch_id}
    end

    # Markets relation
    def markets
      @markets ||= subscription.client.markets(exch_code).data.map { |data| Coinigy::Market.new(data.merge({ exchange: self })) }
    end
  end
end
