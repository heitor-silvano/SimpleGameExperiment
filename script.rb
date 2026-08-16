require_relative 'player_job'
require_relative 'scenes/house'
require_relative 'scenes/village'
require_relative 'scenes/passage'
require_relative 'utils/render'
require "io/console"

def render_hp_bar(life_quantity, total_life)
  empty_blocks = total_life - life_quantity
  "\e[0;31m#{("█" * life_quantity)}\e[0;37m#{("░" * empty_blocks)} #{life_quantity}/#{total_life}"
end

def player_status(player)
  bar_information = "HP: #{render_hp_bar(player.life_quantity, player.total_life)} | NAME: #{player.name} | JOB: #{player.job}"
  puts "Você está em: #{player.area}"
  puts "-" * bar_information.size
  puts bar_information
  puts "-" * bar_information.size
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

render_fight

render_typewriter_text("\e[1;32mBem-vindo, amigo. Qual o seu nome?", 0.03)

name = gets.chomp

sleep 0.3

render_typewriter_text("\e[1;32mCerto, #{name}...", 0.03)

sleep 1

render_typewriter_text("...", 0.2)

render_frame("\e[1;32mVindo de onde veio, deve estar procurando algo nessa cidade. Do que você trabalha?\e[0;37m\n1. Guerreiro\n2. Mago\n3. Ladrão\n4. Arqueiro")

job_list = %w[Guerreiro Mago Ladrão Arqueiro]

job = job_list[gets.chomp.to_i - 1]

player = PlayerJob.new(name, job)

render_player_frame(player, "Deixa eu ver se entendi. Seu nome é #{name} e trabalha como #{job.downcase}?")

response = gets.chomp

render_player_frame(player, "Fique a vontade então...")

sleep 1

player.area = :village

loop do
  case player.area
  when :village then village_scene(player)
  when :passage then passage_scene(player)
  when :house then house_scene(player)
  else puts("puts")
  end
end

player.life_quantity = 25

village_scene(player)



