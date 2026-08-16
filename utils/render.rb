require 'io/console'

def render_player_frame(player, text)
  hud_rows_quantity = 4
  text_rows_quantity = text.lines.count
  screen_rows, _screen_cols = STDOUT.winsize

  puts text

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