require "commands/base_command"
require "track/timestamp"
require "track/cumulative_times"

class WeeklyReport < BaseCommand
  WEEK = "week"

  def self.matches?(input)
    input.first == WEEK
  end

  def execute
    beginning_of_week = Timestamp.beginning_of_week
    end_of_week = Timestamp.end_of_week
    records = timelog.between(beginning_of_week, end_of_week)

    # print all of this week records

    # puts
    output.text "Time spent by project between the #{beginning_of_week.to_date} and the #{end_of_week.to_date}:"
    Table.new(output).headers("Project", "Time spent").rows(CumulativeTimes.new(records).to_rows)
  end
end
