RegisterCommand("anim1", function()
    local animDict = "doors@unarmed"
    local animName = "r_hand_sweep"
    
    while not HasAnimDictLoaded(animDict) do 
        Wait(10)
    end

    ClearPedTasksImmediately(PlayerPedId())
    TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, 8.0, 2000, 8, 0, 1, 1, 1)
end, false)

RegisterCommand("anim", function()
    local animDict = "anim_heist@hs3f@ig8_vault_explosives@left@male@"
    local animName = "player_ig8_vault_explosive_plant_a"
    
    

    ClearPedTasksImmediately(PlayerPedId())
    
    
    TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, -8.0, -1, 8, 0, 0, 0, 0)
    
end, false)

RegisterCommand("eanim", function()
    local prop = GetClosestObjectOfType(2504.97, -240.31, -70.17, 1.0, GetHashKey("ch_des_heist3_vault_01"), false, false, false)
    local animDict = "anim_heist@hs3f@ig8_vault_door_explosion@"
    local animName = "explosion_vault_01"
    
    if DoesAnimDictExist(animDict) then 
        print("yes")
    else
        print("no")
    end

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
        Wait(10)
    end
    
    print(GetAnimDuration(animDict, animName))
    print(prop)
    PlayEntityAnim(prop, animName, animDict,  1, false, false, false, 1, 1)
    print(IsEntityPlayingAnim(prop, animDict, animName, 2))
    --print(GetHashKey("ch_des_heist3_vault_01"))
    --SetEntityVisible(prop, false)
    --SetEntityCollision(prop, false, true)
    --Wait(3000)
    --SetEntityVisible(prop, true)
    --SetEntityCollision(prop, true, true)
end, false)

RegisterCommand("stopa", function() ClearPedTasksImmediately(PlayerPedId()) end, false)

-- mp_heist@keypad -> enter, idle_a, exit       - Keypad

-- mp_doorbell -> exit_peda                     - Door deur lopen