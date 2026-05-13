/*
MADE BY EAZY-V
MOSTLY USING VIBE CODING AND SHITS
V1.0
*/

local lights = {}
local selectedLight = nil

local function GetLightById(id)

    for i = 1, #lights do
        if lights[i].id == id then
            return lights[i], i
        end
    end

    return nil
end
--------------------------------------------------
-- REQUEST SYNC
--------------------------------------------------
CreateThread(function()
    Wait(1000)
    TriggerServerEvent('stud_light:requestSync')
end)

--------------------------------------------------
-- NETWORK EVENTS
--------------------------------------------------
RegisterNetEvent('stud_light:sync', function(serverLights)
    lights = serverLights
end)

RegisterNetEvent('stud_light:addClient', function(light)
    table.insert(lights, light)
end)

RegisterNetEvent('stud_light:updateClient', function(id, data)
    for i = 1, #lights do
        if lights[i].id == id then
            lights[i] = data
            break
        end
    end
end)

RegisterNetEvent('stud_light:deleteClient', function(id)
    for i = #lights, 1, -1 do
        if lights[i].id == id then
            table.remove(lights, i)
            break
        end
    end
end)

--------------------------------------------------
-- CREATE LIGHT
--------------------------------------------------
local function CreateLight()

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local forward = GetEntityForwardVector(ped)

    local light = {
        pos = {
            x = coords.x + forward.x * 2.0,
            y = coords.y + forward.y * 2.0,
            z = coords.z + 1.0
        },

        intensity = 5.0,
        range = 20.0,
        color = {
            r = 255,
            g = 255,
            b = 255
        }
            }

    TriggerServerEvent('stud_light:add', light)
end

