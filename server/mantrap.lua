RegisterNetEvent("sv:casinoheist:mantrap:syncvaultbombs")
AddEventHandler("sv:casinoheist:mantrap:syncvaultbombs", function(side)
    TriggerClientEvent("cl:casinoheist:mantrap:syncvaultbombs", -1, side)
end)

RegisterCommand("vl_start", function() 
    --SetVaultDoorStatus(2)
    --local prop = GetClosestObjectOfType(2505.54, -238.53, -71.65, 10.0, GetHashKey("ch_prop_ch_vault_wall_damage"), false, false, false)
    --SetEntityVisible(prop, false)
    --local vaultDoorOne = "ch_des_heist3_vault_01"
    --local vaultDoorTwo = "ch_des_heist3_vault_02"
    --LoadModel(vaultDoorOne)
    --LoadModel(vaultDoorTwo)
    --vaultObjOne = CreateObject(GetHashKey(vaultDoorOne), 2504.97, -240.31, -73.69, false, false, false)
    --vaultObjTwo = CreateObject(GetHashKey(vaultDoorTwo), 2504.97, -240.31, -75.334, false, false, false)  
    --canPlantExplosive = true 
    TriggerClientEvent("test:cl:mantrap:syncdoors", -1)
end, false)

RegisterCommand("test_vaultroom", function()
    TriggerClientEvent("test:cl:vaultroom", -1)
end)