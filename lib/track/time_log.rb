require "json"

class TimeLog
  RECORDS_FILE = "timelog.json"

  def self.boot
    self.ensure_file_is_there
    self.new self.open_file.read
  end

  def initialize(content)
    @records = JSON.parse(content)["records"]
  end

  def append(record)
    @records.push(record)
    self.class.save_all(@records)
  end

  private
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

  def self.save_all(records)
    self.open_file.write JSON.generate({:records => records})
  end
end
