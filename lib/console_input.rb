class ConsoleInput
  @args

  def initialize(args)
    @args = args
  end

  def empty?
    @args.empty?
  end
end
