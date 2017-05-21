require "locale/utils/event"
require "band"

local function on_player_created(event)
  local player = game.players[event.player_index]
  player.insert{name="iron-plate", count=80}
  player.insert{name="pistol", count=1}
  player.insert{name="firearm-magazine", count=100}
  player.insert{name="burner-mining-drill", count = 10}
  player.insert{name="stone-furnace", count = 10}
  -- local mrange = 50
  -- player.force.chart(player.surface, {{player.position.x - mrange, player.position.y - mrange}, {player.position.x + mrange, player.position.y + mrange}})
  player.cheat_mode = true
end

Event.register(defines.events.on_player_created, on_player_created)
