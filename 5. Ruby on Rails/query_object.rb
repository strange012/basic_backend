class NeverLoggenInClientsQuery
  def initialize(query = Client.all)
    @query = query
  end

  def call
    @query.where(current_sign_in_at: nil)
  end
end

class LoggenInSinceClientsQuery
  def initialize(time, query = Client.all)
    @time = time
    @query = query
  end

  def call
    @query.where('clients.current_sign_in_at > ?', @time)
  end
end

class LoggenInPeriodClientsQuery
  def initialize(period, query = Client.all)
    @period = period
    @query = query
  end

  def call
    case period
    when 'week', 'month', 'year'
      time = DateTimeHelper.beginning_of_period(period)
      LoggenInSinceClientsQuery.new(time, @query).call
    when 'never'
      NeverLoggenInClientsQuery.new(@query).call
    end
  end
end
