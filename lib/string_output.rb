class StringOutput
  def initialize
    @lines = []
  end

  def text msg
    @lines.push msg
  end

  def many(lines)
    @lines << lines
  end

  def print_received
    @lines.join "\n"
  end
end
