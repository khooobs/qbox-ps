lib.callback.register('tpmenu:isAdmin', function(source)
    return IsPlayerAceAllowed(source, 'admin')
end)