require "sqlite3"

class SqliteTimelog
  DB_FILE = "timelog.sqlite"

  attr_reader :db

  def initialize(db = DB_FILE)
    db_path = "#{File.dirname(__FILE__)}/../../storage/#{db}"
    @db = SQLite3::Database.new db_path
  end

  def save(record)
    if no_record_that_start record.start
      db.execute "insert into records values (?, ?, ?, ?)", record.to_hash.values
    else
      db.execute "update records set finish = ? where start = ?", [record.finish.to_s, record.start.to_s]
    end
  end

  def remove(record)
    db.execute "delete from records where start = ?", [record.start.to_s]
  end

  def has_wip?
    wip = db.execute "select * from records where finish = ''"
    wip.count > 0
  end

  def wip
    wip = db.execute "select * from records where finish = ''"
    to_record wip[0]
  end

  def all
    map_to_records db.execute "select * from records where finish != ''"
  end

  def contains_project?(project)
    rows = db.execute "select * from records where project = ?", project
    rows.count > 0
  end

  def finish_during(timeframe)
    between(timeframe.beginning, timeframe.end)
  end

  def last(count = 1)
    dbrows = db.execute "select * from records where finish != '' order by start desc limit ?", count
    dbrows.reverse.map { |row| to_record(row) }
  end

  def migrate
    db.execute "create table records (project varchar(50), task varchar(50), start datetime, finish datetime)"
  end

  private
  def map_to_records(rows)
    rows.map { |row| to_record(row) }
  end

  def to_record(row)
    Record.new({
      :project => row[0],
      :task => row[1],
      :start => DateTime.parse(row[2]),
      :finish => row[3] != '' ? DateTime.parse(row[3]) : nil,
    })
  end

  def no_record_that_start(start)
    rows = db.execute "select * from records where start = ?", start.to_s
    rows.count == 0
  end

  def between(from, to)
    dbrows = db.execute "select * from records where finish > ? and finish < ?", [from.to_s, to.to_s]
    dbrows.map { |row| to_record(row) }
  end
end
