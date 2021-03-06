module Coinigy
  # Represents a Market of a exchange
  class Market < Coinigy::Model
    attr_accessor :exch_id, :exch_name, :exch_code, :mkt_id, :mkt_name, :exchmkt_id

    # Relations
    attr_accessor :exchange

    alias_attribute :id, :mkt_id
    alias_attribute :pair, :mkt_name

    def attributes
      { 'exch_id' => exch_id,
        'exch_name' => exch_name,
        'exch_code' => exch_code,
        'mkt_id' => mkt_id,
        'mkt_name' => mkt_name,
        'exchmkt_id' => exchmkt_id }
    end

    def history
      get_data(:history)['history']
    end

    def asks
      get_data(:asks)['asks']
    end

    def bids
      get_data(:bids)['bids']
    end

    def asks_and_bids
      orders_data = get_data(:orders)
      {
        asks: orders_data['asks'],
        bids: orders_data['bids']
      }
    end

    def data
      all_data = get_data(:all)
      {
        history: all_data['history'],
        asks: all_data['asks'],
        bids: all_data['bids']
      }
    end

    def ticker
      values = exchange.subscription.client.ticker('exchange_code' => exch_code,
                                                   'exchange_market' => mkt_name).data.first
      {
        last_trade: values['last_trade'],
        high_trade: values['high_trade'],
        low_trade: values['low_trade'],
        volume: values['current_volume'],
        timestamp: values['timestamp'],
        ask: values['ask'],
        bid: values['bid']
      }
    end

    def alert(price, note = '')
      Coinigy::Alert.new('exch_code' => exch_code,
                         'mkt_name' => mkt_name,
                         'price' => price,
                         'alert_note' => note,
                         'subscription' => exchange.subscription).place
    end

    def open_alerts(reload = false)
      exchange.subscription.open_alerts(reload).select { |alert| alert.mkt_name == mkt_name }
    end

    private

    def get_data(type = :all)
      exchange.subscription.client.data('exchange_code' => exch_code,
                                        'exchange_market' => mkt_name,
                                        'type' => type.to_s).data
    end
  end
end
