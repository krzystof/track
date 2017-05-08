class Report
  attr_reader :output

  HEADER = ["Project", "Task", "Time"]

  def initialize(output)
    @output = output
  end

  def records(records)
    rows = [HEADER].concat records.map { |r| r.to_row }

    @col_width = rows.map { |r| r.map { |word| word.length } }.transpose.map { |lengths| lengths.max}
    # p rows
    formatted_rows = rows.map { |row| format_row(row) }

    output.many formatted_rows
    # transpose!

    # p rows
    # p col_width.inspect
    # print header
    # print record
    print_header
  end

  private
  def format_row(row)
    row.map.with_index { |col, idx| pad_column(idx, col) }.join "  "
  end

  def pad_column(idx, col)
    if col.length == @col_width[idx]
      col
    else
      col.ljust col.length - @col_width[idx]
    end
  end

  def print_header
    output.text HEADER.join "  "
  end
end
