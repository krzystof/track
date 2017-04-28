class Track
  attr_reader :output

  def initialize(output)
    @output = output
  end

  def self.execute(output)
    self.new(output).execute
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
