# Coinigy

Ruby toolkit for the Coinigy API (v1).

This gem allows you to interact with your Coinigy Account and Exchange Accounts directly, to refresh balances, place and cancel orders, set and cancel alerts, and poll for market data.

## Quick start

Install via Rubygems

```
gem install coinigy
```

... or add it to your Gemfile

```ruby
gem 'coinigy', "~> 1.0"
```

### Using the low level client

API methods are accessible directly from a `Coinigy::Client` class instance.

```ruby
# Provide authentication credentials
client = Coinigy::Client.new(key: '9328lksdjfñlkj234', secret: 'c0d3b4ssssss43sfsaf')
# Fetch the user info
client.user_info
```

## Requirements

The coinigy gem depends on these other gems for usage at runtime:

  * [yajl-ruby](https://github.com/brianmario/yajl-ruby)
  * [rest-client](https://github.com/rest-client/rest-client)

## Reference

See the [reference](https://mdeniz.github.io/coinigy/doc/) for more detailed information.
