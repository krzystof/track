class Record
  attr_reader :project, :task, :start, :finish

  def initialize(params)
    @project = params[:project]
    @task = params[:task]
    @start = params[:start]
    @finish = params[:finish] || nil
  end

  def to_h
    {
      :project => @project,
      :task => @task,
      :start => @start,
      :finish => @finish
    }
  end

  def in_progress
    p @finish
    @finish == nil
  end
end
