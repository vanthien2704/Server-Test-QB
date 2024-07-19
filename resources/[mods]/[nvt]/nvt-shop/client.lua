QBCore         = nil
QBCore = exports['qb-core']:GetCoreObject()

-- Tạo npc và target
Citizen.CreateThread(function()
    for k,v in ipairs(Config["Zone"])do
        for kz,a in ipairs(v["Coords"])do
            local npcModel = `a_m_y_stwhi_02` -- Model của NPC
            RequestModel(npcModel)
            while not HasModelLoaded(npcModel) do
                Citizen.Wait(1)
            end
        
            local npcCoords = v["Coords"][kz] 
            local npcHeading = npcCoords.w 
        
            -- tạo blip trên bản đồ
            if v["Blips"]["Blip"] then
                local blip = AddBlipForCoord(npcCoords)
                SetBlipSprite (blip, v["Blips"]["Id"]) --icon
                SetBlipDisplay(blip, 4)  --luôn hiển thị trên minimap
                SetBlipScale  (blip, v["Blips"]["Scale"]) --độ to icon
                SetBlipColour (blip, v["Blips"]["Color"]) --màu icon
                SetBlipAsShortRange(blip, true) --đến gần thì xuất hiện trên minimap
                BeginTextCommandSetBlipName("STRING") --đặt tên cho blip
                AddTextComponentString(v["Blips"]["Blipname"]) --thêm Blipname
                SetBlipCategory(blip, v["Blips"]["Blipname"]) --phân loại blip
                EndTextCommandSetBlipName(blip) --kết thúc đặt tên
            end
            


            local npc = CreatePed(4, npcModel, npcCoords.x, npcCoords.y, npcCoords.z-1, npcHeading, false, true)
            SetEntityHeading(npc, npcHeading)
            FreezeEntityPosition(npc, true)
            SetEntityInvincible(npc, true)
            SetBlockingOfNonTemporaryEvents(npc, true)
        
            exports['qb-target']:AddTargetEntity(npc, {
                options = {
                    {
                        type = "client",
                        event = "moshop",
                        icon = "fas fa-comment",
                        label = "WINTER SHOP",
                    },
                },
                distance = 2.5
            })
        end
    end
end)


RegisterNetEvent('moshop')
AddEventHandler('moshop', function(money, bank)
    for k,v in ipairs(Config["Zone"])do
            local PlayerId = GetPlayerServerId(PlayerId())     

            SendNUIMessage({
                type = "ui",
                status = true,
                playerid = PlayerId
            
            })
        
            SetNuiFocus(true, true)
            SendNUIMessage({
                type = "loaditem",                           
                itemlist = v["Item"]
            })
    end


end)

-- thoat
RegisterNUICallback(
    "NUIFocusOff",
    function()
		SendNUIMessage({
			type = "ui",
			status = false,
		})
		SetNuiFocus(false, false)
        IsOpen = false
    end
)
--check tien
RegisterNUICallback(
    "cash",
    function(data)
        TriggerServerEvent("payitem", GetPlayerServerId(PlayerId()), "cash", data)
        print(json.encode(data))
        
    end
)
--check bank
RegisterNUICallback(
    "bank",
    function(data)
        TriggerServerEvent("payitem", GetPlayerServerId(PlayerId()), "bank", data)
        print(json.encode(data))
    end
)

