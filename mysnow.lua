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
EquipGlove("Snow")
wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Lobby.Teleport2.CFrame
wait(3)
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local validPlayers = {}

for _, player in ipairs(Players:GetPlayers()) do
    if player == localPlayer then continue end -- Пропускаем себя
    
    local character = player.Character
    if not character then continue end -- Если нет персонажа
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then continue end -- Если мёртв
    
    local isInArena = character:FindFirstChild("isInArena")
    if not isInArena or not isInArena.Value then continue end -- Если не в арене
    
    local hasRock = character:FindFirstChild("rock")
    if hasRock then continue end -- Если есть rock
    
    table.insert(validPlayers, player) -- Добавляем подходящего игрока
end

-- Выбираем случайного игрока из подходящих
local target = validPlayers[math.random(1, #validPlayers)]
if target then
    print("Выбранный игрок:", target.Name)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
    wait(0.5)
    for i = 1, config.Power do
        game:GetService("ReplicatedStorage").SnowHit:FireServer(target.Character.HumanoidRootPart)
    end
    wait(3)
    local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local placeId = game.PlaceId
local AllIDs = {}
local foundAnything = ""

-- Загрузка посещённых серверов из файла
local fileLoaded = pcall(function()
    AllIDs = HttpService:JSONDecode(readfile("server-hop-temp.json"))
end)

if not fileLoaded then
    AllIDs = {}
    pcall(function()
        writefile("server-hop-temp.json", HttpService:JSONEncode(AllIDs))
    end)
end

-- Функция для поиска нового сервера и подключения
local function serverHop()
    local Site
    local success, response = pcall(function()
        if foundAnything == "" then
            return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"))
        else
            return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. foundAnything))
        end
    end)

    -- Если запрос не удался или ответ некорректен
    if not success or not response or not response.data then
        TeleportService:Teleport(placeId)
        return
    end

    Site = response

    if Site.nextPageCursor and Site.nextPageCursor ~= "" then
        foundAnything = Site.nextPageCursor
    end

    -- Проверяем наличие данных перед итерацией
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
                        TeleportService:TeleportToPlaceInstance(placeId, ID, player)
                    end)
                    return
                end
            end
        end
    end

    -- Если подходящий сервер не найден, телепортируем на случайный
    TeleportService:Teleport(placeId)
end
    serverHop()
else
    print("Нет подходящих игроков")
end
