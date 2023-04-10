ESX = nil
local isOpen, letSleep = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)
        Citizen.Wait(250)
    end
end)

RegisterNUICallback('close', function(data, cb)
    display(false)
    cb('ok')
end)

RegisterNUICallback('getName', function(data, cb)
    TriggerServerEvent('ardi:set:name', data.first, data.last)
    display(false)
    cb('ok')
end)

function display(bool)
    if bool then
        SendNUIMessage({action = 'UI', display = true})
        SetNuiFocus(true, true)
        isUIopen = true
    else
        SendNUIMessage({action = 'UI'})
        SetNuiFocus(false, false)
        isUIopen = false
    end
end

Citizen.CreateThread(function()

    for _, v in pairs(ULTRACL.Position) do
        local blip = AddBlipForCoord(v)
        SetBlipSprite(blip, ULTRACL.Blip.ID)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, ULTRACL.Blip.Scale)
        SetBlipColour(blip, ULTRACL.Blip.Colour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(ULTRACL.Blip.Title)
        EndTextCommandSetBlipName(blip)
    end

    while true do
        Citizen.Wait(0)
        local letSleep = true
        if nearLocation() then
            if not isUIopen then
                letSleep = false
                ESX.ShowHelpNotification('Drücke ~INPUT_PICKUP~ um eine Namensänderung zu beantragen')
                if IsControlJustPressed(0, 38) and not isUIopen then
                    display(true)
                end
            end
        end

        if letSleep then
            Citizen.Wait(500)
        end

    end

end)

function nearLocation()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    for k, v in pairs(ULTRACL.Position) do
        local distance = #(coords - v)

        if distance < 1.5 then
            return true
        end
    end

    return false
end