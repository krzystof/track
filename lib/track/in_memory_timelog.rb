class InMemoryTimelog
  attr_reader :records

  def initialize(records = [])
    @records = records
  end

  def save(record)
    if contains_record? record
      idx = @records.find_index record
      @records[idx] = record
    else
      @records.push(record)
    end
  end

  def has_wip?
    records.any? { |r| r.in_progress? }
  end

  def wip
    records.find { |r| r.in_progress? }
  end

  def contains_project?(project)
    records.any? { |record| record.project == project }
  end

  def finish_during(timeframe)
    between(timeframe.beginning, timeframe.end)
  end

  def last(count = 1)
    records.select { |r| not r.in_progress? }.last(count)
  end

  def remove(record)
    @records = records.reject { |r| r == record }
  end

  private
  def contains_record?(record)
    records.find { |r| r == record }
  end

  def between(from, to)
    records.select { |r| r.finished_in?(from, to) }
  end
end
