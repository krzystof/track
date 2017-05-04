require "track/record"
require "commands/base_command"

class StartTracking < BaseCommand
  def self.matches?(input)
    input.count == 1 || input.count == 2
  end

  def execute
    # @todo if same as current, do nothing

    project = @input.at_position 0
    task = @input.at_position 1

    @timelog.append Record.new({ :project => project, :task => task })
    @timelog.commit

    @output.in_progress @timelog.wip
  end
end
