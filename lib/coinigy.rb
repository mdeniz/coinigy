module Coinigy
  VERSION = '1.0.0'
end

require 'active_model'

['response',
 'client',
 'model',
 'subscription',
 'preferences',
 'account',
 'exchange',
 'market'].each { |file| require File.expand_path("../coinigy/#{file}", __FILE__) }
