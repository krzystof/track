require "track/record"

module TestTimelogRole
  def test_create_a_new_record_in_progress
    record = Record.new({ :project => "prjct", :task => "tsk" })
    @timelog.save(record)
    wip = @timelog.wip
    assert_equal "prjct", wip.project
    assert_equal "tsk", wip.task
  end

  def test_check_has_wip
    has_a_dummy_wip_record
    assert_equal true, @timelog.has_wip?
  end

  def test_check_has_project
    has_a_dummy_wip_record
    assert_equal true, @timelog.contains_project?("prjct")
    assert_equal false, @timelog.contains_project?("something else")
  end

  def test_remove_a_record
    has_a_dummy_wip_record
    assert_equal true, @timelog.contains_project?("prjct")
    @timelog.remove @record
    assert_equal false, @timelog.contains_project?("prjct")
  end

  def test_last_record
    has_a_dummy_completed_record
    assert_equal 1, @timelog.last(1).count
  end

  def test_saves_a_record
    has_a_dummy_wip_record
    assert_equal true, @timelog.has_wip?
    @record.complete
    @timelog.save @record
    assert_equal false, @timelog.has_wip?
  end

  def test_get_records_between_two_dates
    now = DateTime.now

    @timelog.save Record.new({
      :project => "prjct",
      :start => DateTime.new(now.year, now.month, now.day, 14, 0, 0, 0),
      :finish => DateTime.new(now.year, now.month, now.day, 15, 0, 0, 0),
    })
    @timelog.save Record.new({
      :project => "prjct",
      :start => DateTime.new(now.year, now.month, now.day, 16, 0, 0, 0),
      :finish => DateTime.new(now.year, now.month, now.day, 17, 0, 0, 0),
    })

    assert_equal 1, @timelog.between(
      DateTime.new(now.year, now.month, now.day, 16, 30, 0),
      DateTime.new(now.year, now.month, now.day, 17, 30, 0),
    ).count
  end

  private
  def has_a_dummy_wip_record
    @record = Record.new({ :project => "prjct", :task => "tsk" })
    @timelog.save @record
  end

  def has_a_dummy_completed_record
    now = DateTime.now
    @record = Record.new({
      :project => "prjct",
      :task => "tsk",
      :start => DateTime.new(now.year, now.month, now.day - 1, 16, 0, 0, 0),
      :finish => DateTime.new(now.year, now.month, now.day - 1, 17, 0, 0, 0),
    })
    @timelog.save @record
  end
end
