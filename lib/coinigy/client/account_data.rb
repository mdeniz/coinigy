module Coinigy
  class Client
    module AccountData
      def user_info
        request('userInfo')
      end

      def activity
        request('activity')
      end

      def notifications
        request('pushNotifications')
      end

      def accounts
        request('accounts')
      end
    end
  end
end
