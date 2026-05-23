local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand("annonce", function(source, args, rawCommand)
    if source == 0 then
        print("[Annonce] Cette commande doit être exécutée en jeu, pas depuis la console serveur.")
        return
    end

    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        TriggerClientEvent('QBCore:Notify', source, "Erreur : joueur introuvable.", "error")
        return
    end

    if not QBCore.Functions.HasPermission(source, "admin") then
        TriggerClientEvent('QBCore:Notify', source, "Vous n'avez pas la permission d'utiliser cette commande.", "error")
        return
    end

    if #args < 1 then
        -- Pas d'argument => on affiche la description/usage
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {
                "[Annonce]",
                "Utilisation : /annonce [message] [all | ID joueur]\n" ..
                "Exemples :\n" ..
                "   /annonce Maintenance dans 5 minutes all\n" ..
                "   /annonce Salut 5 (pour le joueur ID 5)\n" ..
                "   /annonce Bonjour (envoie à tous)"
            }
        })
        return
    end

    local lastArg = args[#args]
    local maybePlayerId = tonumber(lastArg)
    local message = ""
    local target = -1  -- -1 => tout le monde

    if lastArg == "all" then
        table.remove(args, #args) -- Retire "all"
        message = table.concat(args, " ")
        target = -1

    elseif maybePlayerId ~= nil then
        table.remove(args, #args) -- Retire l'ID
        message = table.concat(args, " ")
        target = maybePlayerId

        if not GetPlayerName(target) then
            TriggerClientEvent('QBCore:Notify', source, "Le joueur spécifié n'est pas connecté.", "error")
            return
        end

    else
        -- Ni "all" ni un ID => message global
        message = table.concat(args, " ")
        target = -1
    end

    if message == "" then
        TriggerClientEvent('QBCore:Notify', source, "Vous devez spécifier un message.", "error")
        return
    end

    -- Envoi de l'annonce
    TriggerClientEvent("ton_resource:showAnnouncement", target, message, Config.AnnouncementDuration)

    if target == -1 then
        print(("Admin (ID %d) a fait une annonce globale : %s"):format(source, message))
    else
        print(("Admin (ID %d) a fait une annonce au joueur %d : %s"):format(source, target, message))
        TriggerClientEvent('QBCore:Notify', source, ("Annonce envoyée au joueur %d avec succès."):format(target), "success")
    end
end)