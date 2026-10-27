require 'io/console'
def render_hp_bar(player)
  life_quantity = player.life_quantity
  total_life = player.total_life

  empty_blocks = total_life - life_quantity
  "\e[0;31m#{("█" * life_quantity)}\e[0;37m#{("░" * empty_blocks)} #{life_quantity}/#{total_life}"
end

def player_status(player)
  bar_information = "HP: #{render_hp_bar(player)} | NAME: #{player.name} | JOB: #{player.job}"
  _screen_rows, screen_cols = STDOUT.winsize

  puts "Local: #{player.area}"

  puts "-" * screen_cols
  puts bar_information
  puts "-" * screen_cols
end

def render_player_frame(player, text, is_typewriter)
  hud_rows_quantity = 4
  text_rows_quantity = text.lines.count
  screen_rows, _screen_cols = STDOUT.winsize

  if is_typewriter
    render_typewriter_text(text, 0.03)

    sleep 0.5
  else
    puts text
  end

  blank_space = screen_rows - hud_rows_quantity - text_rows_quantity - 1

  puts "\n" * blank_space

  player_status(player)
end

def render_frame(text)
  hud_rows_quantity = 3
  text_rows_quantity = text.lines.count
  screen_rows, screen_cols = STDOUT.winsize

  puts "#{text}\e[0;37m"

  blank_space = screen_rows - hud_rows_quantity - text_rows_quantity - 1

  puts "\n" * blank_space

  puts "-" * screen_cols.to_i
  puts "???"
  puts "-" * screen_cols
end

def render_typewriter_text(text, delay)
  text.each_char do |char|
    print char
    sleep delay unless char == " "
  end
  puts "\e[0;37m"
end

def render_fight_started(enemy)
  print("ATENÇÃO")
  render_typewriter_text("!!", 0.2)

  sleep(1)

  text = "Você encontrou #{enemy.title}"

  puts("-" * text.length)
  render_typewriter_text(text, 0.02)
end

def render_fight
  rows, cols = STDOUT.winsize

  bars = rows - 5

  blank_space = rows - bars

  loop do
    (1...cols / 3).each do |i|
      (1...bars).each do |row|
        puts "#{'   ' * i}|"
      end

      puts "\n" * blank_space
      sleep(0.02)
    end
  end
end

def clear_screen
  print "\e[2J"
  print "\e[H"
end

def show_choices(choices)
  puts("Qual sua próxima ação?\n")
  choices.each_with_index { |item, index| puts "#{index + 1}. #{item}" }
end

def show_fight_options(fight_options)
  puts("Escolha sua ação")
  puts("--------------------------")
  fight_options.each_with_index { |item, index| puts "#{index + 1}. #{item[:title]}" }
end

def enemy_fight(enemy)
  puts("ATENÇÃO")
  puts("Você encontrou #{enemy.title}!\n")
end

def prompt_save_file
  puts "Deseja salvar o progresso?"
  puts "S/N"
end

def render_select_file_menu_prompt(options, selected_option_index)
  options.each_with_index do |filename, file_index|
    puts file_index == selected_option_index ? GREEN_BACKGROUND + BLACK_TEXT + filename + RESET_BACKGROUND + RESET_TEXT : filename
  end
end
def render_select_list(options, text)
  index = 0
  list_size = get_save_files_quantity

  render_select_file_menu_prompt(options, 0)

  reader = TTY::Reader.new

  loop do
    char = reader.read_keypress

    case char
    when "\e[A"
      if index == 0
        index = list_size
      else
        index > 0
        index = index - 1
      end
    when "\e[B"
      if index == list_size
        index = 0
      else
        index < list_size
        index = index + 1
      end
    when "\r"
      return index
    else
      puts "else"
    end

    clear_screen
    puts GREEN_TEXT + text + RESET_TEXT
    render_select_file_menu_prompt(options, index)
  end
end