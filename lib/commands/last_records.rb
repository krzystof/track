require "commands/base_command"

class LastRecords < BaseCommand
  CMD_NAME = "last"

  def self.matches?(input)
    input.at_position(0) == CMD_NAME
  end

  def execute
    how_many = input.at_position(1).to_i || 5
    records = @timelog.last(how_many)

    Table.new(output)
      .headers("Date", "Project", "Task", "Time")
      .rows(RecordsList.new(records).to_rows)
  end
end
