class StopTracking < BaseCommand
  MIN_IN_SECONDS = 5 * 60
  CMD_NAME = "stop"

  def self.matches?(input)
    input.at_position(0) == CMD_NAME
  end

  def execute
    if @timelog.has_wip?
      record = @timelog.wip
      record.complete
      @timelog.save record if record.seconds > MIN_IN_SECONDS
      output.completed record
    end
    output.text "Not working on anything right now"
  end
end
