require "track/json_timelog"
require "track/sqlite_timelog"

class BaseCommand
  attr_reader :input, :output, :timelog

  def initialize(input, output)
    @input = input
    @output = output
    @timelog = SqliteTimelog.new
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
