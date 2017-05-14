require "commands/base_command"
require "track/records_list"

class ShortSummary < BaseCommand
  def self.matches?(input)
    input.empty?
  end

  def execute
    records = @timelog.last(3)
    Table.new(output).headers("Date", "Project", "Task", "Time").rows(RecordsList.new(records).to_rows)

    if @timelog.has_wip?
      output.in_progress @timelog.wip
    else
      output.text "Nothing in progress"
    end
  end
end
