require 'rest-client'
require 'yajl'

require 'coinigy/client/account'
require 'coinigy/client/subscription'

module Coinigy
  class Client

    include Coinigy::Client::Account
    include Coinigy::Client::Subscription

    def initialize(options = {})
      @headers = {
        content_type: 'application/json',
        x_api_key: options[:key] || '',
        x_api_secret: options[:secret] || ''
      }
      #@root = 'https://private-anon-53a8e2b59c-coinigy.apiary-proxy.com/api/v1'
      @root = options[:root] || 'https://private-anon-53a8e2b59c-coinigy.apiary-mock.com/api/v1'
      @last_request_timestamp = Time.now
    end

    private

    def url(path)
      "#{@root}/#{path}"
    end

    def request(path, payload = nil)
      wait_for_api_limit
      if payload
        response = RestClient.post(url(path), payload, @headers)
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
