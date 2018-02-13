module Coinigy
  class Client
    module Account
      def accounts
        request('accounts')
      end
    end
  end
end
