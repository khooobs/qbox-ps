local Freecam = exports["fivem-freecam"]

-- ## Freecam Events

RegisterNetEvent("freecam:onEnter", function() exports['pma-voice']:setListenerOnCamera( true ) end)
RegisterNetEvent("freecam:onExit", function() exports['pma-voice']:setListenerOnCamera( false ) end)

-- ## Toggles

CreateThread(function()
    while true do
        if IsDisabledControlJustPressed(0, 166) then
            local isAdmin = QBX.PlayerData.job.name == 'admin'
            local license = QBX.PlayerData.license 
            if not isAdmin then 
                print ("Job Admin Nécessaire")
                return 
            end

            local isActive = Freecam:IsActive()
            Freecam:SetActive(not isActive)

        end

        Wait(0)
    end
end)
