def intro_scene
  render_typewriter_text("\e[1;32mBem-vindo, amigo. Qual o seu nome?", 0.03)

  name = gets.chomp

  sleep 0.3

  render_typewriter_text("\e[1;32mCerto, #{name}...", 0.03)

  sleep 1

  render_typewriter_text("...", 0.2)

  render_frame("\e[1;32mSuas vestes são incomuns. Com o que você trabalha?\e[0;37m\n1. Guerreiro\n2. Mago\n3. Ladrão\n4. Arqueiro")

  job_list = %w[Guerreiro Mago Ladrão Arqueiro]

  job = job_list[gets.chomp.to_i - 1]

  player = PlayerJob.new(name, job)

  render_player_frame(player, "Deixa eu ver se entendi. Seu nome é #{name} e trabalha como #{job.downcase}?", true)

  response = gets.chomp

  render_player_frame(player, "Fique a vontade então...", true)

  player.area = :village
end

def set_window_height_and_width
  puts("\e[8;40;160t")
end