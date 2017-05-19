-- Give players the option to set their preferred role as a tag
-- A 3Ra Gaming creation
-- Befzz's revision 0.1.5

-- Role list: "tag_roles.lua"
local roles = require "tag_roles"

local expand_tag_gui

local function create_tag_gui(event)
  local player = game.players[event.player_index]
  if player.gui.top.tag_toggle_btn == nil then
    local button = player.gui.top.add { name = "tag_toggle_btn", type = "sprite-button", caption = "Tag", style = "dialog_button_style" }
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


-- Make a list of random names with roles
local function test_fake_players( t )
  local limit =  math.random(20,120)
  
  local roles_ind = {}
  for role in pairs(roles) do
    table.insert( roles_ind, role)
  end
  
  for i = 1,limit do
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

local function get_random_from_table(tbl)
  return tbl[math.random(1,#tbl)]
end

-- dev_icons(ctrl + click): show icon-choose buttons
-- dev_addfakes(alt + click): add random number of player names w/ color
expand_tag_gui = function(player, dev_icons, dev_addfakes, right_click)

  local frame = player.gui.left["tag-panel"]
  if (frame) then
    frame.destroy()
    
    if player.gui.center["textfield_item_icon_frame"] then
      player.gui.center["textfield_item_icon_frame"].destroy()
    end
    if player.tag ~= "" then
      player.gui.top.tag_toggle_btn.tooltip = "Tag: "..player.tag.."\n Right Click to show offline players with tags."
      if player.admin then
        player.gui.top.tag_toggle_btn.tooltip = player.gui.top.tag_toggle_btn.tooltip.."\n CTRL + Click to explore icons.\n ALT + Click to add fake names"
      end
    end
    return
  end
  
  local player_role = player.tag:sub(2,-2)

  -- Will be filled: { roleN = {{name,color},...} , ...}
  local players_by_role = {}
  
  for role in pairs(roles) do
    players_by_role[role] = {}
  end
  
  if right_click then
    for _, oplayer in pairs(game.players) do
      local prole = oplayer.tag:sub(2,-2)
      if prole ~= "" then
        if oplayer.connected then
          table.insert( players_by_role[prole], {oplayer.name, oplayer.color})
        else
          table.insert( players_by_role[prole], {oplayer.name, {r=0,g=0,b=0}})
        end
      end
    end
  else
    for _, oplayer in pairs(game.connected_players) do
      local prole = oplayer.tag:sub(2,-2)
      if prole ~= "" then
          table.insert( players_by_role[prole], {oplayer.name, oplayer.color})
      end
    end
  end
  

  
  if dev_addfakes then
    test_fake_players(players_by_role)
  end
  
  player.gui.top.tag_toggle_btn.tooltip = ""
  
  local button--reusable variable :D
  local frame = player.gui.left.add { type = "frame", direction = "vertical", name = "tag-panel", caption = "What are you doing right now:"}
  
  if dev_icons then
    local choose
    local chooselist = frame.add { type = "flow", direction = "horizontal" }
    -- ["signal"] = {type = "virtual", name = "signal-A"}
    for itype, ivalue in pairs({["item"] = "green-wire", ["entity"] = "medium-spitter", ["tile"] = "grass"}) do
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
  scroll.style.maximal_height = 600
  scroll.style.minimal_width = 250
  scroll.style.bottom_padding = 10
  
  local table_roles = scroll.add{type = "table", name = "table_roles", colspan = 2}
  table_roles.style.horizontal_spacing = 15
  table_roles.style.vertical_spacing = 4
        
        
  local name_label
  local color_k = 0.6
  local pname
  local pcolor
  
  local show_role_tooltip = math.random() > .5
  
  for role, role_icons in pairs(roles) do
  
    local role_line = table_roles.add { type = "flow", direction = "horizontal" }

    button = role_line.add { type = "sprite-button", sprite = get_random_from_table(role_icons), name = "tag_role_"..role, style = "recipe_slot_button_style"}
    button.style.top_padding = 4
    button.style.left_padding = 0
    button.style.right_padding = 0
    button.style.bottom_padding = 4
    if show_role_tooltip and role_icons.tooltip then
      button.tooltip = get_random_from_table( role_icons.tooltip )
    end
    
    local role_cap_line = role_line.add { type = "flow", direction = "horizontal" }
    role_cap_line.style.max_on_row = 1
         
    local role_label = role_cap_line.add { type = "label", caption = role, single_line = true}
    -- role_label.style.minimal_width = 0
    role_label.style.minimal_height = 0
    role_label.style.maximal_height = 12  
    role_label.style.top_padding = 0
    role_label.style.left_padding = 0
    role_label.style.right_padding = 0
    role_label.style.bottom_padding = 0
    role_label.style.font = "default-bold"
    if role == player_role then
      role_label.style.font_color = {r=.7,g=1,b=.7}
    end
    
    
    if #players_by_role[role] > 0 then
      local count_label = role_cap_line.add {type = "label", caption = #players_by_role[role], single_line = false}
      count_label.style.font = "default-small-bold"
      count_label.style.maximal_height = 10  
      count_label.style.top_padding = 0
      count_label.style.left_padding = 0
      count_label.style.right_padding = 0
      count_label.style.bottom_padding = 0
      count_label.style.font_color = {r=.55,g=.55,b=.55}
    end


    local list_players = table_roles.add { type = "flow", direction = "horizontal" }
    list_players.style.max_on_row = 3
    list_players.style.top_padding = 0
    list_players.style.bottom_padding = 7
    -- list_players.style.vertical_spacing = 0

    if players_by_role[role] then
      for _,pdata in pairs(players_by_role[role]) do
        pname = pdata[1]
        pcolor = pdata[2]
        
        name_label = list_players.add {type = "label", caption = pname, want_ellipsis = true, single_line = false}
        name_label.style.font = "default"
        name_label.style.top_padding = 0
        name_label.style.right_padding = 4
        name_label.style.left_padding = 2
        name_label.style.bottom_padding = 0
        name_label.style.maximal_height = 11
        name_label.style.minimal_height = 11
        name_label.style.maximal_width = 120
        name_label.style.minimal_width = 120
        name_label.style.font_color = {
         r = .4 + pcolor.r * color_k,
         g = .4 + pcolor.g * color_k,
         b = .4 + pcolor.b * color_k,
        }

      end
    end
  end
  
  
  button = frame.add { type = "button", caption = "Clear tag", name = "tag_clear" }
  button.style.font = "default-bold"
  if player.tag == "" then
    button.style.font_color = {r=.7, g=1, b=.7}
    button.caption = "Close"
  else
    button.style.font_color = {r=1, g=0.5, b=0.5}
  end
  button.style.minimal_width = 80
  button.style.maximal_height = 26
  button.style.top_padding = 0
  button.style.left_padding = 2
  button.style.right_padding = 2
  button.style.bottom_padding = 0
end

local function update_player_role(player, role)
  if role ~= "" then
    player.tag = "[" .. role .. "]"
  else
    player.tag = ""
  end
end


local function on_gui_click(event)
  if not (event and event.element and event.element.valid) then return end
  local player = game.players[event.element.player_index]
  local name = event.element.name
  if (name == "tag_toggle_btn") then
    --player, dev_icons, dev_addfakes
    expand_tag_gui(player, 
      player.admin and event.control, 
      player.admin and event.alt,
      event.button == defines.mouse_button_type.right)
  end

  if (name == "tag_clear") then
  
    update_player_role(player, "")
    
    player.gui.top.tag_toggle_btn.caption = "Tag"
    player.gui.top.tag_toggle_btn.tooltip = ""
    player.gui.top.tag_toggle_btn.sprite = ""
    expand_tag_gui(player)
    return
  end
  
  --role button clicked
  if name:find("tag_role_") == 1 then
    local _,role_ind_start = name:find("tag_role_")
    local name_role = name:sub(role_ind_start + 1)
    for role, role_icons in pairs(roles) do
      if (name_role == role) then
      
        update_player_role(player, role)
          
        player.gui.top.tag_toggle_btn.caption = ""
        player.gui.top.tag_toggle_btn.sprite = event.element.sprite  --get_random_from_table(role_icons)
        
        expand_tag_gui(player)
      end
    end
  end
end

--handle choose-item button
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
      -- if type(event.element.elem_value ) == 'table' then
        -- textfield = frame.add { name = "textfield_item_icon", type = "textfield", text = "virtual-signal/" .. event.element.elem_value.name }
      -- else
        textfield = frame.add { name = "textfield_item_icon", type = "textfield", text = event.element.elem_type .. "/" .. event.element.elem_value }
      -- end
      
      --buggy
      textfield.style.minimal_width = 300
    end
  end
  
end

Event.register(defines.events.on_gui_elem_changed, on_gui_elem_changed)
Event.register(defines.events.on_gui_click, on_gui_click)
Event.register(defines.events.on_player_joined_game, create_tag_gui)
