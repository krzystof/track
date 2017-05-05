require "minitest/autorun"
require "minitest/pride"
require "string_output"
require "report"

class TableTest < Minitest::Test
  def test_format_one_record
    text_ouput = StringOutput.new
    record = Record.new :project => "AwesomeProject", :task => "AwesomeTask", :start => "2017-05-05 14:00:00", :finish => "2017-05-05 16:00:00"
    report = Report.new(text_ouput).records([
      record
    ])

    expected_table = <<~END
      Project          Task          Time
     ---------------- ------------- ---------
      AwesomeProject   AwesomeTask   2 hours
    END
    assert_equal expected_table, text_ouput.print_received
  end
end
