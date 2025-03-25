game.Workspace:WaitForChild(game.Players.LocalPlayer.Name):WaitForChild("HumanoidRootPart").CFrame = game.Workspace:WaitForChild("Lobby"):WaitForChild("Teleport1").CFrame
wait(0.5)
for _, obj in pairs(game.Workspace:WaitForChild("Arena"):WaitForChild("island5"):WaitForChild("Slapples"):GetChildren()) do
    if obj:FindFirstChild("Glove") then
        obj:FindFirstChild("Glove").CFrame = game.Workspace:WaitForChild(game.Players.LocalPlayer.Name):WaitForChild("HumanoidRootPart").CFrame
    end
end
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
wait(1)
serverHop()
