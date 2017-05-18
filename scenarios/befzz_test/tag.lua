-- Give players the option to set their preferred role as a tag
-- A 3Ra Gaming creation
-- Befzz's revision 0.1.2

local function create_tag_gui(event)
  local player = game.players[event.player_index]
  if player.gui.top.tag == nil then
    local button = player.gui.top.add { name = "tag", type = "sprite-button", caption = "Tag", style = "dialog_button_style" }
    button.style.font = "default-bold"
    button.style.minimal_height = 38
    button.style.minimal_width = 38
    button.style.top_padding = 2
    button.style.left_padding = 4
    button.style.right_padding = 4
    button.style.bottom_padding = 2

    -- expand_tag_gui(player)
  end
end

-- Tag list
-- Icon name must be legal. (right click on a Tag button to explore icon names)

local roles = {
  ["Trooper"] = "item/tank",
  ["Security"] = "item/submachine-gun",
  ["Resources"] = "item/iron-axe",
  ["Production"] = "item/assembling-machine-2",
  ["Science"] = "item/science-pack-1",  
  ["Spaghetti"] = "item/transport-belt",
  ["Trains"] = "item/locomotive",
  ["Powah!"] = "item/steam-turbine",
  ["Lurker"] = "entity/small-spitter",
  ["Cat"] = "item/raw-fish"
}



