def village_scene(player)
  puts "Você chegou na vila. à esquerda tem uma passagem e à direita uma casa.\n"

  show_choices(["Ir para a passagem à esquerda", "Entrar na casa à direita"])
  player_status(player)

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