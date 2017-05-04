class StopTracking < BaseCommand
  STOP = "stop"

  def self.matches?(input)
    input.at_position(0) == STOP
  end

  def execute
    if @timelog.has_wip?
      record = @timelog.wip
      record.complete
      @timelog.save record
      output.completed record
    end
    output.text "Not working on anything right now"
  end
end
