require "commands/base_command"

class Continue < BaseCommand
  CMD_NAME = "continue"

  def self.matches?(input)
    input.first == CMD_NAME
  end

  def execute
    if @timelog.has_wip?
      output.error "You are currently working on something. Use 'switch' to work on the previous entry"
    else
      record = @timelog.last(1)
      @timelog.save Record.from_previous(record[0])
      @output.in_progress @timelog.wip
    end
  end
end
