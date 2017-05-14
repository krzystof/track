class RecordsList
  def initialize(records)
    @records = records
  end

  def to_rows
    @records.map { |record| record.to_row}
  end
end
