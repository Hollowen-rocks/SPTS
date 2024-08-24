-- put this in a loadstring or some shit

local isSpamming = false

local whiteListIDs = { 
-- "IN CASE U WANT WHITELIST (I REMOVED KICKED)"
""
}

local kickablePlayers = {
"" -- put the names of the people you wanna control (they have to have executed this) 
}

local adminUsernames = {
 "" -- put the usernames of the people you want to have admin access
}

local function isKickable(playerName)
    return table.find(kickablePlayers, playerName) ~= nil
end

local function isAdmin(player)
    return table.find(adminUsernames, player.Name) ~= nil
end

local function handleCommand(player, message)
    if isAdmin(player) then
        local args = string.split(message, " ")
        local command = args[1]

        if command == "!H" then
            local text = "Diddy did me"
            game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(text, "All")
        elseif command == "!tp" and args[2] then
            local targetPlayerName = args[2]
            local targetPlayer = game.Players:FindFirstChild(targetPlayerName)
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        p.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
                        print("Teleported player to target")
                    end
                end
            else
                print("Target player not found or their character does not have a HumanoidRootPart")
            end
elseif command == "!spams" then
local isSpamming = false
        elseif command == "!die" then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("Head") and isKickable(p.Name) then
                    p.Character.Head:Destroy()
                    print("Removed head of player " .. p.Name)
                end
            end
        elseif command == "!180" then
            for _, playerName in ipairs(kickablePlayers) do
                local targetPlayer = game.Players:FindFirstChild(playerName)
                if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local currentCFrame = targetPlayer.Character.HumanoidRootPart.CFrame
                    targetPlayer.Character.HumanoidRootPart.CFrame = currentCFrame * CFrame.Angles(0, math.rad(180), 0)
                    print("Turned player " .. targetPlayer.Name .. " around 180 degrees")
                end
            end
        elseif command == "!r" then
            game.ReplicatedStorage.RemoteEvent:FireServer({ "Skill_SpherePunch", Vector3.new(0, 0, 0) })
        elseif command == "!f" then
            local startTime = tick() 
            local duration = 10 
            while tick() - startTime < duration do
                game.ReplicatedStorage.RemoteEvent:FireServer({ "Skill_BulletPunch", "Left", Vector3.new(0, 25, 0) })
                game.ReplicatedStorage.RemoteEvent:FireServer({ "Skill_BulletPunch", "Right", Vector3.new(0, 25, 0) })
                wait(0.1)
            end
        elseif command == "!c" then
            local startTime = tick() 
            local duration = 20 
            while tick() - startTime < duration do
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer({ "Skill_Punch", "Left" })
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer({ "Skill_Punch", "Right" })
                wait(0.01)
            end
        elseif command == "!fling" then
            local localPlayer = game.Players.LocalPlayer
            if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                localPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(10000, 100000, 111)
                print("Local player flung")
            end
        elseif command == "!kick" and args[2] then
            local username = args[2]
            local playerToKick = game.Players:FindFirstChild(username)
            if playerToKick then
                playerToKick:Kick()
                print("Kicked player: " .. username)
            else
                print("Player not found: " .. username)
            end
        elseif command == "!spam" then
            isSpamming = not isSpamming -- Toggle spamming on or off
            print(isSpamming and "Spamming started" or "Spamming stopped")
        end
    end
end

for _, adminName in ipairs(adminUsernames) do
    local admin = game.Players:FindFirstChild(adminName)
    if admin then
        admin.Chatted:Connect(function(message)
            handleCommand(admin, message)
        end)
    else
        warn("Unable to find player with username " .. adminName)
    end
end

game:GetService("RunService").Heartbeat:Connect(function()
    if isSpamming then
        game.ReplicatedStorage.RemoteEvent:FireServer({ "Skill_KillingIntent_Start" })
    end
end)

local success, err = pcall(function()
    LocalScript.Name = "LocalScript"
end)

if not success then
    warn("Failed to rename LocalScript: " .. err)
end

local function onPlayerAdded(player)
    if isAdmin(player) then
        player.Chatted:Connect(function(message)
            handleCommand(player, message)
        end)
    end
end

game.Players.PlayerAdded:Connect(onPlayerAdded)





-- i am hollo dont steal my fucking code if u do give credit in like a print
