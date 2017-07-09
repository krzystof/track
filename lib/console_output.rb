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
    print @colors.red " ⨯ "
    puts @colors.regular(" #{message} ")
  end

  def question(question)
    print @colors.white.on_blue " ? "
    puts @colors.regular(" #{question} ")
  end

  def success(message)
    print @colors.green " ✓ "
    puts @colors.regular(" #{message} ")
  end

  def info(message)
    print @colors.blue " ➜ "
    puts @colors.regular(" #{message} ")
  end

  def section(message)
    print @colors.blue " ➜ "
    puts @colors.regular(" #{message} ")
  end

  def in_progress(record)
    if record.task != "-"
      info("Working on '#{record.project}', specifically '#{record.task}', for #{record.human_time}")
    else
      info("Working on '#{record.project}' for #{record.human_time}")
    end
  end

  def completed(record)
    task_comment = record.task == "-" ? "" : "on task '#{record.task}' "
    success("Stopped working #{task_comment}on the project '#{record.project}' after #{record.human_time}")
  end
end
