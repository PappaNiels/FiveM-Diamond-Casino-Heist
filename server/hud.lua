teamlives = 0
take = 0

RegisterNetEvent("sv:casinoheist:addtake", function(add)
    take = take + add
    TriggerClientEvent("cl:casinoheist:synctake", -1 , take)
end)

RegisterNetEvent("sv:casinoheist:removeteamlive", function()
    TriggerClientEvent("cl:casinoheist:syncteamlives", -1, teamlives - 1)
end)