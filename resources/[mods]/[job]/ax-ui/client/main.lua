local Sucesscb

RegisterNUICallback('MiniGameResult',function(data)
    SetNuiFocus(false,false)
    Sucesscb(data.won)
    Sucesscb = function() end
end)

RegisterNUICallback('PlaySound', function()
    PlaySound(-1, "CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
end)

RegisterNetEvent('ax-ui:StartMinigame')
AddEventHandler('ax-ui:StartMinigame',function(cb)
    SetNuiFocus(true,true) 
    SendNUIMessage({
        action = 'minigame'
    }) 
    Sucesscb = cb
end)

RegisterCommand('openminigame', function()
    TriggerEvent('ax-ui:StartMinigame',function(retval)
        print(retval)
    end)
end)