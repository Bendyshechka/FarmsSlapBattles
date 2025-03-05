local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local player = game.Players.LocalPlayer
local placeId = game.PlaceId

local teleportFunc = queueonteleport or queue_on_teleport

-- Код, который выполнится на новом сервере
local teleportScript = [[
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end
    local players = game:GetService("Players")
		local localPlayer = players.LocalPlayer  -- Получаем LocalPlayer

		local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()  -- Ждем загрузки персонажа
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")  -- Ждем загрузки HumanoidRootPart

		-- Устанавливаем новый CFrame
		humanoidRootPart.CFrame = CFrame.new(17902, -23, -3534)
		fireclickdetector(workspace.Lobby.Ghost.ClickDetector)
    task.wait(0.3)
    fireclickdetector(workspace.Lobby.Ghost.ClickDetector)
    task.wait(0.3)
    game.ReplicatedStorage.Ghostinvisibilityactivated:FireServer()

    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local player = game.Players.LocalPlayer
    local placeId = game.PlaceId
    local AllIDs = {}

    local function loadServerList()
        local success, result = pcall(function()
            return HttpService:JSONDecode(readfile("server-hop-temp.json"))
        end)
        if success and type(result) == "table" then
            AllIDs = result
        else
            AllIDs = {}
            writefile("server-hop-temp.json", HttpService:JSONEncode(AllIDs))
        end
    end

    local function saveServerList()
        writefile("server-hop-temp.json", HttpService:JSONEncode(AllIDs))
    end

    local function serverHop()
        loadServerList()
        local Site = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"))

        for _, v in pairs(Site.data) do
            local ID = tostring(v.id)
            local Possible = true

            if tonumber(v.playing) < tonumber(v.maxPlayers) then
                for _, Existing in pairs(AllIDs) do
                    if ID == tostring(Existing) then
                        Possible = false
                        break
                    end
                end

                if Possible then
                    table.insert(AllIDs, ID)
                    saveServerList()
                    TeleportService:TeleportToPlaceInstance(placeId, ID, player)
                    return
                end
            end
        end

        TeleportService:Teleport(placeId)
    end

    task.spawn(function()
        task.wait(0.3)
        replicatedStorage.Ghostinvisibilityactivated:FireServer()
        task.wait(0.3)
        workspace.Lobby.Boxer.ClickDetector.MaxActivationDistance = 1000
        fireclickdetector(workspace.Lobby.Boxer.ClickDetector)
        while true do
            game:GetService("ReplicatedStorage").Events.Boxing:FireServer(game.Players.LocalPlayer.Character.HumanoidRootPart)
            task.wait(0.001)
        end
    end)

    task.spawn(function()
        while true do
            task.wait(1)
            local leaderstats = player:FindFirstChild("leaderstats")
            if leaderstats then
                local slaps = leaderstats:FindFirstChild("Slaps")
                if slaps and slaps.Value >= 1000000 then
                    local nextMilestone = math.floor(slaps.Value / 100000) * 100000 + 100000
                    if nextMilestone - slaps.Value <= 500 then
			wait(1)
                        serverHop()
                    end
                end
            end
        end
    end)
]]

if teleportFunc then
    teleportFunc(teleportScript)
end

loadstring(teleportScript)()
