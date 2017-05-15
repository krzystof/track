require "json"

class Timelog
  RECORDS_FILE = "timelog.json"
  MIN_IN_SECONDS = 5 * 60

  def self.open(file = RECORDS_FILE)
    filepath = "#{File.dirname(__FILE__)}/../../storage/#{file}"
    file = self.open_file(filepath)
    records_hashes = self.parse_records file.read
    file.close
    self.new filepath, records_hashes.map { |r| Record.from_hash(r) }
  end

  def initialize(filepath, records)
    @filepath = filepath
    @records = records
  end

  def append(record)
    @records.push(record)
    commit
  end

  def save(record)
    idx = @records.find_index record
    @records[idx] = record
    commit
  end

  def commit
    file = self.class.open_file(@filepath)
    records_hashes = @records.select { |r| r.seconds > MIN_IN_SECONDS }.map { |r| r.to_hash }
    file.write(JSON.generate({ :records => records_hashes}))
    file.close
  end

  def has_wip?
    @records.any? { |r| r.in_progress? }
  end

  def wip
    @records.find { |r| r.in_progress? }
  end

  def between(from, to)
    @records.select { |r| r.finished_in?(from, to) }
  end

  def last(count = 1)
    @records.select { |r| not r.in_progress? }.last(count)
  end

  private
  def self.parse_records(content)
    if content.empty?
      []
    else
      JSON.parse(content)["records"].sort_by { :start }
    end
  end

  def self.ensure_file_is_there(filepath)
    if not File.exist? filepath
      self.open_file(filepath).write JSON.generate({:records => []})
    end
  end

  def self.open_file(filepath)
    File.new filepath, File::CREAT|File::RDWR
  end
end
