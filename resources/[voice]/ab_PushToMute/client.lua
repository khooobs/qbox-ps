local IsMuted = false

lib.addKeybind({
	name = 'Push_To_Mute',
	description = 'Activer/Desactiver Micro',
	defaultKey = 'F7',
	onPressed = function ()

        --print('F7 onPressed')

        local playerPed = PlayerPedId()
        local playerindex = PlayerId()          
        local playerServerId = GetPlayerServerId(playerindex)
        --print(playerindex)

        -- Vérifie si le joueur est mort ou inconscient
        if IsPedDeadOrDying(playerPed, true) then 
            
            --print("IsPedDeadOrDying")
            return 
        end

		IsMuted = not IsMuted
        --print('IsMuted switch')

		TriggerServerEvent( 'ab_PushToMute:Server:SetMute', playerServerId, IsMuted )

        SendNUIMessage({
            action = "updateMic",
            muted = IsMuted
        })
	end
})

