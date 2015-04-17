if ControlOverride == nil then
  print ( '[ControlOverride] creating ControlOverride' )
  ControlOverride = {}
  ControlOverride.__index = ControlOverride

  ControlOverride.clickCallback = nil;
  ControlOverride.mouseMoveCallback = nil;
  ControlOverride.keyDownCallback = nil;
  ControlOverride.keyUpCallback = nil;
  ControlOverride.selectCallback = nil;

  Convars:RegisterCommand('co_click', function(...)
    local arg = {...}
    table.remove(arg,1)

    local cmdPlayer = Convars:GetCommandClient()
    print("co_click: " .. cmdPlayer:GetPlayerID() .. " " .. table.concat(arg, ", "));

    if ControlOverride.clickCallback then
      local status, ret = pcall(ControlOverride.clickCallback, cmdPlayer, arg[1] == "0", tonumber(arg[2]), tonumber(arg[3]), Vector(tonumber(arg[4]),tonumber(arg[5]),tonumber(arg[6])))
      if not status then
        print('[ControlOverride] Click callback failure: ' .. ret)
      end
    end
  end, 'co_click', 0)

  Convars:RegisterCommand('co_mouse_move', function(...)
    local arg = {...}
    table.remove(arg,1)

    local cmdPlayer = Convars:GetCommandClient()
    print("co_mouse_move: " .. cmdPlayer:GetPlayerID() .. " " .. table.concat(arg, ", "));

    if ControlOverride.mouseMoveCallback then
      local status, ret = pcall(ControlOverride.mouseMoveCallback, cmdPlayer, Vector(tonumber(arg[1]),tonumber(arg[2]),tonumber(arg[3])))
      if not status then
        print('[ControlOverride] Mouse move callback failure: ' .. ret)
      end
    end
  end, 'co_mouse_move', 0)

  Convars:RegisterCommand('co_key_down', function(...)
    local arg = {...}
    table.remove(arg,1)

    local cmdPlayer = Convars:GetCommandClient()
    print("co_key_down: " .. cmdPlayer:GetPlayerID() .. " " .. table.concat(arg, ", "));

    if ControlOverride.keyDownCallback then
      local status, ret = pcall(ControlOverride.keyDownCallback, cmdPlayer, tonumber(arg[1]), arg[2], arg[3], arg[4])
      if not status then
        print('[ControlOverride] Key Down callback failure: ' .. ret)
      end
    end
  end, 'co_key_down', 0)

  Convars:RegisterCommand('co_key_up', function(...)
    local arg = {...}
    table.remove(arg,1)

    local cmdPlayer = Convars:GetCommandClient()
    print("co_key_up: " .. cmdPlayer:GetPlayerID() .. " " .. table.concat(arg, ", "));

    if ControlOverride.keyUpCallback then
      local status, ret = pcall(ControlOverride.keyUpCallback, cmdPlayer, tonumber(arg[1]), arg[2], arg[3], arg[4])
      if not status then
        print('[ControlOverride] Key Up callback failure: ' .. ret)
      end
    end
  end, 'co_key_up', 0)

  Convars:RegisterCommand('co_select', function(...)
    local arg = {...}
    table.remove(arg,1)

    local cmdPlayer = Convars:GetCommandClient()
    print("co_select: " .. cmdPlayer:GetPlayerID() .. " " .. table.concat(arg, ", "));

    if ControlOverride.selectCallback then
      local status, ret = pcall(ControlOverride.selectCallback, cmdPlayer, tonumber(arg[1]))
      if not status then
        print('[ControlOverride] Selection callback failure: ' .. ret)
      end
    end
  end, 'co_select', 0)
end



function ControlOverride:ClickHandler(fun)
  ControlOverride.clickCallback = fun
end
function ControlOverride:MouseMoveHandler(fun)
  ControlOverride.mouseMoveCallback = fun
end
function ControlOverride:KeyDownHandler(fun)
  ControlOverride.keyDownCallback = fun
end
function ControlOverride:KeyUpHandler(fun)
  ControlOverride.keyUpCallback = fun
end
function ControlOverride:SelectionHandler(fun)
  ControlOverride.selectCallback = fun
end


function ControlOverride:SendConfigToAll(clicks, keys, movement, selection)
  ControlOverride:SendConfig(-1, clicks, keys, movement, selection)
end
function ControlOverride:SendConfig(pid, clicks, keys, movement, selection)
  local obj = {pid=pid, clicks=clicks, keys=keys, movement=movement, selection=selection}
  FireGameEvent("control_override_config", obj)
end


function ControlOverride:SendKeyFilterToAll(filter)
  ControlOverride:SendKeyFilter(-1, filter)
end
function ControlOverride:SendKeyFilter(pid, filter)
  local obj = {pid=pid, filter=table.concat(filter ",")}
  FireGameEvent("control_override_keyfilter", obj)
end


function ControlOverride:SendSelectionFilterToAll(filter)
  ControlOverride:SendSelectionFilter(-1, filter)
end
function ControlOverride:SendSelectionFilter(pid, filter)
  local obj = {pid=pid, filter=table.concat(filter ",")}
  FireGameEvent("control_override_selectfilter", obj)
end


function ControlOverride:SendMouseFilterToAll(filter)
  ControlOverride:SendMouseFilter(-1, filter)
end
function ControlOverride:SendMouseFilter(pid, filter)
  local obj = {pid=pid, filter=table.concat(filter ",")}
  FireGameEvent("control_override_mousefilter", obj)
end


function ControlOverride:SendCvarToAll(cvar, value)
  ControlOverride:SendCvar(-1, cvar, value)
end
function ControlOverride:SendCvar(pid, cvar, value)
  local obj = {pid=pid, cvar=cvar, value=value}
  FireGameEvent("control_override_cvar", obj)
end
