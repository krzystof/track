class CumulativeTimes
  attr_reader :records

  def initialize(records)
    @records = records
  end

  def to_rows
    records
      .group_by { |record| record.project }
      .map { |records_per_project| format_row(records_per_project) }
      .sort_by { |row| row[1] }
      .reverse
  end

  private
  def format_row(records_per_project)
    project = records_per_project.first
    total_time_in_s = records_per_project.last.inject(0) { |sum, record| sum + record.seconds }
    [project, HumanTime.new(total_time_in_s).to_s]
  end
end
