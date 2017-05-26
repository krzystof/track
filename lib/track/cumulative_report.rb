class CumulativeReport
  def self.all(output, records)
    rows = CumulativeTimes.new(records).to_rows(&:project)
    Table.new(output).headers("Project", "Time spent").rows(rows)
  end

  def self.weekly(output, records)
    by_week = lambda { |record| Timestamp.beginning_of_week(record.finish).strftime("%d-%b %Y") }
    rows = CumulativeTimes.new(records).sort_by_label.to_rows(&by_week)
    Table.new(output).headers("Week", "Time").rows(rows)
  end

  def self.monthly(output, records)
    by_month = lambda { |record| record.start.strftime("%b %Y") }
    rows = CumulativeTimes.new(records).sort_by_label.to_rows(&by_month)
    Table.new(output).headers("Month", "Time").rows(rows)
  end
end
