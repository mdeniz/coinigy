module Coinigy
  class Client
    module Subscription
      def user_info
        request('userInfo')
      end
    end
  end
end
