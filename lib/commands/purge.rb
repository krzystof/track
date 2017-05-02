require "commands/base_command"

class Purge < BaseCommand
  ARGUMENT_NAME = "purge"

  def self.matches?(input)
    input.first == ARGUMENT_NAME
  end

  def execute
    output.confirm "This will delete all you records. Are? You? Sure?"
    p input.read
  end
end
