lib = 'coinigy'
lib_file = File.expand_path("../lib/#{lib}.rb", __FILE__)
File.read(lib_file) =~ /\bVERSION\s*=\s*["'](.+?)["']/
version = $1

Gem::Specification.new do |spec|
  spec.name        = lib
  spec.version     = version
  spec.date        = '2018-02-13'

  spec.summary     = "A client for the API of www.coinigy.com"
  spec.description = "This client allows you to interact with your Coinigy Account and Exchange Accounts directly, to refresh balances, place and cancel orders, set and cancel alerts, and poll for market data."

  spec.authors     = ["Moisés Déniz Alemán"]
  spec.email       = 'mdeniz@suse.com'
  spec.homepage    = 'https://github.com/mdeniz/coinigy'
  spec.license     = 'MIT'

  spec.add_runtime_dependency 'rest-client', '~> 2.0'
  spec.add_runtime_dependency 'yajl-ruby', '~> 1.3'
  spec.add_runtime_dependency 'activemodel', '~> 5.1'

  spec.files = %w(LICENSE README.md)
  spec.files << "#{lib}.gemspec"
  spec.files += Dir.glob("lib/**/*.rb")
end
