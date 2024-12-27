local campfires = {} -- Tabelle für erstellte Lagerfeuer

RegisterNetEvent('prop:campfire')
AddEventHandler('prop:campfire', function()
	
    local playerPed = PlayerPedId() -- Spieler-Entity
    local playerCoords = GetEntityCoords(playerPed) -- Spieler-Koordinaten
    local forwardVector = GetEntityForwardVector(playerPed) -- Blickrichtung des Spielers

    -- Position vor dem Spieler berechnen
    local campfireX = playerCoords.x + (forwardVector.x * 2.0) -- 2.0 Meter vor dem Spieler
    local campfireY = playerCoords.y + (forwardVector.y * 2.0)
    local campfireZ = playerCoords.z

    -- Lagerfeuer-Modell laden
    local campfireModel = `P_CAMPFIRE02X` -- Modell-Hash für Lagerfeuer
    RequestModel(campfireModel)
    while not HasModelLoaded(campfireModel) do
        Wait(10)
    end

    -- Lagerfeuer platzieren
    local campfire = CreateObject(campfireModel, campfireX, campfireY, campfireZ - 1.0, true, true, false)
    PlaceObjectOnGroundProperly(campfire)
    FreezeEntityPosition(campfire, true) -- Lagerfeuer fixieren

    -- Lagerfeuer in der Tabelle speichern
    table.insert(campfires, campfire)

    -- Spieleranimation starten
    local animScenario = "WORLD_HUMAN_CAMPFIRE_SIT" -- Animation zum Sitzen am Lagerfeuer
    TaskStartScenarioInPlace(playerPed, animScenario, 0, true)

    -- Timer zum Entfernen des Lagerfeuers (optional)
    Citizen.SetTimeout(150000, function() -- Entfernt das Lagerfeuer nach 5 Minuten
        DeleteObject(campfire)
        for i, obj in ipairs(campfires) do
            if obj == campfire then
                table.remove(campfires, i)
                break
            end
        end
    end)
end, false)
