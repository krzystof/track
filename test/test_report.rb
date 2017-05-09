require "minitest/autorun"
require "minitest/pride"
require "string_output"
require "report"

class ReportTest < Minitest::Test
  def test_format_one_record
    string_output = StringOutput.new
    record = Record.new :project => "AwesomeProject", :task => "AwesomeTask", :start => "2017-05-05 14:00:00", :finish => "2017-05-05 16:00:00"
    report = Report.new(string_output).for_records([record])

    expected_table = [
      "#  Project         Task         Time   ",
      "1  AwesomeProject  AwesomeTask  2 hours",
    ].join("\n")

    assert_equal expected_table, string_output.to_s
  end
end