-- Make a list of random names with roles
local function test_fake_players( t )
  local limit =  math.random(20,120)
  
  local roles_ind = {}
  for role in pairs(roles) do
    table.insert( roles_ind, role)
  end
  
  for i = 1,limit do print(i) 
    local rolei = math.random(1, #roles_ind)
    local role = roles_ind[rolei]

    table.insert(t[role], 
      {
        "Fake#" .. (tostring(math.random())):sub(3,-math.random(1,10)),
        {
          r=math.random(),
          g=math.random(),
          b=math.random()
        }
      }
    )
  end
end

local function expand_tag_gui(player, devmode, dev_addfakes)

  local player_role = player.tag:sub(2,-2)

  local players_by_role = {}
  
  for role in pairs(roles) do
    players_by_role[role] = {}
  end
  
  for _, oplayer in pairs(game.connected_players) do
    local prole = oplayer.tag:sub(2,-2)
    if prole ~= "" then
      table.insert( players_by_role[prole], {oplayer.name, oplayer.color})
    end
  end
  
  if dev_addfakes then
    test_fake_players(players_by_role)
  end
  
  local frame = player.gui.left["tag-panel"]
  if (frame) then
    frame.destroy()
    
    if player.gui.center["textfield_item_icon_frame"] then
      player.gui.center["textfield_item_icon_frame"].destroy()
    end
    if player.tag ~= "" then
      if player.admin then
        player.gui.top.tag.tooltip = "Tag: "..player.tag.."\n Right Click to debug icons."
      else
        player.gui.top.tag.tooltip = "Tag: "..player.tag
      end
      
    end
    return
  end
  
  player.gui.top.tag.tooltip = ""
  
  local button
  local frame = player.gui.left.add { type = "frame", direction = "vertical", name = "tag-panel", style = "frame_style", caption = "What are you doing right now:"}
  
  if devmode then
    local choose
    local chooselist = frame.add { type = "flow", direction = "horizontal" }
    for itype, ivalue in pairs({["item"] = "green-wire", ["entity"] = "medium-spitter", ["signal"] = {type = "virtual", name = "signal-A"}, ["tile"] = "grass"}) do
      choose = chooselist.add { type = "choose-elem-button", elem_type = itype, [itype] = ivalue, name = "help_item_icon_choose_"..itype }
      choose.style.minimal_height = 36
      choose.style.minimal_width = 36
      choose.style.top_padding = 2
      choose.style.left_padding = 2
      choose.style.right_padding = 2
      choose.style.bottom_padding = 2
    end
  end
  
  local scroll = frame.add{type = "scroll-pane", horizontal_scroll_policy = "never", vertical_scroll_policy = "auto"}
  
  --Frame max. height
  scroll.style.maximal_height = 600
  scroll.style.minimal_width = 250
  scroll.style.bottom_padding = 10
  local table_roles = scroll.add{type = "table", name = "table_roles", colspan = 2}
  table_roles.style.horizontal_spacing = 20
  table_roles.style.vertical_spacing = 6

  for role, role_icon in pairs(roles) do
  
    local role_line = table_roles.add { type = "flow" }

    button = role_line.add { type = "sprite-button", sprite = role_icon, name = role}

    button.style.minimal_width = 50
    button.style.minimal_height = 34
    button.style.top_padding = 2
    button.style.left_padding = 2
    button.style.right_padding = 2
    button.style.bottom_padding = 2
        
    local sublabel = role_line.add { type = "label", caption = role}
    -- sublabel.style.minimal_width = 0
    sublabel.style.minimal_height = 36
    sublabel.style.top_padding = 2
    sublabel.style.left_padding = 0
    sublabel.style.right_padding = 0
    sublabel.style.bottom_padding = 0
    sublabel.style.font = "default-bold"
    if role == player_role then
      sublabel.style.font_color = {r=.7,g=1,b=.7}
    end


    local plist = table_roles.add { type = "flow", direction = "horizontal" }
    plist.style.max_on_row = 3
    plist.style.top_padding = 0
    plist.style.bottom_padding = 7
    -- plist.style.vertical_spacing = 0
    local pbutn
    local color_k = 0.6
    local pname
    local pcolor
    if players_by_role[role] then
      for _,pdata in pairs(players_by_role[role]) do
        pname = pdata[1]
        pcolor = pdata[2]
        
        pbutn = plist.add {type = "label", caption = pname, want_ellipsis = true, single_line = false}
        pbutn.style.font = "default"
        pbutn.style.top_padding = 0
        pbutn.style.right_padding = 4
        pbutn.style.left_padding = 1
        pbutn.style.bottom_padding = 0
        pbutn.style.maximal_height = 11
        pbutn.style.minimal_height = 11
        pbutn.style.maximal_width = 120
        pbutn.style.minimal_width = 120
        

        pbutn.style.font_color = {
         r = .4 + pcolor.r * color_k,
         g = .4 + pcolor.g * color_k,
         b = .4 + pcolor.b * color_k,
        }
      end
    end
  end
  
  button = frame.add { type = "button", caption = "Clear", name = "tag_clear" }
  button.style.font = "default-bold"
  if player.tag == "" then
    button.style.font_color = {r=.7, g=1, b=.7}
  else
    button.style.font_color = {r=1, g=0.5, b=0.5}
  end
  button.style.minimal_width = 60
  button.style.maximal_height = 26
  button.style.top_padding = 0
  button.style.left_padding = 2
  button.style.right_padding = 2
  button.style.bottom_padding = 0
end

local function update_player_role(player, role)
  -- local prev_role = player.tag:sub(2,-2)
  
  -- if prev_role ~= "" then
    -- global.players_by_role[prev_role][player.index] = nil
  -- end
  
  if role ~= "" then
    -- if global.players_by_role[role] == nil then
      -- global.players_by_role[role] = {player.index}
    -- else
      -- global.players_by_role[role][player.index] = 1
    -- end
    player.tag = "[" .. role .. "]"
  else
    player.tag = ""
  end
end

local function on_player_left_game(event)
  local player = game.players[event.player_index]
  
  update_player_role(player, "")
  
end


local function on_gui_click(event)
  if not (event and event.element and event.element.valid) then return end
  local player = game.players[event.element.player_index]
  local name = event.element.name
  local devmode = (event.button == defines.mouse_button_type.right)
  if (name == "tag") then
    expand_tag_gui(player, devmode, event.alt and player.admin)
  end

  if (name == "tag_clear") then
  
    update_player_role(player, "")
    
    player.gui.top.tag.caption = "Tag"
    player.gui.top.tag.tooltip = ""
    player.gui.top.tag.sprite = ""
    expand_tag_gui(player)
    return
  end
  for role, role_icon in pairs(roles) do
    if (name == role) then
    
      update_player_role(player, role)
        
      player.gui.top.tag.caption = ""
      player.gui.top.tag.sprite = role_icon
      
      expand_tag_gui(player, devmode)
    end
  end
end

local function on_gui_elem_changed(event)
  if not (event and event.element and event.element.valid) then return end
  local player = game.players[event.element.player_index]
  local name = event.element.name
  if name:find("help_item_icon_choose") then
    if player.gui.center["textfield_item_icon_frame"] then
      player.gui.center["textfield_item_icon_frame"].destroy()
    end
    if event.element.elem_type and event.element.elem_value then
      local frame = player.gui.center.add{ type = "frame", name = "textfield_item_icon_frame", caption = "SpritePath"}
      frame.style.minimal_width = 310
      local textfield 
      if type(event.element.elem_value ) == 'table' then
        textfield = frame.add { name = "textfield_item_icon", type = "textfield", text = "virtual-signal/" .. event.element.elem_value.name }
      else
        textfield = frame.add { name = "textfield_item_icon", type = "textfield", text = event.element.elem_type .. "/" .. event.element.elem_value }
      end
      textfield.style.minimal_width = 300
    end
  end
  
end

Event.register(defines.events.on_player_left_game, on_player_left_game)
Event.register(defines.events.on_gui_elem_changed, on_gui_elem_changed)
Event.register(defines.events.on_gui_click, on_gui_click)
Event.register(defines.events.on_player_joined_game, create_tag_gui)