--------------------------------------------------
-- OPEN MENU
--------------------------------------------------
local function OpenMainMenu()

    local options = {
        {
                    title = 'Add Light',
                    icon = 'lightbulb',
                    description = 'Create a new light',
                    onSelect = function()
                        CreateLight()
                    end
                }
            }

            for i = 1, #lights do

                local light = lights[i]

                table.insert(options, {
                    title = ('Light #%s'):format(light.id),
                    icon = 'sun',
                    description = 'Edit this light',
                    onSelect = function()
                        selectedLight = light
                        OpenLightEditor(light)
                    end
                })
            end

            lib.registerContext({
                id = 'stud_light_main',
                title = 'Studio Lights',
                options = options
            })

            lib.showContext('stud_light_main')
        end

        --------------------------------------------------
        -- LIGHT EDITOR
        --------------------------------------------------
        function OpenLightEditor(light)

            lib.registerContext({
                id = 'stud_light_editor',
                title = ('Editing Light #%s'):format(light.id),

                options = {
                    {
                        title = 'Move Gizmo',
                        icon = 'up-down-left-right',
                        description = 'Precisely move the light',

                        onSelect = function()

                            --------------------------------------------------
                            -- CLOSE MENU
                            --------------------------------------------------
                            lib.hideContext()

                            Wait(100)

                            --------------------------------------------------
                            -- MODEL
                            --------------------------------------------------
                            local model = `prop_air_lights_02a`

                            lib.requestModel(model)

                            --------------------------------------------------
                            -- CREATE OBJECT
                            --------------------------------------------------
                            local obj = CreateObject(
                                model,
                                light.pos.x,
                                light.pos.y,
                                light.pos.z,
                                false,
                                false,
                                false
                            )

                            --------------------------------------------------
                            -- GIZMO
                            --------------------------------------------------
                            local data = exports.object_gizmo:useGizmo(obj)

                            --------------------------------------------------
                            -- APPLY POSITION
                            --------------------------------------------------
                            if data then

                                local coords = GetEntityCoords(obj)

                                light.pos = {
                                    x = coords.x,
                                    y = coords.y,
                                    z = coords.z
                                }

                                TriggerServerEvent(
                                    'stud_light:update',
                                    light.id,
                                    light
                                )

                                lib.notify({
                                    title = 'Studio Light',
                                    description = 'Light updated',
                                    type = 'success'
                                })
                            end

                            --------------------------------------------------
                            -- CLEANUP
                            --------------------------------------------------
                            DeleteEntity(obj)

                            --------------------------------------------------
                            -- REOPEN MENU
                            --------------------------------------------------
                            Wait(100)

                            OpenLightEditor(light)
                        end
                    },

            {
                title = ('Intensity: %s'):format(light.intensity),
                icon = 'sliders',

                onSelect = function()

                    local input = lib.inputDialog(
                        'Light Intensity',
                        {
                            {
                                type = 'slider',
                                label = 'Intensity',
                                default = light.intensity,
                                min = 0.1,
                                max = 200
                            }
                        }
                    )

                    if input then

                        local target = GetLightById(light.id)

                        if not target then
                            return
                        end

                        target.intensity = input[1]

                        TriggerServerEvent(
                            'stud_light:update',
                            target.id,
                            target
                        )

                        OpenLightEditor(target)
                    end
                end
            },

            {
                title = ('Range: %s'):format(light.range),
                icon = 'arrows-left-right-to-line',

                onSelect = function()

                    local input = lib.inputDialog(
                        'Light Range',
                        {
                            {
                                type = 'slider',
                                label = 'Range',
                                default = light.range,
                                min = 1,
                                max = 100,
                                step = 5.0
                            }
                        }
                    )

                    if input then

                        local target = GetLightById(light.id)

                        if not target then
                            return
                        end

                        target.range = tonumber(input[1]) + 0.0

                        TriggerServerEvent(
                            'stud_light:update',
                            target.id,
                            target
                        )

                        OpenLightEditor(target)
                    end
                end
            },
            {
                title = ('Color: %s'):format(light.color),
                icon = 'brush',

                onSelect = function()

                    local input = lib.inputDialog(
                        'Light color',
                        {
                            {
                                type = 'slider',
                                label = 'Red',
                                default = light.color.r,
                                min = 0,
                                max = 255
                            },
                            {
                                type = 'slider',
                                label = 'Green',
                                default = light.color.g,
                                min = 0,
                                max = 255
                            },
                            {
                                type = 'slider',
                                label = 'Blue',
                                default = light.color.b,
                                min = 0,
                                max = 255
                            }
                        }
                    )

                    if input then

                        local target = GetLightById(light.id)

                        if not target then
                            return
                        end

                        target.color.r = input[1]
                        target.color.g = input[2]
                        target.color.b = input[3]

                        TriggerServerEvent(
                            'stud_light:update',
                            target.id,
                            target
                        )

                        OpenLightEditor(target)
                    end
                end
            },

            {
                title = 'Delete Light',
                icon = 'trash',

                onSelect = function()
                    TriggerServerEvent(
                        'stud_light:delete',
                        light.id
                    )

                    selectedLight = nil
                    OpenMainMenu()
                end
            },

            {
                title = 'Back',
                icon = 'arrow-left',

                onSelect = function()
                    OpenMainMenu()
                end
            }
        }
    })

    lib.showContext('stud_light_editor')
end

--------------------------------------------------
-- COMMAND
--------------------------------------------------
RegisterCommand('gotalight', function()
    OpenMainMenu()
end)

--------------------------------------------------
-- DRAW LIGHTS
--------------------------------------------------
CreateThread(function()
    while true do
        Wait(0)

        for i = 1, #lights do

            local light = lights[i]

            DrawLightWithRange(
                light.pos.x,
                light.pos.y,
                light.pos.z,

                light.color.r,
                light.color.g,
                light.color.b,

                math.max(light.range or 10.0, 0.1),
                math.max(light.intensity or 5.0, 0.1)
            )

            DrawMarker(
                28,
                light.pos.x,
                light.pos.y,
                light.pos.z,
                0.0,
                0.0,
                0.0,
                0.0,
                0.0,
                0.0,
                0.05,
                0.05,
                0.05,
                255,
                255,
                0,
                200,
                false,
                false,
                2,
                false,
                nil,
                nil,
                false
            )
        end
    end
end)
