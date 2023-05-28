RegisterNetEvent("hud:client:LoadMap", function()
    Wait(50)
    -- Credit to Dalrae for the solve.
    local defaultAspectRatio = 1920/1080 -- Don't change this.
    local resolutionX, resolutionY = GetActiveScreenResolution()
    local aspectRatio = resolutionX/resolutionY
    local minimapOffset = 0
    if aspectRatio > defaultAspectRatio then
        minimapOffset = ((defaultAspectRatio-aspectRatio)/3.6)-0.008
    end

        RequestStreamedTextureDict("squaremap", false)
        if not HasStreamedTextureDictLoaded("squaremap") then
            Wait(150)
        end
        SetMinimapClipType(0)
        AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")
        AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "squaremap", "radarmasksm")
        -- 0.0 = nav symbol and icons left
        -- 0.1638 = nav symbol and icons stretched
        -- 0.216 = nav symbol and icons raised up
        SetMinimapComponentPosition("minimap", "L", "B", 0.0 + minimapOffset, -0.047, 0.1638, 0.183)

        -- icons within map
        SetMinimapComponentPosition("minimap_mask", "L", "B", 0.0 + minimapOffset, 0.0, 0.128, 0.20)

        -- -0.01 = map pulled left
        -- 0.025 = map raised up
        -- 0.262 = map stretched
        -- 0.315 = map shorten
        SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.01 + minimapOffset, 0.025, 0.262, 0.300)
        SetBlipAlpha(GetNorthRadarBlip(), 0)
        SetRadarBigmapEnabled(true, false)
        SetMinimapClipType(0)
        Wait(50)
        SetRadarBigmapEnabled(false, false)
        Wait(1200)

end)
TriggerEvent("hud:client:LoadMap")
SatNav = {
    ["NONE"] = {icon = 0},
    ["UP"] = {icon = 1},
    ["DOWN"] = {icon = 2},
    ["LEFT"] = {icon = 3},
    ["RIGHT"] = {icon = 4},
    ["EXIT_LEFT"] = {icon = 5},
    ["EXIT_RIGHT"] = {icon = 6},
    ["UP_LEFT"] = {icon = 7},
    ["UP_RIGHT"] = {icon = 8},
    ["MERGE_RIGHT"] = {icon = 9},
    ["MERGE_LEFT"] = {icon = 10},
    ["UTURN"] = {icon = 11},
}

MinimapScaleform = {
    scaleform = nil,
}

local function getMinimap()
    return MinimapScaleform.scaleform
end

function SetSatNavDirection(direction)
    local dir = SatNav[direction]
    if type(direction) == 'number' then
        dir = direction
    end
    if dir then
        BeginScaleformMovieMethod(getMinimap(), "SET_SATNAV_DIRECTION")
        ScaleformMovieMethodAddParamInt(dir.icon)
        EndScaleformMovieMethod()
    end
end



function SetSatNavState(show)
    BeginScaleformMovieMethod(getMinimap(), (show and "SHOW_SATNAV" or "HIDE_SATNAV"))
    EndScaleformMovieMethod()
end

function SetStallWarningState(show)
    BeginScaleformMovieMethod(getMinimap(), "SHOW_STALL_WARNING")
    ScaleformMovieMethodAddParamBool(show)
    EndScaleformMovieMethod()
end

function SetAbilityGlow(show)
    BeginScaleformMovieMethod(getMinimap(), "SET_ABILITY_BAR_GLOW")
    ScaleformMovieMethodAddParamBool(show)
    EndScaleformMovieMethod()
end

function SetAbilityVisible(show)
    BeginScaleformMovieMethod(getMinimap(), "SET_ABILITY_BAR_VISIBILITY_IN_MULTIPLAYER")
    ScaleformMovieMethodAddParamBool(show)
    EndScaleformMovieMethod()
end

function ShowYoke(x, y, vis, alpha)
    BeginScaleformMovieMethod(getMinimap(), "SHOW_YOKE")
    ScaleformMovieMethodAddParamFloat(show)
    ScaleformMovieMethodAddParamFloat(show)
    ScaleformMovieMethodAddParamBool(show)
    ScaleformMovieMethodAddParamInt(alpha)
    EndScaleformMovieMethod()
end

function SetHealthArmorType(type)
    BeginScaleformMovieMethod(getMinimap(), "SETUP_HEALTH_ARMOUR")
    ScaleformMovieMethodAddParamInt(type)
    EndScaleformMovieMethod()
end

function SetHealthAmount(amount)
    BeginScaleformMovieMethod(getMinimap(), "SET_PLAYER_HEALTH")
    ScaleformMovieMethodAddParamInt(amount)
    ScaleformMovieMethodAddParamFloat(0)
    ScaleformMovieMethodAddParamFloat(2000)
    ScaleformMovieMethodAddParamBool(false)
    EndScaleformMovieMethod()
end

function SetArmorAmount(amount)
    BeginScaleformMovieMethod(getMinimap(), "SET_PLAYER_ARMOUR")
    ScaleformMovieMethodAddParamInt(amount)
    ScaleformMovieMethodAddParamFloat(0)
    ScaleformMovieMethodAddParamFloat(2000)
    EndScaleformMovieMethod()
end

function SetAbilityAmount(amount)
    BeginScaleformMovieMethod(getMinimap(), "SET_ABILITY_BAR")
    ScaleformMovieMethodAddParamInt(amount)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamFloat(100)
    EndScaleformMovieMethod()
end

function SetAirAmount(amount)
    BeginScaleformMovieMethod(getMinimap(), "SET_AIR_BAR")
    ScaleformMovieMethodAddParamFloat(amount)
    EndScaleformMovieMethod()
end

Citizen.CreateThread(function()
    MinimapScaleform.scaleform = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
end)

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    -- while true do
        Wait(0)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
    --end
end)