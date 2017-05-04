require "commands/base_command"

class Purge < BaseCommand
  ARGUMENT_NAME = "purge"

  def self.matches?(input)
    input.first == ARGUMENT_NAME
  end

  def execute
    output.info "All the records have been deleted"
    Timelog.delete
  end
end
