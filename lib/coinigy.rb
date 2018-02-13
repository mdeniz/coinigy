module Coinigy
  VERSION = '0.0.0'
end

require 'rest-client'
require 'yajl'

['agent'].each { |file| require File.expand_path("../coinigy/#{file}", __FILE__) }
