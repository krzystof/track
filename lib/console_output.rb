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
    print @colors.white.on_red " Crap! "
    puts @colors.regular(" #{message} ")
  end

  def confirm(message)
    puts
    print @colors.white.on_blue " Sure? "
    print @colors.regular(" #{message} ")
  end
end
