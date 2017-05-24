require "commands/base_command"
require "track/cumulative_report"

class Sum < BaseCommand
  @name = "sum"

  def execute
    records = @timelog.all
    oldest_date = records.min { |a, b| a.start <=> b.start }.start
    time_ago = TimeAgo.new(oldest_date)
    output.info "Started #{time_ago}"
    CumulativeReport.renders(output, records)
  end
end
