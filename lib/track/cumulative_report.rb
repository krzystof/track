class CumulativeReport
  def self.renders(output, records)
    rows = CumulativeTimes.new(records).to_rows
    Table.new(output).headers("Project", "Time spent").rows(rows)
  end
end
