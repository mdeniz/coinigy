module Coinigy
  VERSION = '1.0.0'
end

['response', 'client'].each { |file| require File.expand_path("../coinigy/#{file}", __FILE__) }
