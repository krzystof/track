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
      if record.seconds > MIN_IN_SECONDS
        @timelog.save record
        output.completed record
      else
        @timelog.remove record
        output.info "Discarding that one 'cause you didn't work a lot on it"
      end
    end
    output.text "Not working on anything right now"
  end
end
