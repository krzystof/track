# get inspiration here
# https://github.com/piotrmurach/pastel/blob/master/lib/pastel/ansi.rb

class Colors
  CODES = {
    black:   30,
    red:     31,
    green:   32,
    yellow:  33,
    blue:    34,
    magenta: 35,
    cyan:    36,
    white:   37,
    on_black:   40,
    on_red:     41,
    on_green:   42,
    on_yellow:  43,
    on_blue:    44,
    on_magenta: 45,
    on_cyan:    46,
    on_white:   47,
  }.freeze

  @text

  def initialize
    @fg = CODES[:white]
    @bg = CODES[:on_black]
  end

  def regular(text)
    @fg = CODES[:white]
    @bg = CODES[:on_black]
    @text = text
    self
  end

  def method_missing(name, *args, &block)
    if CODES.has_key? name
      if name.to_s.start_with? "on_"
        @bg = CODES[name]
      else
        @fg = CODES[name]
      end
    end
    @text = args.first if args.first != nil
    self
  end

  def respond_to_missing?(name, include_all = false)
    CODES.has_key? name
  end

  def to_s
    string = @text
    ansi_colors = "\e[#{@fg};#{@bg}m"
    "#{ansi_colors}#{string.gsub(/(\e\[0m)([^\e]+)$/, "\\1#{ansi_colors}\\2")}\e[0m"
  end
end
