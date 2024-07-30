QBCore = exports["qb-core"]:GetCoreObject()
r = GetCurrentResourceName()
GetName = function(a,b) return string.format("%s:%s:%s", r, a, b) end
RegisEvent = function(b, a, c)
    if b then RegisterNetEvent(a) end
    AddEventHandler(a, c)
end
t = {TriggerClientEvent, TriggerServerEvent}
e = {}
e.sv = {
    ["QuestRewards"] = GetName("SV", "QuestRewards"),
    ["ResetQuestID"] = GetName("SV", "ResetQuestID"),
}
e.cl = {
    ["ResetQuestID"] = GetName("CL", "ResetQuestID"),
    ["ClearQuestState"] = GetName("CL", "ClearQuestState"),
    ["ExportServer"] = GetName("CL", "ExportServer"),
}