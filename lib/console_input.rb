class ConsoleInput
  @args

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

  def read
    gets
  end
end
