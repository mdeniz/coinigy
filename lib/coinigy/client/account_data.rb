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

      def balances
        request('balances')
      end

      def balance_history(date = Date.today.to_s)
        request('balanceHistory', { date: date })
      end
    end
  end
end
