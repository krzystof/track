require "track/record"
require "commands/base_command"

class StartTracking < BaseCommand
  def self.matches?(input)
    input.count == 1 || input.count == 2
  end

  def execute
    if @timelog.has_wip?
      wip = @timelog.wip
      output.question "Finish work on #{wip.project}?"
      return if not input.confirmed?
      wip.complete
      @timelog.save wip
      output.completed wip
    end

    project = @input.at_position 0
    task = @input.at_position 1

    if not @timelog.contains_project?(project)
      output.question "The project #{project} does not exist yet. You positive?"
      return if not input.confirmed?
    end

    @timelog.create Record.new({ :project => project, :task => task })

    @output.in_progress @timelog.wip
  end
end
