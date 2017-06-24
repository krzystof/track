require "commands/base_command"
require "track/cumulative_report"

class Sum < BaseCommand
  @name = "sum"

  def execute
    if input.has_flag?(:project)
      project = get_project_like input.flag(:project)
      records = @timelog.on_project(project)
    else
      project = ""
      records = @timelog.all
    end

    oldest_date = records.min { |a, b| a.start <=> b.start }.start
    time_ago = TimeAgo.new(oldest_date)

    if input.has_flag?(:weekly)
      report_label = 'weekly breakdown'
      report = CumulativeReport.method(:weekly)
    elsif input.has_flag?(:monthly)
      report_label = 'monthly breakdown'
      report = CumulativeReport.method(:monthly)
    else
      report_label = 'total by project'
      report = CumulativeReport.method(:per_project)
    end

    output.info "Showing: #{report_label} #{project} since #{time_ago}"
    report.call(output, records)
  end
end
