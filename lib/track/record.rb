class Record
  attr_reader :project, :task, :start, :finish

  def initialize(project, task, timestamp)
    @project = project
    @task = task
    @start = timestamp
  end

  def to_s
    {
      :project => @project,
      :task => @task,
      :start => @start,
      :finish => @finish
    }.to_s
  end
end
