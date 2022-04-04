isInSecurity = false

local blipActive = false
local canSwipeKeycard = false
local holdingPass = false
local keycard = 0
local keycardProp
--local blipsThreeKeypad = false 
--local blipOne
--local blipTwo 
local blip = {1, 1}

RegisterCommand("sec_blips", function()
    --AddSecurityBlips()
    isInSecurity = true
end, false)

function AddSecurityBlips()
    for i = 1, #blip, 1 do 
        blip[i] = AddBlipForCoord(lvlFourKeypad[i])    
        SetBlipSprite(blip[i], 733)
        SetBlipColour(blip[i], 2)
        SetBlipHighDetail(blip[i], true)
        blipActive = true
    end
end

function StartKeycardAnim(num)
    local animDict = "anim_heist@hs3f@ig3_cardswipe_insync@male@"
    
    LoadAnim(animDict)
    LoadModel("ch_prop_vault_key_card_01a")
    local coords = GetEntityCoords(PlayerPedId())
    keycardProp = CreateObject(GetHashKey("ch_prop_vault_key_card_01a"), coords, true, true, false)
    
    ClearPedTasksImmediately(PlayerPedId())

    if num == 1 then 
        holdingPass = true
        AttachEntityToEntity(keycardProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0x67F2), 0.13, -0.04, 0.0, 0.0, 90.0, 0.0, false, false, false, false, 2, true) 
        TaskPlayAnimAdvanced(PlayerPedId(), animDict, "ped_a_enter", 2465.45, -282.0, -70.69, 0, 0, 109.0, 8.0, -8.0, -1, 8, 0, 0, 0)
        Wait(600)
        while holdingPass do 
            TaskPlayAnimAdvanced(PlayerPedId(), animDict, "ped_a_enter_loop", 2465.45, -282.0, -70.69, 0, 0, 109.0, 8.0, -8.0, 600, 8, 0, 0, 0)
            Wait(500)
        end
        --print("tick")

        --TaskPlayAnim(PlayerPedId(), animDict, "ped_a_intro_b", 8.0, -8.0, -1, 8, 0, 0, 0, 0)
    else 
        print('2')
    end
end

CreateThread(function()
    while true do 
        Wait(0)
        if isInSecurity then 
            SubtitleMsg("Go to one of the ~g~keypads~s~.", 110)
            if not blipActive then 
                AddSecurityBlips()
                Wait(100)
            else
                local distance1, distance2 = #(GetEntityCoords(PlayerPedId()) - lvlFourKeypad[1]), #(GetEntityCoords(PlayerPedId()) - lvlFourKeypad[2])
                if distance1 < 1.5 or distance2 < 1.5 then
                    isInSecurity = false
                    canSwipeKeycard = true 
                else 
                    Wait(100)
                    --print("false")
                end
            end
        else 
            Wait(500)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(0)
        if canSwipeKeycard then 
            SubtitleMsg("Simultaneously swipe the ~g~keycards~s~", 100)
            local distance1, distance2 = #(GetEntityCoords(PlayerPedId()) - lvlFourKeypad[1]), #(GetEntityCoords(PlayerPedId()) - lvlFourKeypad[2])
            
            if distance1 < 0.5 then 
                HelpMsg("Press ~INPUT_CONTEXT~ to swipe the keycard", 150) 
                if IsControlPressed(0, 38) then  
                    StartKeycardAnim(1)
                    --print("a")
                    canSwipeKeycard = false
                    keycard = 1
                else 
                    --print("wha") 
                    Wait(10)
                end
            elseif distance2 < 0.5 then
                HelpMsg("Press ~INPUT_CONTEXT~ to swipe the keycard", 150) 
                if IsControlPressed(0, 38) then 
                    StartKeycardAnim(2)
                    --print("a")
                    canSwipeKeycard = false
                    keycard = 2
                else
                    --print("wha") 
                    Wait(10)
                end
            else 
                Wait(50)
            end 
        else 
            Wait(1000)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0) 
        if holdingPass then 
            DisableControlAction(1, 200, true)
            HelpMsg("Both Players must insert their keycards simultaneously. Press ~INPUT_FRONTEND_RDOWN~ when you are both ready. to back out press ~INPUT_FRONTEND_PAUSE_ALTERNATE~.")
            if IsControlPressed(0, 18) then 
                print("enter") 
                holdingPass = false
            elseif IsControlPressed(0, 202) then 
                print("esc")
                holdingPass = false 
            else 
                Wait(50)
            end

        else 
            Wait(1000)
        end
    end
end)