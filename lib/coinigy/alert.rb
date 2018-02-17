module Coinigy
  # Represents an Alert on a market
  class Alert < Coinigy::Model
    # Alert operator types
    ABOVE = :>.freeze
    BELOW = :<.freeze

    attr_accessor :exch_code, :exch_name,  :mkt_name, :price, :operator,
                  :alert_id, :operator_text, :alert_note,
                  :alert_added, :display_name, :exch_code,
                  :alert_history_id, :timestamp, :alert_price

    # Relations
    attr_accessor :subscription, :market, :exchange

    def attributes
      { 'exch_name' => exch_name,
        'mkt_name' => mkt_name,
        'price' => price,
        'operator' => operator,
        'alert_id' => alert_id,
        'operator_text' => operator_text,
        'alert_note' => alert_note,
        'alert_added' => alert_added,
        'display_name' => display_name,
        'exch_code' => exch_code,
        'alert_history_id' => alert_history_id,
        'timestamp' => timestamp,
        'alert_price' => alert_price }
    end

    def exchange
      subscription.exchanges.find { |exchange| exchange.exch_code == exch_code }
    end

    def market
      exchange.markets.find { |market| market.mkt_name == mkt_name }
    end

    def place
      subscription.client.add_alert('exch_code' => exch_code,
                                    'market_name' => mkt_name,
                                    'alert_price' => price,
                                    'alert_note' => alert_note)
    end

    def replace(changes = {})
      return nil if changes.empty?
      cancel
      changes.each { |key, value| self.send("#{key}=", value) }
      place
    end

    def cancel
      subscription.client.delete_alert(alert_id)
    end
  end
end
