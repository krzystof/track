class Table
  attr_reader :output

  def initialize(output)
    @output = output
  end

  def headers(*headers)
    @headers = headers
    self
  end

  def rows(rows)
    @rows = rows
    to_table
  end

  private
  def to_table
    return output.says_nothing_recorded if @rows.empty?
    all_rows = generate_rows
    calculate_column_widths(all_rows)
    output.many all_rows.map { |row| format_row(row) }
  end

  def generate_rows
    [@headers].concat @rows
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
