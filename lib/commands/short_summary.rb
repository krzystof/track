require "commands/base_command"
require "report"

class ShortSummary < BaseCommand
  def self.matches?(input)
    input.empty?
  end

  def execute
    print_last_three_records
    print_wip
  end

  private
  def print_last_three_records
    Report.new(output).for_records @timelog.last(3)
  end

  def print_wip
    if @timelog.has_wip?
      output.in_progress @timelog.wip
    else
      output.text "Nothing in progress"
    end
  end
end
