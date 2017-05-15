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

  def at_position(pos)
    @args[pos]
  end

  def confirmed?
      answer = STDIN.gets.chomp
      return true if ["y", "yes"].include? answer.downcase
  end
end
