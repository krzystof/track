require "minitest/autorun"
require "minitest/pride"
require "commands/sum_by_week"
require "console_input"

class TestSumByWeek < Minitest::Test
  def test_show_records_for_the_week
    input = ConsoleInput.new("week")
    output = StringOutput.new
    timelog = InMemoryTimelog.new([
      Record.new({
        :project => "example",
        :task => "stuff",
        :start => DateTime.parse("2017-01-01 15:00:00"),
        :finish => DateTime.parse("2017-01-01 16:00:00"),
      })
    ])

    expected = [
      "Time spent by project between the 2016-12-26 and the 2017-01-01",
      "Project  Time spent",
      "example  1 hour    ",
      "Total    1 hour    ",
    ].join("\n")

    DateTime.stub :now, DateTime.parse("2017-01-01 19:00:00") do
      SumByWeek.new(input, output, timelog).execute
      assert_equal expected, output.to_s
    end
  end

  def test_sort_by_max
    input = ConsoleInput.new("week")
    output = StringOutput.new
    timelog = InMemoryTimelog.new([
      Record.new({
        :project => "example",
        :task => "stuff",
        :start => DateTime.parse("2017-01-01 15:00:00"),
        :finish => DateTime.parse("2017-01-01 16:00:00"),
      }),
      Record.new({
        :project => "another",
        :task => "stuff",
        :start => DateTime.parse("2017-01-01 10:00:00"),
        :finish => DateTime.parse("2017-01-01 14:00:00"),
      }),
    ])

    expected = [
      "Time spent by project between the 2016-12-26 and the 2017-01-01",
      "Project  Time spent",
      "example  1 hour    ",
      "another  4 hours   ",
      "Total    5 hours   ",
    ].join("\n")

    DateTime.stub :now, DateTime.parse("2017-01-01 19:00:00") do
      SumByWeek.new(input, output, timelog).execute
      assert_equal expected, output.to_s
    end
  end
end
