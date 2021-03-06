require "track/timestamp"

class Week
  def initialize(datetime)
    @datetime = datetime
  end

  def self.of(datetime)
    self.new(datetime)
  end

  def sub_weeks(how_many)
    self.class.of(@datetime - how_many * 7)
  end

  def start
    Timestamp.beginning_of_week @datetime
  end

  def finish
    Timestamp.end_of_week @datetime
  end

  def start_date
    start.strftime("%d-%m-%Y")
  end

  def finish_date
    finish.strftime("%d-%m-%Y")
  end
end
