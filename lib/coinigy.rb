module Coinigy
  VERSION = '1.0.0'
end

require 'active_model'

['misc',
 'response',
 'client',
 'model',
 'subscription',
 'preferences',
 'account',
 'exchange',
 'market',
 'order',
 'alert'].each { |file| require File.expand_path("../coinigy/#{file}", __FILE__) }
