require "commands/base_command"
require "track/cumulative_report"

class Sum < BaseCommand
  @name = "sum"

  def execute
    records = @timelog.all
    oldest_date = records.min { |a, b| a.start <=> b.start }.start
    time_ago = TimeAgo.new(oldest_date)

    if input.has_flag?(:weekly)
      label = 'weekly breakdown'
      report = CumulativeReport.method(:weekly)
    elsif input.has_flag?(:monthly)
      label = 'monthly breakdown'
      report = CumulativeReport.method(:monthly)
    else
      label = 'total by project'
      report = CumulativeReport.method(:all)
    end

    output.info "Showing: #{label}, since #{time_ago}"
    report.call(output, records)
  end
end
