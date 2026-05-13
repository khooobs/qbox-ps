local lights = {}

RegisterNetEvent('stud_light:requestSync', function()
    local src = source
    TriggerClientEvent('stud_light:sync', src, lights)
end)

RegisterNetEvent('stud_light:add', function(light)
    light.id = #lights + 1

    table.insert(lights, light)

    TriggerClientEvent('stud_light:addClient', -1, light)
end)

RegisterNetEvent('stud_light:update', function(id, data)
    for i = 1, #lights do
        if lights[i].id == id then
            lights[i].pos = data.pos
            lights[i].intensity = data.intensity
            lights[i].range = data.range
            lights[i].color = data.color
            TriggerClientEvent('stud_light:updateClient', -1, id, data)
            break
        end
    end
end)

RegisterNetEvent('stud_light:delete', function(id)
    for i = #lights, 1, -1 do
        if lights[i].id == id then
            table.remove(lights, i)
            break
        end
    end

    TriggerClientEvent('stud_light:deleteClient', -1, id)
end)