require "track/timelog"

class BaseCommand
  attr_reader :input, :output

  def initialize(input, output)
    @input = input
    @output = output
    @timelog = Timelog.boot
  end

  def self.execute(input, output)
    self.new(input, output).execute
  end

  def self.matches?(input)
    raise NotImplementedError "#{self.class.name}#matches?() is not implemented"
  end

  def execute
    raise NotImplementedError "#{self.class.name}#execute() is not implemented"
  end
end
