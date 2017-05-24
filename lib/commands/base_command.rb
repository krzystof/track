require "track/sqlite_timelog"

class BaseCommand
  attr_reader :input, :output, :timelog

  def initialize(input, output, timelog = nil)
    @input = input
    @output = output
    @timelog = timelog || SqliteTimelog.new
  end

  def self.execute(input, output)
    self.new(input, output).execute
  end

  def self.matches?(input)
    input.first == @name
  end

  def execute
    raise NotImplementedError "#{self.class.name}#execute() is not implemented"
  end
end
