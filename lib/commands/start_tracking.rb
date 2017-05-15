require "track/record"
require "commands/base_command"

class StartTracking < BaseCommand
  def self.matches?(input)
    input.count == 1 || input.count == 2
  end

  def execute
    if @timelog.has_wip?
      record = @timelog.wip
      output.question "Finish work on #{record.project}?"
      return if not input.confirmed?
      record.complete
      @timelog.save record
      output.completed record
    end

    project = @input.at_position 0
    task = @input.at_position 1

    if not @timelog.contains_project?(project)
      output.question "The project #{project} does not exist yet. You positive?"
      return if not input.confirmed?
    end

    @timelog.append Record.new({ :project => project, :task => task })
    @timelog.commit

    @output.in_progress @timelog.wip
  end
end
