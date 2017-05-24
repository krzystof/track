require "commands/base_command"
require "track/timestamp"
require "track/cumulative_times"
require "track/week"

class SumByWeek < BaseCommand
  WEEK = "week"

  def self.matches?(input)
    input.first == WEEK
  end

  def execute
    num_week = input.second_or(0).to_i

    num_week.downto(0) do |wk_ago|
      week = Week.of(DateTime.now).sub_weeks(wk_ago)
      records = timelog.finish_during(week)
      output.info "Time spent by project between the #{week.beginning.to_date} and the #{week.end.to_date}"
      Table.new(output).headers("Project", "Time spent").rows(CumulativeTimes.new(records).to_rows)
    end
  end
end
