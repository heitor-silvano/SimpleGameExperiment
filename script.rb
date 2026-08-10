require_relative 'player_job'
require_relative 'scenes/house'
require_relative 'scenes/village'
require_relative 'scenes/passage'

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

def render_life_bar(life_quantity, total_life)
  empty_blocks = total_life - life_quantity
  "#{("█" * life_quantity)}#{("░" * empty_blocks)} #{life_quantity}/#{total_life}"
end

puts "Bem-vindo, amigo. Qual o seu nome?"

name = gets.chomp

puts "Certo, #{name}..."
puts "Vindo de onde veio, deve estar procurando algo nessa cidade. Do que você trabalha?"
puts "1. Guerreiro"
puts "2. Mago"
puts "3. Ladrão"
puts "4. Arqueiro"

job_list = %w[Guerreiro Mago Ladrão Arqueiro]

job = job_list[gets.chomp.to_i - 1]

player = PlayerJob.new(name, job)

puts "Deixa eu ver se entendi. Seu nome é #{name} e trabalha como #{job.downcase}?"

response = gets.chomp

puts "'#{response}'... Fique a vontade então"

def player_status(player)
  bar_information = "HP: #{render_life_bar(player.life_quantity, player.total_life)} | DMG: #{player.damage} | AREA: #{player.area}"
  puts "-" * bar_information.size
  puts bar_information
  puts "-" * bar_information.size
end

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



