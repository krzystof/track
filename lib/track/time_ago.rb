class TimeAgo
  ONE_MINUTE = 60
  ONE_HOUR = 60 * ONE_MINUTE
  ONE_DAY = 24 * ONE_HOUR
  ONE_WEEK = 7 * ONE_DAY
  ONE_MONTH = 4.3 * ONE_WEEK
  ONE_YEAR = 12 * ONE_MONTH

  PERIODS = {
    ONE_MINUTE => "minute",
    ONE_HOUR => "hour",
    ONE_DAY => "day",
    ONE_WEEK => "week",
    ONE_MONTH => "month",
    ONE_YEAR => "year",
  }

  def initialize(ago)
    @ago = ago.is_a?(DateTime) ? ago : DateTime.parse(ago)
    @diff = nil
  end

  def to_s
    if diff < ONE_MINUTE
      "Just now"
    else
      find_closer_match
    end
  end

  private
  def find_closer_match
    case
    when diff < ONE_MINUTE then "Just now"
    when diff < ONE_HOUR then interval(ONE_MINUTE)
    when diff < ONE_DAY then interval(ONE_HOUR)
    when diff < ONE_WEEK then interval(ONE_DAY)
    when diff < ONE_MONTH then interval(ONE_WEEK)
    when diff < ONE_YEAR then interval(ONE_MONTH)
    else interval(ONE_YEAR)
    end
  end

  def diff
    if !@diff
      @diff = DateTime.now().strftime("%s").to_i - @ago.strftime("%s").to_i
    end
    @diff
  end

  def interval(size)
    counts = diff.div(size)
    if counts > 1
      "#{counts} #{PERIODS[size]}s ago"
    else
      "#{counts} #{PERIODS[size]} ago"
    end
  end
end
