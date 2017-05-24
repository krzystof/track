class ConsoleInput
  def initialize(args)
    @args = args
  end

  def empty?
    @args.empty?
  end

  def count
    @args.count
  end

  def first
    at_position 0
  end

  def second_or(default)
    at_position 1 || default
  end

  def at_position(pos, default = nil)
    @args[pos] || default
  end

  def confirmed?
      answer = STDIN.gets.chomp
      return true if ["y", "yes"].include? answer.downcase
  end
end
