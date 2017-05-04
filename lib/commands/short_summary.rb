require "commands/base_command"

class ShortSummary < BaseCommand
  def self.matches?(input)
    input.empty?
  end

  def execute
    # if nothing previously
    output.text('No previous entries')

    # if nothing in progress
    print_wip
  end

  private
  def print_wip
    if @timelog.has_wip?
      output.in_progress @timelog.wip
    else
      output.text "Nothing in progress"
    end
  end
end
