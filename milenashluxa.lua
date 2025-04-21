-- Ожидаем загрузку основных сервисов
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")

-- Ожидаем загрузку игрока
local localPlayer = Players.LocalPlayer -- Ждём появление персонажа
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

-- Ждём загрузку HumanoidRootPart (на случай, если персонаж ещё не полностью загрузился)
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Конфиг

-- Функция для надежного экипирования перчатки
local function EquipGlove(Glove)
    -- Ожидаем загрузку _NETWORK
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

-- Телепортируемся в лобби (с проверкой всех частей пути)
local lobby = Workspace:WaitForChild("Lobby")
local teleport1 = lobby:WaitForChild("Teleport1")
humanoidRootPart.CFrame = teleport1.CFrame
task.wait(1)

-- Собираем яблоки (с проверкой всех частей)
local arena = Workspace:WaitForChild("Arena")
local island5 = arena:WaitForChild("island5")
local slapples = island5:WaitForChild("Slapples")

for _, obj in pairs(slapples:GetChildren()) do
    local glove = obj:FindFirstChild("Glove") -- FindFirstChild, а не WaitForChild, потому что не у всех объектов он есть
    if glove then
        glove.CFrame = humanoidRootPart.CFrame
    end
end

task.wait(2)

-- Ищем подходящего игрока для атаки
local validPlayers = {}

for _, player in ipairs(Players:GetPlayers()) do
    if player == localPlayer then continue end
    
    -- Ожидаем загрузку персонажа (если его нет)
    local targetCharacter = player.Character
    
    
    -- Проверяем, в арене ли игрок
    local isInArena = targetCharacter:WaitForChild("isInArena")
    if not isInArena.Value then continue end
    
    -- Проверяем, есть ли у него камень (rock)
    if targetCharacter:FindFirstChild("rock") then continue end
    
    table.insert(validPlayers, player)
end

if #validPlayers > 0 then
    local target = validPlayers[math.random(1, #validPlayers)]
    print("Выбранный игрок:", target.Name)
    
    -- Ожидаем загрузку его персонажа (на всякий случай)
    local targetCharacter = target.Character
    local targetRoot = targetCharacter:WaitForChild("HumanoidRootPart")
    
    -- Телепортируемся к нему и атакуем
    task.spawn(function()
        while true do
            humanoidRootPart.CFrame = targetRoot.CFrame
            wait(0.5)
        end
    end)
    
    task.wait(0.5)
    
    -- Атакуем SnowHit'ами
    local snowHit = game.ReplicatedStorage.SnowHit
    for i = 1, 70 do
        snowHit:FireServer(targetRoot)
    end
    
    task.wait(3)
    
    -- Сервер-хоп
    local placeId = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    
    -- Загрузка списка серверов
    local fileLoaded = pcall(function()
        AllIDs = HttpService:JSONDecode(readfile("server-hop-temp.json"))
    end)
    
    if not fileLoaded then
        AllIDs = {}
        pcall(function()
            writefile("server-hop-temp.json", HttpService:JSONEncode(AllIDs))
        end)
    end
    
    -- Функция для поиска сервера
    local function serverHop()
        local Site
        local success, response = pcall(function()
            if foundAnything == "" then
                return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"))
            else
                return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. foundAnything))
            end
        end)
        
        if not success or not response or not response.data then
            TeleportService:Teleport(placeId)
            return
        end
        
        Site = response
        
        if Site.nextPageCursor and Site.nextPageCursor ~= "" then
            foundAnything = Site.nextPageCursor
        end
        
        if Site.data then
            for _, v in pairs(Site.data) do
                local ID = tostring(v.id)
                local Possible = true
                
                if tonumber(v.maxPlayers) < tonumber(v.playing) then
                    for _, Existing in pairs(AllIDs) do
                        if ID == tostring(Existing) then
                            Possible = false
                            break
                        end
                    end
                    
                    if Possible then
                        table.insert(AllIDs, ID)
                        pcall(function()
                            writefile("server-hop-temp.json", HttpService:JSONEncode(AllIDs))
                            TeleportService:TeleportToPlaceInstance(placeId, ID, localPlayer)
                        end)
                        return
                    end
                end
            end
        end
        
        TeleportService:Teleport(placeId)
    end
    
    serverHop()
else
    warn("Нет подходящих игроков для атаки!")
end
