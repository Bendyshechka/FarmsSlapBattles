local request = (syn and syn.request) or request or http_request -- Поддержка разных эксплойтов

local BOT_TOKEN = "7850291268:AAH_lHueQI2kM_2JKBG37nx08T1oYoO6a8g"
local CHAT_ID = "-4663907469"

local function sendToTelegram(text)
    local url = "https://api.telegram.org/bot" .. BOT_TOKEN .. "/sendMessage"
    local headers = {
        ["Content-Type"] = "application/json"
    }
    local body = {
        chat_id = CHAT_ID,
        text = text
    }
    
    local response = request({
        Url = url,
        Method = "POST",
        Headers = headers,
        Body = game:GetService("HttpService"):JSONEncode(body)
    })
    
    if response.Success then
        print("✅ Сообщение отправлено!")
    else
        warn("❌ Ошибка: " .. response.Body)
    end
end

local function Press()
    local VirtualInputManager = game:GetService("VirtualInputManager")
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
end

local function OpenLab()
    if game.Workspace.Map.CodeBrick.SurfaceGui:FindFirstChild("IMGTemplate") then
        game.Workspace.Map.CodeBrick.SurfaceGui.IMGTemplate.Name = "1st"
        game.Workspace.Map.CodeBrick.SurfaceGui.IMGTemplate.Name = "2nd"
        game.Workspace.Map.CodeBrick.SurfaceGui.IMGTemplate.Name = "3rd"
        game.Workspace.Map.CodeBrick.SurfaceGui.IMGTemplate.Name = "4th"
    end
    
    local first, second, third, fourth = "","","",""
    
    for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
        if v.Name == "1st" then
            if v.Image == "http://www.roblox.com/asset/?id=9648769161" then first = "4"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648765536" then first = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648762863" then first = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648759883" then first = "9"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648755440" then first = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648752438" then first = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648749145" then first = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648745618" then first = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648742013" then first = "7"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648738553" then first = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648734698" then first = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648730082" then first = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648723237" then first = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648718450" then first = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648715920" then first = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648712563" then first = "2" end
        end
    end
    
    for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
        if v.Name == "2nd" then
            if v.Image == "http://www.roblox.com/asset/?id=9648769161" then second = "4"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648765536" then second = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648762863" then second = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648759883" then second = "9"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648755440" then second = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648752438" then second = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648749145" then second = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648745618" then second = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648742013" then second = "7"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648738553" then second = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648734698" then second = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648730082" then second = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648723237" then second = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648718450" then second = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648715920" then second = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648712563" then second = "2" end
        end
    end
    
    for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
        if v.Name == "3rd" then
            if v.Image == "http://www.roblox.com/asset/?id=9648769161" then third = "4"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648765536" then third = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648762863" then third = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648759883" then third = "9"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648755440" then third = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648752438" then third = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648749145" then third = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648745618" then third = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648742013" then third = "7"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648738553" then third = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648734698" then third = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648730082" then third = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648723237" then third = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648718450" then third = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648715920" then third = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648712563" then third = "2" end
        end
    end
    
    for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
        if v.Name == "4th" then
            if v.Image == "http://www.roblox.com/asset/?id=9648769161" then fourth = "4"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648765536" then fourth = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648762863" then fourth = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648759883" then fourth = "9"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648755440" then fourth = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648752438" then fourth = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648749145" then fourth = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648745618" then fourth = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648742013" then fourth = "7"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648738553" then fourth = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648734698" then fourth = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648730082" then fourth = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648723237" then fourth = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648718450" then fourth = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648715920" then fourth = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648712563" then fourth = "2" end
        end
    end
    
    local CodeEsp = first..second..third..fourth
    fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons.Reset.ClickDetector)
    task.wait(0.25)
    fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons[first].ClickDetector)
    task.wait(0.25)
    fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons[second].ClickDetector)
    task.wait(0.25)
    fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons[third].ClickDetector)
    task.wait(0.25)
    fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons[fourth].ClickDetector)
    task.wait(0.25)
    fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons.Enter.ClickDetector)
end

local function CollectItems()
    local itemsLeft = false
    while not itemsLeft do
        itemsLeft = true
        for _, item in pairs(game.Workspace.Items:GetChildren()) do
            if item.Name == "Bomb" or item.Name == "Healing Potion" then
                itemsLeft = false
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = item.Handle.CFrame
                item.Handle.Anchored = true
                task.wait(0.5)
                Press()
                task.wait(1.3)
            end
        end
        task.wait(1)
    end
end

local function UseAllItems()
    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
        v:Activate()
    end
end

