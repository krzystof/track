class Record
  attr_accessor :project, :task, :start, :finish

  def initialize(params)
    @project = params["project"]
    @task = params["task"]
    @start = params["start"]
    @finish = params["finish"] || nil
  end

  def to_hash
    {
      :project => @project,
      :task => @task,
      :start => @start,
      :finish => @finish
    }
  end

  def self.from_hash(hash)
    self.new hash
  end

  def in_progress?
    @finish == nil
  end
end
