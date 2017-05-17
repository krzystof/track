require "json"

class JsonTimelog
  RECORDS_FILE = "timelog.json"

  attr_reader :records

  def initialize(filename = RECORDS_FILE)
    @file = filename
    load_records
  end

  def create(record)
    @records.push(record)
    save_file
  end

  def save(record)
    idx = @records.find_index record
    @records[idx] = record
    save_file
  end

  def has_wip?
    records.any? { |r| r.in_progress? }
  end

  def wip
    records.find { |r| r.in_progress? }
  end

  def contains_project?(project)
    records.any? { |record| record.project == project }
  end

  def between(from, to)
    records.select { |r| r.finished_in?(from, to) }
  end

  def last(count = 1)
    records.select { |r| not r.in_progress? }.last(count)
  end

  private
  def load_records
    file = open_file
    records_hashes = parse_records file.read
    file.close
    @records = records_hashes.map { |r| Record.from_hash(r) }
  end

  def open_file
    File.new filepath, File::CREAT|File::RDWR
  end

  def filepath
    "#{File.dirname(__FILE__)}/../../storage/#{@file}"
  end

  def parse_records(content)
    if content.empty?
      []
    else
      JSON.parse(content)["records"].sort_by { :start }
    end
  end

  def save_file
    file = open_file
    records_hashes = @records.map { |r| r.to_hash }
    file.write(JSON.generate({ :records => records_hashes}))
    file.close
  end
end
