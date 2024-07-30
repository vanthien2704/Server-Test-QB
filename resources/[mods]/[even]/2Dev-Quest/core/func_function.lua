ExportQuestClient = function(a, b)
    if QuestState[a] and QuestState[a].State == false then
        local s = QuestState[a].Count - b
        if s > 0 then
            QuestState[a].Count = s
            UpdateQuestScore(a, s)
        else
            t[2](e.sv["QuestRewards"], a)
            t[2](e.sv["ResetQuestID"], a)
        end
    end
end

UpdateQuestScore = function(a, s)
    Wait(100)
    SendNUIMessage({action = "update-stack", event = a, count = s})
end
QuestStackUpdate = function ()
    local elm = {}
    for k, v in pairs(QuestState) do
        if v.State == false then
            table.insert(elm, {
                key = k,
                count = v.Count,
                detail = v.Detail
            })
        end
    end
    if #elm > 0 then
        SendNUIMessage({action = "open-stack", data = elm})
    else
        SendNUIMessage({action = "close-stack"})
    end
end

NUIOpenQuest = function()
    if Config.BlurMode then TriggerScreenblurFadeIn(1) end
    SetNuiFocus(true, true)
    SendNUIMessage({action = "open-ui", data = QuestState})
end

ResetQuest = function()
    QuestState = {}
    QuestState = Config.Quest
end


