require_relative 'scenes/intro'
require_relative 'player_job'
require_relative 'scenes/house'
require_relative 'scenes/village'
require_relative 'scenes/passage'
require_relative 'utils/render'
require_relative 'utils/save_file'
require_relative 'constants/directory'
require_relative 'utils/load_file'
require "io/console"

UP_KEY = "\e[A"
DOWN_KEY = "\e[B"
RIGHT_KEY = "\e[C"
LEFT_KEY = "\e[D"

# player = load_player || create_player

# save_file(player)

def render_map
  reader = TTY::Reader.new
  row = 2
  col = 9

  max_cols = 18
  max_rows = 10

  loop do
    char = reader.read_keypress

    case char
    when UP_KEY
      if row > 0
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
      if col > 0
        col = col - 1
      end
    else
      puts "else"
    end

    print "\e[2J"
    print "\e[H"

    rows_till_player = max_rows - row
    rows_after_player = max_rows - rows_till_player

    cols_till_player = max_cols - col
    cols_after_player = max_cols - cols_till_player

    cont = 0
    while cont < rows_till_player
      puts "." * cols_till_player
      if row == rows_till_player - 1
        print "@"
      end
      cont = cont + 1
    end

    print "@"

    cont2 = 0
    while cont2 < rows_after_player
      if cont2 == 0
        puts "." * (cols_till_player - 1)
      else
        puts "." * cols_till_player
      end

      cont2 = cont2 + 1
    end
  end
end

render_map

sleep 1
