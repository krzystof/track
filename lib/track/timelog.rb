require "json"

class Timelog
  RECORDS_FILE = "timelog.json"

  def self.boot
    self.ensure_file_is_there
    records = self.parse_records self.open_file.read
    self.new records
  end

  def initialize(records)
    @records = records
  end

  def append(record)
    @records.push(record)
    save
  end

  def wip?
    @records.any? { |r| r.in_progress }
  end

  def save
    self.class.open_file.write JSON.generate({:records => @records})
  end

  private
  def self.parse_records(content)
    if content.empty?
      []
    else
      JSON.parse(content)["records"]
    end
  end

  def self.ensure_file_is_there
    if not File.exist? self.filepath
      self.open_file.write JSON.generate({:records => []})
    end
  end

  def self.open_file
    File.new self.filepath, File::CREAT|File::RDWR
  end

  def self.filepath
    "#{Dir.pwd}/storage/#{RECORDS_FILE}"
  end
end
