require_relative '../constants/terminal_colors'

def create_player
  render_typewriter_text(GREEN_TEXT + "Bem-vindo, amigo. Qual o seu nome?", 0.03)

  name = gets.chomp

  sleep 0.3

  set_window_height_and_width

  sleep 0.3

  render_typewriter_text(GREEN_TEXT + "Certo, #{name}...", 0.03)

  sleep 1

  render_typewriter_text("...", 0.2)

  render_frame(GREEN_TEXT + "Suas vestes são incomuns. Com o que você trabalha?" + WHITE_TEXT + "\n1. Guerreiro\n2. Mago\n3. Ladrão\n4. Arqueiro")

  job_list = %w[Guerreiro Mago Ladrão Arqueiro]

  job = job_list[gets.chomp.to_i - 1]

  player = PlayerJob.new(name, job)

  render_player_frame(player, GREEN_TEXT + "Deixa eu ver se entendi. Seu nome é #{name} e trabalha como #{job.downcase}?", true)

  response = gets.chomp

  render_player_frame(player, GREEN_TEXT + "Fique a vontade então...", true)

  player.area = :village

  player
end

def set_window_height_and_width
  puts("\e[8;40;160t")
end