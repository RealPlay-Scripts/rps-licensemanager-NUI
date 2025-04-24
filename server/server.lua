local QBCore = exports['qb-core']:GetCoreObject()

-- Check if the user is police (grade >= 4) or an admin group
function hasLicensePermission(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end

    local job = Player.PlayerData.job
    local isPolice = job.name == "police" and job.grade.level >= 4
    local isAdmin = QBCore.Functions.HasPermission(source, "admin")

    return isPolice or isAdmin
end

RegisterNetEvent('rps_licensemanager:updateLicense', function(targetId, licenseType, action)
    local src = source
    if not hasLicensePermission(src) then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'rps License Manager',
            description = 'You do not have permission to use this.',
            type = 'error'
        })
        return
    end

    local Target = QBCore.Functions.GetPlayer(tonumber(targetId))
    if not Target then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'rps License Manager',
            description = 'Player not found or not online.',
            type = 'error'
        })
        return
    end

    local metadata = Target.PlayerData.metadata
    metadata.licences = metadata.licences or {}
    metadata.licences[licenseType] = action == "grant"

    Target.Functions.SetMetaData("licences", metadata.licences)

    exports.oxmysql:execute('UPDATE players SET metadata = ? WHERE citizenid = ?', {
        json.encode(Target.PlayerData.metadata), Target.PlayerData.citizenid
    })

    TriggerClientEvent('ox_lib:notify', src, {
        title = 'rps License Manager',
        description = ('%s license %s successfully.'):format(licenseType, action == "grant" and "granted" or "revoked"),
        type = action == "grant" and 'success' or 'warning'
    })
end)

lib.callback.register('rps_licensemanager:canUseCommand', function(source)
    return hasLicensePermission(source)
end)

-- Send the license types to the client
RegisterNetEvent('rps_licensemanager:getLicenseTypes', function()
    local licenseTypes = Config.LicenseTypes  -- Get the license types from the config
    TriggerClientEvent('rps_licensemanager:setLicenseTypes', source, licenseTypes)
end)

-- Trigger the event when the client opens the UI (via command or other methods)
RegisterCommand("managelicense", function(source)
    -- Send license types to the player when they use the command
    TriggerEvent('rps_licensemanager:getLicenseTypes')
end)
