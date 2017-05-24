require "date"

class Timestamp
  def self.beginning_of_week(datetime)
    diff_in_days = datetime.strftime("%u").to_i - 1
    prev_monday = datetime.prev_day(diff_in_days)
    DateTime.new(prev_monday.year, prev_monday.month, prev_monday.day)
  end

  def self.end_of_week(datetime)
    diff_in_days = 7 - datetime.strftime("%u").to_i
    next_sunday = datetime.next_day(diff_in_days)
    DateTime.new(next_sunday.year, next_sunday.month, next_sunday.day, 23, 59, 59)
  end
end
