class Report
  attr_reader :output

  HEADER = ["Date", "Project", "Task", "Time"]

  def initialize(output)
    @output = output
  end

  def for_records(records)
    return output.says_nothing_recorded if records.empty?
    rows = generate_rows(records)
    calculate_column_widths(rows)
    output.many rows.map { |row| format_row(row) }
  end

  private
  def generate_rows(records)
    [HEADER].concat records.map { |record| record.to_row }
  end

  def calculate_column_widths(rows)
    @col_width = rows.map { |r| r.map { |word| word.length } }.transpose.map { |lengths| lengths.max}
  end

  def format_row(row)
    row.map.with_index { |col, idx| pad_column(idx, col) }.join "  "
  end

  def pad_column(idx, col)
    col.ljust @col_width[idx]
  end
end
