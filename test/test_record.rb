require "minitest/autorun"
require "minitest/pride"


class RecordTest < Minitest::Test
  def test_completed_has_a_length_in_seconds
    record = Record.new({
      :project => "a test",
      :task => "a task",
      :start => "2017-05-04T13:10:25+01:00",
      :finish => "2017-05-04T13:10:55+01:00"
    })

    assert_equal 30, record.seconds
  end

  def test_in_progress_has_a_length_in_seconds
    record = Record.new({
      :project => "a test",
      :task => "a task",
      :start => "2017-05-04T13:10:25+01:00",
    })

    some_date = DateTime.parse "2017-05-04T13:11:25+01:00"
    DateTime.stub :now, some_date do
      assert_equal 60, record.seconds
    end
  end
end
