def show_choices(choices)
  puts("Qual sua próxima ação?\n")
  choices.each_with_index { |item, index| puts "#{index + 1}. #{item}" }
end

def show_fight_choices(fight_options)
  puts("Escolha sua ação")
  puts("--------------------------")
  fight_options.each_with_index { |item, index| puts "#{index + 1}. #{item[:title]}" }
end

def enemy_fight(enemy)
  puts("ATENÇÃO")
  puts("Você encontrou #{enemy}!\n")
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

class PlayerJob
  attr_accessor :name, :job, :life_quantity, :damage, :area, :level, :fight_options, :total_life

  def initialize(name, job)
    @name = name
    @job = job
    @life_quantity = life_by_job(job)
    @total_life = life_by_job(job)
    @damage = damage_by_job(job)
    @area = :village
    @level = 0
    @fight_options = fight_options_by_job(job)
  end

  private

  def damage_by_job(job)
    { "Guerreiro" => 15, "Mago" => 20, "Ladrão" => 10, "Arqueiro" => 10 } [job]
  end

  def life_by_job(job)
    { "Guerreiro" => 150, "Mago" => 80, "Ladrão" => 90, "Arqueiro" => 100 } [job]
  end

  def fight_options_by_job(job)
    {
      "Guerreiro" => [{ title: "Ataque leve", damage: 15 }, { title: "Ataque pesado", damage: 22 }, { title: "Porrada", damage: 8 }],
      "Mago" => [{ title: "Orb de energia", damage: 18 }, { title: "Cajadada", damage: 3 }],
      "Ladrão" => [{ title: "Facadas duplas", damage: 13 }, { title: "Arremessar estrelas", damage: 18 }, { title: "Chutes", damage: 6 }],
      "Arqueiro" => [{ title: "Atirar", damage: 16 }, { title: "Tiro duplo", damage: 19 }, { title: "Arqueada", damage: 5 }]
    }[job]
  end
end

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

def passage_scene(player)
  player.area = "Passagem"
  player_status(player)
  enemy_fight("Ratão furioso")

  show_fight_choices(player.fight_options)
end

def house_scene(player)
  player.area = "Casa aleatória (você deveria sair entrando assim nos lugares?)"
  player_status(player)

  puts "Ok. Está vazia."
end

def village_scene(player)
  player.area = "Vila"
  puts "Você chegou na vila. à esquerda tem uma passagem e à direita uma casa.\n"

  show_choices(["Ir para a passagem à esquerda", "Entrar na casa à direita"])
  player_status(player)

  choice = gets.chomp.to_i

  case choice
  when 1
    passage_scene(player)
  when 2
    house_scene(player)
  else
    puts "Essa opção não é válida, tente novamente."
    village_scene(player)
  end
end

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



