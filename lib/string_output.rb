class StringOutput
  def initialize
    @lines = []
  end

  def text msg
    @lines.push msg
  end

  def print_received
    @lines.join "\n"
  end
end
