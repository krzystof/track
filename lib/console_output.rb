require "colors"

class ConsoleOutput
  def initialize
    @colors = Colors.new
  end

  def text(content)
    puts content
  end

  def error(message)
    puts
    print @colors.white.on_red("Ayayay!")
    puts @colors.regular(" Sorry! I didn't find a command for whatever you tried to type.")
  end
end
