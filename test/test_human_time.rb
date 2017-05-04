require "minitest/autorun"
require "minitest/pride"
require "track/human_time"

class HumanTimeTest < Minitest::Test
  def test_format_less_than_a_minute
    human_time = HumanTime.new 59
    assert_equal "less than a minute", human_time.to_s
  end

  def test_format_one_minute
    human_time = HumanTime.new 60
    assert_equal "1 minute", human_time.to_s
  end

  def test_format_several_minutes
    human_time = HumanTime.new 360
    assert_equal "6 minutes", human_time.to_s
  end

  def test_ignores_seconds
    human_time = HumanTime.new 364
    assert_equal "6 minutes", human_time.to_s
  end

  def test_format_one_hour
    human_time = HumanTime.new 3600
    assert_equal "1 hour", human_time.to_s
  end

  def test_format_several_hours
    human_time = HumanTime.new 7200
    assert_equal "2 hours", human_time.to_s
  end

  def test_format_several_hours_and_minutes
    human_time = HumanTime.new 7260
    assert_equal "2 hours and 1 minute", human_time.to_s
  end
end
