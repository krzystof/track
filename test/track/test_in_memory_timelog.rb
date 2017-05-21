require "minitest/autorun"
require "minitest/pride"
require_relative "test_timelog_role"
require "track/in_memory_timelog"

class TestInMemoryTimelog < Minitest::Test
  include TestTimelogRole

  def setup
    @timelog = InMemoryTimelog.new
  end
end
