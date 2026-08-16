require_relative '../utils/render'

def village_scene(player)
  text = "Você chegou na vila. à esquerda tem uma passagem e à direita uma casa.\n\n1. Ir para a passagem à esquerda\n2. Entrar na casa à direita"
  render_player_frame(player, text)

  choice = gets.chomp.to_i

  case choice
  when 1
    player.area = :passage
  when 2
    player.area = :house
  else
    puts "Essa opção não é válida, tente novamente."
    player.area = :village
  end
end