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
    puts @colors.regular(" #{message} ")
  end

  def info(message)
    puts
    print @colors.white.on_blue " WIP "
    puts @colors.regular(" #{message} ")
  end

  def in_progress(record)
    if record.seconds < 60
      info("Now working on task #{record.task} on the project #{record.project}")
    else
      info("Working on task #{record.task} on the project #{record.project} for #{formated(time)}")
    end
  end
end
