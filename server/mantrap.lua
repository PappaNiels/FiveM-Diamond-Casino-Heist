RegisterNetEvent("sv:casinoheist:mantrap:syncvaultbombs")
AddEventHandler("sv:casinoheist:mantrap:syncvaultbombs", function(side)
    TriggerClientEvent("cl:casinoheist:mantrap:syncvaultbombs", -1, side)
end)