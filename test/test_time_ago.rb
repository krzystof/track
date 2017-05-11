require "minitest/autorun"
require "minitest/pride"
require "track/time_ago"
require "date"

class TestTimeAgo < Minitest::Test
  NOW = DateTime.parse("2000-06-15 12:00:00")
  TIMES_AGO = {
    "2000-06-15 12:00:00" => "Just now",
    "2000-06-15 11:58:59" => "1 minute ago",
    "2000-06-15 11:55:00" => "5 minutes ago",
    "2000-06-15 11:00:01" => "59 minutes ago",
    "2000-06-15 11:00:00" => "1 hour ago",
    "2000-06-15 10:00:00" => "2 hours ago",
    "2000-06-14 12:00:01" => "23 hours ago",
    "2000-06-14 12:00:00" => "1 day ago",
    "2000-06-13 12:00:00" => "2 days ago",
    "2000-06-08 12:00:00" => "1 week ago",
    "2000-05-16 12:00:00" => "4 weeks ago",
    "2000-05-14 12:00:00" => "1 month ago",
    "1999-06-15 12:00:00" => "1 year ago",
    "1995-06-15 12:00:00" => "5 years ago",
  }

  def test_times_ago
    DateTime.stub :now, NOW do
      TIMES_AGO.each_pair { |timestamp, expected| assert_equal(expected, TimeAgo.new(timestamp).to_s) }
    end
  end
end
