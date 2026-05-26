-- Admin check permissions ACE dans config server
local function isAdmin()
    return IsPlayerAceAllowed(PlayerId(), "group.admin")
end

-- Commande à taper
RegisterCommand('tpme', function()
    local isAdmin = lib.callback.await('tpmenu:isAdmin', false)

    if not isAdmin then
        lib.notify({
            title = 'Non non non non non !',
            description = 'Depuis quand tu es admin ?',
            type = 'error'
        })
        return
    end

    local options = {}

-- Pour chaque demande, réaliser ces actions
for i = 1, #Config.Teleports do
    local loc = Config.Teleports[i]

    options[#options + 1] = {
        title = loc.title,
        icon = loc.icon or 'location-dot',

        onSelect = function()
            local ped = PlayerPedId()

            DoScreenFadeOut(500)
            Wait(600)

            SetEntityCoords(
                ped,
                loc.coords.x,
                loc.coords.y,
                loc.coords.z,
                false, false, false, false
            )

            Wait(300)
            DoScreenFadeIn(500)

            lib.notify({
                title = 'Et flash !',
                description = ('Envoyé.e vers %s'):format(loc.title),
                type = 'success'
            })
        end
    }
end

-- Menu ox_lib affiché
    lib.registerContext({
        id = 'teleport_menu',
        title = 'Menu de téléportation',
        position = 'top-left',
        options = options
    })

    lib.showContext('teleport_menu')
end)