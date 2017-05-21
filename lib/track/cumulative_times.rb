class CumulativeTimes
  attr_reader :records

  def initialize(records)
    @records = records
  end

  def to_rows
    records
      .group_by { |record| record.project }
      .map { |records_per_project| aggregate_row(records_per_project) }
      .sort_by { |row| row[1] }
      .map { |row| to_readable(row) }
      .push(total_row)
  end

  private
  def aggregate_row(records_per_project)
    project = records_per_project.first
    total_time_in_s = records_per_project.last.inject(0) { |sum, record| sum + record.seconds }
    [project, total_time_in_s]
  end

  def to_readable(row)
    [row[0], HumanTime.new(row[1]).to_s]
  end

  def total_row
    ["TOTAL", HumanTime.new(total).to_s]
  end

  def total
    records.inject(0) { |sum, record| sum + record.seconds }
  end
end
