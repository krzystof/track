require "date"
require "track/human_time"

class Record
  attr_accessor :project, :task, :start, :finish

  def initialize(params)
    @project = params[:project]
    @task = params[:task] || "various"
    @start = params[:start] ? DateTime.parse(params[:start]) : DateTime.now
    @finish = params[:finish] != nil ? DateTime.parse(params[:finish]) : nil
  end

  def to_hash
    {
      :project => @project,
      :task => @task,
      :start => @start.to_s,
      :finish => @finish
    }
  end

  def self.from_hash(hash)
    self.new Hash[hash.map { |(k,v)| [k.to_sym,v] }]
  end

  def in_progress?
    @finish == nil
  end

  def seconds
    finish = @finish || DateTime.now
    finish.strftime("%s").to_i - @start.strftime("%s").to_i
  end

  def human_time
    HumanTime.new seconds
  end

  def complete
    @finish = DateTime.now
  end

  def == other
    project == other.project && task == other.task && start == other.start
  end

  def to_row
    [project, task, human_time.to_s]
  end
end
