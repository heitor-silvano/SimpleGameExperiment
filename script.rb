require_relative 'scenes/intro'
require_relative 'player_job'
require_relative 'scenes/house'
require_relative 'scenes/village'
require_relative 'scenes/passage'
require_relative 'utils/render'
require "io/console"

intro_scene

sleep 1

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



