module Coinigy
  class Client
    # Access exchange and market data
    module MarketData
      # Returns a list of all supported exchanges
      def exchanges
        request('exchanges')
      end

      # Returns a list of markets on specified exchange
      def markets(id = nil)
        request('markets', { exchange_code: id })
      end

      # Trade history, asks and bids for any supported exchange/market
      # type: Can be 'all', 'history', 'asks', 'bids' or 'orders'
      def data(options = {})
        request('data', options.slice('exchange_code', 'exchange_market', 'type'))
      end

      # Returns last, high (24h), low (24h), ask, bid for specified market
      def ticker(options = {})
        request('ticker', options.slice('exchange_code', 'exchange_market'))
      end
    end
  end
end
