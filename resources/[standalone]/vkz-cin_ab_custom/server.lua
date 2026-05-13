local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand('playvideo', function(source, args, rawCommand)
    if QBCore.Functions.HasPermission(source, 'admin') then
        local target = tonumber(args[1]) -- ID du joueur (optionnel)
        local videoUrl = args[2] -- URL de la vidéo
        local action = args[3] -- "true" pour lecture, "false" pour arrêter

        if not videoUrl or (action ~= "true" and action ~= "false") then
            TriggerClientEvent('QBCore:Notify', source, "Utilisation: /playvideo [id] [url] [true/false]", "error")
            return
        end

        local playState = action == "true"

        if target then
            -- Envoyer uniquement à un joueur
            TriggerClientEvent('playVideoForAll', target, videoUrl, playState)
            TriggerClientEvent('QBCore:Notify', source, "Vidéo envoyée au joueur " .. target, "success")
        else
            -- Envoyer à tout le monde
            TriggerClientEvent('playVideoForAll', -1, videoUrl, playState)
            TriggerClientEvent('QBCore:Notify', source, "Vidéo envoyée à tous les joueurs.", "success")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "Vous n'avez pas la permission.", "error")
    end
end, false)

-- Envoie du statut admin au client
RegisterNetEvent('requestAdminStatus')
AddEventHandler('requestAdminStatus', function()
    local src = source
    local isAdmin = QBCore.Functions.HasPermission(src, 'admin')
    TriggerClientEvent('setAdminStatus', src, isAdmin)
end)

RegisterCommand("fixhud", function(source, args, rawCommand)
    local playerId = source
    TriggerClientEvent("displayHUD", playerId) -- Forcer l'affichage de l'HUD
end, false)

RegisterServerEvent('chatMessage')
AddEventHandler('chatMessage', function(source, name, message)
    local player = source
    local playerGroup = GetPlayerGroup(player) -- Remplace par ton système de permissions

    -- Si le joueur n'est pas admin, on bloque le message
    if playerGroup ~= "admin" and playerGroup ~= "mod" then
        CancelEvent()
    end
end)

RegisterNetEvent('stopVideoForAll')
AddEventHandler('stopVideoForAll', function()
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') then
        TriggerClientEvent('playVideoForAll', -1, nil, false)
    end
end)

RegisterNetEvent('stopPlayerVideo')
AddEventHandler('stopPlayerVideo', function()
    local src = source
    TriggerClientEvent('playVideoForAll', src, nil, false) -- Coupe uniquement pour le joueur qui clique
end)



