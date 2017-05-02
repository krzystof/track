require "commands/base_command"

class ShortSummary < BaseCommand
  def self.matches?(input)
    input.empty?
  end

  def execute
    # if nothing previously
    output.text('No previous entries')

    # if nothing in progress
    output.text('Nothing in progress')
  end
end
