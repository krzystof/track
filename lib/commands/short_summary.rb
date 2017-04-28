class ShortSummary
  attr_reader :input, :output

  def initialize(input, output)
    @input = input
    @output = output
  end

  def self.execute(input, output)
    self.new(input, output).execute
  end

  def self.matches(input)
    input.empty?
  end

  def execute
    # if nothing previously
    output.text('No previous entries')

    # if nothing in progress
    output.text('Nothing in progress')
  end
end
