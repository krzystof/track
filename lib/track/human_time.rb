class HumanTime
  attr_reader :seconds

  def initialize(seconds)
    @seconds = seconds
  end

  def to_s
    if seconds < 60
      "less than a minute"
    else
      "#{formatted_hours}#{connector}#{formatted_minutes}".strip
    end
  end

  def hours
    seconds / 3600
  end

  def minutes
    remaining_seconds = seconds % 3600
    remaining_seconds / 60
  end

  def formatted_hours
    return "" if hours == 0
    hour_label = hours == 1 ? "hour" : "hours"
    "#{hours} #{hour_label}"
  end

  def connector
    " and " if hours > 0 and minutes > 0
  end

  def formatted_minutes
    return "" if minutes == 0
    minute_label = minutes == 1 ? "minute" : "minutes"
    "#{minutes} #{minute_label}"
  end
end
