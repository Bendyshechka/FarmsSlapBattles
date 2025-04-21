local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")

-- Получаем текущий JobId (идентификатор сервера)
local currentJobId = game.JobId

-- Проверяем, есть ли этот сервер в списке для избегания
local AllIDs = {}
local fileLoaded = pcall(function()
    AllIDs = HttpService:JSONDecode(readfile("server-hop-temp.json"))
end)

if not fileLoaded then
    AllIDs = {}
    pcall(function()
        writefile("server-hop-temp.json", HttpService:JSONEncode(AllIDs))
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

-- Ожидаем загрузку игрока
local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Функция для надежного экипирования перчатки
local function EquipGlove(Glove)
    local networkFolder = ReplicatedStorage:WaitForChild("_NETWORK")
    
    for _, v in pairs(networkFolder:GetChildren()) do
        if v.Name:find("{") then
            local args = {
                [1] = Glove,
                [2] = true
            }
            
            if v:IsA("RemoteEvent") then
                v:FireServer(unpack(args))
            elseif v:IsA("RemoteFunction") then
                local result = v:InvokeServer(unpack(args))
                print("Result from InvokeServer:", result)
            else
                warn("v is neither a RemoteEvent nor a RemoteFunction:", v:GetFullName())
            end
        end
    end
end

-- Экипируем перчатку
EquipGlove("Snow")
task.wait(1)

-- Телепортируемся в лобби
local lobby = Workspace:WaitForChild("Lobby")
local teleport1 = lobby:WaitForChild("Teleport1")
humanoidRootPart.CFrame = teleport1.CFrame
task.wait(1)

-- Собираем яблоки
local arena = Workspace:WaitForChild("Arena")
local island5 = arena:WaitForChild("island5")
local slapples = island5:WaitForChild("Slapples")

for _, obj in pairs(slapples:GetChildren()) do
    local glove = obj:FindFirstChild("Glove")
    if glove then
        glove.CFrame = humanoidRootPart.CFrame
    end
end

task.wait(2)

-- Ищем подходящего игрока для атаки
local validPlayers = {}

for _, player in ipairs(Players:GetPlayers()) do
    if player == localPlayer then continue end
    
    local targetCharacter = player.Character
    if not targetCharacter then continue end
    
    local isInArena = targetCharacter:WaitForChild("isInArena")
    if not isInArena.Value then continue end
    
    if targetCharacter:FindFirstChild("rock") then continue end
    
    table.insert(validPlayers, player)
end

if #validPlayers > 0 then
    local target = validPlayers[math.random(1, #validPlayers)]
    print("Выбранный игрок:", target.Name)
    
    local targetCharacter = target.Character
    local targetRoot = targetCharacter:WaitForChild("HumanoidRootPart")
    
    task.spawn(function()
        while true do
            humanoidRootPart.CFrame = targetRoot.CFrame
            task.wait(0.1)
        end
    end)
    
    task.wait(0.5)
    
    local snowHit = game.ReplicatedStorage.SnowHit
    for i = 1, 70 do
        snowHit:FireServer(targetRoot)
    end
    
    task.wait(3)
else
    warn("Нет подходящих игроков для атаки!")
end

-- В любом случае делаем сервер-хоп (если сервер новый, добавляем его в список)
table.insert(AllIDs, currentJobId)
pcall(function()
    writefile("server-hop-temp.json", HttpService:JSONEncode(AllIDs))
end)

print("Выполняем сервер-хоп...")
RandomServerHop()