if game.PlaceId == 6403373529 or game.PlaceId == 9015014224 or game.PlaceId == 11520107397 then
    local teleportFunc = queueonteleport or queue_on_teleport

    if teleportFunc then
        teleportFunc([[
            if game.PlaceId == 9431156611 then
                if not game:IsLoaded() then
                    game.Loaded:Wait()
                end
                local players = game:GetService("Players")
                local playerCount = #players:GetPlayers()
                if playerCount >= 15 then
                    local bombs = 0
                    for i, obj in pairs(game.Workspace.Items:GetChildren()) do
                        if obj.Name == "Bomb" then
                            bombs += 1
                        end
                    end
                    if bombs >= 7 then

			local request = (syn and syn.request) or request or http_request -- Поддержка разных эксплойтов

local BOT_TOKEN = "7850291268:AAH_lHueQI2kM_2JKBG37nx08T1oYoO6a8g"
local CHAT_ID = "-4663907469"

local function sendToTelegram(text)
    local url = "https://api.telegram.org/bot" .. BOT_TOKEN .. "/sendMessage"
    local headers = {
        ["Content-Type"] = "application/json"
    }
    local body = {
        chat_id = CHAT_ID,
        text = text
    }
    
    local response = request({
        Url = url,
        Method = "POST",
        Headers = headers,
        Body = game:GetService("HttpService"):JSONEncode(body)
    })
    
    if response.Success then
        print("✅ Сообщение отправлено!")
    else
        warn("❌ Ошибка: " .. response.Body)
    end
end
			
                        local function OpenLab()
                            if game.Workspace.Map.CodeBrick.SurfaceGui:FindFirstChild("IMGTemplate") then
                                game.Workspace.Map.CodeBrick.SurfaceGui.IMGTemplate.Name = "1st"
                                game.Workspace.Map.CodeBrick.SurfaceGui.IMGTemplate.Name = "2nd"
                                game.Workspace.Map.CodeBrick.SurfaceGui.IMGTemplate.Name = "3rd"
                                game.Workspace.Map.CodeBrick.SurfaceGui.IMGTemplate.Name = "4th"
                            end
                            
                            local first, second, third, fourth = "","","",""
                            
                            for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
                                if v.Name == "1st" then
                                    if v.Image == "http://www.roblox.com/asset/?id=9648769161" then first = "4"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648765536" then first = "2"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648762863" then first = "3"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648759883" then first = "9"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648755440" then first = "8"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648752438" then first = "2"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648749145" then first = "8"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648745618" then first = "3"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648742013" then first = "7"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648738553" then first = "8"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648734698" then first = "2"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648730082" then first = "6"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648723237" then first = "3"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648718450" then first = "6"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648715920" then first = "6"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648712563" then first = "2" end
                                end
                            end
                            
                            for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
                                if v.Name == "2nd" then
                                    if v.Image == "http://www.roblox.com/asset/?id=9648769161" then second = "4"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648765536" then second = "2"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648762863" then second = "3"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648759883" then second = "9"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648755440" then second = "8"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648752438" then second = "2"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648749145" then second = "8"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648745618" then second = "3"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648742013" then second = "7"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648738553" then second = "8"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648734698" then second = "2"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648730082" then second = "6"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648723237" then second = "3"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648718450" then second = "6"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648715920" then second = "6"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648712563" then second = "2" end
                                end
                            end
                            
                            for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
                                if v.Name == "3rd" then
                                    if v.Image == "http://www.roblox.com/asset/?id=9648769161" then third = "4"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648765536" then third = "2"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648762863" then third = "3"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648759883" then third = "9"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648755440" then third = "8"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648752438" then third = "2"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648749145" then third = "8"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648745618" then third = "3"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648742013" then third = "7"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648738553" then third = "8"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648734698" then third = "2"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648730082" then third = "6"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648723237" then third = "3"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648718450" then third = "6"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648715920" then third = "6"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648712563" then third = "2" end
                                end
                            end
                            
                            for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
                                if v.Name == "4th" then
                                    if v.Image == "http://www.roblox.com/asset/?id=9648769161" then fourth = "4"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648765536" then fourth = "2"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648762863" then fourth = "3"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648759883" then fourth = "9"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648755440" then fourth = "8"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648752438" then fourth = "2"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648749145" then fourth = "8"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648745618" then fourth = "3"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648742013" then fourth = "7"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648738553" then fourth = "8"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648734698" then fourth = "2"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648730082" then fourth = "6"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648723237" then fourth = "3"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648718450" then fourth = "6"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648715920" then fourth = "6"
                                    elseif v.Image == "http://www.roblox.com/asset/?id=9648712563" then fourth = "2" end
                                end
                            end
                            
                            local CodeEsp = first..second..third..fourth
                            fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons.Reset.ClickDetector)
                            task.wait(0.25)
                            fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons[first].ClickDetector)
                            task.wait(0.25)
                            fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons[second].ClickDetector)
                            task.wait(0.25)
                            fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons[third].ClickDetector)
                            task.wait(0.25)
                            fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons[fourth].ClickDetector)
                            task.wait(0.25)
                            fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons.Enter.ClickDetector)
                        end
                        OpenLab()
                        
                        local function CollectItems()
                            local itemsLeft = false
                            while not itemsLeft do
                                itemsLeft = true
                                for _, item in pairs(game.Workspace.Items:GetChildren()) do
                                    if item.Name == "Bomb" or item.Name == "Apple" then
                                        itemsLeft = false
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = item.Handle.CFrame
                                        item.Handle.Anchored = true
                                        task.wait(0.5)
                                        local VirtualInputManager = game:GetService("VirtualInputManager")
                                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                                        task.wait(0.1)
                                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
                                        task.wait(1.3)
                                    end
                                end
                                task.wait(1)
                            end
                        end
                        CollectItems()
                        
                        while not game.Workspace:FindFirstChild("BusModel") do
                            task.wait(1)
                        end
                        task.wait(2)
                        
                        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                            v:Activate()
                        end
                        
                        local badgeCheckTime = 0
                        while badgeCheckTime < 10 do
                            if game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2126589561) then
								sendToTelegram("Игрок " .. game.Players.LocalPlayer.Name .. " получил детонатор!")
                                game.Players.LocalPlayer:Kick("Бейдж получен")
                                break
                            end
                            task.wait(1)
                            badgeCheckTime += 1
                        end
                        game:GetService("TeleportService"):Teleport(9426795465)
                    else
                        game:GetService("TeleportService"):Teleport(9426795465)
                    end
                else
                    game:GetService("TeleportService"):Teleport(9426795465)
                end
            end
        ]])
    end
    game:GetService("TeleportService"):Teleport(9426795465)
end
