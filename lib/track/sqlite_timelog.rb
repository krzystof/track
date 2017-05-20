require "sqlite3"

class SqliteTimelog
  DB_FILE = "timelog.sqlite"

  attr_reader :db

  def initialize(db = DB_FILE)
    db_path = "#{File.dirname(__FILE__)}/../../storage/#{db}"
    @db = SQLite3::Database.new db_path
  end

  def create(record)
    db.execute "insert into records values (?, ?, ?, ?)", record.to_hash.values
  end

  def save(record)
    db.execute "update records set finish = ? where start = ?", [record.finish.to_s, record.start.to_s]
  end

  def has_wip?
    wip = db.execute "select * from records where finish = ''"
    wip.count > 0
  end

  def wip
    wip = db.execute "select * from records where finish = ''"
    to_record wip[0]
  end

  def contains_project?(project)
    rows = db.execute "select count(*) from records where project == ?", project
    rows.count > 0
  end

  def between(from, to)
    # records.select { |r| r.finished_in?(from, to) }
  end

  def last(count = 1)
    dbrows = db.execute "select * from records where finish is not null limit ?", count
    dbrows.map { |row| to_record(row) }
  end

  private
  def to_record(row)
    Record.new({
      :project => row[0],
      :task => row[1],
      :start => row[2],
      :finish => row[3],
    })
  end
end
