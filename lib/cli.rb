require "commands/short_summary"
require "commands/last_records"
require "commands/start_tracking"
require "commands/stop_tracking"

class Cli
  COMMANDS = [
    StopTracking,
    LastRecords,
    StartTracking,
    ShortSummary,
    # ContinueTracking
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
    cmd = matching_command
    if cmd
      cmd.execute @input, @output
    else
      output.error "I didn't catch that. Can you reformulate?"
    end
  end

  def matching_command
    COMMANDS.find { |c| c.matches? @input }
  end
end
