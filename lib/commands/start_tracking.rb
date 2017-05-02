require "date"
require "track/time_log"
require "track/record"
require "commands/base_command"

class StartTracking < BaseCommand
  def self.matches?(input)
    input.count == 1 || input.count == 2
  end

  def execute
    # if same as current, do nothing

    project = @input.at_position 0
    task = @input.at_position 1
    time = DateTime.now.strftime("%s").to_i

    TimeLog.boot.append Record.new(project, task, time)
  end
end
