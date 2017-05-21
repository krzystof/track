require "minitest/autorun"
require "minitest/pride"
require "track/record"

class TestRecord < Minitest::Test
  def test_completed_has_a_length_in_seconds
    record = Record.new({
      :project => "a test",
      :task => "a task",
      :start => DateTime.parse("2017-05-04T13:10:25+01:00"),
      :finish => DateTime.parse("2017-05-04T13:10:55+01:00"),
    })

    assert_equal 30, record.seconds
  end

  def test_in_progress_has_a_length_in_seconds
    record = Record.new({
      :project => "a test",
      :task => "a task",
      :start => DateTime.parse("2017-05-04T13:10:25+01:00"),
    })

    some_date = DateTime.parse "2017-05-04T13:11:25+01:00"
    DateTime.stub :now, some_date do
      assert_equal 60, record.seconds
    end
  end

  def test_complete_a_record
    record = Record.new({
      :project => "a test",
      :task => "a task",
      :start => DateTime.parse("2017-05-04T13:10:25+01:00"),
    })

    some_date = DateTime.parse "2017-05-04T13:11:25+01:00"
    DateTime.stub :now, some_date do
      record.complete
      assert_equal some_date, record.finish
    end
  end

  def test_record_equality
    record_a = Record.new({
      :project => "a test",
      :task => "a task",
      :start => DateTime.parse("2017-05-04T13:10:25+01:00"),
    })

    record_b = Record.new({
      :project => "a test",
      :task => "a task",
      :start => "2017-05-04T13:10:25+01:00",
    })

    assert_equal record_a, record_b
  end

  def test_default_task_name_on_a_record
    record = Record.new({ :project => "a test", })
    assert_equal "-", record.task
  end
end
