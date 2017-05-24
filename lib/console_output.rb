require "colors"

class ConsoleOutput
  def initialize
    @colors = Colors.new
  end

  def says_nothing_recorded
    text "Nothing recorded in there!"
  end

  def text(content)
    puts content
  end

  def many(lines)
    lines.each { |l| puts l }
    puts
  end

  def error(message)
    puts
    print @colors.white.on_red " Crap! "
    puts @colors.regular(" #{message} ")
    puts
  end

  def question(question)
    puts
    print @colors.white.on_blue " Sure? "
    puts @colors.regular(" #{question} ")
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
    puts
  end

  def in_progress(record)
    if record.task != "-"
      info("Working on '#{record.project}', specifically '#{record.task}', for #{record.human_time}")
    else
      info("Working on '#{record.project}' for #{record.human_time}")
    end
  end

  def completed(record)
    success("Completed task '#{record.task}' on the project '#{record.project}' after #{record.human_time}")
  end
end
