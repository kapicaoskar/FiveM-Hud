local load_d = false
local playerPed = PlayerPedId()
local isInVehicle = IsPedInAnyVehicle(playerPed, false)
local Vechicle
local health
local breath
local hunger = 100
local thirst = 100
local armour = 0
local oxygen = 0
local rpm
local gearCount
local carhud = false
local id
local hour
local min
local street
local talking
local talkingStatus
local streetName
local voiceLevel = 0
local fuel
local rpm
local playerCoords
local speed
local chekHudActive = true
local playerCoords = GetEntityCoords(PlayerPedId())
local beltOnCheck = false
local direction = "Unknown"
local waypointDist = 0
local region = ""
local vibelife = false

local vibelife2 = false

local vibelife3 = false
local zones = {['OBSERV'] = "Obserwatorium", ['GALLI'] = "Znak Vinewood", ['AIRP'] = "Lotnisko Los Santos", ['ALAMO'] = "Morze Alamo", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Kanion Banham Dr", ['BANNING'] = "Banning", ['BEACH'] = "Plaża Vespucci", ['BHAMCA'] = "Kanion Banham", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Tunel Braddock", ['BURTON'] = "Burton", ['CALAFB'] = "Most Calafia", ['CANNY'] = "Kanion Raton", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Góry Chamberlain", ['CHIL'] = "Góry Vinewood", ['CHU'] = "Chumash", ['CMSW'] = "Pustkowie Chilliad Mountain", ['CYPRE'] = "Niziny Cypress", ['DAVIS'] = "Davis", ['DELBE'] = "Plaża Del Perro", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Pustynia Grand Senora", ['DOWNT'] = "Sródmieście", ['DTVINE'] = "Sródmieście Vinewood", ['EAST_V'] = "Wschodnie Vinewood", ['EBURO'] = "Wyżyny El Burro", ['ELGORL'] = "Latarnia El Gordo", ['ELYSIAN'] = "Wyspa Elysian", ['GALFISH'] = "Galilee", ['GOLF'] = "Towarzystwo DWT i Golfa", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Tor Wyścigowy Vinewood", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Zakład Bolingbroke", ['KOREAT'] = "Mały Seul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Wyżyny Murrieta", ['NCHU'] = "Północne Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Ocean Pacyfik", ['PALCOV'] = "Zatoka Paleto", ['PALETO'] = "Przybrzeże Paleto", ['PALFOR'] = "Las Paleto", ['PALHIGH'] = "Wyżyny Palomino", ['PALMPOW'] = "Elektrownia Palmer-Taylor", ['PBLUFF'] = "Urwiska Pacyfik", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Plaża Procopio", ['RANCHO'] = "Ranczo", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Góry Rockford", ['golf'] = "Pole Golfowe" ,['RTRAK'] = "Tor Świateł Rockwood", ['SANAND'] = "San Andreas", ['SANCHIA'] = "Pasmo Górskie San Chianski", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Góry Tataviam", ['TERMINA'] = "Terminal", ['TEXTI'] = "Miasto Textile", ['TONGVAH'] = "Góry Tongva", ['TONGVAV'] = "Wioska Tongva", ['VCANA'] = "Kanały Vespucci", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Farma Wiatraków", ['WVINE'] = "Zachodnie Vinewood", ['ZANCUDO'] = "Rzeka Zancudo", ['ZP_ORT'] = "Port Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    Citizen.Wait(100)
    PlayerData = ESX.GetPlayerData()
    Player = ESX.GetPlayerData()
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    Player = ESX.GetPlayerData()
    TriggerEvent("hud:client:LoadMap")
    load_d = true
end)





AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
   --     Player = ESX.GetPlayerData()
   TriggerEvent("hud:client:LoadMap")
        load_d = true
    end
end)

Citizen.CreateThread(function()
    repeat
        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            hunger = status.getPercent()
        end)
        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            thirst = status.getPercent()
        end)
        Citizen.Wait(3000)
    until(vibelife)
end)




Citizen.CreateThread(function()
    Citizen.Wait(550)
    repeat      
        Citizen.Wait(600)
        if load_d then 
            
            health = (GetEntityHealth(playerPed) - 100)
            armour = GetPedArmour(playerPed)
            breath = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10
            armour = GetPedArmour(playerPed)
            talking = NetworkIsPlayerTalking(PlayerId())
            hunger = hunger
            thirst = thirst
            if LocalPlayer.state['proximity'] then
                voiceLevel = LocalPlayer.state['proximity'].distance
            end
            if talking then
                talkingStatus = true
            else
                talkingStatus = false
            end
            if breath <= 0 then breath = 0 end

            if health <= 0 then health = 0 end

            if not IsPedSwimming(ped) and not IsPedSwimmingUnderWater(ped) then
                breath = GetPlayerSprintTimeRemaining(PlayerId()) * 10
            end
            SendNUIMessage({
                action = "HudInfo", 
                health = health,
                armour = armour,
                thirst = thirst,
                hunger = hunger,
                breath = breath,
                voiceLevel = voiceLevel,
                talkingStatus = talkingStatus,
                chekHudActive = chekHudActive,
            })
            chekHudActive = false
        end
    until (vibelife2)
end)


