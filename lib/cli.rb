require "commands/track"

class Cli
  COMMANDS = [
    Track
  ]

  @input
  @output

  def initialize(input, output)
    @input = input
    @output = output
  end

  def self.run(input, output)
    self.new(input, output).run
  end

  def run
    cmd = matching_command

    if cmd
      cmd.execute @input, @output
    else
      @output.error "Sorry! I didn't find a command for whatever you tried to type."
    end
  end

  def matching_command
    COMMANDS.find { |c| c.matches @input }
  end
end
