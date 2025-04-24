Config = {}

-- Define all available license types
Config.LicenseTypes = {
    { value = "driver", label = "Driver License" },
    { value = "motorcycle", label = "Motorcycle License" },
    { value = "weapon", label = "Glass1 License" },
    { value = "weapon2", label = "Glass2 License" },
    { value = "weapon3", label = "Glass3 License" },
    { value = "hunting", label = "Hunting License" },
    { value = "boat", label = "Boat License" },
    { value = "pilot", label = "Pilot License" },
}

-- Define which jobs and grades can manage which license types
Config.LicensePermissions = {
    driver = {
        { name = "police", minGrade = 3 },
        { name = "dmv", minGrade = 1 },
    },
    motorcycle = {
        { name = "dmv", minGrade = 1 },
    },
    weapon = {
        { name = "police", minGrade = 4 },
    },
    weapon2 = {
        { name = "police", minGrade = 5 },
    },
    weapon3 = {
        { name = "police", minGrade = 6 },
    },
    hunting = {
        { name = "ranger", minGrade = 2 },
    },
    boat = {
        { name = "coastguard", minGrade = 1 },
    },
    pilot = {
        { name = "airtraffic", minGrade = 3 },
    },
}
