module Coinigy
  class Client
    # Gather information about your Coinigy account
    module AccountData
      # Returns your account information and preferences
      #
      # NOTE: For security purposes, the "userInfo" method is only available by request. Please contact support to request access.
      def user_info
        request('userInfo')
      end

      # Returns a list of your recent account activity
      def activity
        request('activity')
      end

      # List any unshown alerts or trade notifications
      def notifications
        request('pushNotifications')
      end

      # Returns a list of your attached exchange accounts and wallets, each with a unique auth_id.
      def accounts
        request('accounts')
      end

      # Returns a combined list of balances for all accounts, or specificied auth_ids
      def balances(ids = '', show_nils = 0)
        request('balances', { auth_ids: ids, show_nils: show_nils })
      end

      # Returns balances for your entire account on given date (eg '2018-02-23')
      def balance_history(date = Date.today.to_s)
        request('balanceHistory', { date: date })
      end

      # Returns a list of all open orders and recent order history
      def orders
        request('orders')
      end

      # Returns a list of all open alerts and recent alert history
      def alerts
        request('alerts')
      end

      # Returns ticker data on your favorite markets (as selected on Coinigy.com)
      def watch_list
        request('userWatchList')
      end

      # Returns a list of the latest items from Coinigy's newsfeed sources
      def news_feed
        request('newsFeed')
      end
    end
  end
end
