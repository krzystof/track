require "commands/base_command"

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
    last_three_records = @timelog.last 3

    if last_three_records.empty?
      output.text "Nothing previously recorded!"
    else
      ouptut.records last_three_records
    end
  end

  def print_wip
    if @timelog.has_wip?
      output.in_progress @timelog.wip
    else
      output.text "Nothing in progress"
    end
  end
end
