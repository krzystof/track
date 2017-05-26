class CumulativeTimes
  attr_reader :records

  def initialize(records)
    @records = records
    @sort_col = 1
  end

  def to_rows(&aggregate_type)
    records
      .group_by(&aggregate_type)
      .map { |records_chunk| aggregate_row(records_chunk) }
      .sort_by { |row| row[@sort_col] }
      .map { |row| to_readable(row) }
      .push(total_row)
  end

  def sort_by_label
    @sort_col = 0
    self
  end

  private
  def aggregate_row(records_chunk)
    project = records_chunk.first
    total_time_in_s = records_chunk.last.inject(0) { |sum, record| sum + record.seconds }
    [project, total_time_in_s]
  end

  def to_readable(row)
    [row[0], HumanTime.new(row[1]).to_s]
  end

  def total_row
    ["Total", HumanTime.new(total).to_s]
  end

  def total
    records.inject(0) { |sum, record| sum + record.seconds }
  end
end
