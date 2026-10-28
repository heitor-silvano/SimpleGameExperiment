require_relative 'scenes/intro'
require_relative 'player_job'
require_relative 'scenes/house'
require_relative 'scenes/village'
require_relative 'scenes/passage'
require_relative 'utils/render'
require_relative 'utils/save_file'
require_relative 'constants/directory'
require_relative 'utils/load_file'
require_relative 'constants/terminal_colors'
require "io/console"

UP_KEY = "\e[A"
DOWN_KEY = "\e[B"
RIGHT_KEY = "\e[C"
LEFT_KEY = "\e[D"

# player = load_player || create_player

# save_file(player)

def render_map(player_symbol, player_color, tile_symbol, row, col, max_rows, max_cols)
  reader = TTY::Reader.new

  loop do
    char = reader.read_keypress

    case char
    when UP_KEY
      if row > 1
        row = row - 1
      end
    when DOWN_KEY
      if row < max_rows
        row = row + 1
      end
    when RIGHT_KEY
      if col < max_cols
        col = col + 1
      end
    when LEFT_KEY
      if col > 1
        col = col - 1
      end
    else
      puts "else"
    end

    print "\e[2J"
    print "\e[H"

    rows_after_player = max_rows - row
    rows_till_player = max_rows - rows_after_player

    cols_after_player = max_cols - col
    cols_till_player = max_cols - cols_after_player - 1

    screen_rows, screen_cols = STDOUT.winsize

    center_cols = (screen_cols - max_cols) / 2
    center_rows = (screen_rows - max_rows) / 2

    cont = 0
    while cont < center_rows
      puts
      cont += 1
    end

    print " " * (center_cols - 1)
    print "╔"
    print "═" * max_cols
    print "╗"
    puts

    cont = 0
    while cont < rows_till_player
      print " " * (center_cols - 1)

      print "║"
      print tile_symbol * cols_till_player

      if cont == row - 1
        print player_color + player_symbol + RESET_TEXT
        print tile_symbol * (cols_after_player)
      else
        print tile_symbol * (cols_after_player + 1)
      end

      print "║"

      puts
      cont += 1
    end

    cont = 0
    while cont < rows_after_player
      print " " * (center_cols - 1)

      print "║"
      print tile_symbol * max_cols
      print "║"

      puts

      cont = cont + 1
    end

    print " " * (center_cols - 1)
    print "╚"
    print "═" * max_cols
    print "╝"
    puts

  end
end

system("xset r rate 500 40")

begin
  render_map("Ѭ", GREEN_TEXT, ".", 5, 15, 10, 30)
ensure
  system("xset r rate 500 33")
end

sleep 1
