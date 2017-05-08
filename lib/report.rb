class Report
  attr_reader :output

  HEADER = ["Project", "Task", "Time"]

  def initialize(output)
    @output = output
  end

  def records(records)
    # column width




    # col_width = HEADER.map { |h| h.length}

    # rows = records.map { |r| r.to_row }

    # transpose!

    # p rows
    # p col_width.inspect
    # print header
    # print record
    print_header
  end

  def print_header
    output.text HEADER.join "  "
  end
end
