-- Ici mettre le nom du job qui n'a pas le chat cut 
local chatjob = 'admin'


CreateThread(function() 

    Wait(1000)
    

    while not QBX or not QBX.PlayerData or not QBX.PlayerData.citizenid do
        Wait(100)
        --print("En attente des données du joueur (citizenid)...")
    end



    while true do 
        Wait(0) -- Vérification continue
        local playerjob = QBX.PlayerData.job.name
        if playerjob ~= chatjob then
            DisableControlAction(0, 245, true) -- Désactive la touche "chat"
            TriggerEvent('chat:clear') 
            TriggerEvent('chat:setVisible', false) 
            
        end
    end

end)

