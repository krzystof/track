require "commands/base_command"
require "track/records_list"
require "track/time_frame"

class ShortSummary < BaseCommand
  def self.matches?(input)
    input.empty?
  end

  def execute
    show_last_five_records
    show_sum_for_today
    show_what_is_in_progress
  end

  private
  def show_last_five_records
    output.info "The last 5 things you did"
    records = @timelog.last(5)
    Table.new(output).headers("Date", "Project", "Task", "Time").rows(RecordsList.new(records).to_rows)
  end

  def show_sum_for_today
    now = DateTime.now
    today_start = DateTime.new(now.year, now.month, now.day)
    records = timelog.finish_during(TimeFrame.new(today_start, now))
    if records.empty?
      output.info "Nothing done today, you slacker"
    else
      output.info "What you've been up to today"
      CumulativeReport.per_project(output, records)
    end
  end

  def show_what_is_in_progress
    if @timelog.has_wip?
      output.in_progress @timelog.wip
    else
      output.error "Nothing in progress"
    end
  end
end
