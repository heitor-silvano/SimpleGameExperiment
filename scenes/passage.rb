require_relative '../enemy'

def passage_scene(player)
  player_status(player)

  big_rat = Enemy.new(28, "Ratão furioso")

  clear_screen

  render_fight_started(big_rat)

  show_fight_options(player.fight_options)

  option = gets.chomp.to_i

  damage = player.fight_options[option - 1][:damage]
  #inflict_damage(player.fight_options[job])
end