local QBCore = exports['qb-core']:GetCoreObject()
local earthquaking = false

local function applyDrunkEffect(ped)
    RequestAnimSet("move_m@drunk@slightlydrunk")
    while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do Wait(100) end
    SetPedMovementClipset(ped, "move_m@drunk@slightlydrunk", 0.5)

    local shakeDirections = {{x=0.3,y=0.0,z=0.0},{x=-0.3,y=0.0,z=0.0},{x=0.0,y=0.3,z=0.0},{x=0.0,y=-0.3,z=0.0}}

    while earthquaking do
        local direction = shakeDirections[math.random(1, #shakeDirections)]
        ApplyForceToEntity(ped, 1, direction.x, direction.y, direction.z, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
        if math.random() < 0.05 then SetPedToRagdoll(ped, 1000, 1000, 0, true, true, false) end
        Wait(750)
    end

    ResetPedMovementClipset(ped, 0.5)
end

RegisterNetEvent('cs-earthquake:perform', function()
    if earthquaking then return end

    local ped = PlayerPedId()
    earthquaking = true

    SendNUIMessage({ type = 'play', volume = config.soundEffectVolume })

    local activeMs, intensity = 0, config.intensity.min
    local totalDurationMs = config.buildUpMs + config.wearOffMs

    ShakeGameplayCam(config.effect, intensity)

    CreateThread(function() applyDrunkEffect(ped) end)

    while activeMs < totalDurationMs do
        if activeMs < config.buildUpMs then
            intensity = math.min(intensity + config.intensity.step, config.intensity.max)
        else
            intensity = math.max(intensity - config.intensity.step, config.intensity.min)
        end

        SetGameplayCamShakeAmplitude(intensity)
        Wait(config.tickIntervalMs)
        activeMs = activeMs + config.tickIntervalMs
    end

    ShakeGameplayCam(config.effect, 0.0)
    earthquaking = false
end)
