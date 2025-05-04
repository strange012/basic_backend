class LoggenInClientsQuery
  class << self
    def with_never_logged_in(query = Client.all)
      query.where(current_sign_in_at: nil)
    end

    def with_logged_in_since(time, query = Client.all)
      query.where('clients.current_sign_in_at > ?', time)
    end

    def with_logged_users_in(period, query = Client.all)
      case period
      when 'week', 'month', 'year'
        with_logged_in_since(DateTimeHelper.beginning_of_period(period), query)
      when 'never'
        with_never_logged_in(query)
      end
    end
  end
end
