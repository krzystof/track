require "minitest/autorun"
require "minitest/pride"
require "track/record"
require "track/timelog"
require "track/json_driver"

class TimelogTest < Minitest::Test
  TESTLOG = "testlog.json"

  def setup
    testlog = "#{Dir.pwd}/storage/#{TESTLOG}"
    if File.exist? testlog
      File.delete testlog
    end
  end

  def test_can_save_a_record_on_an_empty_file
    record = Record.new({ :project => "a project", :task => "a task" })

    t = Timelog.new JsonDriver.new(TESTLOG)
    t.create record

    wip = Timelog.open(TESTLOG).wip

    assert_instance_of Record, wip
    assert_equal "a project", wip.project
    assert_equal "a task", wip.task
    assert_instance_of DateTime, wip.start
    assert_nil wip.finish
  end
end
