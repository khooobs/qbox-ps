local function playVideo(url, play)
    if not play then
        SendNUIMessage({ type = "closeVideo" })
        SetNuiFocus(false, false)
        return
    end

    local videoId = url:match("v=([%w_-]+)") or url:match("youtu.be/([%w_-]+)") or url:match("embed/([%w_-]+)")
    if videoId then
        SendNUIMessage({
            type = "playVideo",
            videoId = videoId
        })
        SetNuiFocus(true, true)
    else
        print("URL de vidéo YouTube invalide.")
    end
end

RegisterNetEvent('playVideoForAll')
AddEventHandler('playVideoForAll', function(url, play)
    playVideo(url, play)
end)

local function closeVideo()
    SendNUIMessage({ type = "closeVideo" })
    SetNuiFocus(false, false) -- Désactiver la souris et débloquer le jeu
end

RegisterNUICallback("focusNUI", function(data, cb)
    SetNuiFocus(data.focus, data.focus)
    cb("ok")
end)

RegisterNetEvent('displayHUD')
AddEventHandler('displayHUD', function()
    exports["office_ui"]:DisplayHud()
    print("🟢 HUD forcé à réapparaître via event")
end)
