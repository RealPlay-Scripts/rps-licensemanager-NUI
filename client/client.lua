local QBCore = exports['qb-core']:GetCoreObject()

-- Register the /managelicense command
RegisterCommand("managelicense", function()
    lib.callback('rps_licensemanager:canUseCommand', false, function(allowed)
        if allowed then
            TriggerEvent("rps_licensemanager:openUI")
        else
            lib.notify({
                title = "rps License Manager",
                description = "You do not have permission to use this.",
                type = "error"
            })
        end
    end)
end)

-- Open the NUI
RegisterNetEvent("rps_licensemanager:openUI", function()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = "openUI" })
    -- Get license types dynamically from server
    TriggerServerEvent('rps_licensemanager:getLicenseTypes')
end)

-- NUI callback to close the UI
RegisterNUICallback("closeUI", function(_, cb)
    SetNuiFocus(false, false)
    cb({})
end)

-- NUI callback when form is submitted
RegisterNUICallback("submitForm", function(data, cb)
    if data and data.playerId and data.licenseType and data.action then
        TriggerServerEvent("rps_licensemanager:updateLicense", data.playerId, data.licenseType, data.action)
        SetNuiFocus(false, false)
    else
        print("Error: Invalid form data.")
    end
    cb({})
end)

-- Receive and set license types in UI
RegisterNetEvent("rps_licensemanager:setLicenseTypes", function(licenseTypes)
    SendNUIMessage({
        action = "setLicenseTypes",
        licenseTypes = licenseTypes
    })
end)
