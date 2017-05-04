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

  def success(message)
    puts
    print @colors.black.on_green " Yay! "
    puts @colors.regular(" #{message} ")
  end

  def info(message)
    puts
    print @colors.white.on_blue " Hey! "
    puts @colors.regular(" #{message} ")
  end

  def in_progress(record)
    info("Working on task '#{record.task}' on the project '#{record.project}' for #{record.human_time}")
  end

  def completed(record)
    success("Completed task '#{record.task}' on the project '#{record.project}' after #{record.human_time}")
  end
end