RegisterKeyMapping("huded", "Pokaz/ukryj HUD", "MOUSE_BUTTON", "MOUSE_MIDDLE")

RegisterCommand("huded", function()
    SendNUIMessage({
        action = "hidehjud"
    })
end)



local OnMinimap = true

RegisterNUICallback('Minimap', function(data)
    OnMinimap = data.map
end)

Citizen.CreateThread(function()
    Citizen.Wait(100)
    repeat
        Citizen.Wait(150)
        Player = ESX.GetPlayerData()
        playerPed = PlayerPedId()
        isInVehicle = IsPedInAnyVehicle(playerPed, false)
        playerCoords =  GetEntityCoords(playerPed)
        if isInVehicle then 
            fuel = GetVehicleFuelLevel(Vechicle)
            street = GetStreetNameAtCoord(playerCoords.x,playerCoords.y,playerCoords.z)
            region = zones[GetNameOfZone(playerCoords.x, playerCoords.y, playerCoords.z)]
            streetName = GetStreetNameFromHashKey(street)
            gearCount = GetVehicleCurrentGear(Vechicle)
            local heading = GetEntityHeading(playerPed)
            if heading >= 315 or heading < 45 then
                direction = "N"
            elseif heading >= 45 and heading < 135 then
                direction = "E"
            elseif heading >= 135 and heading < 225 then
                direction = "S"
            elseif heading >= 225 and heading < 315 then
                direction = "W"
            end

            local coordsiu = GetEntityCoords(Vechicle);
            currentStreet = GetStreetNameFromHashKey(GetStreetNameAtCoord(coordsiu.x, coordsiu.y, coordsiu.z));
            
            Vechicle = GetVehiclePedIsIn(playerPed, false)
            speed = math.floor((GetEntitySpeed(Vechicle)*2.236936))
            carhud = true
            DisplayRadar(OnMinimap)
            SendNUIMessage({
                action = "UpdateCarHud",
                speed = speed,
                gearCount = gearCount,
                direction = direction,
                carhud = carhud,
                region = region,
                street = streetName,
                fuel = fuel,
            });
        else
            carhud = false
            SendNUIMessage({
                action = "UpdateCarHud",
                carhud = carhud,
            });
            DisplayRadar(false)
        end
    until (vibelife3)
end)










Citizen.CreateThread(function()
    Citizen.Wait(500)
    repeat
        Citizen.Wait(500)
        playerPed = PlayerPedId()
        isInVehicle = IsPedInAnyVehicle(playerPed, false)
        playerCoords =  GetEntityCoords(playerPed)
        if isInVehicle then 
            local coordsiu = GetEntityCoords(Vechicle);
            currentStreet = GetStreetNameFromHashKey(GetStreetNameAtCoord(coordsiu.x, coordsiu.y, coordsiu.z));
            
            if IsWaypointActive() then 
                Citizen.Wait(1000)

                    local blip = GetFirstBlipInfoId(8)
                    local distance = 0
                    local ghahahah = 0
                    if (blip ~= 0) then
                        local coord = GetBlipCoords(blip)
                        ghahahah = CalculateTravelDistanceBetweenPoints(GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0,-1)), coord)
                                
                        if blip ~= 0 then
                            if ghahahah ~= 0 then
                                waypointDist = ghahahah
                            else
                                waypointDist = 0
                            end
                        end
                    end


                -- local waypointCoords = GetBlipCoords(GetFirstBlipInfoId(8))
                -- local coord = GetBlipCoords(blip)
                -- waypointDist =  CalculateTravelDistanceBetweenPoints(GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0,-1)), coord) / 1000
            else
                waypointDist = 0;
            end
            SendNUIMessage({
                action = "UpdateCarHud3",
                waypointDist = waypointDist,
            });
        end
    until (vibelife3)
end)






RegisterCommand("ustawienia" , function()
    SendNUIMessage({
        action = "Settings",
    });
    SetNuiFocus(true , true)
end)







RegisterNUICallback("HideHud", function()
SetNuiFocus(false , false)
end)



RegisterNetEvent('nuifix:hud')
AddEventHandler('nuifix:hud', function()
    SendNUIMessage({
        action = "nuifix"
    })
end)

