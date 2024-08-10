ESX = exports["es_extended"]:getSharedObject()
local currentKills = {}

RegisterNetEvent('killfeed:server:announcKill', function(killer)
    local player = ESX.GetPlayerFromId(source)
    local target = ESX.GetPlayerFromId(killer)

    currentKills[source] = 0
    currentKills[killer] = (currentKills[killer] or 0) + 1

    exports.ox_inventory:AddItem(killer, 'money', (20 * currentKills[killer]))
    for _, xPlayer in pairs(ESX.GetExtendedPlayers()) do
        if xPlayer.source == source or xPlayer.source == killer then
            TriggerClientEvent('killfeed:client:announcKill', xPlayer.source,
                player.job.name == 'unemployed' and GetPlayerName(source) or
                player.job.label .. " | " .. GetPlayerName(source),
                target.job.name == 'unemployed' and GetPlayerName(killer) or
                target.job.label .. " | " .. GetPlayerName(killer),
                currentKills[killer], xPlayer.source == source and 'death' or 'kill')
            goto continue
        end

        TriggerClientEvent('killfeed:client:announcKill', xPlayer.source,
            player.job.name == 'unemployed' and GetPlayerName(source) or
            player.job.label .. " | " .. GetPlayerName(source),
            target.job.name == 'unemployed' and GetPlayerName(killer) or
            target.job.label .. " | " .. GetPlayerName(killer),
            currentKills[killer])
        ::continue::
    end
end)


RegisterNetEvent('killfeed:server:selfKill', function()
    local player = ESX.GetPlayerFromId(source)

    currentKills[source] = 0

    TriggerClientEvent('killfeed:client:announcKill', -1,
        player.job.name == 'unemployed' and GetPlayerName(source) or
        player.job.label .. " | " .. GetPlayerName(source))
end)

lib.callback.register('killfeed:callback:getKills', function(source)
    return currentKills[source] == nil and tostring(0) or tostring(currentKills[source])
end)
