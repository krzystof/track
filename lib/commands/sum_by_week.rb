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

      if num_week == 0
        print_daily_sums(records)
      end

      if records.empty?
        output.error "nothing done between #{week.start_date} and #{week.finish_date}"
      else
        output.info "Time spent by project for the week starting #{week.start.to_date} and finishing #{week.finish.to_date}"
        CumulativeReport.per_project(output, records)
      end
    end
  end

  def print_daily_sums(records)
    if records.empty?
      output.error "Nothing done this week"
    else
      output.info "here's what happened this week"
      CumulativeReport.daily(output, records)
    end
  end
end
