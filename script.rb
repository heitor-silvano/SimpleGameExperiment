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
require 'json'
require "io/console"

UP_KEY = "\e[A"
DOWN_KEY = "\e[B"
RIGHT_KEY = "\e[C"
LEFT_KEY = "\e[D"

# player = load_player || create_player

# save_file(player)

def render_map(player_symbol, player_color, floor_character, current_row, current_col, max_rows, max_cols)
  reader = TTY::Reader.new

  loop do
    char = reader.read_keypress

    case char
    when UP_KEY
      if current_row > 0
        current_row = current_row - 1
      end
    when DOWN_KEY
      if current_row < max_rows
        current_row = current_row + 1
      end
    when RIGHT_KEY
      if current_col < max_cols
        current_col = current_col + 1
      end
    when LEFT_KEY
      if current_col > 0
        current_col = current_col - 1
      end
    else
      puts "else"
    end

    print "\033c"

    screen_rows, screen_cols = STDOUT.winsize

    col_left = (screen_cols - max_cols) / 2
    row_top = (screen_rows - max_rows) / 2

    col_right = col_left + max_cols
    row_bottom = row_top + max_rows

    map_array = Array.new(screen_rows) { Array.new(screen_cols) }

    screen_rows.times do |row|
      screen_cols.times do |col|
        map_array[row][col] = " "

        if col > col_left && col < col_right && row > row_top && row < row_bottom
          map_array[row][col] = floor_character
        end

        if col > col_left && col < col_right && (row == row_top || row == row_bottom)
          map_array[row][col] = "═"
        end

        if row > row_top && row < row_bottom && (col == col_left || col == col_right)
          map_array[row][col] = "║"
        end

        if row == row_top && col == col_left
          map_array[row][col] = "╔"
        end

        if row == row_top && col == col_right
          map_array[row][col] = "╗"
        end

        if row == row_bottom && col == col_left
          map_array[row][col] = "╚"
        end

        if row == row_bottom && col == col_right
          map_array[row][col] = "╝"
        end
      end
    end

    horizontal_wall_center_index = ((row_top + row_bottom) / 2)
    map_array[horizontal_wall_center_index][col_right] = "R"
    map_array[horizontal_wall_center_index][col_left] = "L"

    vertical_wall_center_index = ((col_left + col_right) / 2)
    map_array[row_top][vertical_wall_center_index] = "T"
    map_array[row_bottom][vertical_wall_center_index] = "B"

    if map_array[row_top + current_row][col_left + current_col] == "L"
      map_array[0][0] = "P"
    end

    map_array[row_top + current_row][col_left + current_col] = player_color + player_symbol + RESET_TEXT

    puts map_array.map { |linha| linha.join("") }.join("\n")

  end
end

rooms = [
  {
    "node": "A",
    "neighbours": [{ "node": "B", "node_at": "UP" }, { "node": "C", "node_at": "RIGHT" }],
    "rows": 10,
    "cols": 30,
    "doors": ["UP", "RIGHT"],
    "is_main_room": true
  },
  {
    "node": "B",
    "neighbours": [{ "node": "A", "node_at": "DOWN" }],
    "rows": 10,
    "cols": 30,
    "doors": ["DOWN"],
    "is_main_room": false
  },
  {
    "node": "C",
    "neighbours": [{ "node": "A", "node_at": "LEFT" }],
    "rows": 10,
    "cols": 30,
    "doors": ["LEFT"],
    "is_main_room": false
  }
]

begin
  render_map("Ѭ", GREEN_TEXT, ".", 1, 1, rooms[0][:rows], rooms[0][:cols])

end

sleep 1
