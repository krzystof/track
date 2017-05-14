require "minitest/autorun"
require "minitest/pride"
require "string_output"
require "table"
require "track/records_list"

class ReportTest < Minitest::Test
  def test_format_one_record
    string_output = StringOutput.new
    record = Record.new(
      :project => "AwesomeProject",
      :task => "AwesomeTask",
      :start => "2017-05-05 14:00:00",
      :finish => "2017-05-05 16:00:00"
    )

    expected_table = [
      "Date         Project         Task         Time   ",
      "2 hours ago  AwesomeProject  AwesomeTask  2 hours",
    ].join("\n")

    now = DateTime.parse("2017-05-05 18:00:00")
    DateTime.stub :now, now do
      Table.new(string_output).headers("Date", "Project", "Task", "Time").rows(RecordsList.new([record]).to_rows)

      assert_equal expected_table, string_output.to_s
    end
  end
end
