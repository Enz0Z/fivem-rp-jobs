local ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj 
end)


RegisterServerEvent("esx-SteelScrap:retrieveSteelScrap")
AddEventHandler("esx-SteelScrap:retrieveSteelScrap", function()
    local player = ESX.GetPlayerFromId(source)

    math.randomseed(os.time())
    local luck = math.random(0, 69)
    local randomSteelScrap = math.random((Config.SteelScrapRecieve[1] or 1), (Config.SteelScrapRecieve[2] or 6))

    if luck >= 0 and luck <= 0 then
        TriggerClientEvent("esx:showNotification", source, "The bin had no SteelScraps in it.")
    else
        player.addInventoryItem("SteelScrap", randomSteelScrap)
        TriggerClientEvent("esx:showNotification", source, ("You found x%s SteelScraps"):format(randomSteelScrap))
    end
end)
