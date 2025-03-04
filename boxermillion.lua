local player = game.Players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats")
local slaps = leaderstats:WaitForChild("Slaps")
local teleportService = game:GetService("TeleportService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local httpService = game:GetService("HttpService")
local placeId = game.PlaceId -- ID текущего плейса
local foundAnything = ""

-- Загружаем список посещённых серверов
local AllIDs
local fileLoaded = pcall(function()
    AllIDs = httpService:JSONDecode(readfile("server-hop-temp.json"))
end)

if not fileLoaded then
    AllIDs = {}
    pcall(function()
        writefile("server-hop-temp.json", httpService:JSONEncode(AllIDs))
    end)
end

-- Функция для поиска нового сервера и подключения
local function serverHop()
    local Site
    if foundAnything == "" then
        Site = httpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"))
    else
        Site = httpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. foundAnything))
    end

    if Site.nextPageCursor then
        foundAnything = Site.nextPageCursor
    end

    for _, v in pairs(Site.data) do
        local ID = tostring(v.id)
        local Possible = true

        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _, Existing in pairs(AllIDs) do
                if ID == tostring(Existing) then
                    Possible = false
                    break
                end
            end

            if Possible then
                table.insert(AllIDs, ID)
                pcall(function()
                    writefile("server-hop-temp.json", httpService:JSONEncode(AllIDs))
                    teleportService:TeleportToPlaceInstance(placeId, ID, player)
                end)
                return
            end
        end
    end

    -- Если подходящий сервер не найден, телепортируем на случайный
    teleportService:Teleport(placeId)
end

-- Функция активации Ghost Mode
local function activateGhostMode()
    local ghostClickDetector = workspace.Lobby.Ghost:FindFirstChild("ClickDetector")
    if ghostClickDetector then
        fireclickdetector(ghostClickDetector)
        task.wait(0.3)
        replicatedStorage.Ghostinvisibilityactivated:FireServer()
        task.wait(0.3)
        fireclickdetector(workspace.Lobby.Boxer.ClickDetector)
    else
        print("ClickDetector для Ghost не найден!")
    end
end

-- Функция фарма
local function startFarming()
    while true do
        replicatedStorage.Events.Boxing:FireServer(player.Character.HumanoidRootPart)
        task.wait(0.001)  
        local currentSlaps = slaps.Value
        local nextMilestone = math.floor(currentSlaps / 100000) * 100000 + 100000
        if nextMilestone - currentSlaps <= 500 then
            wait(1)
            print("Осталось 500 до " .. nextMilestone .. ", делаем серверхоп...")

            queue_on_teleport([[
                wait(5)  -- Ждём загрузку
                local player = game.Players.LocalPlayer
                local leaderstats = player:WaitForChild("leaderstats")
                local slaps = leaderstats:WaitForChild("Slaps")
                local teleportService = game:GetService("TeleportService")
                local replicatedStorage = game:GetService("ReplicatedStorage")
                local httpService = game:GetService("HttpService")
                local placeId = game.PlaceId
                local foundAnything = ""

                -- Загружаем список посещённых серверов
                local AllIDs
                local fileLoaded = pcall(function()
                    AllIDs = httpService:JSONDecode(readfile("server-hop-temp.json"))
                end)

                if not fileLoaded then
                    AllIDs = {}
                    pcall(function()
                        writefile("server-hop-temp.json", httpService:JSONEncode(AllIDs))
                    end)
                end

                -- Функция для поиска нового сервера
                local function serverHop()
                    local Site
                    if foundAnything == "" then
                        Site = httpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"))
                    else
                        Site = httpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. foundAnything))
                    end

                    if Site.nextPageCursor then
                        foundAnything = Site.nextPageCursor
                    end

                    for _, v in pairs(Site.data) do
                        local ID = tostring(v.id)
                        local Possible = true

                        if tonumber(v.maxPlayers) > tonumber(v.playing) then
                            for _, Existing in pairs(AllIDs) do
                                if ID == tostring(Existing) then
                                    Possible = false
                                    break
                                end
                            end

                            if Possible then
                                table.insert(AllIDs, ID)
                                pcall(function()
                                    writefile("server-hop-temp.json", httpService:JSONEncode(AllIDs))
                                    teleportService:TeleportToPlaceInstance(placeId, ID, player)
                                end)
                                return
                            end
                        end
                    end

                    -- Если подходящий сервер не найден, телепортируем на случайный
                    teleportService:Teleport(placeId)
                end

                -- Функция активации Ghost Mode
                local function activateGhostMode()
                    local ghostClickDetector = workspace.Lobby.Ghost:FindFirstChild("ClickDetector")
                    if ghostClickDetector then
                        fireclickdetector(ghostClickDetector)
                        task.wait(0.3)
                        replicatedStorage.Ghostinvisibilityactivated:FireServer()
                        task.wait(0.3)
                        fireclickdetector(workspace.Lobby.Boxer.ClickDetector)
                    else
                        print("ClickDetector для Ghost не найден!")
                    end
                end

                -- Функция фарма
                local function startFarming()
                    while true do
                        replicatedStorage.Events.Boxing:FireServer(player.Character.HumanoidRootPart)
                        task.wait(0.001)
                        local currentSlaps = slaps.Value
                        local nextMilestone = math.floor(currentSlaps / 100000) * 100000 + 100000
                        if nextMilestone - currentSlaps <= 500 then
                            print("Осталось 500 до " .. nextMilestone .. ", делаем серверхоп...")
                            wait(1)
                            queue_on_teleport(_G.script)
                            serverHop()
                            break
                        end
                    end
                end

                activateGhostMode()
                startFarming()
            ]])

            serverHop() -- Запускаем новый серверхоп
            break
        end
    end
end

activateGhostMode()
startFarming()
