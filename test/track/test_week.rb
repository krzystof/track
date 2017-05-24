require "minitest/autorun"
require "minitest/pride"
require "date"
require "track/week"

class TestWeek < Minitest::Test
  def test_get_current_week
    stubnow = DateTime.parse("2017-05-24")
    DateTime.stub :now, stubnow do
      week = Week.of(stubnow)
      assert_equal "2017-05-22T00:00:00+00:00", week.beginning.to_s
      assert_equal "2017-05-28T23:59:59+00:00", week.end.to_s
    end
  end

  def test_get_previous_week
    stubnow = DateTime.parse("2017-05-24")
    DateTime.stub :now, stubnow do
      week = Week.of(stubnow).sub_weeks(1)
      assert_equal "2017-05-15T00:00:00+00:00", week.beginning.to_s
      assert_equal "2017-05-21T23:59:59+00:00", week.end.to_s
    end
  end
end
