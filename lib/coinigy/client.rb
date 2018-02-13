require 'rest-client'
require 'yajl'

require 'coinigy/client/account_data'
require 'coinigy/client/account_functions'
require 'coinigy/client/market_data'

module Coinigy
  # Client to connect to the specified coinigy api
  class Client

    include Coinigy::Client::AccountData
    include Coinigy::Client::AccountFunctions
    include Coinigy::Client::MarketData

    def initialize(options = {})
      @headers = {
        'Content-Type': 'application/json',
        'X-API-KEY': options[:key] || '',
        'X-API-SECRET': options[:secret] || ''
      }
      #@root = 'https://private-anon-53a8e2b59c-coinigy.apiary-proxy.com/api/v1'
      @root = options[:root] || 'https://private-anon-53a8e2b59c-coinigy.apiary-mock.com/api/v1'
      # https://api.coinigy.com/api/v1
      @last_request_timestamp = Time.now
    end

    private

    def url(path)
      "#{@root}/#{path}"
    end

    def request(path, payload = nil)
      wait_for_api_limit
      if payload
        response = RestClient.post(url(path), payload, @headers.merge({ 'Content-Type': 'application/json,application/json' }))
      else
        response = RestClient.post(url(path), @headers)
      end
      @last_request_timestamp = Time.now
      Coinigy::Response.new(response)
    end

    def wait_for_api_limit
      while Time.now - @last_request_timestamp < 0.5; end # 2 request per second
    end
  end
end
