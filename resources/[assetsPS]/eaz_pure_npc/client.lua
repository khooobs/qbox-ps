/*
MADE BY EAZY-V
MOSTLY USING VIBE CODING AND SHITS
V1.1
*/

local spawnedPeds = {}
local debugMode = true
local nextPedId = 1

local animations = {
    {
        label = "Smoking",
        dict = "amb@world_human_smoking@male@male_a@enter",
        anim = "enter"
    },
    {
        label = "Hangout",
        dict = "amb@world_human_hang_out_street@male_a@idle_a",
        anim = "idle_a"
    },
    {
        label = "Whistle",
        dict = "rcmnigel1c",
        anim = "hailing_whistle_waive_a"
    },
    {
        label = "Lay wall",
        dict = "amb@world_human_leaning@female@wall@back@holding_elbow@base",
        anim = "base"
    },
    {
        label = "Car repair",
        dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer"
    },
    {
        label = "Car repair lay",
        dict = "amb@world_human_vehicle_mechanic@male@base",
        anim = "base"
    },
    {
        label = "Sit phone down",
        dict = "anim@amb@business@bgen@bgen_no_work@",
        anim = "sit_phone_phoneputdown_idle_nowork"
    },
    {
        label = "Medic kneel idle",
        dict = "amb@medic@standing@kneel@idle_a",
        anim = "idle_a"
    },
    {
        label = "Lay feet up",
        dict = "amb@world_human_sunbathe@female@front@base",
        anim = "base"
    }
}

-- DEBUG TOGGLE
RegisterCommand('npcdebug', function()
    debugMode = not debugMode

    lib.notify({
        title = 'NPC Spawner',
        description = ('Debug mode: %s'):format(debugMode and 'ON' or 'OFF'),
        type = debugMode and 'success' or 'inform'
    })
end)

-- SPAWN NPC
RegisterCommand('npcspawn', function()
    local animOptions = {}

    for i = 1, #animations do
        animOptions[#animOptions + 1] = {
            value = i,
            label = animations[i].label
        }
    end

    local input = lib.inputDialog('Spawn NPC', {
        {
            type = 'input',
            label = 'Ped Model',
            description = 'Enter exact ped model name',
            placeholder = 'a_m_m_business_01',
            required = true
        },

        -- PRESET DROPDOWN
        {
            type = 'select',
            label = 'Animation Preset',
            description = 'Optional preset animation',
            options = animOptions,
            required = false
        },

        -- MANUAL ANIM DICT
        {
            type = 'input',
            label = 'Animation Dictionary',
            description = 'Overrides preset if filled',
            placeholder = 'amb@world_human_smoking@male@male_a@enter',
            required = false
        },

        -- MANUAL ANIM NAME
        {
            type = 'input',
            label = 'Animation Name',
            description = 'Overrides preset if filled',
            placeholder = 'enter',
            required = false
        },

        {
            type = 'checkbox',
            label = 'Freeze NPC',
            checked = true
        },

        {
            type = 'checkbox',
            label = 'Invincible',
            checked = true
        }
    })

    if not input then return end

    local modelName = input[1]
    local presetIndex = input[2]
    local customDict = input[3]
    local customAnim = input[4]
    local freezePed = input[5]
    local invincible = input[6]

    local animDict = nil
    local animName = nil

    -- CUSTOM ANIMATION PRIORITY
    if customDict and customDict ~= '' and customAnim and customAnim ~= '' then
        animDict = customDict
        animName = customAnim

    -- OTHERWISE USE PRESET
    elseif presetIndex then
        local preset = animations[presetIndex]

        animDict = preset.dict
        animName = preset.anim
    end

    local model = joaat(modelName)

    if not IsModelInCdimage(model) then
        lib.notify({
            title = 'NPC Spawner',
            description = 'Invalid model name.',
            type = 'error'
        })

        return
    end

    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(0)
    end

    local playerPed = PlayerPedId()
    local coords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 2.0, 0.0)
    local heading = GetEntityHeading(playerPed)

    local ped = CreatePed(
        4,
        model,
        coords.x,
        coords.y,
        coords.z - 1.0,
        heading,
        true,
        true
    )

    SetEntityAsMissionEntity(ped, true, true)

    if freezePed then
        FreezeEntityPosition(ped, true)
    end

    if invincible then
        SetEntityInvincible(ped, true)
    end

    SetBlockingOfNonTemporaryEvents(ped, false)

    -- PLAY ANIMATION
    if animDict and animName then
        RequestAnimDict(animDict)

        while not HasAnimDictLoaded(animDict) do
            Wait(0)
        end

        TaskPlayAnim(
            ped,
            animDict,
            animName,
            8.0,
            -8.0,
            -1,
            1,
            0.0,
            false,
            false,
            false
        )
    end

    SetModelAsNoLongerNeeded(model)

    local pedId = nextPedId
    nextPedId += 1

    spawnedPeds[pedId] = {
        entity = ped,
        model = modelName
    }

    local msg = ('Spawned NPC: %s'):format(modelName)

    if debugMode then
        msg = msg .. (' | ID: %s'):format(pedId)

        print(('[NPC DEBUG] Spawned NPC ID %s (%s)'):format(
            pedId,
            modelName
        ))

        if animDict and animName then
            print(('[NPC DEBUG] Animation: %s -> %s'):format(
                animDict,
                animName
            ))
        end
    end

    lib.notify({
        title = 'NPC Spawner',
        description = msg,
        type = 'success'
    })
end)

-- CLEAR NPCS
RegisterCommand('npcdelete', function(_, args)
    local pedId = tonumber(args[1])

    -- REMOVE SPECIFIC NPC
    if pedId then
        local pedData = spawnedPeds[pedId]

        if not pedData then
            lib.notify({
                title = 'NPC Spawner',
                description = ('NPC ID %s not found.'):format(pedId),
                type = 'error'
            })

            return
        end

        if DoesEntityExist(pedData.entity) then
            DeleteEntity(pedData.entity)
        end

        spawnedPeds[pedId] = nil

        lib.notify({
            title = 'NPC Spawner',
            description = ('Deleted NPC ID %s'):format(pedId),
            type = 'success'
        })

        if debugMode then
            print(('[NPC DEBUG] Deleted NPC ID %s'):format(pedId))
        end

        return
    end

    -- REMOVE ALL NPCS
    local count = 0

    for id, pedData in pairs(spawnedPeds) do
        if DoesEntityExist(pedData.entity) then
            DeleteEntity(pedData.entity)
            count += 1
        end
    end

    spawnedPeds = {}

    lib.notify({
        title = 'NPC Spawner',
        description = ('Deleted %s NPC(s)'):format(count),
        type = 'inform'
    })

    if debugMode then
        print(('[NPC DEBUG] Deleted all NPCs (%s total)'):format(count))
    end
end)