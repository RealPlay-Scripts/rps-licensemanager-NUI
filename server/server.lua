local QBCore = exports['qb-core']:GetCoreObject()

-- Check if the user has permission for a specific licenseType
function hasLicensePermission(source, licenseType)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end

    -- Admins can manage any license
    if QBCore.Functions.HasPermission(source, "admin") then
        return true
    end

    local job = Player.PlayerData.job
    local allowedJobs = Config.LicensePermissions[licenseType]
    if not allowedJobs then return false end

    for _, jobConfig in pairs(allowedJobs) do
        if job.name == jobConfig.name and job.grade.level >= jobConfig.minGrade then
            return true
        end
    end

    return false
end

RegisterNetEvent('rps_licensemanager:updateLicense', function(targetId, licenseType, action)
    local src = source
    if not hasLicensePermission(src, licenseType) then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'rps License Manager',
            description = 'You do not have permission to manage this license.',
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
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end

    -- Admin override
    if QBCore.Functions.HasPermission(source, "admin") then
        return true
    end

    local job = Player.PlayerData.job
    for licenseType, jobs in pairs(Config.LicensePermissions) do
        for _, jobConfig in pairs(jobs) do
            if job.name == jobConfig.name and job.grade.level >= jobConfig.minGrade then
                return true
            end
        end
    end

    return false
end)

-- Send license types to the UI
RegisterNetEvent('rps_licensemanager:getLicenseTypes', function()
    local licenseTypes = Config.LicenseTypes
    TriggerClientEvent('rps_licensemanager:setLicenseTypes', source, licenseTypes)
end)

-- Trigger the license manager UI via command
RegisterCommand("managelicense", function(source)
    TriggerEvent('rps_licensemanager:getLicenseTypes')
end)
