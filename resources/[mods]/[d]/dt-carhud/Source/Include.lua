
--[[

    @ Include Side

]]--

-- @ Function Reference ]
function createEvent(eventName, eventRoutine)
    return RegisterNetEvent(eventName), AddEventHandler(eventName, eventRoutine)
end 

-- @ Lua Reference ]
write = print
js = json
triggerNui = SendNUIMessage
Nuicallback = RegisterNUICallback
-- debug

-- @ Debug Refernce ]  
--[[
    debug('var1', var1)
    debug('var2', var2)
--]]
debugMode = Secure.Debug_mode -- For Developer

debug = function(self, key, ...)
    if not debugMode then return end
    write(('\n^0[ ^3Debug^0. ^4%s^0 ]'):format(key),...)
end