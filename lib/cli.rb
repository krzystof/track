require "commands/short_summary"
require "commands/last_records"
require "commands/start_tracking"
require "commands/stop_tracking"
require "commands/sum_by_week"
require "commands/continue"
require "commands/sum"
require "table"
require "invalid_input"

class Cli
  COMMANDS = [
    # First word match command:
    LastRecords,
    StopTracking,
    Continue,
    SumByWeek,
    Sum,
    # Catch all:
    StartTracking,
    # No args:
    ShortSummary,

    # Todos:
    # SwitchTracking (between previous) -> can accept project name
    # WeeklyReport -> can accept project name
    # DailyReport -> can accept project name
  ]

  attr_reader :input, :output

  def initialize(input, output)
    @input = input
    @output = output
  end

  def self.run(input, output)
    self.new(input, output).run
  end

  def run
    begin
      cmd = matching_command
      cmd.execute @input, @output
    rescue InvalidInput => e
      output.error e.message
    end
  end

  def matching_command
    cmd = COMMANDS.find { |c| c.matches? @input }
    raise InvalidInput.new "I didn't catch that command. Can you reformulate?" if not cmd
    cmd
  end
end
