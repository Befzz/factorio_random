require "locale/utils/event"
require "tag"

script.on_event(defines.events.on_player_created, function(event)
  local player = game.players[event.player_index]
  player.insert{name="iron-plate", count=80}
  player.insert{name="pistol", count=1}
  player.insert{name="firearm-magazine", count=100}
  player.insert{name="burner-mining-drill", count = 10}
  player.insert{name="stone-furnace", count = 10}
  player.force.chart(player.surface, {{player.position.x - 200, player.position.y - 200}, {player.position.x + 200, player.position.y + 200}})
end)
