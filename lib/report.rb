class Report
  attr_reader :output

  def initialize(output)
    @output = output
  end

  def records(records)
    p records
    # column width
    # print header
    # print record
  end
end
