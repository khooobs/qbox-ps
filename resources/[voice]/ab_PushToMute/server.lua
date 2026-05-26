RegisterNetEvent( 'ab_PushToMute:Server:SetMute', function ( ClientId, IsMute )
    MumbleSetPlayerMuted( ClientId, IsMute )
    --print('SetMute')
end )