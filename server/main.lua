hPlayer = {}

RegisterCommand("test_h", function(source, args)
    print(source, args[1], GetPlayerPed(source))
    --print(hPlayer[1], hPlayer[2])
    Set(args[1], source)
end, false)

function Set(num, src)
    hPlayer[num] = GetPlayerPed(src)
    print(hPlayer[1])
end