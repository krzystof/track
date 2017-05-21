require "minitest/autorun"
require "minitest/pride"
require_relative "test_timelog_role"
require "track/sqlite_timelog"

class TestSqliteTimelog < Minitest::Test
  include TestTimelogRole

  def setup
    @timelog = SqliteTimelog.new("test_timelog.sqlite")
    @timelog.migrate
  end

  def teardown
    @timelog.db.execute "drop table records"
  end
end
