local teleportConnection = nil

-- Функция для активации/деактивации закрепления
local function toggleAnchor(enable)
    if teleportConnection then
        teleportConnection:Disconnect()
        teleportConnection = nil
    end
    
    if enable then
        teleportConnection = game:GetService("RunService").Heartbeat:Connect(function()
            local player = game.Players.LocalPlayer
            if player.Character then
                local root = player.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    root.CFrame = CFrame.new(17902, -15, -3534)
                end
            end
        end)
    end
end

local currentJobId = game.JobId
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")

-- Проверяем, есть ли этот сервер в списке для избегания
local AllIDs = {}
local fileLoaded = pcall(function()
    AllIDs = HttpService:JSONDecode(readfile("server-hp-temp.json"))
end)

if not fileLoaded then
    AllIDs = {}
    pcall(function()
        writefile("server-hp-temp.json", HttpService:JSONEncode(AllIDs))
    end)
end

-- Если сервер уже в списке, делаем мгновенный сервер-хоп
local shouldHop = false
for _, serverId in pairs(AllIDs) do
    if tostring(serverId) == currentJobId then
        shouldHop = true
        break
    end
end

-- Улучшенная функция сервер-хопа (полностью рандомный сервер)
local function RandomServerHop()
    local placeId = game.PlaceId
    local cursor = ""
    local servers = {}

    -- Собираем все доступные серверы
    while true do
        local success, response = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(
                "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100" .. 
                (cursor ~= "" and "&cursor=" .. cursor or "")
            ))
        end)

        if not success or not response or not response.data then
            break
        end

        for _, server in ipairs(response.data) do
            table.insert(servers, tostring(server.id))
        end

        if not response.nextPageCursor or response.nextPageCursor == "" then
            break
        else
            cursor = response.nextPageCursor
        end
    end

    -- Если серверы найдены, выбираем случайный
    if #servers > 0 then
        local randomServer = servers[math.random(1, #servers)]
        TeleportService:TeleportToPlaceInstance(placeId, randomServer, Players.LocalPlayer)
    else
        -- Если не удалось получить серверы, просто телепортируем в основное место
        TeleportService:Teleport(placeId)
    end
end

if shouldHop then
    print("Сервер уже в списке, выполняем сервер-хоп...")
    RandomServerHop()
    return -- Прерываем выполнение остального скрипта
end

print("Новый сервер, продолжаем выполнение...")
task.spawn(function()
    toggleAnchor(true)
end)
workspace:WaitForChild("TournamentIsland").Name = "TournamentIsland"
task.spawn(function()
    toggleAnchor(false)
end)
wait(1)
game:GetService("ReplicatedStorage").Events.Tournament.TournamentResponse:FireServer(true)
wait(5)
task.spawn(function()
    toggleAnchor(true)
end)
wait(1)
game:GetService("ReplicatedStorage").RunMasteryAbility:FireServer()
wait(12)
for _, obj in pairs(game.Players:GetPlayers()) do
					if obj.Name ~= game.Players.LocalPlayer.Name then
						obj.Character.HumanoidRootPart:PivotTo(game.Players.LocalPlayer.Character.Skull.Hitbox.CFrame)
					end
				end

wait(1)
-- В любом случае делаем сервер-хоп (если сервер новый, добавляем его в список)
table.insert(AllIDs, currentJobId)
pcall(function()
    writefile("server-hp-temp.json", HttpService:JSONEncode(AllIDs))
end)

print("Выполняем сервер-хоп...")
RandomServerHop()
