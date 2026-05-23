
RegisterNetEvent("ton_resource:showAnnouncement", function(message, duration)
    -- Montre la fenêtre Win95
    SendNUIMessage({
        type = "show",
        text = message
    })
    
    -- Fermeture automatique
    if duration and duration > 0 then
        CreateThread(function()
            Wait(duration)
            SendNUIMessage({ type = "hide" })
        end)
    end
end)

-- Fermer via ESC
CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustPressed(0, 200) then -- 200 = ESC
            SendNUIMessage({ type = "hide" })
        end
    end
end)

-- Callback du bouton X
RegisterNUICallback("close", function(data, cb)
    SendNUIMessage({ type = "hide" })
    cb("ok")
end)