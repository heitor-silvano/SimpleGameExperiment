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

def render_map(player_symbol, player_color, floor_character, current_row, current_col, map_graph)
  reader = TTY::Reader.new

  current_room = map_graph[0]

  loop do
    max_rows = current_room[:rows]
    max_cols = current_room[:cols]

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
    if current_room[:neighbours].key?(:right)
      map_array[horizontal_wall_center_index - 1][col_right] = "╚"
      map_array[horizontal_wall_center_index][col_right] = "_"
      map_array[horizontal_wall_center_index + 1][col_right] = "╔"
    end

    if current_room[:neighbours].key?(:left)
      map_array[horizontal_wall_center_index - 1][col_left] = "╝"
      map_array[horizontal_wall_center_index][col_left] = "_"
      map_array[horizontal_wall_center_index + 1][col_left] = "╗"
    end

    vertical_wall_center_index = ((col_left + col_right) / 2)

    if current_room[:neighbours].key?(:top)
      map_array[row_top][vertical_wall_center_index - 1] = "╝"
      map_array[row_top][vertical_wall_center_index] = "_"
      map_array[row_top][vertical_wall_center_index + 1] = "╚"
    end

    if current_room[:neighbours].key?(:bottom)
      map_array[row_bottom][vertical_wall_center_index - 1] = "╗"
      map_array[row_bottom][vertical_wall_center_index] = "_"
      map_array[row_bottom][vertical_wall_center_index + 1] = "╔"
    end

    if (row_top + current_row) == horizontal_wall_center_index && (col_left + current_col) == col_right
      current_room = map_graph[map_graph.find_index { |map| map[:node] == current_room[:neighbours][:right] }]
      current_col = (vertical_wall_center_index)
    end

    if (row_top + current_row) == horizontal_wall_center_index && (col_left + current_col) == col_left
      current_room = map_graph[map_graph.find_index { |map| map[:node] == current_room[:neighbours][:left] }]
      current_col = 5
    end

    if (row_top + current_row) == row_top && (col_left + current_col) == vertical_wall_center_index
      current_room = map_graph[map_graph.find_index { |map| map[:node] == current_room[:neighbours][:top] }]
      current_col = 5
    end

    if (row_top + current_row) == row_bottom && (col_left + current_col) == vertical_wall_center_index
      current_room = map_graph[map_graph.find_index { |map| map[:node] == current_room[:neighbours][:bottom] }]
      current_col = 5
    end

    map_array[row_top + current_row][col_left + current_col] = player_color + player_symbol + RESET_TEXT

    puts map_array.map { |linha| linha.join("") }.join("\n")

  end
end

rooms = [
  {
    "node": "A",
    "neighbours": { top: "B", right: "C" },
    "rows": 10,
    "cols": 30,
  },
  {
    "node": "B",
    "neighbours": { bottom: "A" },
    "rows": 15,
    "cols": 20,
  },
  {
    "node": "C",
    "neighbours": { left: "A" },
    "rows": 10,
    "cols": 55,
  }
]

begin
  render_map("Ѭ", GREEN_TEXT, ".", 1, 1, rooms)

end

sleep 1
