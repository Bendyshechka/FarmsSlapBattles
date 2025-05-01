if game.Workspace:FindFirstChild("Sigma") == nil then
    local s = Instance.new("Model", game.Workspace)
    s.Name = "Sigma"
    print("text")
else
    return
end

local teleportConnection = nil
local function EquipGlove(Glove)
	for i, v in pairs(game:GetService("ReplicatedStorage")._NETWORK:GetChildren()) do
      -- Check if the name contains the character '{'
      if v.Name:find("{") then
          local args = {
              [1] = Glove,
			  [2] = true
          }
  
          -- Check if v is a RemoteEvent and can FireServer
          if v:IsA("RemoteEvent") then
              v:FireServer(unpack(args))
          elseif v:IsA("RemoteFunction") then
              -- If it's a RemoteFunction, use InvokeServer
              local result = v:InvokeServer(unpack(args))
              print("Result from InvokeServer:", result)  -- Optional: Print the result
          else
              print("v is neither a RemoteEvent nor a RemoteFunction.")
          end
      end
  end
end

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
local MAX_HISTORY = 20 -- Макс. сохранённых серверов (чтобы файл не рос бесконечно)
local MIN_PLAYERS = 7  -- Минимум игроков на сервере
local MAX_PLAYER_PERCENT = 0.85 -- Макс. заполненность сервера (85%)

local function RandomServerHop()
    local placeId = game.PlaceId
    local cursor = ""
    local servers = {}
    local suitableServers = {}

    -- Загружаем историю серверов
    local AllIDs = {}
    local fileLoaded = pcall(function()
        AllIDs = HttpService:JSONDecode(readfile("server-hp-temp.json")) or {}
    end)

    -- Очищаем старые записи (если их больше MAX_HISTORY)
    if #AllIDs > MAX_HISTORY then
        local overflow = #AllIDs - MAX_HISTORY
        table.move(AllIDs, overflow + 1, #AllIDs, 1)
        for i = 1, overflow do
            table.remove(AllIDs)
        end
        pcall(function()
            writefile("server-hp-temp.json", HttpService:JSONEncode(AllIDs))
        end)
    end

    -- Собираем серверы с API
    while true do
        local success, response = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(
                "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100" .. 
                (cursor ~= "" and "&cursor=" .. cursor or ""),
                true
            ))
        end)

        if not success or not response or not response.data then
            warn("⚠️ Ошибка загрузки серверов: " .. (response and tostring(response) or "unknown"))
            break
        end

        -- Фильтруем серверы: не пустые, не полные, не посещённые ранее
        for _, server in ipairs(response.data) do
            local serverId = tostring(server.id)
            local playing = tonumber(server.playing) or 0
            local maxPlayers = tonumber(server.maxPlayers) or 16 -- дефолтный лимит

            -- Проверяем, подходит ли сервер
            local isSuitable = (
                playing >= MIN_PLAYERS and
                playing <= (maxPlayers * MAX_PLAYER_PERCENT) and
                not table.find(AllIDs, serverId)
            )

            if isSuitable then
                table.insert(suitableServers, {
                    id = serverId,
                    players = playing
                })
            end
        end

        if not response.nextPageCursor then break end
        cursor = response.nextPageCursor
    end

    -- Выбираем сервер:
    local targetServerId
    if #suitableServers > 0 then
        -- Предпочитаем серверы с игроками (но не самые заполненные)
        table.sort(suitableServers, function(a, b)
            return a.players > b.players
        end)
        local topN = math.min(5, #suitableServers) -- Берём из топ-5
        targetServerId = suitableServers[math.random(1, topN)].id
    elseif #servers > 0 then
        -- Если нет подходящих — случайный из всех
        targetServerId = servers[math.random(1, #servers)]
    end

    -- Телепортируемся
    if targetServerId then
        TeleportService:TeleportToPlaceInstance(placeId, targetServerId, Players.LocalPlayer)
    else
        TeleportService:Teleport(placeId) -- Фолбэк
    end
end

if shouldHop then
    print("Сервер уже в списке, выполняем сервер-хоп...")
    RandomServerHop()
    return -- Прерываем выполнение остального скрипта
end

print("Новый сервер, продолжаем выполнение...")
-- В любом случае делаем сервер-хоп (если сервер новый, добавляем его в список)
task.spawn(function()
    EquipGlove("Run")
    toggleAnchor(true)
    wait(1)
    game:GetService("ReplicatedStorage").RunMasteryAbility:FireServer()
    wait(1)
    EquipGlove("Diamond")
end)
workspace:WaitForChild("TournamentIsland").Name = "TournamentIsland"
table.insert(AllIDs, currentJobId)
pcall(function()
    writefile("server-hp-temp.json", HttpService:JSONEncode(AllIDs))
end)
task.spawn(function()
    EquipGlove("Diamond")
    toggleAnchor(false)
end)
wait(1)
game:GetService("ReplicatedStorage").Events.Tournament.TournamentResponse:FireServer(true)
wait(5)
task.spawn(function()
    toggleAnchor(true)
end)
wait(1)
wait(12)
task.spawn(function()
    for _, obj in pairs(game.Players:GetPlayers()) do
					if obj.Name ~= game.Players.LocalPlayer.Name and obj.Character:FindFirstChild("rock") == nil and obj.Character.Humanoid.Sit == false then
						obj.Character.HumanoidRootPart:PivotTo(game.Players.LocalPlayer.Character:FindFirstChild("Skull"):FindFirstChild("Hitbox").CFrame)
					end
				end
end)

wait(1)

print("Выполняем сервер-хоп...")
RandomServerHop()
