ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('kp_whale:reward')
AddEventHandler('kp_whale:reward', function(Weight)
    local xPlayer = ESX.GetPlayerFromId(source)

    if Weight >= 1 then
        xPlayer.addInventoryItem('meat_w', 2)
    elseif Weight >= 9 then
        xPlayer.addInventoryItem('meat_w', 3)
    elseif Weight >= 15 then
        xPlayer.addInventoryItem('meat_w', 4)
    end

  --  xPlayer.addInventoryItem('leather_w', math.random(0, 1))
        
end)

RegisterServerEvent('kp_whale:sell')
AddEventHandler('kp_whale:sell', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    local meat_wPrice = 2500
    --local leather_wPrice = 125

    local meat_wQuantity = xPlayer.getInventoryItem('meat_w').count
   --local leather_wQuantity = xPlayer.getInventoryItem('leather_w').count

    if meat_wQuantity > 0  then
        xPlayer.addMoney(meat_wQuantity * meat_wPrice)
       -- xPlayer.addMoney(leather_wQuantity * leather_wPrice)

        xPlayer.removeInventoryItem('meat_w', meat_wQuantity)
       -- xPlayer.removeInventoryItem('leather_w', leather_wQuantity)
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'You sold ' ..  meat_wQuantity .. ' and earned $' ..  meat_wPrice * meat_wQuantity)
    else
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'You don\'t have any meat ')
    end
        
end)

function sendNotification(xsource, message, messageType, messageTimeout)
    TriggerClientEvent('notification', xsource, message)
end