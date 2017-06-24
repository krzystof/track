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

  private
  def get_project_like(string)
      projects = @timelog.find_projects_like(string)
      if not projects
        raise InvalidInput.new "Could not find a project matching '#{string}'"
      elsif projects.length > 1
        raise InvalidInput.new "The project '#{string}' is ambiguous. I found these: #{projects}. Do refine."
      else
        projects.first
      end
  end
end
