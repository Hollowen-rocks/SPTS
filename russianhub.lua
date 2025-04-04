---@diagnostic disable
repeat task.wait() until game:IsLoaded()

local isnetworkowner = isnetworkowner or function() return true end
local cloneref = cloneref or function(instance) return instance end
local Services = setmetatable({}, {__index = function(self, Name)
    local Service = cloneref(game:GetService(Name))
    self[Name] = Service
    return Service
end})
local ReplicatedStorage = Services.ReplicatedStorage
local RemoteEvent = ReplicatedStorage.RemoteEvent
local RemoteFunction = ReplicatedStorage.RemoteFunction
local RunService = Services.RunService
local UserInputService = Services.UserInputService
local TeleportService = Services.TeleportService
local HttpService = Services.HttpService 
local TweenService = Services.TweenService
local Lighting = Services.Lighting
local Stats = Services.Stats
local StarterGui = Services.StarterGui
local VirtualUser = Services.VirtualUser
local Workspace = Services.Workspace
local CoreGui = Services.CoreGui
local Players = Services.Players
local LocalPlayer = Players.LocalPlayer
local PrivateStats = LocalPlayer.PrivateStats
local PlayerGui = LocalPlayer.PlayerGui
local ScreenGui = PlayerGui.ScreenGui
local Camera = Workspace.CurrentCamera
local Storage = Workspace.Storage
local PlaceId = game.PlaceId
local JobId = game.JobId
local InjectorName = identifyexecutor()
local RespawnHealth = .5
local StockGravity = 196.1999969482422
local TCAdded, LPCAdded, CChanged, RespawnFunction, Teleported, Changed, SavedCameraCFrame, SavedPosition, GodCheck

if Loaded then
    TeleportService:TeleportToPlaceInstance(PlaceId, JobId, LocalPlayer)
    return
end

CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function()
    TeleportService:TeleportToPlaceInstance(PlaceId, JobId, LocalPlayer)
    return
end)

local Fluent = loadstring(game:HttpGet("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()
local Flags = Fluent.Options
local Check = newcclosure and checkcaller and hookmetamethod and hookfunction and InjectorName ~= "NX"

if Check then
    task.spawn(function()
        local chatted = Instance.new("BindableEvent")
        chatted.Name = LocalPlayer.Name .. "_Chatted"
        local OldChatted = LocalPlayer.Chatted
        local MessagePosted =  require(LocalPlayer.PlayerScripts.ChatScript.ChatMain).MessagePosted
    
        local oldhook = nil
        oldhook = hookfunction(MessagePosted.fire, function(self, ...)
            if not checkcaller() and self == MessagePosted then
                return chatted:Fire(...)
            end
            return oldhook(self, ...)
        end)

        local oldcall = nil
        oldcall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "Fire" and self.Name == "MessagePosted" then
                return task.wait(9e9)
            elseif method == "Create" then
                local args = {...}
                if args[1] == Camera then
                    return setmetatable({}, {
                        ["__index"] = function(self, ...)
                            return function() end
                        end
                    })
                end
            elseif not checkcaller() and self == LocalPlayer.Character and method == "BreakJoints" then
                return nil
            end
            return oldcall(self, ...)
        end))
    end)
end

task.spawn(function()
    repeat task.wait() until LocalPlayer.Character
    task.delay(.5, function()
        function RemoteFunction.OnClientInvoke() 
            return false
        end
        GodCheck = true
    end)
end)

PlayerGui:WaitForChild("BubbleChat", math.huge).DescendantAdded:Connect(function(descendant)
    if descendant:IsA("ImageLabel") then
        descendant.ImageColor3 = Color3.new(0, 0, 0)
    elseif descendant:IsA("TextLabel") then
        descendant.TextColor3 = Color3.new(1, 1, 1)
    end
end)

for _, object in pairs(Workspace:GetChildren()) do
    if object.Name:match("SoulAttackBeam") and object:IsA("Beam") then
        object:Destroy()
    elseif object.Name == "Town" then
        if object.Halloween.SecretTraining2:FindFirstChild("Part") then
            object.Halloween.SecretTraining2.Part.CanCollide = false
        end
    end
end

for _, object in pairs(game:GetDescendants()) do
    if object:IsA("BillboardGui") and object.Name == "WarnBBGui" then
        object:Destroy()
    end
end

Workspace.ChildAdded:Connect(function(object)
    task.wait()
    if object.Name:match("SoulAttackBeam") and object:IsA("Beam") then
        object:Destroy()
    end
end)

Workspace.FallenPartsDestroyHeight = math.huge - math.huge

LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0, 0), Camera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0, 0), Camera.CFrame)
end)

PlayerGui.IntroGui:GetPropertyChangedSignal("Enabled"):Connect(function()
    PlayerGui.IntroGui.Enabled = false
end)

Lighting.Blur:GetPropertyChangedSignal("Enabled"):Connect(function()
    Lighting.Blur.Enabled = false
end)

ScreenGui:GetPropertyChangedSignal("Enabled"):Connect(function()
    ScreenGui.Enabled = true
end)

local function formatstats(num)
    local rnum = math.floor(num * 100 + .5) / 100
    local suffixes = {"K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc", "Ud", "Dd", "Td", "Qad", "Qid", "Sxd", "Spd", "Ocd", "Nod", "Vg", "Uvg", "Dvg", "Tvg"}

    for i = #suffixes, 1, -1 do
        if rnum >= 10 ^ (i * 3) then
            return string.format("%.2f%s", rnum / 10 ^ (i * 3), suffixes[i])
        end
    end

    return tostring(math.floor(rnum))
end

local colors = {
    textcolor = {
        Criminal = Color3.new(1, .454902, .454902),
        Lawbreaker = Color3.new(1, .662745, .388235),
        Guardian = Color3.new(.631373, 1, .631373),
        Protector = Color3.new(1, .988235, .627451),
        Supervillain = Color3.new(1, 0, 0),
        Superhero = Color3.new(0, 1, .968627),
    },
    strokecolor = {
        Criminal = Color3.new(0, 0, 0),
        Lawbreaker = Color3.new(0, 0, 0),
        Guardian = Color3.new(0, 0, 0),
        Protector = Color3.new(0, 0, 0),
        Supervillain = Color3.new(1, .717647, .180392),
        Superhero = Color3.new(.015686, .117647, 1),
    },
}

local function updcolor(status)
    return colors.textcolor[status] or Color3.new(1,1,1)
end

local function updcolorstroke(status)
    return colors.strokecolor[status] or Color3.new(0, 0, 0)
end

local function formattime(time)
    local days = math.floor(time / 86400)
    local hours = math.floor((time % 86400) / 3600)
    local minutes = math.floor((time % 3600) / 60)
    local seconds = time % 60

    local result = {}

    if days > 0 then
        table.insert(result, string.format("%dd", days))
    end
    if hours > 0 then
        table.insert(result, string.format("%dh", hours))
    end
    if minutes > 0 then
        table.insert(result, string.format("%dm", minutes))
    end
    table.insert(result, string.format("%ds", seconds))

    return table.concat(result, " : ")
end

local function isAlive(player)
    if not player then
        player = LocalPlayer
    end

    return player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0
end

local lastchatted = {}
local function onChatted(player, msg)
    if Flags["Logs"].Value["ChatSpy"] then
        local newchatted = false
        
        local command, target = msg:match("^/(w) (%S+)")

        if command == "w" and Players[target] then
            newchatted = true
            lastchatted[player.Name] = target
        end

        local hidden = true
        local con = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents", math.huge):WaitForChild("OnMessageDoneFiltering", math.huge).OnClientEvent:Connect(function(packet, channel)
            if packet.SpeakerUserId == player.UserId and packet.Message == msg:sub(#msg-#packet.Message + 1) and (channel== "All") then
                hidden = false
                lastchatted[player.Name] = nil
            end
        end)
        task.wait(1)
        con:Disconnect()
        
        if hidden then
            local text = "[" .. player.Name .. " -> " .. (lastchatted[player.Name] or "unknown") .. "]: " .. (newchatted and msg:sub(msg:find(target) + #target + 1) or msg)
            if Flags["Type Of Logs"].Value["Chat"] then
                StarterGui:SetCore("ChatMakeSystemMessage", {
                    Text = text,
                    Color = Color3.new(.988235, 1, .329412),
                    Font = "GothamBold",
                    TextSize = 20
                })
            end
            
            if Flags["Type Of Logs"].Value["Notify"] then
                Fluent:Notify({
                    Title = "Z3XHub",
                    Content = "[LOGS]",
                    SubContent = text,
                    Duration = 3
                })
            end
            
            if Flags["Type Of Logs"].Value["Console"] then
                print("[LOGS]: " .. text)
            end
        end
    end
end

local ESPFolder, HFolder = Instance.new("Folder", CoreGui), Instance.new("Folder", CoreGui)
ESPFolder.Name = "ESPFolder"
HFolder.Name = "HFolder"

local function CreateESP(player)
    task.spawn(function()
        local PrivateStats = player:WaitForChild("PrivateStats", math.huge)
        local leaderstats = player:WaitForChild("leaderstats", math.huge)
        local Status = leaderstats.Status

        local BillboardGui = Instance.new("BillboardGui", CoreGui.ESPFolder)
        BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
        BillboardGui.AlwaysOnTop = true
        BillboardGui.Size = UDim2.new(0, 2, 0, 2)
        BillboardGui.StudsOffset = Vector3.new(0, 3, 0)
        BillboardGui.Name = player.Name
        BillboardGui.Enabled = false

        local Frame = Instance.new("Frame", BillboardGui)
        Frame.ZIndex = 10
        Frame.BackgroundTransparency = 1
        Frame.Size = UDim2.new(5, 0, 5, 0)

        local TxtName = Instance.new("TextLabel", Frame)
        TxtName.Name = "Names"
        TxtName.ZIndex = 10
        TxtName.Text = player.Name
        TxtName.BackgroundTransparency = 1
        TxtName.Position = UDim2.new(0, 0, 0, -55)
        TxtName.Size = UDim2.new(1, 0, 10, 0)
        TxtName.Font = "GothamBold"
        TxtName.TextSize = 14
        TxtName.TextStrokeTransparency = .5
        TxtName.TextColor3 = updcolor(Status.Value)
        TxtName.TextStrokeColor3 = updcolorstroke(Status.Value)

        local TxtDistance = Instance.new("TextLabel", Frame)
        TxtDistance.Name = "Distance"
        TxtDistance.ZIndex = 10
        TxtDistance.Text = "Distance: nil"
        TxtDistance.BackgroundTransparency = 1
        TxtDistance.Position = UDim2.new(0, 0, 0, -45)
        TxtDistance.Size = UDim2.new(1, 0, 10, 0)
        TxtDistance.Font = "GothamBold"
        TxtDistance.TextColor3 = Color3.new(1, 1, 1)
        TxtDistance.TextSize = 14
        TxtDistance.TextStrokeTransparency = .5

        local TxtHealth = Instance.new("TextLabel", Frame)
        TxtHealth.Name = "Health"
        TxtHealth.ZIndex = 10
        TxtHealth.BackgroundTransparency = 1
        TxtHealth.Position = UDim2.new(0, 0, 0, -35)
        TxtHealth.Size = UDim2.new(1, 0, 10, 0)
        TxtHealth.Font = "GothamBold"
        TxtHealth.TextColor3 = Color3.new(1, 1, 1)
        TxtHealth.TextSize = 14
        TxtHealth.TextStrokeTransparency = .5

        local TxtBody = Instance.new("TextLabel", Frame)
        TxtBody.Name = "Body"
        TxtBody.ZIndex = 10
        TxtBody.BackgroundTransparency = 1
        TxtBody.Position = UDim2.new(0, 0, 0, -25)
        TxtBody.Size = UDim2.new(1, 0, 10, 0)
        TxtBody.Font = "GothamBold"
        TxtBody.TextColor3 = Color3.new(1, 1, 1)
        TxtBody.TextSize = 14
        TxtBody.TextStrokeTransparency = .5
        TxtBody.Text = "Body: " .. formatstats(PrivateStats:WaitForChild("BodyToughness", math.huge).Value)

        local TxtFist = Instance.new("TextLabel", Frame)
        TxtFist.Name = "Fist"
        TxtFist.ZIndex = 10
        TxtFist.BackgroundTransparency = 1
        TxtFist.Position = UDim2.new(0, 0, 0, -15)
        TxtFist.Size = UDim2.new(1, 0, 10, 0)
        TxtFist.Font = "GothamBold"
        TxtFist.TextColor3 = Color3.new(1, 1, 1)
        TxtFist.TextSize = 14
        TxtFist.TextStrokeTransparency = .5
        TxtFist.Text = "Fist: " .. formatstats(PrivateStats:WaitForChild("FistStrength", math.huge).Value)

        local TxtPsychic = Instance.new("TextLabel", Frame)
        TxtPsychic.Name = "Psychic"
        TxtPsychic.ZIndex = 10
        TxtPsychic.BackgroundTransparency = 1
        TxtPsychic.Position = UDim2.new(0, 0, 0, -5)
        TxtPsychic.Size = UDim2.new(1, 0, 10, 0)
        TxtPsychic.Font = "GothamBold"
        TxtPsychic.TextColor3 = Color3.new(1, 1, 1)
        TxtPsychic.TextSize = 14
        TxtPsychic.TextStrokeTransparency = .5
        TxtPsychic.Text = "Psychic: " .. formatstats(PrivateStats:WaitForChild("PsychicPower", math.huge).Value)
    
        task.spawn(function()
            while task.wait() do
                if isAlive() and isAlive(player) then
                    TxtDistance.Text = "Distance: " .. math.floor((LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude)
                end
            end
        end)
    end)
end

local function CreateH(player)
    task.spawn(function()
        local leaderstats = player:WaitForChild("leaderstats", math.huge)
        local Status = leaderstats.Status

        local Highlight = Instance.new("Highlight", CoreGui.HFolder)
        Highlight.Name = player.Name
        Highlight.FillTransparency = .5
        Highlight.FillColor = updcolor(Status.Value)
        Highlight.OutlineColor = updcolor(Status.Value)
        Highlight.Enabled = false
    end)
end

local function getfs()
    if PrivateStats.FistStrength.Value >= 1e13 then
        return {"+FS6"}
    elseif PrivateStats.FistStrength.Value >= 1e11 then
        return {"+FS5"}
    elseif PrivateStats.FistStrength.Value >= 1e9 then
        return {"+FS4"}
    elseif PrivateStats.FistStrength.Value >= 1e5 then
        return {"+FS3"}
    elseif PrivateStats.FistStrength.Value >= 2e1 then
        return {"+FS2"}
    else
        return {"+FS1"}
    end
end

local function getpp()
    if PrivateStats.PsychicPower.Value >= 1e15 then
        return {"+PP6"}
    elseif PrivateStats.PsychicPower.Value >= 1e12 then
        return {"+PP5"}
    elseif PrivateStats.PsychicPower.Value >= 1e9 then
        return {"+PP4"}
    elseif PrivateStats.PsychicPower.Value >= 1e6 then
        return {"+PP3"}
    elseif PrivateStats.PsychicPower.Value >= 1e4 then
        return {"+PP2"}
    else
        return {"+PP1"}
    end
end

local function getfspos()
    if PrivateStats.FistStrength.Value >= 1e13 then
        return CFrame.new(-364.10, 15735.15, -7.32)
    elseif PrivateStats.FistStrength.Value >= 1e11 then
        return CFrame.new(1380.36, 9273.74, 1652.63)
    elseif PrivateStats.FistStrength.Value >= 1e9 then
        return CFrame.new(1175.30, 4789.25, -2293.05)
    end
end

local function getbtpos()
    if PrivateStats.BodyToughness.Value >= 1e13 / 20 then
        return CFrame.new(-278.40, 281.40, 999.50)
    elseif PrivateStats.BodyToughness.Value >= 1e11 / 20 then
        return CFrame.new(-275.53, 281.64, 991.48)
    elseif PrivateStats.BodyToughness.Value >= 1e9 / 20 then
        return CFrame.new(-244.45, 287.11, 978.97)
    elseif PrivateStats.BodyToughness.Value >= 1e7 / 20 then
        return CFrame.new(-2024.79, 714.25, -1882.21)
    elseif PrivateStats.BodyToughness.Value >= 1e6 / 20 then
        return CFrame.new(-2297.46, 976.74, 1075.02)
    elseif PrivateStats.BodyToughness.Value >= 1e5 / 20 then
        return CFrame.new(1634.49, 259.62, 2248.21)
    elseif PrivateStats.BodyToughness.Value >= 1e4 / 20 then
        return CFrame.new(357.28, 263.74, -492.33)
    elseif PrivateStats.BodyToughness.Value >= 1e2 / 20 then
        return CFrame.new(367.77, 249.71, -444.75)
    end
end

local function getpppos()
    if PrivateStats.PsychicPower.Value >= 1e15 then
        return CFrame.new(-2545.08, 5412.33, -491.88)
    elseif PrivateStats.PsychicPower.Value >= 1e12 then
        return CFrame.new(-2581.78, 5516.39, -500.41)
    elseif PrivateStats.PsychicPower.Value >= 1e9 then
        return CFrame.new(-2561.86, 5500.88, -440.46)
    elseif PrivateStats.PsychicPower.Value >= 1e6 then
        return CFrame.new(-2529.78, 5486.39, -534.67)
    end
end

local function getball()
    if PrivateStats.FistStrength.Value > 1e15 then
        return "EnergySphere9"
    elseif PrivateStats.FistStrength.Value > 1e12 then
        return "EnergySphere8"
    elseif PrivateStats.FistStrength.Value > 1e10 then
        return "EnergySphere7"
    elseif PrivateStats.FistStrength.Value > 1e8 then
        return "EnergySphere6"
    elseif PrivateStats.FistStrength.Value > 1e7 then
        return "EnergySphere5"
    elseif PrivateStats.FistStrength.Value > 1e6 then
        return "EnergySphere4"
    elseif PrivateStats.FistStrength.Value > 1e5 then
        return "EnergySphere3"
    elseif PrivateStats.FistStrength.Value > 1e4 then
        return "EnergySphere2"
    else
        return "EnergySphere1"
    end
end

local Animations = {
    Bubbly = {
        {"idle", "Animation1", "http://www.roblox.com/asset/?id=910004836"},
        {"idle", "Animation2", "http://www.roblox.com/asset/?id=910009958"},
        {"walk", "WalkAnim", "http://www.roblox.com/asset/?id=910034870"},
        {"run", "RunAnim", "http://www.roblox.com/asset/?id=910025107"},
        {"jump", "JumpAnim", "http://www.roblox.com/asset/?id=910016857"},
        {"fall", "FallAnim", "http://www.roblox.com/asset/?id=910001910"},
        {"swimidle", "SwimIdle", "http://www.roblox.com/asset/?id=910030921"},
        {"swim", "Swim", "http://www.roblox.com/asset/?id=910028158"}
    },
    Astronaut = {
        {"idle", "Animation1", "http://www.roblox.com/asset/?id=891621366"},
        {"idle", "Animation2", "http://www.roblox.com/asset/?id=891633237"},
        {"walk", "WalkAnim", "http://www.roblox.com/asset/?id=891667138"},
        {"run", "RunAnim", "http://www.roblox.com/asset/?id=891636393"},
        {"jump", "JumpAnim", "http://www.roblox.com/asset/?id=891627522"},
        {"climb", "ClimbAnim", "http://www.roblox.com/asset/?id=891609353"},
        {"fall", "FallAnim", "http://www.roblox.com/asset/?id=891617961"}
    },
    Cartoony = {
        {"idle", "Animation1", "http://www.roblox.com/asset/?id=742637544"},
        {"idle", "Animation2", "http://www.roblox.com/asset/?id=742638445"},
        {"walk", "WalkAnim", "http://www.roblox.com/asset/?id=742640026"},
        {"run", "RunAnim", "http://www.roblox.com/asset/?id=742638842"},
        {"jump", "JumpAnim", "http://www.roblox.com/asset/?id=742637942"},
        {"climb", "ClimbAnim", "http://www.roblox.com/asset/?id=742636889"},
        {"fall", "FallAnim", "http://www.roblox.com/asset/?id=742637151"}
    },
    Elder = {
        {"idle", "Animation1", "http://www.roblox.com/asset/?id=845397899"},
        {"idle", "Animation2", "http://www.roblox.com/asset/?id=845400520"},
        {"walk", "WalkAnim", "http://www.roblox.com/asset/?id=845403856"},
        {"run", "RunAnim", "http://www.roblox.com/asset/?id=845386501"},
        {"jump", "JumpAnim", "http://www.roblox.com/asset/?id=845398858"},
        {"climb", "ClimbAnim", "http://www.roblox.com/asset/?id=845392038"},
        {"fall", "FallAnim", "http://www.roblox.com/asset/?id=845396048"}
    },
    Knight = {
        {"idle", "Animation1", "http://www.roblox.com/asset/?id=657595757"},
        {"idle", "Animation2", "http://www.roblox.com/asset/?id=657568135"},
        {"walk", "WalkAnim", "http://www.roblox.com/asset/?id=657552124"},
        {"run", "RunAnim", "http://www.roblox.com/asset/?id=657564596"},
        {"jump", "JumpAnim", "http://www.roblox.com/asset/?id=658409194"},
        {"climb", "ClimbAnim", "http://www.roblox.com/asset/?id=658360781"},
        {"fall", "FallAnim", "http://www.roblox.com/asset/?id=657600338"}
    },
    Levitation = {
        {"idle", "Animation1", "http://www.roblox.com/asset/?id=616006778"},
        {"idle", "Animation2", "http://www.roblox.com/asset/?id=616008087"},
        {"walk", "WalkAnim", "http://www.roblox.com/asset/?id=616013216"},
        {"run", "RunAnim", "http://www.roblox.com/asset/?id=616010382"},
        {"jump", "JumpAnim", "http://www.roblox.com/asset/?id=616008936"},
        {"climb", "ClimbAnim", "http://www.roblox.com/asset/?id=616003713"},
        {"fall", "FallAnim", "http://www.roblox.com/asset/?id=616005863"}
    },
    Mage = {
        {"idle", "Animation1", "http://www.roblox.com/asset/?id=707742142"},
        {"idle", "Animation2", "http://www.roblox.com/asset/?id=707855907"},
        {"walk", "WalkAnim", "http://www.roblox.com/asset/?id=707897309"},
        {"run", "RunAnim", "http://www.roblox.com/asset/?id=707861613"},
        {"jump", "JumpAnim", "http://www.roblox.com/asset/?id=707853694"},
        {"climb", "ClimbAnim", "http://www.roblox.com/asset/?id=707826056"},
        {"fall", "FallAnim", "http://www.roblox.com/asset/?id=707829716"}
    },
    Ninja = {
        {"idle", "Animation1", "http://www.roblox.com/asset/?id=656117400"},
        {"idle", "Animation2", "http://www.roblox.com/asset/?id=656118341"},
        {"walk", "WalkAnim", "http://www.roblox.com/asset/?id=656121766"},
        {"run", "RunAnim", "http://www.roblox.com/asset/?id=656118852"},
        {"jump", "JumpAnim", "http://www.roblox.com/asset/?id=656117878"},
        {"climb", "ClimbAnim", "http://www.roblox.com/asset/?id=656114359"},
        {"fall", "FallAnim", "http://www.roblox.com/asset/?id=656115606"}
    },
    Pirate = {
        {"idle", "Animation1", "http://www.roblox.com/asset/?id=750781874"},
        {"idle", "Animation2", "http://www.roblox.com/asset/?id=750782770"},
        {"walk", "WalkAnim", "http://www.roblox.com/asset/?id=750785693"},
        {"run", "RunAnim", "http://www.roblox.com/asset/?id=750783738"},
        {"jump", "JumpAnim", "http://www.roblox.com/asset/?id=750782230"},
        {"climb", "ClimbAnim", "http://www.roblox.com/asset/?id=750779899"},
        {"fall", "FallAnim", "http://www.roblox.com/asset/?id=750780242"}
    },
    Robot = {
        {"idle", "Animation1", "http://www.roblox.com/asset/?id=616088211"},
        {"idle", "Animation2", "http://www.roblox.com/asset/?id=616089559"},
        {"walk", "WalkAnim", "http://www.roblox.com/asset/?id=616095330"},
        {"run", "RunAnim", "http://www.roblox.com/asset/?id=616091570"},
        {"jump", "JumpAnim", "http://www.roblox.com/asset/?id=616090535"},
        {"climb", "ClimbAnim", "http://www.roblox.com/asset/?id=616086039"},
        {"fall", "FallAnim", "http://www.roblox.com/asset/?id=616087089"}
    },
    Stylish = {
        {"idle", "Animation1", "http://www.roblox.com/asset/?id=616136790"},
        {"idle", "Animation2", "http://www.roblox.com/asset/?id=616138447"},
        {"walk", "WalkAnim", "http://www.roblox.com/asset/?id=616146177"},
        {"run", "RunAnim", "http://www.roblox.com/asset/?id=616140816"},
        {"jump", "JumpAnim", "http://www.roblox.com/asset/?id=616139451"},
        {"climb", "ClimbAnim", "http://www.roblox.com/asset/?id=616133594"},
        {"fall", "FallAnim", "http://www.roblox.com/asset/?id=616134815"}
    },
    Superhero = {
        {"idle", "Animation1", "http://www.roblox.com/asset/?id=616111295"},
        {"idle", "Animation2", "http://www.roblox.com/asset/?id=616113536"},
        {"walk", "WalkAnim", "http://www.roblox.com/asset/?id=616122287"},
        {"run", "RunAnim", "http://www.roblox.com/asset/?id=616117076"},
        {"jump", "JumpAnim", "http://www.roblox.com/asset/?id=616115533"},
        {"climb", "ClimbAnim", "http://www.roblox.com/asset/?id=616104706"},
        {"fall", "FallAnim", "http://www.roblox.com/asset/?id=616108001"}
    },
    Toy = {
        {"idle", "Animation1", "http://www.roblox.com/asset/?id=782841498"},
        {"idle", "Animation2", "http://www.roblox.com/asset/?id=782845736"},
        {"walk", "WalkAnim", "http://www.roblox.com/asset/?id=782843345"},
        {"run", "RunAnim", "http://www.roblox.com/asset/?id=782842708"},
        {"jump", "JumpAnim", "http://www.roblox.com/asset/?id=782847020"},
        {"climb", "ClimbAnim", "http://www.roblox.com/asset/?id=782843869"},
        {"fall", "FallAnim", "http://www.roblox.com/asset/?id=782846423"}
    },
    Vampire = {
        {"idle", "Animation1", "http://www.roblox.com/asset/?id=1083445855"},
        {"idle", "Animation2", "http://www.roblox.com/asset/?id=1083450166"},
        {"walk", "WalkAnim", "http://www.roblox.com/asset/?id=1083473930"},
        {"run", "RunAnim", "http://www.roblox.com/asset/?id=1083462077"},
        {"jump", "JumpAnim", "http://www.roblox.com/asset/?id=1083455352"},
        {"climb", "ClimbAnim", "http://www.roblox.com/asset/?id=1083439238"},
        {"fall", "FallAnim", "http://www.roblox.com/asset/?id=1083443587"}
    },
    Werewolf = {
        {"idle", "Animation1", "http://www.roblox.com/asset/?id=1083195517"},
        {"idle", "Animation2", "http://www.roblox.com/asset/?id=1083214717"},
        {"walk", "WalkAnim", "http://www.roblox.com/asset/?id=1083178339"},
        {"run", "RunAnim", "http://www.roblox.com/asset/?id=1083216690"},
        {"jump", "JumpAnim", "http://www.roblox.com/asset/?id=1083218792"},
        {"climb", "ClimbAnim", "http://www.roblox.com/asset/?id=1083182000"},
        {"fall", "FallAnim", "http://www.roblox.com/asset/?id=1083189019"}
    },
    Zombie = {
        {"idle", "Animation1", "http://www.roblox.com/asset/?id=616158929"},
        {"idle", "Animation2", "http://www.roblox.com/asset/?id=616160636"},
        {"walk", "WalkAnim", "http://www.roblox.com/asset/?id=616168032"},
        {"run", "RunAnim", "http://www.roblox.com/asset/?id=616163682"},
        {"jump", "JumpAnim", "http://www.roblox.com/asset/?id=616161997"},
        {"climb", "ClimbAnim", "http://www.roblox.com/asset/?id=616156119"},
        {"fall", "FallAnim", "http://www.roblox.com/asset/?id=616157476"}
    },
    Ghost = {
        {"idle", "Animation1", "http://www.roblox.com/asset/?id=616006778"},
        {"idle", "Animation2", "http://www.roblox.com/asset/?id=616008087"},
        {"walk", "WalkAnim", "http://www.roblox.com/asset/?id=616013216"},
        {"run", "RunAnim", "http://www.roblox.com/asset/?id=616013216"},
        {"jump", "JumpAnim", "http://www.roblox.com/asset/?id=616008936"},
        {"fall", "FallAnim", "http://www.roblox.com/asset/?id=616005863"},
        {"swimidle", "SwimIdle", "http://www.roblox.com/asset/?id=616012453"},
        {"swim", "Swim", "http://www.roblox.com/asset/?id=616011509"}
    }
}

local Window = Fluent:CreateWindow({
    Title = "Z3XHub 5.5",
    SubTitle = "by wer4er",
    TabWidth = 130,
    Size = UDim2.fromOffset(580, 460),
    Resize = false,
    MinSize = Vector2.new(580, 460),
    UseAcrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.H
})

local Tabs = {
    Farm = Window:AddTab({Title = "Farm & More", Icon = "axe" }),
    Visual = Window:AddTab({Title = "Visual",Icon = "eye"}),
    Usual = Window:AddTab({Title = "Usual",Icon = "zap"}),
    Pvp = Window:AddTab({Title = "Pvp",Icon = "swords"}),
    Teleports = Window:AddTab({Title = "Teleports",Icon = "navigation"}),
    Fun = Window:AddTab({Title = "Fun",Icon = "smile"}),
    Server = Window:AddTab({Title = "Server",Icon = "wrench"}),
    Settings = Window:AddTab({Title = "Settings",Icon = "cog"}),
}

Window:SelectTab(1)

local Targets = {}
local Whitelisted = {}
local Target = Players:GetChildren()[math.random(1, #Players:GetChildren())].Name

Tabs.Pvp:AddInput("Input", {
    Title = "Targets",
    Default = "",
    Placeholder = "Nickname",
    Numeric = false,
    Finished = true,
    Callback = function(value)
        for _, player in pairs(Players:GetPlayers()) do
            if string.find(string.lower(player.Name), string.lower(value)) then
                if player ~= LocalPlayer then
                    Target = player.Name
                    break
                end
            end
        end
        Fluent:Notify({
            Title = "Z3XHub",
            Content = "Selected:",
            SubContent = Target,
            Duration = 3
        })
    end
})

Tabs.Pvp:AddButton({
    Title = "Add To Whitelist",
    Callback = function()
        if Players:FindFirstChild(Target) and Players[Target] ~= LocalPlayer then
            if not table.find(Whitelisted, Target) then
                table.insert(Whitelisted, Target)
            end
        end
        Fluent:Notify({
            Title = "Z3XHub",
            Content = "Whitelisted:",
            SubContent = table.concat(Whitelisted, ", "),
            Duration = 3
        })
    end
})

Tabs.Pvp:AddButton({
    Title = "Remove From Whitelist",
    Callback = function()
        if table.find(Whitelisted, Target) then
            for _, rTarget in pairs(Whitelisted) do
                if rTarget == Target then
                    table.remove(Whitelisted, i)
                end
            end
        end
        Fluent:Notify({
            Title = "Z3XHub",
            Content = "Whitelisted:",
            SubContent = table.concat(Whitelisted, ", "),
            Duration = 3
        })
    end
})

Tabs.Pvp:AddButton({
    Title = "Clear Whitelist",
    Callback = function()
        Whitelisted = {}
        Fluent:Notify({
            Title = "Z3XHub",
            Content = "Whitelisted:",
            SubContent = table.concat(Whitelisted, ", "),
            Duration = 3
        })
    end
})

Tabs.Pvp:AddButton({
    Title = "Add To Targets",
    Callback = function()
        if Players:FindFirstChild(Target) and Players[Target] ~= LocalPlayer then
            if not table.find(Targets, Target) then
                table.insert(Targets, Target)
            end
        end
        Fluent:Notify({
            Title = "Z3XHub",
            Content = "Targets:",
            SubContent = table.concat(Targets, ", "),
            Duration = 3
        })
    end
})

Tabs.Pvp:AddButton({
    Title = "Remove From Targets",
    Callback = function()
        if table.find(Targets, Target) then
            for _, rTarget in pairs(Targets) do
                if rTarget == Target then
                    table.remove(Targets, i)
                end
            end
        end
        Fluent:Notify({
            Title = "Z3XHub",
            Content = "Targets:",
            SubContent = table.concat(Targets, ", "),
            Duration = 3
        })
    end
})

Tabs.Pvp:AddButton({
    Title = "Clear Targets",
    Callback = function()
        Targets = {}
        Fluent:Notify({
            Title = "Z3XHub",
            Content = "Targets:",
            SubContent = table.concat(Targets, ", "),
            Duration = 3
        })
    end
})

local teleports = {
    {"SafeZone", CFrame.new(471, 249, 889)},
    {"LeaderBoards", CFrame.new(-766, 249, 750)},
    {"FS Rock", CFrame.new(382, 249, 971)},
    {"FS Crystal", CFrame.new(-2273, 1943, 1048)},
    {"FS 1B", CFrame.new(1176, 4789, -2293)},
    {"FS 100B", CFrame.new(1381, 9274, 1648)},
    {"FS 10T", CFrame.new(-363, 15735, -3)},
    {"PP 1M", CFrame.new(-2527, 5486, -532)},
    {"PP 1B", CFrame.new(-2560, 5500, -439)},
    {"PP 1T", CFrame.new(-2582, 5516, -504)},
    {"PP 1Qa", CFrame.new(-2544, 5412, -495)},
    {"BT 100", CFrame.new(365, 249, -445)},
    {"BT 10K", CFrame.new(349, 263, -490)},
    {"BT 100K", CFrame.new(1640, 258, 2244)},
    {"BT 1M", CFrame.new(-2307, 976, 1068)},
    {"BT 10M", CFrame.new(-2024, 714, -1860)},
    {"BT 1B", CFrame.new(-254, 286, 980)},
    {"BT 100B", CFrame.new(-271, 281, 991)},
    {"BT 10T", CFrame.new(-279, 281, 1007)}
}

local teleportsvalue = {}
local teleportposition = {}

for _, teleport in pairs(teleports) do
    table.insert(teleportsvalue, teleport[1])
    teleportposition[teleport[1]] = teleport[2]
end

local oldUtilities = {}

local Components = {
    Fist = Tabs.Farm:AddToggle("Fist Strength", {Title = "Fist Strength", Default = false}),
    Body = Tabs.Farm:AddToggle("Body Toughness", {Title = "Body Toughness", Default = false}),
    Psychic = Tabs.Farm:AddToggle("Psychic Power", {Title = "Psychic Power", Default = false}),
    BodyFist = Tabs.Farm:AddToggle("Body Toughness & Fist Strength", {Title = "Body Toughness & Fist Strength", Default = false}),
    BodyPsychic = Tabs.Farm:AddToggle("Body Toughness & Psychic Power", {Title = "Body Toughness & Psychic Power", Default = false}),
    JumpSpeed = Tabs.Farm:AddToggle("Jump & Speed", {Title = "Jump & Speed", Default = false}),
    GodMode = Tabs.Farm:AddToggle("GodMode", {Title = "GodMode", Default = false}),
    Respawn = Tabs.Farm:AddSlider("Respawn Health", {Title = "Respawn Value", Default = 50, Min = 1, Max = 99, Rounding = 0}),
    Utilities = Tabs.Farm:AddDropdown("Utilities", {Title = "Utilities", Values = {"Stats Checker", "Stats Counter", "Multi Checker"}, Default = {}, Multi = true}),

    Esp = Tabs.Visual:AddToggle("ESP", {Title = "ESP", Default = false}),
    Highlights = Tabs.Visual:AddToggle("Highlights", {Title = "Highlights", Default = false}),
    Time = Tabs.Visual:AddSlider("Time", {Title = "Time", Default = 12, Min = 0, Max = 23, Rounding = 0}),
    
    SuperAura = Tabs.Usual:AddToggle("Auto Super Aura", {Title = "Auto Super Aura", Default = false}),
    DisableAura = Tabs.Usual:AddToggle("Auto Disable Aura", {Title = "Auto Disable Aura", Default = false}),
    Quests = Tabs.Usual:AddToggle("Auto Claim Quests", {Title = "Auto Claim Quests", Default = false}),
    AntiAura = Tabs.Usual:AddToggle("Anti Killing Intent Aura", {Title = "Anti Killing Intent Aura", Default = false}),
    Animations = Tabs.Usual:AddDropdown("Animations", {Title = "Animations", Values = {"None", "Bubbly", "Astronaut", "Cartoony", "Elder", "Knight", "Levitation", "Mage", "Ninja", "Pirate", "Robot", "Stylish", "Superhero", "Toy", "Vampire", "Werewolf", "Zombie", "Ghost"}, Default = {"None"}, Multi = false}),
    Fov = Tabs.Usual:AddSlider("Fov", {Title = "Fov", Default = 70, Min = 1, Max = 120, Rounding = 0}),
    
    CBring = Tabs.Pvp:AddToggle("CBring", {Title = "CBring", Default = false}),
    AutoC = Tabs.Pvp:AddToggle("Spam C", {Title = "Spam C", Default = false}),
    SpamR = Tabs.Pvp:AddToggle("Spam R", {Title = "Spam R", Default = false}),
    Stack = Tabs.Pvp:AddToggle("Stack", {Title = "Stack", Default = false}),
    Spectate = Tabs.Pvp:AddToggle("Spectate", {Title = "Spectate", Default = false}),
    SoulAttack = Tabs.Pvp:AddToggle("Soul Attack", {Title = "Soul Attack", Default = false}),
    SoulReap = Tabs.Pvp:AddToggle("Soul Reap", {Title = "Soul Reap", Default = false}),
    HellFire = Tabs.Pvp:AddToggle("Hell Fire", {Title = "Hell Fire", Default = false}),
    LoopTeleport = Tabs.Pvp:AddToggle("Loop Teleport", {Title = "Loop Teleport", Default = false}),
    SitOnHead = Tabs.Pvp:AddToggle("Sit On Head", {Title = "Sit On Head", Default = false}),
    CBringAll = Tabs.Pvp:AddToggle("CBring All", {Title = "CBring All", Default = false}),
    StackAll = Tabs.Pvp:AddToggle("Stack All", {Title = "Stack All", Default = false}),
    SoulAttackAll = Tabs.Pvp:AddToggle("Soul Attack All", {Title = "Soul Attack All", Default = false}),
    HellFireAll = Tabs.Pvp:AddToggle("Hell Fire All", {Title = "Hell Fire All", Default = false}),
    SoulReapAll = Tabs.Pvp:AddToggle("Soul Reap All", {Title = "Soul Reap All", Default = false}),
    
    Locations = Tabs.Teleports:AddDropdown("Locations", {Title = "Select Location", Values = teleportsvalue, Default = 1, Multi = false}),
    LoopTeleportToLocation = Tabs.Teleports:AddToggle("Loop Teleport To Location", {Title = "Loop Teleport To Location", Default = false}),
    
    SpamX = Tabs.Fun:AddToggle("Spam X", {Title = "Spam X", Default = false}),
    SpamT = Tabs.Fun:AddToggle("Spam T", {Title = "Spam T", Default = false}),
    RGBRank = Tabs.Fun:AddToggle("Rainbow Rank", {Title = "Rainbow Rank", Default = false}),
    RGBWeight = Tabs.Fun:AddToggle("Rainbow Weight", {Title = "Rainbow Weight", Default = false}),
    RGBSpheres = Tabs.Fun:AddToggle("Rainbow Spheres", {Title = "Rainbow Spheres", Default = false}),
    RGBLasers = Tabs.Fun:AddToggle("Rainbow Lasers", {Title = "Rainbow Lasers", Default = false}),
    RGBNames = Tabs.Fun:AddToggle("Rainbow Names", {Title = "Rainbow Names", Default = false}),
    CustomColor = Tabs.Fun:CreateColorpicker("Custom Color", {Title = "Custom Color", Default = Color3.new(0,0,0)}),
    CustomSpheres = Tabs.Fun:AddToggle("Custom Spheres", {Title = "Custom Spheres", Default = false}),
    CustomLasers = Tabs.Fun:AddToggle("Custom Lasers", {Title = "Custom Lasers", Default = false}),
    CustomNames = Tabs.Fun:AddToggle("Custom Names", {Title = "Custom Names", Default = false}),
    Spin = Tabs.Fun:AddToggle("Spin", {Title = "Spin", Default = false}),
    Gravity = Tabs.Fun:AddToggle("Gravity", {Title = "Gravity", Default = false}),
    SpinSpeed = Tabs.Fun:AddSlider("Spin Speed", {Title = "Spin", Default = 250, Min = 0, Max = 1000, Rounding = 0}),
    GravityValue = Tabs.Fun:AddSlider("Gravity value", {Title = "Gravity ", Default = 250, Min = 0, Max = 1000, Rounding = 0}),
    
    LagS = Tabs.Server:AddToggle("Spam Z", {Title = "Spam Z", Default = false}),
    Teleport = Tabs.Server:AddToggle("Teleport To Starter Camera", {Title = "Teleport To Starter Camera", Default = false}),
    SpamS = Tabs.Server:AddToggle("Spam Sounds", {Title = "Spam Sounds", Default = false}),
    Cooldown = Tabs.Server:AddSlider("Cooldown Of Spam Sounds", {Title = "Cooldown Of Spam Sounds", Default = 1, Min = .1, Max = 10, Rounding = 1}),
    
    Logs = Tabs.Settings:AddDropdown("Logs", {Title = "Logs", Values = {"Dead", "Joined/Left", "ChatSpy"}, Default = {"Dead", "Joined/Left", "ChatSpy"}, Multi = true}),
    TypeOfLogs = Tabs.Settings:AddDropdown("Type Of Logs", {Title = "Type Of Logs", Values = {"Chat", "Notify", "Console"}, Default = {"Chat"}, Multi = true})
}

Components.Fist:OnChanged(function()
    while Flags["Fist Strength"].Value and task.wait() do
        if isAlive() then
            if getfspos() then
                LocalPlayer.Character.HumanoidRootPart.CFrame = getfspos()
            end
            for i = 1, #getfs() do
                RemoteEvent:FireServer({getfs()[i]})
            end
        end
    end
end)

Components.Body:OnChanged(function()
    while Flags["Body Toughness"].Value and task.wait() do
        if isAlive() then
            if getbtpos() then
                LocalPlayer.Character.HumanoidRootPart.CFrame = getbtpos()
            else
                RemoteEvent:FireServer({"+BT1"})
            end
        end
    end
end)

Components.Psychic:OnChanged(function()
    while Flags["Psychic Power"].Value and task.wait() do
        if isAlive() then
            if getpppos() then
                LocalPlayer.Character.HumanoidRootPart.CFrame = getpppos()
            end
            for i = 1, #getpp() do
                RemoteEvent:FireServer({getpp()[i]})
            end
        end
    end
end)

Components.BodyFist:OnChanged(function()
    while Flags["Body Toughness & Fist Strength"].Value and task.wait() do
        if isAlive() then
            if getfspos() then
                LocalPlayer.Character.HumanoidRootPart.CFrame = getfspos()
            end
            task.wait(.2)
            for i = 1, #getfs() do
                RemoteEvent:FireServer({getfs()[i]})
            end
            if getbtpos() then
                local lastValue = PrivateStats.BodyToughness.Value
                repeat LocalPlayer.Character.HumanoidRootPart.CFrame = getbtpos() task.wait() until PrivateStats.BodyToughness.Value ~= lastValue
            else
                RemoteEvent:FireServer({"+BT1"})
            end
        end
    end
end)

Components.BodyPsychic:OnChanged(function()
    while Flags["Body Toughness & Psychic Power"].Value and task.wait() do
        if isAlive() then
            if getpppos() then
                LocalPlayer.Character.HumanoidRootPart.CFrame = getpppos()
            end
            task.wait(.2)
            for i = 1, #getpp() do
                RemoteEvent:FireServer({getpp()[i]})
            end
            if getbtpos() then
                local lastValue = PrivateStats.BodyToughness.Value
                repeat LocalPlayer.Character.HumanoidRootPart.CFrame = getbtpos() task.wait() until PrivateStats.BodyToughness.Value ~= lastValue
            else
                RemoteEvent:FireServer({"+BT1"})
            end
        end
    end
end)

Components.JumpSpeed:OnChanged(function()
    if Flags["Jump & Speed"].Value then
        while Flags["Jump & Speed"].Value and task.wait(.2) do
            if isAlive() then
                if PrivateStats.MovementSpeed.Value >= 20 and PrivateStats.JumpForce.Value >= 20 then
                    if not LocalPlayer.Character:FindFirstChild("LeftWeight4") and not LocalPlayer.Character:FindFirstChild("RightWeight4") then
                        RemoteEvent:FireServer({"Weight", "Weight4"})
                    end
                    RemoteEvent:FireServer({"+MS5"})
                    RemoteEvent:FireServer({"+JF5"})
                else
                    RemoteEvent:FireServer({"+MS1"})
                    RemoteEvent:FireServer({"+JF1"})
                end
            end
        end
    else
        task.delay(.5, function()
            RemoteEvent:FireServer({"Weight", "Unequip"})
        end)
    end
end)

Components.GodMode:OnChanged(function()
    if Flags["GodMode"].Value then
        if isAlive() then
            RemoteEvent:FireServer({"QuestTalkStart"})
        end
    else
        if isAlive() then 
            if LocalPlayer.Character:FindFirstChild("GodModeShield ") and not Check then
                LocalPlayer.Character["GodModeShield "].Name = "GodModeShield"
            end
            RemoteEvent:FireServer({"QuestTalkEnd", "GhostRider"})
        end
    end
end)

Components.Respawn:OnChanged(function()
    RespawnHealth = Flags["Respawn Health"].Value / 100
end)

local function loadUtility(name)
    if name == "Stats Checker" then
        local StatsChecker = {
            StatsCheckerGui = Instance.new("ScreenGui"),
            MainFrame = Instance.new("TextButton"),
            MainFrameCorner = Instance.new("UICorner"),
            PlayerNameFrame = Instance.new("Frame"),
            PlayerNameFrameCorner = Instance.new("UICorner"),
            PlayerTextBox = Instance.new("TextBox"),
            PlayerTextBoxConstraint = Instance.new("UITextSizeConstraint"),
            FsFrame = Instance.new("Frame"),
            FsFrameText = Instance.new("TextLabel"),
            FsFrameCorner = Instance.new("UICorner"),
            BtFrame = Instance.new("Frame"),
            BtFrameText = Instance.new("TextLabel"),
            BtFrameCorner = Instance.new("UICorner"),
            PpFrame = Instance.new("Frame"),
            PpFrameText = Instance.new("TextLabel"),
            PpFrameCorner = Instance.new("UICorner"),
            MsFrame = Instance.new("Frame"),
            MsFrameText = Instance.new("TextLabel"),
            MsFrameCorner = Instance.new("UICorner"),
            JfFrame = Instance.new("Frame"),
            JfFrameText = Instance.new("TextLabel"),
            JfFrameCorner = Instance.new("UICorner"),
            TokensFrame = Instance.new("Frame"),
            TokensFrameText = Instance.new("TextLabel"),
            TokensFrameCorner = Instance.new("UICorner"),
        }
        
        StatsChecker.StatsCheckerGui.Name = "Stats Checker"
        StatsChecker.StatsCheckerGui.Parent = CoreGui
        StatsChecker.StatsCheckerGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        StatsChecker.StatsCheckerGui.ResetOnSpawn = false
        
        StatsChecker.MainFrame.Name = "MainFrame"
        StatsChecker.MainFrame.Parent = StatsChecker.StatsCheckerGui
        StatsChecker.MainFrame.AnchorPoint = Vector2.new(.5, .5)
        StatsChecker.MainFrame.BackgroundColor3 = Color3.new(.098039, .098039, .098039)
        StatsChecker.MainFrame.BackgroundTransparency = 0
        StatsChecker.MainFrame.Position = UDim2.new(.5, 0, .5, 0)
        StatsChecker.MainFrame.Size = UDim2.new(.25, 0, .28, 0)
        StatsChecker.MainFrame.Active = false
        StatsChecker.MainFrame.Text = ""
        StatsChecker.MainFrame.AutoButtonColor = false
        StatsChecker.MainFrame.MouseButton1Down:Connect(function()
            local Mx, My = LocalPlayer:GetMouse().X, LocalPlayer:GetMouse().Y
            local MouseMove, MouseKill
            MouseMove = LocalPlayer:GetMouse().Move:Connect(function()
                local nMx, nMy = LocalPlayer:GetMouse().X, LocalPlayer:GetMouse().Y
                local Dx, Dy = nMx - Mx, nMy - My
                StatsChecker.MainFrame.Position = StatsChecker.MainFrame.Position + UDim2.fromOffset(Dx, Dy)
                Mx, My = nMx, nMy
            end)
            MouseKill = UserInputService.InputEnded:Connect(function(UserInput)
                if UserInput.UserInputType == Enum.UserInputType.MouseButton1 then
                    MouseMove:Disconnect()
                    MouseKill:Disconnect()
                end
            end)
        end)
        
        StatsChecker.MainFrameCorner.CornerRadius = UDim.new(0, 10)
        StatsChecker.MainFrameCorner.Name = "MainFrameCorner"
        StatsChecker.MainFrameCorner.Parent = StatsChecker.MainFrame
        
        StatsChecker.PlayerNameFrame.Name = "PlayerNameFrame"
        StatsChecker.PlayerNameFrame.Parent = StatsChecker.MainFrame
        StatsChecker.PlayerNameFrame.AnchorPoint = Vector2.new(.5, .5)
        StatsChecker.PlayerNameFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatsChecker.PlayerNameFrame.BackgroundTransparency = .5
        StatsChecker.PlayerNameFrame.Position = UDim2.new(.5, 0, .15, 0)
        StatsChecker.PlayerNameFrame.Size = UDim2.new(.6, 0, .15, 0)
        
        StatsChecker.PlayerNameFrameCorner.CornerRadius = UDim.new(0, 10)
        StatsChecker.PlayerNameFrameCorner.Name = "PlayerNameFrameCorner"
        StatsChecker.PlayerNameFrameCorner.Parent = StatsChecker.PlayerNameFrame
        
        StatsChecker.PlayerTextBox.Name = "PlayerTextBox"
        StatsChecker.PlayerTextBox.Parent = StatsChecker.PlayerNameFrame
        StatsChecker.PlayerTextBox.AnchorPoint = Vector2.new(1, .5)
        StatsChecker.PlayerTextBox.BackgroundColor3 = Color3.new(1, 1, 1)
        StatsChecker.PlayerTextBox.BackgroundTransparency = 1
        StatsChecker.PlayerTextBox.Position = UDim2.new(1, 0, .5, 0)
        StatsChecker.PlayerTextBox.Size = UDim2.new(1, 0, 1, 0)
        StatsChecker.PlayerTextBox.Font = "GothamBold"
        StatsChecker.PlayerTextBox.PlaceholderText = "Nickname"
        StatsChecker.PlayerTextBox.Text = ""
        StatsChecker.PlayerTextBox.TextColor3 = Color3.new(1, 1, 1)
        StatsChecker.PlayerTextBox.TextScaled = true
        StatsChecker.PlayerTextBox.TextSize = 16
        StatsChecker.PlayerTextBox.TextWrapped = true
        StatsChecker.PlayerTextBox.ClearTextOnFocus = true
        
        StatsChecker.PlayerTextBoxConstraint.Parent = StatsChecker.PlayerTextBox
        StatsChecker.PlayerTextBoxConstraint.MaxTextSize = 20
        
        StatsChecker.FsFrame.Name = "FsStat"
        StatsChecker.FsFrame.Parent = StatsChecker.MainFrame
        StatsChecker.FsFrame.AnchorPoint = Vector2.new(1, .5)
        StatsChecker.FsFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatsChecker.FsFrame.BackgroundTransparency = 0
        StatsChecker.FsFrame.BorderSizePixel = 1
        StatsChecker.FsFrame.Position = UDim2.new(.49, 0, .4, 0)
        StatsChecker.FsFrame.Size = UDim2.new(.46, 0, .21, 0)
        
        StatsChecker.FsFrameText.Name = "FsStatText"
        StatsChecker.FsFrameText.Parent = StatsChecker.FsFrame
        StatsChecker.FsFrameText.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatsChecker.FsFrameText.BackgroundTransparency = 1
        StatsChecker.FsFrameText.TextTransparency = 0
        StatsChecker.FsFrameText.Position = UDim2.new(0, 0, .28, 0)
        StatsChecker.FsFrameText.Size = UDim2.new(1, 0, .48, 0)
        StatsChecker.FsFrameText.Font = "GothamBold"
        StatsChecker.FsFrameText.Text = ""
        StatsChecker.FsFrameText.TextScaled = true
        StatsChecker.FsFrameText.TextColor3 = Color3.new(.913725, .913725, .913725)
        StatsChecker.FsFrameText.TextSize = 25
        StatsChecker.FsFrameText.TextXAlignment = Enum.TextXAlignment.Center
        
        StatsChecker.FsFrameCorner.CornerRadius = UDim.new(0, 10)
        StatsChecker.FsFrameCorner.Name = "FsFrameCorner"
        StatsChecker.FsFrameCorner.Parent = StatsChecker.FsFrame
        
        StatsChecker.BtFrame.Name = "BtStat"
        StatsChecker.BtFrame.Parent = StatsChecker.MainFrame
        StatsChecker.BtFrame.AnchorPoint = Vector2.new(1, .5)
        StatsChecker.BtFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatsChecker.BtFrame.BackgroundTransparency = 0
        StatsChecker.BtFrame.BorderSizePixel = 1
        StatsChecker.BtFrame.Position = UDim2.new(.49, 0, .63, 0)
        StatsChecker.BtFrame.Size = UDim2.new(.46, 0, .21, 0)
        
        StatsChecker.BtFrameText.Name = "BtStatText"
        StatsChecker.BtFrameText.Parent = StatsChecker.BtFrame
        StatsChecker.BtFrameText.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatsChecker.BtFrameText.BackgroundTransparency = 1
        StatsChecker.BtFrameText.TextTransparency = 0
        StatsChecker.BtFrameText.Position = UDim2.new(0, 0, .28, 0)
        StatsChecker.BtFrameText.Size = UDim2.new(1, 0, .48, 0)
        StatsChecker.BtFrameText.Font = "GothamBold"
        StatsChecker.BtFrameText.Text = ""
        StatsChecker.BtFrameText.TextScaled = true
        StatsChecker.BtFrameText.TextColor3 = Color3.new(.913725, .913725, .913725)
        StatsChecker.BtFrameText.TextSize = 25
        StatsChecker.BtFrameText.TextXAlignment = Enum.TextXAlignment.Center
        
        StatsChecker.BtFrameCorner.CornerRadius = UDim.new(0, 10)
        StatsChecker.BtFrameCorner.Name = "BtFrameCorner"
        StatsChecker.BtFrameCorner.Parent = StatsChecker.BtFrame
        
        StatsChecker.PpFrame.Name = "PpStat"
        StatsChecker.PpFrame.Parent = StatsChecker.MainFrame
        StatsChecker.PpFrame.AnchorPoint = Vector2.new(1, .5)
        StatsChecker.PpFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatsChecker.PpFrame.BackgroundTransparency = 0
        StatsChecker.PpFrame.BorderSizePixel = 1
        StatsChecker.PpFrame.Position = UDim2.new(.49, 0, .858, 0)
        StatsChecker.PpFrame.Size = UDim2.new(.46, 0, .21, 0)
        
        StatsChecker.PpFrameText.Name = "PpStatText"
        StatsChecker.PpFrameText.Parent = StatsChecker.PpFrame
        StatsChecker.PpFrameText.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatsChecker.PpFrameText.BackgroundTransparency = 1
        StatsChecker.PpFrameText.TextTransparency = 0
        StatsChecker.PpFrameText.Position = UDim2.new(0, 0, .28, 0)
        StatsChecker.PpFrameText.Size = UDim2.new(1, 0, .48, 0)
        StatsChecker.PpFrameText.Font = "GothamBold"
        StatsChecker.PpFrameText.Text = ""
        StatsChecker.PpFrameText.TextScaled = true
        StatsChecker.PpFrameText.TextColor3 = Color3.new(.913725, .913725, .913725)
        StatsChecker.PpFrameText.TextSize = 25
        StatsChecker.PpFrameText.TextXAlignment = Enum.TextXAlignment.Center
        
        StatsChecker.PpFrameCorner.CornerRadius = UDim.new(0, 10)
        StatsChecker.PpFrameCorner.Name = "PpFrameCorner"
        StatsChecker.PpFrameCorner.Parent = StatsChecker.PpFrame
        
        StatsChecker.MsFrame.Name = "MsStat"
        StatsChecker.MsFrame.Parent = StatsChecker.MainFrame
        StatsChecker.MsFrame.AnchorPoint = Vector2.new(1, .5)
        StatsChecker.MsFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatsChecker.MsFrame.BackgroundTransparency = 0
        StatsChecker.MsFrame.BorderSizePixel = 1
        StatsChecker.MsFrame.Position = UDim2.new(.97, 0, .4, 0)
        StatsChecker.MsFrame.Size = UDim2.new(.46, 0, .21, 0)
        
        StatsChecker.MsFrameText.Name = "MsStatText"
        StatsChecker.MsFrameText.Parent = StatsChecker.MsFrame
        StatsChecker.MsFrameText.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatsChecker.MsFrameText.BackgroundTransparency = 1
        StatsChecker.MsFrameText.TextTransparency = 0
        StatsChecker.MsFrameText.Position = UDim2.new(0, 0, .28, 0)
        StatsChecker.MsFrameText.Size = UDim2.new(1, 0, .48, 0)
        StatsChecker.MsFrameText.Font = "GothamBold"
        StatsChecker.MsFrameText.Text = ""
        StatsChecker.MsFrameText.TextScaled = true
        StatsChecker.MsFrameText.TextColor3 = Color3.new(.913725, .913725, .913725)
        StatsChecker.MsFrameText.TextSize = 25
        StatsChecker.MsFrameText.TextXAlignment = Enum.TextXAlignment.Center
        
        StatsChecker.MsFrameCorner.CornerRadius = UDim.new(0, 10)
        StatsChecker.MsFrameCorner.Name = "MsFrameCorner"
        StatsChecker.MsFrameCorner.Parent = StatsChecker.MsFrame
        
        StatsChecker.JfFrame.Name = "JfStat"
        StatsChecker.JfFrame.Parent = StatsChecker.MainFrame
        StatsChecker.JfFrame.AnchorPoint = Vector2.new(1, .5)
        StatsChecker.JfFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatsChecker.JfFrame.BackgroundTransparency = 0
        StatsChecker.JfFrame.BorderSizePixel = 1
        StatsChecker.JfFrame.Position = UDim2.new(.97, 0, .63, 0)
        StatsChecker.JfFrame.Size = UDim2.new(.46, 0, .21, 0)
        
        StatsChecker.JfFrameText.Name = "JfStatText"
        StatsChecker.JfFrameText.Parent = StatsChecker.JfFrame
        StatsChecker.JfFrameText.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatsChecker.JfFrameText.BackgroundTransparency = 1
        StatsChecker.JfFrameText.TextTransparency = 0
        StatsChecker.JfFrameText.Position = UDim2.new(0, 0, .28, 0)
        StatsChecker.JfFrameText.Size = UDim2.new(1, 0, .48, 0)
        StatsChecker.JfFrameText.Font = "GothamBold"
        StatsChecker.JfFrameText.Text = ""
        StatsChecker.JfFrameText.TextScaled = true
        StatsChecker.JfFrameText.TextColor3 = Color3.new(.913725, .913725, .913725)
        StatsChecker.JfFrameText.TextSize = 25
        StatsChecker.JfFrameText.TextXAlignment = Enum.TextXAlignment.Center
        
        StatsChecker.JfFrameCorner.CornerRadius = UDim.new(0, 10)
        StatsChecker.JfFrameCorner.Name = "JfFrameCorner"
        StatsChecker.JfFrameCorner.Parent = StatsChecker.JfFrame
        
        StatsChecker.TokensFrame.Name = "Tokens"
        StatsChecker.TokensFrame.Parent = StatsChecker.MainFrame
        StatsChecker.TokensFrame.AnchorPoint = Vector2.new(1, .5)
        StatsChecker.TokensFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatsChecker.TokensFrame.BackgroundTransparency = 0
        StatsChecker.TokensFrame.BorderSizePixel = 1
        StatsChecker.TokensFrame.Position = UDim2.new(.97, 0, .858, 0)
        StatsChecker.TokensFrame.Size = UDim2.new(.46, 0, .21, 0)
        
        StatsChecker.TokensFrameText.Name = "TokensStatText"
        StatsChecker.TokensFrameText.Parent = StatsChecker.TokensFrame
        StatsChecker.TokensFrameText.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatsChecker.TokensFrameText.BackgroundTransparency = 1
        StatsChecker.TokensFrameText.TextTransparency = 0
        StatsChecker.TokensFrameText.Position = UDim2.new(0, 0, .28, 0)
        StatsChecker.TokensFrameText.Size = UDim2.new(1, 0, .48, 0)
        StatsChecker.TokensFrameText.Font = "GothamBold"
        StatsChecker.TokensFrameText.Text = ""
        StatsChecker.TokensFrameText.TextScaled = true
        StatsChecker.TokensFrameText.TextColor3 = Color3.new(.913725, .913725, .913725)
        StatsChecker.TokensFrameText.TextSize = 25
        StatsChecker.TokensFrameText.TextXAlignment = Enum.TextXAlignment.Center
        
        StatsChecker.TokensFrameCorner.CornerRadius = UDim.new(0, 10)
        StatsChecker.TokensFrameCorner.Name = "TokensFrameCorner"
        StatsChecker.TokensFrameCorner.Parent = StatsChecker.TokensFrame

        local UpdatingStats = {
            {StatsChecker.FsFrameText, "FistStrength", "Fist"},
            {StatsChecker.BtFrameText, "BodyToughness", "Body"},
            {StatsChecker.PpFrameText, "PsychicPower", "Psychic"},
            {StatsChecker.MsFrameText, "MovementSpeed", "Movement"},
            {StatsChecker.JfFrameText, "JumpForce", "Jump"},
            {StatsChecker.TokensFrameText, "Token", "Token"}
        }
        
        StatsChecker.PlayerTextBox.FocusLost:Connect(function()
            for _, player in pairs(Players:GetPlayers()) do
                if (string.sub(string.lower(player.Name), 1, string.len(StatsChecker.PlayerTextBox.Text))) == string.lower(StatsChecker.PlayerTextBox.Text) then
                    StatsChecker.PlayerTextBox.Text = player.Name
                    for _, object in pairs(UpdatingStats) do
                        local Stat = Players:FindFirstChild(player.Name):WaitForChild("PrivateStats", math.huge)
                        local Statname = object[3]
                        object[1].Text = Statname .. ": " .. formatstats(Stat[object[2]].Value)
                        Stat[object[2]]:GetPropertyChangedSignal("Value"):Connect(function()
                            object[1].Text = Statname .. ": " .. formatstats(Stat[object[2]].Value)
                        end)
                    end
                end
            end
        end)        
    elseif name == "Stats Counter" then
        local StatCounter = {
            StatCounterGui = Instance.new("ScreenGui"),
            MainFrame = Instance.new("TextButton"),
            MainFrameCorner = Instance.new("UICorner"),
            TimeFrame = Instance.new("Frame"),
            TimeFrameText = Instance.new("TextLabel"),
            TimeFrameCorner = Instance.new("UICorner"),
            FsFrame = Instance.new("Frame"),
            FsFrameText = Instance.new("TextLabel"),
            FsFrameCorner = Instance.new("UICorner"),
            BtFrame = Instance.new("Frame"),
            BtFrameText = Instance.new("TextLabel"),
            BtFrameCorner = Instance.new("UICorner"),
            PpFrame = Instance.new("Frame"),
            PpFrameText = Instance.new("TextLabel"),
            PpFrameCorner = Instance.new("UICorner"),
            MsFrame = Instance.new("Frame"),
            MsFrameText = Instance.new("TextLabel"),
            MsFrameCorner = Instance.new("UICorner"),
            JfFrame = Instance.new("Frame"),
            JfFrameText = Instance.new("TextLabel"),
            JfFrameCorner = Instance.new("UICorner"),
            TokensFrame = Instance.new("Frame"),
            TokensFrameText = Instance.new("TextLabel"),
            TokensFrameCorner = Instance.new("UICorner"),
        }

        StatCounter.StatCounterGui.Name = "Stats Counter"
        StatCounter.StatCounterGui.Parent = CoreGui
        StatCounter.StatCounterGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        StatCounter.StatCounterGui.ResetOnSpawn = false

        StatCounter.MainFrame.Name = "MainFrame"
        StatCounter.MainFrame.Parent = StatCounter.StatCounterGui
        StatCounter.MainFrame.AnchorPoint = Vector2.new(.5, .5)
        StatCounter.MainFrame.BackgroundColor3 = Color3.new(.098039, .098039, .098039)
        StatCounter.MainFrame.BackgroundTransparency = 0
        StatCounter.MainFrame.Position = UDim2.new(.5, 0, .5, 0)
        StatCounter.MainFrame.Size = UDim2.new(.25, 0, .28, 0)
        StatCounter.MainFrame.Active = false
        StatCounter.MainFrame.Text = ""
        StatCounter.MainFrame.AutoButtonColor = false
        StatCounter.MainFrame.MouseButton1Down:Connect(function()
            local Mx, My = LocalPlayer:GetMouse().X, LocalPlayer:GetMouse().Y
            local MouseMove, MouseKill
            MouseMove = LocalPlayer:GetMouse().Move:Connect(function()
                local nMx, nMy = LocalPlayer:GetMouse().X, LocalPlayer:GetMouse().Y
                local Dx, Dy = nMx - Mx, nMy - My
                StatCounter.MainFrame.Position = StatCounter.MainFrame.Position + UDim2.fromOffset(Dx, Dy)
                Mx, My = nMx, nMy
            end)
            MouseKill = UserInputService.InputEnded:Connect(function(UserInput)
                if UserInput.UserInputType == Enum.UserInputType.MouseButton1 then
                    MouseMove:Disconnect()
                    MouseKill:Disconnect()
                end
            end)
        end)

        StatCounter.MainFrameCorner.CornerRadius = UDim.new(0, 10)
        StatCounter.MainFrameCorner.Name = "MainFrameCorner"
        StatCounter.MainFrameCorner.Parent = StatCounter.MainFrame

        StatCounter.TimeFrame.Name = "Time"
        StatCounter.TimeFrame.Parent = StatCounter.MainFrame
        StatCounter.TimeFrame.AnchorPoint = Vector2.new(1, .5)
        StatCounter.TimeFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatCounter.TimeFrame.BackgroundTransparency = 0
        StatCounter.TimeFrame.BorderSizePixel = 1
        StatCounter.TimeFrame.Position = UDim2.new(.85, 0, .15, 0)
        StatCounter.TimeFrame.Size = UDim2.new(.7, 0, .15, 0)

        StatCounter.TimeFrameText.Name = "Time"
        StatCounter.TimeFrameText.Parent = StatCounter.TimeFrame
        StatCounter.TimeFrameText.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatCounter.TimeFrameText.BackgroundTransparency = 1
        StatCounter.TimeFrameText.TextTransparency = 0
        StatCounter.TimeFrameText.Position = UDim2.new(0, 0, 0, 0)
        StatCounter.TimeFrameText.Size = UDim2.new(1, 0, 1, 0)
        StatCounter.TimeFrameText.Font = "GothamBold"
        StatCounter.TimeFrameText.Text = ""
        StatCounter.TimeFrameText.TextScaled = true
        StatCounter.TimeFrameText.TextColor3 = Color3.new(.913725, .913725, .913725)
        StatCounter.TimeFrameText.TextSize = 25
        StatCounter.TimeFrameText.TextXAlignment = Enum.TextXAlignment.Center

        StatCounter.TimeFrameCorner.CornerRadius = UDim.new(0, 10)
        StatCounter.TimeFrameCorner.Name = "TimeFrameCorner"
        StatCounter.TimeFrameCorner.Parent = StatCounter.TimeFrame

        StatCounter.FsFrame.Name = "Fs"
        StatCounter.FsFrame.Parent = StatCounter.MainFrame
        StatCounter.FsFrame.AnchorPoint = Vector2.new(1, .5)
        StatCounter.FsFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatCounter.FsFrame.BackgroundTransparency = 0
        StatCounter.FsFrame.BorderSizePixel = 1
        StatCounter.FsFrame.Position = UDim2.new(.49, 0, .4, 0)
        StatCounter.FsFrame.Size = UDim2.new(.46, 0, .21, 0)

        StatCounter.FsFrameText.Name = "Fist"
        StatCounter.FsFrameText.Parent = StatCounter.FsFrame
        StatCounter.FsFrameText.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatCounter.FsFrameText.BackgroundTransparency = 1
        StatCounter.FsFrameText.TextTransparency = 0
        StatCounter.FsFrameText.Position = UDim2.new(0, 0, .28, 0)
        StatCounter.FsFrameText.Size = UDim2.new(1, 0, .48, 0)
        StatCounter.FsFrameText.Font = "GothamBold"
        StatCounter.FsFrameText.Text = ""
        StatCounter.FsFrameText.TextScaled = true
        StatCounter.FsFrameText.TextColor3 = Color3.new(.913725, .913725, .913725)
        StatCounter.FsFrameText.TextSize = 25
        StatCounter.FsFrameText.TextXAlignment = Enum.TextXAlignment.Center

        StatCounter.FsFrameCorner.CornerRadius = UDim.new(0, 10)
        StatCounter.FsFrameCorner.Name = "FsFrameCorner"
        StatCounter.FsFrameCorner.Parent = StatCounter.FsFrame

        StatCounter.BtFrame.Name = "Body"
        StatCounter.BtFrame.Parent = StatCounter.MainFrame
        StatCounter.BtFrame.AnchorPoint = Vector2.new(1, .5)
        StatCounter.BtFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatCounter.BtFrame.BackgroundTransparency = 0
        StatCounter.BtFrame.BorderSizePixel = 1
        StatCounter.BtFrame.Position = UDim2.new(.49, 0, .63, 0)
        StatCounter.BtFrame.Size = UDim2.new(.46, 0, .21, 0)

        StatCounter.BtFrameText.Name = "Body"
        StatCounter.BtFrameText.Parent = StatCounter.BtFrame
        StatCounter.BtFrameText.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatCounter.BtFrameText.BackgroundTransparency = 1
        StatCounter.BtFrameText.TextTransparency = 0
        StatCounter.BtFrameText.Position = UDim2.new(0, 0, .28, 0)
        StatCounter.BtFrameText.Size = UDim2.new(1, 0, .48, 0)
        StatCounter.BtFrameText.Font = "GothamBold"
        StatCounter.BtFrameText.Text = ""
        StatCounter.BtFrameText.TextScaled = true
        StatCounter.BtFrameText.TextColor3 = Color3.new(.913725, .913725, .913725)
        StatCounter.BtFrameText.TextSize = 25
        StatCounter.BtFrameText.TextXAlignment = Enum.TextXAlignment.Center

        StatCounter.BtFrameCorner.CornerRadius = UDim.new(0, 10)
        StatCounter.BtFrameCorner.Name = "BtFrameCorner"
        StatCounter.BtFrameCorner.Parent = StatCounter.BtFrame

        StatCounter.PpFrame.Name = "Psychic"
        StatCounter.PpFrame.Parent = StatCounter.MainFrame
        StatCounter.PpFrame.AnchorPoint = Vector2.new(1, .5)
        StatCounter.PpFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatCounter.PpFrame.BackgroundTransparency = 0
        StatCounter.PpFrame.BorderSizePixel = 1
        StatCounter.PpFrame.Position = UDim2.new(.49, 0, .858, 0)
        StatCounter.PpFrame.Size = UDim2.new(.46, 0, .21, 0)

        StatCounter.PpFrameText.Name = "Psychic"
        StatCounter.PpFrameText.Parent = StatCounter.PpFrame
        StatCounter.PpFrameText.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatCounter.PpFrameText.BackgroundTransparency = 1
        StatCounter.PpFrameText.TextTransparency = 0
        StatCounter.PpFrameText.Position = UDim2.new(0, 0, .28, 0)
        StatCounter.PpFrameText.Size = UDim2.new(1, 0, .48, 0)
        StatCounter.PpFrameText.Font = "GothamBold"
        StatCounter.PpFrameText.Text = ""
        StatCounter.PpFrameText.TextScaled = true
        StatCounter.PpFrameText.TextColor3 = Color3.new(.913725, .913725, .913725)
        StatCounter.PpFrameText.TextSize = 25
        StatCounter.PpFrameText.TextXAlignment = Enum.TextXAlignment.Center

        StatCounter.PpFrameCorner.CornerRadius = UDim.new(0, 10)
        StatCounter.PpFrameCorner.Name = "PpFrameCorner"
        StatCounter.PpFrameCorner.Parent = StatCounter.PpFrame

        StatCounter.MsFrame.Name = "Speed"
        StatCounter.MsFrame.Parent = StatCounter.MainFrame
        StatCounter.MsFrame.AnchorPoint = Vector2.new(1, .5)
        StatCounter.MsFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatCounter.MsFrame.BackgroundTransparency = 0
        StatCounter.MsFrame.BorderSizePixel = 1
        StatCounter.MsFrame.Position = UDim2.new(.97, 0, .4, 0)
        StatCounter.MsFrame.Size = UDim2.new(.46, 0, .21, 0)

        StatCounter.MsFrameText.Name = "Speed"
        StatCounter.MsFrameText.Parent = StatCounter.MsFrame
        StatCounter.MsFrameText.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatCounter.MsFrameText.BackgroundTransparency = 1
        StatCounter.MsFrameText.TextTransparency = 0
        StatCounter.MsFrameText.Position = UDim2.new(0, 0, .28, 0)
        StatCounter.MsFrameText.Size = UDim2.new(1, 0, .48, 0)
        StatCounter.MsFrameText.Font = "GothamBold"
        StatCounter.MsFrameText.Text = ""
        StatCounter.MsFrameText.TextScaled = true
        StatCounter.MsFrameText.TextColor3 = Color3.new(.913725, .913725, .913725)
        StatCounter.MsFrameText.TextSize = 25
        StatCounter.MsFrameText.TextXAlignment = Enum.TextXAlignment.Center

        StatCounter.MsFrameCorner.CornerRadius = UDim.new(0, 10)
        StatCounter.MsFrameCorner.Name = "MsFrameCorner"
        StatCounter.MsFrameCorner.Parent = StatCounter.MsFrame

        StatCounter.JfFrame.Name = "Jump"
        StatCounter.JfFrame.Parent = StatCounter.MainFrame
        StatCounter.JfFrame.AnchorPoint = Vector2.new(1, .5)
        StatCounter.JfFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatCounter.JfFrame.BackgroundTransparency = 0
        StatCounter.JfFrame.BorderSizePixel = 1
        StatCounter.JfFrame.Position = UDim2.new(.97, 0, .63, 0)
        StatCounter.JfFrame.Size = UDim2.new(.46, 0, .21, 0)

        StatCounter.JfFrameText.Name = "Jump"
        StatCounter.JfFrameText.Parent = StatCounter.JfFrame
        StatCounter.JfFrameText.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatCounter.JfFrameText.BackgroundTransparency = 1
        StatCounter.JfFrameText.TextTransparency = 0
        StatCounter.JfFrameText.Position = UDim2.new(0, 0, .28, 0)
        StatCounter.JfFrameText.Size = UDim2.new(1, 0, .48, 0)
        StatCounter.JfFrameText.Font = "GothamBold"
        StatCounter.JfFrameText.Text = ""
        StatCounter.JfFrameText.TextScaled = true
        StatCounter.JfFrameText.TextColor3 = Color3.new(.913725, .913725, .913725)
        StatCounter.JfFrameText.TextSize = 25
        StatCounter.JfFrameText.TextXAlignment = Enum.TextXAlignment.Center

        StatCounter.JfFrameCorner.CornerRadius = UDim.new(0, 10)
        StatCounter.JfFrameCorner.Name = "JfFrameCorner"
        StatCounter.JfFrameCorner.Parent = StatCounter.JfFrame

        StatCounter.TokensFrame.Name = "Tokens"
        StatCounter.TokensFrame.Parent = StatCounter.MainFrame
        StatCounter.TokensFrame.AnchorPoint = Vector2.new(1, .5)
        StatCounter.TokensFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatCounter.TokensFrame.BackgroundTransparency = 0
        StatCounter.TokensFrame.BorderSizePixel = 1
        StatCounter.TokensFrame.Position = UDim2.new(.97, 0, .858, 0)
        StatCounter.TokensFrame.Size = UDim2.new(.46, 0, .21, 0)

        StatCounter.TokensFrameText.Name = "Tokens"
        StatCounter.TokensFrameText.Parent = StatCounter.TokensFrame
        StatCounter.TokensFrameText.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        StatCounter.TokensFrameText.BackgroundTransparency = 1
        StatCounter.TokensFrameText.TextTransparency = 0
        StatCounter.TokensFrameText.Position = UDim2.new(0, 0, .28, 0)
        StatCounter.TokensFrameText.Size = UDim2.new(1, 0, .48, 0)
        StatCounter.TokensFrameText.Font = "GothamBold"
        StatCounter.TokensFrameText.Text = ""
        StatCounter.TokensFrameText.TextScaled = true
        StatCounter.TokensFrameText.TextColor3 = Color3.new(.913725, .913725, .913725)
        StatCounter.TokensFrameText.TextSize = 25
        StatCounter.TokensFrameText.TextXAlignment = Enum.TextXAlignment.Center

        StatCounter.TokensFrameCorner.CornerRadius = UDim.new(0, 10)
        StatCounter.TokensFrameCorner.Name = "TokensFrameCorner"
        StatCounter.TokensFrameCorner.Parent = StatCounter.TokensFrame

        local UpdatingStats = {
            {StatCounter.FsFrameText, "FistStrength", PrivateStats.FistStrength.Value},
            {StatCounter.BtFrameText, "BodyToughness", PrivateStats.BodyToughness.Value},
            {StatCounter.PpFrameText, "PsychicPower", PrivateStats.PsychicPower.Value},
            {StatCounter.MsFrameText, "MovementSpeed", PrivateStats.MovementSpeed.Value},
            {StatCounter.JfFrameText, "JumpForce", PrivateStats.JumpForce.Value},
            {StatCounter.TokensFrameText, "Token", PrivateStats.Token.Value}
        }

        local OldValue = 0
        local AllTokens = 0

        for _, object in UpdatingStats do
            object[1].Text = object[1].Name .. ": " .. 0

            if object[2] ~= "Token" then
                PrivateStats[object[2]]:GetPropertyChangedSignal("Value"):Connect(function()
                    object[1].Text = object[1].Name .. ": " .. formatstats(PrivateStats[object[2]].Value - object[3])
                end)
            else
                PrivateStats[object[2]]:GetPropertyChangedSignal("Value"):Connect(function()
                    if PrivateStats[object[2]].Value - OldValue > 0 then
                        AllTokens += 5
                    end
                    OldValue = PrivateStats[object[2]].Value
                    object[1].Text = object[1].Name .. ": " .. formatstats(AllTokens)
                end)
            end
        end

        local startTime = os.time()

        task.spawn(function()
            while task.wait() do
                StatCounter.TimeFrameText.Text = "Time: " .. formattime(os.time() - startTime)
            end
        end)
    elseif name == "Multi Checker" then
        local MultiChecker = {
            MultiCheckerGui = Instance.new("ScreenGui"),
            MainFrame = Instance.new("TextButton"),
            MainFrameCorner = Instance.new("UICorner"),
            PlayerNameFrame = Instance.new("Frame"),
            PlayerNameFrameCorner = Instance.new("UICorner"),
            PlayerTextBox = Instance.new("TextBox"),
            PlayerTextBoxConstraint = Instance.new("UITextSizeConstraint"),
            FsFrame = Instance.new("Frame"),
            FsFrameText = Instance.new("TextLabel"),
            FsFrameCorner = Instance.new("UICorner"),
            BtFrame = Instance.new("Frame"),
            BtFrameText = Instance.new("TextLabel"),
            BtFrameCorner = Instance.new("UICorner"),
            PpFrame = Instance.new("Frame"),
            PpFrameText = Instance.new("TextLabel"),
            PpFrameCorner = Instance.new("UICorner"),
            MsFrame = Instance.new("Frame"),
            MsFrameText = Instance.new("TextLabel"),
            MsFrameCorner = Instance.new("UICorner"),
            JfFrame = Instance.new("Frame"),
            JfFrameText = Instance.new("TextLabel"),
            JfFrameCorner = Instance.new("UICorner"),
            TokensFrame = Instance.new("Frame"),
            TokensFrameText = Instance.new("TextLabel"),
            TokensFrameCorner = Instance.new("UICorner"),
        }

        MultiChecker.MultiCheckerGui.Name = "Multi Checker"
        MultiChecker.MultiCheckerGui.Parent = CoreGui
        MultiChecker.MultiCheckerGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        MultiChecker.MultiCheckerGui.ResetOnSpawn = false

        MultiChecker.MainFrame.Name = "MainFrame"
        MultiChecker.MainFrame.Parent = MultiChecker.MultiCheckerGui
        MultiChecker.MainFrame.AnchorPoint = Vector2.new(.5, .5)
        MultiChecker.MainFrame.BackgroundColor3 = Color3.new(.098039, .098039, .098039)
        MultiChecker.MainFrame.BackgroundTransparency = 0
        MultiChecker.MainFrame.Position = UDim2.new(.5, 0, .5, 0)
        MultiChecker.MainFrame.Size = UDim2.new(.25, 0, .28, 0)
        MultiChecker.MainFrame.Active = false
        MultiChecker.MainFrame.Text = ""
        MultiChecker.MainFrame.AutoButtonColor = false
        MultiChecker.MainFrame.MouseButton1Down:Connect(function()
            local Mx, My = LocalPlayer:GetMouse().X, LocalPlayer:GetMouse().Y
            local MouseMove, MouseKill
            MouseMove = LocalPlayer:GetMouse().Move:Connect(function()
                local nMx, nMy = LocalPlayer:GetMouse().X, LocalPlayer:GetMouse().Y
                local Dx, Dy = nMx - Mx, nMy - My
                MultiChecker.MainFrame.Position = MultiChecker.MainFrame.Position + UDim2.fromOffset(Dx, Dy)
                Mx, My = nMx, nMy
            end)
            MouseKill = UserInputService.InputEnded:Connect(function(UserInput)
                if UserInput.UserInputType == Enum.UserInputType.MouseButton1 then
                    MouseMove:Disconnect()
                    MouseKill:Disconnect()
                end
            end)
        end)

        MultiChecker.MainFrameCorner.CornerRadius = UDim.new(0, 10)
        MultiChecker.MainFrameCorner.Name = "MainFrameCorner"
        MultiChecker.MainFrameCorner.Parent = MultiChecker.MainFrame

        MultiChecker.PlayerNameFrame.Name = "PlayerNameFrame"
        MultiChecker.PlayerNameFrame.Parent = MultiChecker.MainFrame
        MultiChecker.PlayerNameFrame.AnchorPoint = Vector2.new(.5, .5)
        MultiChecker.PlayerNameFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        MultiChecker.PlayerNameFrame.BackgroundTransparency = .5
        MultiChecker.PlayerNameFrame.Position = UDim2.new(.5, 0, .15, 0)
        MultiChecker.PlayerNameFrame.Size = UDim2.new(.6, 0, .15, 0)

        MultiChecker.PlayerNameFrameCorner.CornerRadius = UDim.new(0, 10)
        MultiChecker.PlayerNameFrameCorner.Name = "PlayerNameFrameCorner"
        MultiChecker.PlayerNameFrameCorner.Parent = MultiChecker.PlayerNameFrame

        MultiChecker.PlayerTextBox.Name = "PlayerTextBox"
        MultiChecker.PlayerTextBox.Parent = MultiChecker.PlayerNameFrame
        MultiChecker.PlayerTextBox.AnchorPoint = Vector2.new(1, .5)
        MultiChecker.PlayerTextBox.BackgroundColor3 = Color3.new(1, 1, 1)
        MultiChecker.PlayerTextBox.BackgroundTransparency = 1
        MultiChecker.PlayerTextBox.Position = UDim2.new(1, 0, .5, 0)
        MultiChecker.PlayerTextBox.Size = UDim2.new(1, 0, 1, 0)
        MultiChecker.PlayerTextBox.Font = "GothamBold"
        MultiChecker.PlayerTextBox.PlaceholderText = "Nickname"
        MultiChecker.PlayerTextBox.Text = ""
        MultiChecker.PlayerTextBox.TextColor3 = Color3.new(1, 1, 1)
        MultiChecker.PlayerTextBox.TextScaled = true
        MultiChecker.PlayerTextBox.TextSize = 16
        MultiChecker.PlayerTextBox.TextWrapped = true
        MultiChecker.PlayerTextBox.ClearTextOnFocus = true

        MultiChecker.PlayerTextBoxConstraint.Parent = MultiChecker.PlayerTextBox
        MultiChecker.PlayerTextBoxConstraint.MaxTextSize = 20

        MultiChecker.FsFrame.Name = "FsMulti"
        MultiChecker.FsFrame.Parent = MultiChecker.MainFrame
        MultiChecker.FsFrame.AnchorPoint = Vector2.new(1, .5)
        MultiChecker.FsFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        MultiChecker.FsFrame.BackgroundTransparency = 0
        MultiChecker.FsFrame.BorderSizePixel = 1
        MultiChecker.FsFrame.Position = UDim2.new(.49, 0, .4, 0)
        MultiChecker.FsFrame.Size = UDim2.new(.46, 0, .21, 0)

        MultiChecker.FsFrameText.Name = "FsMultiText"
        MultiChecker.FsFrameText.Parent = MultiChecker.FsFrame
        MultiChecker.FsFrameText.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        MultiChecker.FsFrameText.BackgroundTransparency = 1
        MultiChecker.FsFrameText.TextTransparency = 0
        MultiChecker.FsFrameText.Position = UDim2.new(0, 0, .28, 0)
        MultiChecker.FsFrameText.Size = UDim2.new(1, 0, .48, 0)
        MultiChecker.FsFrameText.Font = "GothamBold"
        MultiChecker.FsFrameText.Text = ""
        MultiChecker.FsFrameText.TextScaled = true
        MultiChecker.FsFrameText.TextColor3 = Color3.new(.913725, .913725, .913725)
        MultiChecker.FsFrameText.TextSize = 25
        MultiChecker.FsFrameText.TextXAlignment = Enum.TextXAlignment.Center

        MultiChecker.FsFrameCorner.CornerRadius = UDim.new(0, 10)
        MultiChecker.FsFrameCorner.Name = "FsFrameCorner"
        MultiChecker.FsFrameCorner.Parent = MultiChecker.FsFrame

        MultiChecker.BtFrame.Name = "BtMulti"
        MultiChecker.BtFrame.Parent = MultiChecker.MainFrame
        MultiChecker.BtFrame.AnchorPoint = Vector2.new(1, .5)
        MultiChecker.BtFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        MultiChecker.BtFrame.BackgroundTransparency = 0
        MultiChecker.BtFrame.BorderSizePixel = 1
        MultiChecker.BtFrame.Position = UDim2.new(.49, 0, .63, 0)
        MultiChecker.BtFrame.Size = UDim2.new(.46, 0, .21, 0)

        MultiChecker.BtFrameText.Name = "BtMultiText"
        MultiChecker.BtFrameText.Parent = MultiChecker.BtFrame
        MultiChecker.BtFrameText.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        MultiChecker.BtFrameText.BackgroundTransparency = 1
        MultiChecker.BtFrameText.TextTransparency = 0
        MultiChecker.BtFrameText.Position = UDim2.new(0, 0, .28, 0)
        MultiChecker.BtFrameText.Size = UDim2.new(1, 0, .48, 0)
        MultiChecker.BtFrameText.Font = "GothamBold"
        MultiChecker.BtFrameText.Text = ""
        MultiChecker.BtFrameText.TextScaled = true
        MultiChecker.BtFrameText.TextColor3 = Color3.new(.913725, .913725, .913725)
        MultiChecker.BtFrameText.TextSize = 25
        MultiChecker.BtFrameText.TextXAlignment = Enum.TextXAlignment.Center

        MultiChecker.BtFrameCorner.CornerRadius = UDim.new(0, 10)
        MultiChecker.BtFrameCorner.Name = "BtFrameCorner"
        MultiChecker.BtFrameCorner.Parent = MultiChecker.BtFrame

        MultiChecker.PpFrame.Name = "PpMulti"
        MultiChecker.PpFrame.Parent = MultiChecker.MainFrame
        MultiChecker.PpFrame.AnchorPoint = Vector2.new(1, .5)
        MultiChecker.PpFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        MultiChecker.PpFrame.BackgroundTransparency = 0
        MultiChecker.PpFrame.BorderSizePixel = 1
        MultiChecker.PpFrame.Position = UDim2.new(.49, 0, .858, 0)
        MultiChecker.PpFrame.Size = UDim2.new(.46, 0, .21, 0)

        MultiChecker.PpFrameText.Name = "PpMultiText"
        MultiChecker.PpFrameText.Parent = MultiChecker.PpFrame
        MultiChecker.PpFrameText.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        MultiChecker.PpFrameText.BackgroundTransparency = 1
        MultiChecker.PpFrameText.TextTransparency = 0
        MultiChecker.PpFrameText.Position = UDim2.new(0, 0, .28, 0)
        MultiChecker.PpFrameText.Size = UDim2.new(1, 0, .48, 0)
        MultiChecker.PpFrameText.Font = "GothamBold"
        MultiChecker.PpFrameText.Text = ""
        MultiChecker.PpFrameText.TextScaled = true
        MultiChecker.PpFrameText.TextColor3 = Color3.new(.913725, .913725, .913725)
        MultiChecker.PpFrameText.TextSize = 25
        MultiChecker.PpFrameText.TextXAlignment = Enum.TextXAlignment.Center

        MultiChecker.PpFrameCorner.CornerRadius = UDim.new(0, 10)
        MultiChecker.PpFrameCorner.Name = "PpFrameCorner"
        MultiChecker.PpFrameCorner.Parent = MultiChecker.PpFrame

        MultiChecker.MsFrame.Name = "MsMulti"
        MultiChecker.MsFrame.Parent = MultiChecker.MainFrame
        MultiChecker.MsFrame.AnchorPoint = Vector2.new(1, .5)
        MultiChecker.MsFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        MultiChecker.MsFrame.BackgroundTransparency = 0
        MultiChecker.MsFrame.BorderSizePixel = 1
        MultiChecker.MsFrame.Position = UDim2.new(.97, 0, .4, 0)
        MultiChecker.MsFrame.Size = UDim2.new(.46, 0, .21, 0)

        MultiChecker.MsFrameText.Name = "MsMultiText"
        MultiChecker.MsFrameText.Parent = MultiChecker.MsFrame
        MultiChecker.MsFrameText.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        MultiChecker.MsFrameText.BackgroundTransparency = 1
        MultiChecker.MsFrameText.TextTransparency = 0
        MultiChecker.MsFrameText.Position = UDim2.new(0, 0, .28, 0)
        MultiChecker.MsFrameText.Size = UDim2.new(1, 0, .48, 0)
        MultiChecker.MsFrameText.Font = "GothamBold"
        MultiChecker.MsFrameText.Text = ""
        MultiChecker.MsFrameText.TextScaled = true
        MultiChecker.MsFrameText.TextColor3 = Color3.new(.913725, .913725, .913725)
        MultiChecker.MsFrameText.TextSize = 25
        MultiChecker.MsFrameText.TextXAlignment = Enum.TextXAlignment.Center

        MultiChecker.MsFrameCorner.CornerRadius = UDim.new(0, 10)
        MultiChecker.MsFrameCorner.Name = "MsFrameCorner"
        MultiChecker.MsFrameCorner.Parent = MultiChecker.MsFrame

        MultiChecker.JfFrame.Name = "JfMulti"
        MultiChecker.JfFrame.Parent = MultiChecker.MainFrame
        MultiChecker.JfFrame.AnchorPoint = Vector2.new(1, .5)
        MultiChecker.JfFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        MultiChecker.JfFrame.BackgroundTransparency = 0
        MultiChecker.JfFrame.BorderSizePixel = 1
        MultiChecker.JfFrame.Position = UDim2.new(.97, 0, .63, 0)
        MultiChecker.JfFrame.Size = UDim2.new(.46, 0, .21, 0)

        MultiChecker.JfFrameText.Name = "JfMultiText"
        MultiChecker.JfFrameText.Parent = MultiChecker.JfFrame
        MultiChecker.JfFrameText.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        MultiChecker.JfFrameText.BackgroundTransparency = 1
        MultiChecker.JfFrameText.TextTransparency = 0
        MultiChecker.JfFrameText.Position = UDim2.new(0, 0, .28, 0)
        MultiChecker.JfFrameText.Size = UDim2.new(1, 0, .48, 0)
        MultiChecker.JfFrameText.Font = "GothamBold"
        MultiChecker.JfFrameText.Text = ""
        MultiChecker.JfFrameText.TextScaled = true
        MultiChecker.JfFrameText.TextColor3 = Color3.new(.913725, .913725, .913725)
        MultiChecker.JfFrameText.TextSize = 25
        MultiChecker.JfFrameText.TextXAlignment = Enum.TextXAlignment.Center

        MultiChecker.JfFrameCorner.CornerRadius = UDim.new(0, 10)
        MultiChecker.JfFrameCorner.Name = "JfFrameCorner"
        MultiChecker.JfFrameCorner.Parent = MultiChecker.JfFrame

        MultiChecker.TokensFrame.Name = "Tokens"
        MultiChecker.TokensFrame.Parent = MultiChecker.MainFrame
        MultiChecker.TokensFrame.AnchorPoint = Vector2.new(1, .5)
        MultiChecker.TokensFrame.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        MultiChecker.TokensFrame.BackgroundTransparency = 0
        MultiChecker.TokensFrame.BorderSizePixel = 1
        MultiChecker.TokensFrame.Position = UDim2.new(.97, 0, .858, 0)
        MultiChecker.TokensFrame.Size = UDim2.new(.46, 0, .21, 0)

        MultiChecker.TokensFrameText.Name = "TokensMultiText"
        MultiChecker.TokensFrameText.Parent = MultiChecker.TokensFrame
        MultiChecker.TokensFrameText.BackgroundColor3 = Color3.new(.156863, .156863, .156863)
        MultiChecker.TokensFrameText.BackgroundTransparency = 1
        MultiChecker.TokensFrameText.TextTransparency = 0
        MultiChecker.TokensFrameText.Position = UDim2.new(0, 0, .28, 0)
        MultiChecker.TokensFrameText.Size = UDim2.new(1, 0, .48, 0)
        MultiChecker.TokensFrameText.Font = "GothamBold"
        MultiChecker.TokensFrameText.Text = ""
        MultiChecker.TokensFrameText.TextScaled = true
        MultiChecker.TokensFrameText.TextColor3 = Color3.new(.913725, .913725, .913725)
        MultiChecker.TokensFrameText.TextSize = 25
        MultiChecker.TokensFrameText.TextXAlignment = Enum.TextXAlignment.Center

        MultiChecker.TokensFrameCorner.CornerRadius = UDim.new(0, 10)
        MultiChecker.TokensFrameCorner.Name = "TokensFrameCorner"
        MultiChecker.TokensFrameCorner.Parent = MultiChecker.TokensFrame

        MultiChecker.PlayerTextBox.FocusLost:Connect(function()
            for _, player in pairs(Players:GetPlayers()) do
                if (string.sub(string.lower(player.Name), 1, string.len(MultiChecker.PlayerTextBox.Text))) == string.lower(MultiChecker.PlayerTextBox.Text) then
                    MultiChecker.PlayerTextBox.Text = player.Name
                    local Multiplier = HttpService:JSONDecode(Players[MultiChecker.PlayerTextBox.Text].PrivateStats.Inventory.Value)
                    MultiChecker.FsFrameText.Text = "Fist: x" .. tostring(Multiplier.FSMultiplier)
                    MultiChecker.BtFrameText.Text = "Body: x" .. tostring(Multiplier.BTMultiplier)
                    MultiChecker.PpFrameText.Text = "Psychic: x" .. tostring(Multiplier.PPMultiplier)
                    MultiChecker.MsFrameText.Text = "Speed: x" .. tostring(Multiplier.MSMultiplier)
                    MultiChecker.JfFrameText.Text = "Jump: x" .. tostring(Multiplier.JFMultiplier)
                    MultiChecker.TokensFrameText.Text = "Tokens: " .. formatstats(Players[MultiChecker.PlayerTextBox.Text].PrivateStats.Token.Value)
                end
            end
        end)
    end
end

local function destroyUtility(name)
    for _, object in pairs(CoreGui:GetChildren()) do
        if name == "Stats Checker" and object.Name == "Stats Checker" then
            object:Destroy()
        elseif name == "Stats Counter" and object.Name == "Stats Counter" then
            object:Destroy()
        elseif name == "Multi Checker" and object.Name == "Multi Checker" then
            object:Destroy()
        end
    end
end

Components.Utilities:OnChanged(function()
    local lenUtility = (function() local count = 0 for i,v in pairs(Flags["Utilities"].Value) do count += 1 end return count end)()
    local lenOldUtility = (function() local count = 0 for i,v in pairs(oldUtilities) do count += 1 end return count end)()

    if lenUtility > lenOldUtility then
        for utility in pairs(Flags["Utilities"].Value) do
            if not oldUtilities[utility] then
                loadUtility(utility)
                break
            end
        end
    else
        for utility in pairs(oldUtilities) do
            if not Flags["Utilities"].Value[utility] then
                destroyUtility(utility)
                break
            end
        end
    end
    
    oldUtilities = table.clone(Flags["Utilities"].Value)
end)

Components.Esp:OnChanged(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and isAlive(player) and CoreGui.ESPFolder:FindFirstChild(player.Name) then
            CoreGui.ESPFolder[player.Name].Adornee = Flags["ESP"].Value and player.Character:WaitForChild("Head") or nil
            CoreGui.ESPFolder[player.Name].Enabled = Flags["ESP"].Value
        end
    end
end)

Components.Highlights:OnChanged(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and isAlive(player) and CoreGui.HFolder:FindFirstChild(player.Name) then
            CoreGui.HFolder[player.Name].Adornee = Flags["Highlights"].Value and player.Character or nil
            CoreGui.HFolder[player.Name].Enabled = Flags["Highlights"].Value
        end
    end
end)

Components.Time:OnChanged(function()
    Lighting.ClockTime = Flags["Time"].Value
end)

Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
    Lighting.ClockTime = Flags["Time"].Value
end)

Components.Quests:OnChanged(function()
    while Flags["Auto Claim Quests"].Value and task.wait() do
        for _, quest in pairs({"MS", "PP", "FS", "BT", "JF"}) do
            RemoteEvent:FireServer({"DLQ", quest, "Claim"})
            task.wait()
        end
        for _, quest in pairs({"PP", "FS", "BT"}) do
            for i = 1, 3 do
                RemoteEvent:FireServer({"WLQ", quest .. i, "Claim"})
                task.wait()
            end
        end
    end
end)

Components.AntiAura:OnChanged(function()
    if Flags["Anti Killing Intent Aura"].Value then
        for _, player in pairs(Players:GetPlayers()) do
            if isAlive(player) then
                for _, object in pairs(player.Character:GetChildren()) do
                    if object.Name == "KillingIntentPart" then 
                        object:Destroy()
                    end
                end
            end
        end
    end
end)

Components.Animations:OnChanged(function()
    if Flags["Animations"].Value ~= "None" then
        for _, object in pairs(Animations[Flags["Animations"].Value]) do
            local Action, SubAction, AssetId = unpack(object)
            if isAlive() then
                LocalPlayer.Character:WaitForChild("Animate", math.huge):WaitForChild(Action, math.huge)[SubAction].AnimationId = AssetId
            end
        end
        if isAlive() then
            LocalPlayer.Character.Humanoid.Jump = true
        end
    end
end)

Components.Fov:OnChanged(function()
    Camera.FieldOfView = Flags["Fov"].Value
end)

Components.CBring:OnChanged(function()
    while Flags["CBring"].Value and task.wait() do
        for _, Target in pairs(Targets) do
            if Target ~= LocalPlayer and isAlive() and isAlive(Players[Target]) then
                Players[Target].Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -1)
            end
        end
    end
end)

Components.AutoC:OnChanged(function()
    while Flags["Spam C"].Value and task.wait() do
        RemoteEvent:FireServer({"Skill_Punch", "Left"})
        RemoteEvent:FireServer({"Skill_Punch", "Right"})
    end
end)

Components.SpamR:OnChanged(function()
    while Flags["Spam R"].Value and task.wait() do
        RemoteEvent:FireServer({"Skill_SpherePunch", Vector3.new(0, 1e20, 0)})
        for _, sphere in pairs(Storage:GetChildren()) do
            task.spawn(function()
                if isAlive() and sphere.Name == getball() and isnetworkowner(sphere) then
                    sphere.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end)
        end
    end
end)

Components.Stack:OnChanged(function()
    if isAlive() then
        RemoteEvent:FireServer({"Respawn"})
    end
    task.delay(1.4, function()
        if Workspace:FindFirstChild("Town") and Flags["Stack"].Value then
            Workspace.Town.Parent = LocalPlayer
        elseif LocalPlayer:FindFirstChild("Town") and not Flags["Stack"].Value then
            LocalPlayer.Town.Parent = Workspace
        end
        task.spawn(function()
            while Flags["Stack"].Value and task.wait() do
                if isAlive() then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, -1e4, 0)
                end
                RemoteEvent:FireServer({"Skill_SpherePunch", Vector3.new(0, 1e20, 0)})
                for _, Target in pairs(Targets) do
                    task.spawn(function()
                        if isAlive() and isAlive(Players[Target]) then
                            Players[Target].Character.HumanoidRootPart.CFrame = CFrame.new(0, 1e5, 0)
                            for _, sphere in pairs(Storage:GetChildren()) do
                                if not LocalPlayer.Character:FindFirstChild("GodModeShield") and not LocalPlayer.Character:FindFirstChild("GodModeShield ") and not LocalPlayer.Character:FindFirstChild("ForceField") and not LocalPlayer.Character:FindFirstChild("SafeZoneShield") then
                                    task.spawn(function()
                                        firetouchinterest(Players[Target].Character.HumanoidRootPart, sphere, 0)
                                    end)
                                end
                            end
                        end
                    end)
                end
            end
        end)
    end)
end)

Components.Spectate:OnChanged(function()
    if Flags["Spectate"].Value then
        for _, Target in pairs(Targets) do
            if isAlive(Players[Target]) then
                Camera.CameraSubject = Players[Target].Character
            end
            TCAdded = Players[Target].CharacterAdded:Connect(function(character)
                Camera.CameraSubject = character:WaitForChild("Humanoid", math.huge)
            end)
            LPCAdded = LocalPlayer.CharacterAdded:Connect(function()
                if Players:FindFirstChild(Target) and isAlive(Players[Target]) then
                    Camera.CameraSubject = Players[Target].Character.Humanoid
                end
            end)
            CChanged = Camera:GetPropertyChangedSignal("CameraSubject"):Connect(function()
                if Players:FindFirstChild(Target) and isAlive(Players[Target]) then
                    Camera.CameraSubject = Players[Target].Character.Humanoid
                end
            end)
        end
    else
        if TCAdded then
            TCAdded:Disconnect()
        end
        if LPCAdded then
            LPCAdded:Disconnect()
        end
        if CChanged then
            CChanged:Disconnect()
        end
        if isAlive() then
            Camera.CameraSubject = LocalPlayer.Character
        end
    end
end)

Components.SoulAttack:OnChanged(function()
    while Flags["Soul Attack"].Value and task.wait() do
        for _, Target in pairs(Targets) do
            if isAlive() and isAlive(Players[Target]) and not Players[Target].Character:FindFirstChild("ForceField") and not Players[Target].Character:FindFirstChild("SafeZoneShield") and not Players[Target].Character:FindFirstChild("GodModeShield") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = Players[Target].Character.HumanoidRootPart.CFrame + Players[Target].Character.HumanoidRootPart.CFrame.UpVector * 40
                RemoteEvent:FireServer({"Skill_SoulAttack_Start", Players[Target]})
                RemoteEvent:FireServer({"Skill_SoulAttack_End"})
                break
            end
        end
    end
end)

Components.SoulReap:OnChanged(function()
    while Flags["Soul Reap"].Value and task.wait() do
        for _, Target in pairs(Targets) do
            if isAlive() and isAlive(Players[Target]) and not Players[Target].Character:FindFirstChild("ForceField") and not Players[Target].Character:FindFirstChild("SafeZoneShield") and not Players[Target].Character:FindFirstChild("GodModeShield") then
                RemoteEvent:FireServer({"Skill_SoulReap", Players[Target]})
                break
            end
        end
    end
end)

Components.HellFire:OnChanged(function()
    while Flags["Hell Fire"].Value and task.wait() do
        for _, Target in pairs(Targets) do
            if isAlive() and isAlive(Players[Target]) then
                RemoteEvent:FireServer({"Skill_DevilFlame", Players[Target]})
                break
            end
        end
    end
end)

Components.LoopTeleport:OnChanged(function()
    while Flags["Loop Teleport"].Value and task.wait() do
        for _, Target in pairs(Targets) do
            if isAlive() and isAlive(Players[Target]) then
                LocalPlayer.Character.HumanoidRootPart.CFrame = Players[Target].Character.HumanoidRootPart.CFrame
            end
        end
    end
end)

Components.SitOnHead:OnChanged(function()
    while Flags["Sit On Head"].Value and task.wait() do
        for _, Target in pairs(Targets) do
            if isAlive() and isAlive(Players[Target]) then
                LocalPlayer.Character.Humanoid.Sit = true
                LocalPlayer.Character.HumanoidRootPart.CFrame = Players[Target].Character:WaitForChild("Head", math.huge).CFrame * CFrame.new(0, 2.5, 0)
            end
        end
    end
end)

Components.CBringAll:OnChanged(function()
    while Flags["CBring All"].Value and task.wait() do
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and not table.find(Whitelisted, player.Name) and isAlive() and isAlive(player) then
                player.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 1
            end
        end
    end
end)

Components.StackAll:OnChanged(function()
    while Flags["Stack All"].Value and task.wait() do
        RemoteEvent:FireServer({"Skill_SpherePunch", Vector3.new(0, 1e20, 0)})
        for _, player in pairs(Players:GetPlayers()) do
            task.spawn(function()
                if (player ~= LocalPlayer and isAlive() and isAlive(player) and not table.find(Whitelisted, player.Name)) and (not player.Character:FindFirstChild("SafeZoneShield") and not player.Character:FindFirstChild("ForceField") and not player.Character:FindFirstChild("GodModeShield")) and (not LocalPlayer.Character:FindFirstChild("SafeZoneShield") and not LocalPlayer.Character:FindFirstChild("ForceField") and not LocalPlayer.Character:FindFirstChild("GodModeShield") and not LocalPlayer.Character:FindFirstChild("GodModeShield ")) and (player.PrivateStats.BodyToughness.Value <= PrivateStats.FistStrength.Value * 1.5) then
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(15e2, -55e2, -25e2)
                    for _, sphere in pairs(Storage:GetChildren()) do
                        task.spawn(function()
                            if sphere.Name == getball() then
                                firetouchinterest(player.Character.HumanoidRootPart, sphere, 0)
                            end
                        end)
                    end
                end
            end)
        end
    end
end)

Components.SoulAttackAll:OnChanged(function()
    while Flags["Soul Attack All"].Value and task.wait() do
        for _, player in pairs(Players:GetPlayers()) do
            if (player ~= LocalPlayer and isAlive() and isAlive(player) and not table.find(Whitelisted, player.Name)) and (not player.Character:FindFirstChild("SafeZoneShield") and not player.Character:FindFirstChild("ForceField") and not player.Character:FindFirstChild("GodModeShield")) and (not LocalPlayer.Character:FindFirstChild("SafeZoneShield") and not LocalPlayer.Character:FindFirstChild("ForceField") and not LocalPlayer.Character:FindFirstChild("GodModeShield") and not LocalPlayer.Character:FindFirstChild("GodModeShield ")) and (player.PrivateStats.PsychicPower.Value * 10 <= PrivateStats.PsychicPower.Value) then
                LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(player.Character.HumanoidRootPart.Velocity / 10)
                RemoteEvent:FireServer({"Skill_SoulAttack_Start", player})
                RemoteEvent:FireServer({"Skill_SoulAttack_End"})
                break
            end
        end
    end
end)

Components.HellFireAll:OnChanged(function()
    while Flags["Hell Fire All"].Value and task.wait() do
        for _, player in pairs(Players:GetPlayers()) do
            if (player ~= LocalPlayer and isAlive() and isAlive(player) and not table.find(Whitelisted, player.Name)) and (not player.Character:FindFirstChild("SafeZoneShield") and not player.Character:FindFirstChild("ForceField") and not player.Character:FindFirstChild("GodModeShield")) and (not LocalPlayer.Character:FindFirstChild("SafeZoneShield") and not LocalPlayer.Character:FindFirstChild("ForceField") and not LocalPlayer.Character:FindFirstChild("GodModeShield") and not LocalPlayer.Character:FindFirstChild("GodModeShield ")) and (player.PrivateStats.PsychicPower.Value * 100 <= PrivateStats.PsychicPower.Value) then
                LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(player.Character.HumanoidRootPart.Velocity / 10)
                RemoteEvent:FireServer({"Skill_DevilFlame", Players[player.Name]})
                break
            end
        end
    end
end)

Components.SoulReapAll:OnChanged(function()
    while Flags["Soul Reap All"].Value and task.wait() do
        for _, player in pairs(Players:GetPlayers()) do
            if (player ~= LocalPlayer and isAlive() and isAlive(player) and not table.find(Whitelisted, player.Name)) and (not player.Character:FindFirstChild("SafeZoneShield") and not player.Character:FindFirstChild("ForceField") and not player.Character:FindFirstChild("GodModeShield")) and (not LocalPlayer.Character:FindFirstChild("SafeZoneShield") and not LocalPlayer.Character:FindFirstChild("ForceField")) and (player.PrivateStats.PsychicPower.Value * 1000 <= PrivateStats.PsychicPower.Value) then
                RemoteEvent:FireServer({"Skill_SoulReap", Players[player.Name]})
                break
            end
        end
    end
end)

Components.LoopTeleportToLocation:OnChanged(function()
    while Flags["Loop Teleport To Location"].Value and task.wait() do
        if isAlive() then
            LocalPlayer.Character.HumanoidRootPart.CFrame = teleportposition[Flags["Locations"].Value]
        end
    end
end)

Components.SpamS:OnChanged(function()
    while Flags["Spam Sounds"].Value and task.wait(Flags["Cooldown Of Spam Sounds"].Value) do
        if isAlive() then
            for _, object in pairs(LocalPlayer.Character.Head:GetChildren()) do
                if object:IsA("Sound") then
                    object:Play()
                end
            end
        end
    end
end)

Components.LagS:OnChanged(function()
    while Flags["Spam Z"].Value and task.wait() do
        RemoteEvent:FireServer({"Skill_KillingIntent_Start", "Start"})
    end
end)

Components.Teleport:OnChanged(function()
    while Flags["Teleport To Starter Camera"].Value and task.wait() do
        if isAlive() then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(705, 942, 846)
        end
    end
end)

Components.SpamX:OnChanged(function()
    while Flags["Spam X"].Value and task.wait() do
        RemoteEvent:FireServer({"ConcealRevealAura", "Start"})
    end
end)

Components.SpamT:OnChanged(function()
    while Flags["Spam T"].Value and task.wait() do
        RemoteEvent:FireServer({"Skill_Invisible", "Start"})
    end
end)

Components.RGBRank:OnChanged(function()
    if Flags["Rainbow Rank"].Value then
        while Flags["Rainbow Rank"].Value and task.wait() do
            RemoteEvent:FireServer({"ChangeRankEmblem", math.random(1, 10)})
        end
    else
        task.delay(.5, function()
            RemoteEvent:FireServer({"ChangeRankEmblem", 10})
        end)
    end
end)

Components.RGBWeight:OnChanged(function()
    if Flags["Rainbow Weight"].Value then
        while Flags["Rainbow Weight"].Value and task.wait() do
            RemoteEvent:FireServer({"Weight", "Weight" .. math.random(1, 4)})
        end
    else
        task.delay(.5, function()
            RemoteEvent:FireServer({"Weight", "Unequip"})
        end)
    end
end)

Components.RGBNames:OnChanged(function()
    if Flags["Rainbow Names"].Value then
        while Flags["Rainbow Names"].Value and task.wait() do
            for _, player in pairs(Players:GetPlayers()) do
                if isAlive(player) then
                    player.Character:WaitForChild("Head", math.huge):WaitForChild("NameBbGui", math.huge):WaitForChild("NameTxt", math.huge).TextColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                    player.Character:WaitForChild("Head", math.huge):WaitForChild("NameBbGui", math.huge):WaitForChild("NameTxt", math.huge).TextStrokeColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                end
            end
        end
    else
        task.wait()
        for _, player in pairs(Players:GetPlayers()) do
            if isAlive(player) then
                player.Character:WaitForChild("Head", math.huge):WaitForChild("NameBbGui", math.huge):WaitForChild("NameTxt", math.huge).TextColor3 = updcolor(player:WaitForChild("leaderstats", math.huge).Status.Value)
                player.Character:WaitForChild("Head", math.huge):WaitForChild("NameBbGui", math.huge):WaitForChild("NameTxt", math.huge).TextStrokeColor3 = updcolorstroke(player:WaitForChild("leaderstats", math.huge).Status.Value)
            end
        end
    end
end)

Components.CustomNames:OnChanged(function()
    if Flags["Custom Names"].Value then
        while Flags["Custom Names"].Value and task.wait() do
            for _, player in pairs(Players:GetPlayers()) do
                if isAlive(player) then
                    player.Character:WaitForChild("Head", math.huge):WaitForChild("NameBbGui", math.huge):WaitForChild("NameTxt", math.huge).TextColor3 = Flags["Custom Color"].Value
                    player.Character:WaitForChild("Head", math.huge):WaitForChild("NameBbGui", math.huge):WaitForChild("NameTxt", math.huge).TextStrokeColor3 = Flags["Custom Color"].Value
                end
            end
        end
    else
        task.wait()
        for _, player in pairs(Players:GetPlayers()) do
            if isAlive(player) then
                player.Character:WaitForChild("Head", math.huge):WaitForChild("NameBbGui", math.huge):WaitForChild("NameTxt", math.huge).TextColor3 = updcolor(player:WaitForChild("leaderstats", math.huge).Status.Value)
                player.Character:WaitForChild("Head", math.huge):WaitForChild("NameBbGui", math.huge):WaitForChild("NameTxt", math.huge).TextStrokeColor3 = updcolorstroke(player:WaitForChild("leaderstats", math.huge).Status.Value)
            end
        end
    end
end)

Components.Spin:OnChanged(function()
    if isAlive() then
        for _, object in pairs(LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
            if object.Name == "Spin" then
                object:Destroy()
            end
        end
        if Flags["Spin"].Value  then
            local Body = Instance.new("BodyAngularVelocity")
            Body.Name = "Spin"
            Body.Parent = LocalPlayer.Character.HumanoidRootPart
            Body.MaxTorque = Vector3.new(0, math.huge, 0)
            Body.AngularVelocity = Vector3.new(0, Flags["Spin Speed"].Value, 0)
        end
    end
end)

Components.SpinSpeed:OnChanged(function()
    if Flags["Spin"].Value and isAlive() then
        if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Spin") then
            LocalPlayer.Character.HumanoidRootPart.Spin.AngularVelocity = Vector3.new(0, Flags["Spin Speed"].Value, 0)
        end
    end
end)

Components.Gravity:OnChanged(function()
    if Flags["Gravity"].Value then
        Workspace.Gravity = Flags["Gravity value"].Value
    else
        Workspace.Gravity = StockGravity
    end
end)

Components.GravityValue:OnChanged(function()
    if Flags["Gravity"].Value then
        Workspace.Gravity = Flags["Gravity value"].Value
    end
end)

Tabs.Visual:AddButton({
    Title = "Better sky",
    Callback = function()
        if Lighting:FindFirstChild("SunRays") then
            Lighting:FindFirstChild("SunRays"):Destroy()
        end
        local Skybox = Instance.new("Sky", Lighting)
        Skybox.CelestialBodiesShown = false
        local Textures = {
            SkyboxBk = "http://www.roblox.com/asset/?id=159454299",
            SkyboxDn = "http://www.roblox.com/asset/?id=159454296",
            SkyboxFt = "http://www.roblox.com/asset/?id=159454293",
            SkyboxLf = "http://www.roblox.com/asset/?id=159454286",
            SkyboxRt = "http://www.roblox.com/asset/?id=159454300",
            SkyboxUp = "http://www.roblox.com/asset/?id=159454288"
        }
        for Direction, TextureUrl in pairs(Textures) do
            Skybox[Direction] = TextureUrl
        end
    end
})

Tabs.Visual:AddButton({
    Title = "Black Map",
    Callback = function()
        local objects = {
            {Workspace.Terrain, "Water"},
            {Workspace.Main.TrainingRock, "Rock"},
            {Workspace.Town.Core, "Material"},
            {Workspace.Town, "object"},
            {Workspace.Main, "object"},
            {Workspace.Main.MouseIgnoreGroup, "object"},
            {Workspace.Main.QuestNPC.Sathopian, "object"},
            {Workspace.Main.TrainingArea, "TrainingArea"},
            {Workspace.Town.Color.Tree1, "Tree"},
            {Workspace.Town.Color.Tree2, "Tree"},
            {Workspace.Town.Color.Tree3, "Tree"},
            {Workspace.Main.TrainingCrystal, "Crystal"},
            {Workspace.Main.Waterfall, "Waterfall"},
            {Workspace.Main.Volcano, "Volcano"},
            {Workspace.Main.IceMountain, "IceMountain"},
            {Workspace.Main.Tornado, "Tornado"},
            {Workspace.Town.Color.Floor, "Children"},
            {Workspace.Town.Core:GetDescendants(), "SpotLight"}
        }
        
        for _, objects1 in pairs(objects) do
            local object = objects1[1]
            local property = objects1[2]
        
            if object and property then
                if property == "Water" then
                    object.WaterColor = Color3.new(0, 0, 0)
                    object.WaterTransparency = 0
                elseif property == "Rock" then
                    object.Color = Color3.new(0, 0, 0)
                elseif property == "Crystal" then
                    for _, Child in pairs(object:GetChildren()) do
                        if Child.Name == "Part" then
                            Child.Color = Color3.new(0, 0, 0)
                            Child.Material = Enum.Material.Foil
                        elseif Child.Name == "CyanGem" then
                            for _, Child1 in pairs(Child:GetChildren()) do
                                Child1.Color = Color3.new(0, 0, 0)
                            end
                        elseif Child.Name == "cloud" then
                            for _, Child1 in pairs(Child:GetChildren()) do
                                Child1.Color = Color3.new(0, 0, 0)
                            end
                        end
                    end
                elseif property == "Waterfall" then
                    for _, Child in pairs(object:GetChildren()) do
                        if Child:IsA("BasePart") then
                            Child.Color = Color3.new(0, 0, 0)
                            if Child.Name == "Union" then
                                Child.UsePartColor = true
                            end
                        end
                    end
                elseif property == "Volcano" then
                    for _, Child in pairs(object:GetChildren()) do
                        if Child.Name == "LavaFloor" then
                            Child.Color = Color3.new(0, 0, 0)
                            Child.UsePartColor = true
                        elseif Child.Name == "Lava" then
                            for _, Child1 in pairs(Child:GetChildren()) do
                                if Child1.Name == ("LavaPart" or "TouchPart") then
                                    Child1.Color = Color3.new(0, 0, 0)
                                elseif Child1.Name == "SmokeEmitter" then
                                    Child1.Color = Color3.new(0, 0, 0)
                                elseif Child1.Name == "Splash" then
                                    Child1.Color = Color3.new(0, 0, 0)
                                end
                            end
                        elseif Child.Name == "Parts" then
                            for _, Child1 in pairs(Child:GetChildren()) do
                                Child1.Color = Color3.new(0, 0, 0)
                            end
                        end
                    end
                elseif property == "IceMountain" then
                    for _, Child in pairs(object:GetChildren()) do
                        Child.Color = Color3.new(0, 0, 0)
                    end
                elseif property == "Tornado" then
                    for _, Child in pairs(object:GetChildren()) do
                        if Child.Name == "Dust" then
                            Child.Color = Color3.new(0, 0, 0)
                        else
                            Child.Color = Color3.new(0, 0, 0)
                        end
                    end
                elseif property == "TrainingArea" then
                    for _, Child in pairs(object:GetChildren()) do
                        if Child.Name:match("StarFSTraining%d") then
                            Child.Color = Color3.new(0, 0, 0)
                            for _, Child1 in pairs(Child:GetChildren()) do
                                if Child1:IsA("BasePart") then
                                    Child1.Color = Color3.new(0, 0, 0)
                                end
                            end
                        elseif Child.Name:match("PPTrainingPart") then
                            Child.Color = Color3.new(0, 0, 0)
                        elseif Child.Name:match("GreenFirePart") then
                            Child.Color = Color3.new(0, 0, 0)
                        elseif Child.Name:match("AcidPart") then
                            Child.Color = Color3.new(0, 0, 0)
                        elseif Child.Name:match("LavaPart2") then
                            Child.Color = Color3.new(0, 0, 0)
                        end
                    end
                elseif property == "Tree" then
                    for _, Leaf in pairs(object.Leaf:GetChildren()) do
                        Leaf.Color = Color3.new(0, 0, 0)
                    end
                    for _, Trunk in pairs(object.Trunk:GetChildren()) do
                        Trunk.Color = Color3.new(0, 0, 0)
                    end
                elseif property == "Children" then
                    for _, Child in pairs(object:GetChildren()) do
                        if Child:IsA("BasePart") then
                            Child.Color = Color3.new(0, 0, 0)
                            if Child.Name == "Union" then
                                Child.UsePartColor = true
                            end
                        end
                    end
                elseif property == "SpotLight" then
                    for _, Light in pairs(object) do
                        if Light:IsA("SpotLight") then
                            Light.Color = Color3.new(0, 0, 0)
                            Light:GetPropertyChangedSignal("Color"):Connect(function()
                                Light.Color = Color3.new(0, 0, 0)
                            end)
                        end
                    end
                elseif property == "object" then 
                    for _, ObjectToDestroy in pairs(object:GetChildren()) do
                        if table.find({"Halloween", "GhostRiderCollisionPart", "GrimCollisionPart", "DangerSign", "NPCBlockPart1", "NPCBlockPart2", "CuteFoxyBeanie"}, ObjectToDestroy.Name) then
                            ObjectToDestroy:Destroy()
                        end
                    end
                elseif property == "Material" then 
                    for _, Part in pairs(object:GetChildren()) do
                        if Part:IsA("BasePart") and Part.Material == Enum.Material.Pebble then
                            Part.Material = Enum.Material.Cobblestone
                        end
                    end
                end
            end
        end
    end
})

Tabs.Visual:AddButton({
    Title = "Green Map",
    Callback = function()
        local objects = {
            {Workspace.Terrain, "Water"},
            {Workspace.Main.TrainingRock, "Rock"},
            {Workspace.Town.Core, "Material"},
            {Workspace.Town, "object"},
            {Workspace.Main, "object"},
            {Workspace.Main.MouseIgnoreGroup, "object"},
            {Workspace.Main.QuestNPC.Sathopian, "object"},
            {Workspace.Main.TrainingArea, "TrainingArea"},
            {Workspace.Town.Color.Tree1, "Tree"},
            {Workspace.Town.Color.Tree2, "Tree"},
            {Workspace.Town.Color.Tree3, "Tree"},
            {Workspace.Main.TrainingCrystal, "Crystal"},
            {Workspace.Main.Waterfall, "Waterfall"},
            {Workspace.Main.Volcano, "Volcano"},
            {Workspace.Main.IceMountain, "IceMountain"},
            {Workspace.Main.Tornado, "Tornado"},
            {Workspace.Town.Color.Floor, "Children"},
            {Workspace.Town.Core:GetDescendants(), "SpotLight"}
        }
        
        for _, objects1 in pairs(objects) do
            local object = objects1[1]
            local property = objects1[2]
        
            if object and property then
                if property == "Water" then
                    object.WaterColor = Color3.new(.5, .7, 1)
                    object.WaterTransparency = 1
                elseif property == "Rock" then
                    object.Color = Color3.new(.8, .8, .8)
                elseif property == "Crystal" then
                    for _, Child in pairs(object:GetChildren()) do
                        if Child.Name == "Part" then
                            Child.Color = Color3.new(.624, .953, .914)
                            Child.Material = Enum.Material.Foil
                        elseif Child.Name == "CyanGem" then
                            for _, Child1 in pairs(Child:GetChildren()) do
                                Child1.Color = Color3.new(.016, .687, .926)
                            end
                        elseif Child.Name == "cloud" then
                            for _, Child1 in pairs(Child:GetChildren()) do
                                Child1.Color = Color3.new(.950, .953, .953)
                            end
                        end
                    end
                elseif property == "Waterfall" then
                    for _, Child in pairs(object:GetChildren()) do
                        if Child:IsA("BasePart") then
                            Child.Color = Color3.new(0.471, 0.565, 0.510)
                            if Child.Name == "Union" then
                                    Child.UsePartColor = true
                            end
                        end
                    end
                elseif property == "Volcano" then
                    for _, Child in pairs(object:GetChildren()) do
                        if Child.Name == "LavaFloor" then
                            Child.Color = Color3.new(1, 0, 0)
                            Child.UsePartColor = true
                        elseif Child.Name == "Lava" then
                            for _, Child1 in pairs(Child:GetChildren()) do
                                if Child1.Name == ("LavaPart" or "TouchPart") then
                                    Child1.Color = Color3.new(1, 0, 0)
                                elseif Child1.Name == "SmokeEmitter" then
                                    Child1.Color = Color3.new(.640, .636, .648)
                                elseif Child1.Name == "Splash" then
                                    Child1.Color = Color3.new(.973, .973, .973)
                                end
                            end
                        elseif Child.Name == "Parts" then
                            for _, Child1 in pairs(Child:GetChildren()) do
                                Child1.Color = Color3.new(.412, .251, .157)
                            end
                        end
                    end
                elseif property == "IceMountain" then
                    for _, Child in pairs(object:GetChildren()) do
                        Child.Color = Color3.new(.906, .906, .926)
                    end
                elseif property == "Tornado" then
                    for _, Child in pairs(object:GetChildren()) do
                        if Child.Name == "Dust" then
                            Child.Color = Color3.new(.389, .373, .385)
                        else
                            Child.Color = Color3.new(.640, .636, .648)
                        end
                    end
                elseif property == "Children" then
                    for _, Child in pairs(object:GetChildren()) do
                        if Child:IsA("BasePart") then
                            Child.Color = Color3.new(.632, .769, .550)
                            if Child.Name == "Union" then
                                Child.UsePartColor = true
                            end
                        end
                    end
                elseif property == "TrainingArea" then
                    for _, Child in pairs(object:GetChildren()) do
                        if Child.Name == "StarFSTraining1" then
                            Child.Color = Color3.new(0.016, 0.687, 0.926)
                            for _, Child1 in pairs(Child:GetChildren()) do
                                if Child1:IsA("BasePart") then
                                    if Child1.Name == "Atmosphere1" then
                                        Child1.Color = Color3.new(1, 1, 1)
                                    else
                                        Child1.Color = Color3.new(1, 1, 1)
                                    end
                                end
                            end
                        elseif Child.Name == "StarFSTraining2" then
                            Child.Color = Color3.new(0, 1, 0)
                            for _, Child1 in pairs(Child:GetChildren()) do
                                if Child1:IsA("BasePart") then
                                    if Child1.Name == "Atmosphere1" then
                                        Child1.Color = Color3.new(0, 1, 0)
                                    else
                                        Child1.Color = Color3.new(1, 1, 0)
                                    end
                                end
                            end
                        elseif Child.Name == "StarFSTraining3" then
                            Child.Color = Color3.new(1, 0, 0)
                            for _, Child1 in pairs(Child:GetChildren()) do
                                if Child1:IsA("BasePart") then
                                    if Child1.Name == "Atmosphere1" then
                                        Child1.Color = Color3.new(1, 0.2, 0)
                                    elseif Child1.Name == "Atmosphere2" then
                                        Child1.Color = Color3.new(1, 0.3, 0)
                                    else
                                        Child1.Color = Color3.new(1, 0.2, 0)
                                    end
                                end
                            end
                        elseif Child.Name:match("PPTrainingPart") then
                            Child.Color = Color3.new(0.228, 0.491, 0.083)
                        elseif Child.Name:match("GreenFirePart") then
                            Child.Color = Color3.new(0.640, 0.636, 0.648)
                        elseif Child.Name:match("AcidPart") then
                            Child.Color = Color3.new(0, 1, 0)
                        elseif Child.Name:match("LavaPart2") then
                            Child.Color = Color3.new(1, 0, 0) 
                        end
                    end
                elseif property == "Tree" then
                    for _, Leaf in pairs(object.Leaf:GetChildren()) do
                        if object.Name == "Tree1" then
                            Leaf.Color = Color3.new(0.133333, 0.545098, 0.133333)  
                        elseif object.Name == "Tree2" then
                            Leaf.Color = Color3.new(0.235294, 0.701961, 0.443137) 
                        elseif object.Name == "Tree3" then
                            Leaf.Color = Color3.new(0.180392, 0.545098, 0.341176)   
                        end
                    end
                    for _, Trunk in pairs(object.Trunk:GetChildren()) do
                        Trunk.Color = Color3.new(0.487, 0.361, 0.275)
                    end                 
                elseif property == "SpotLight" then
                    for _, Light in pairs(object) do
                        if Light:IsA("SpotLight") then
                            Light.Color = Color3.new(1, .843137, 0)
                            Light:GetPropertyChangedSignal("Color"):Connect(function()
                                Light.Color = Color3.new(1, .843137, 0)
                            end)
                        end
                    end
                elseif property == "object" then 
                    for _, ObjectToDestroy in pairs(object:GetChildren()) do
                        if table.find({"Halloween", "GhostRiderCollisionPart", "GrimCollisionPart", "DangerSign", "NPCBlockPart1", "NPCBlockPart2", "CuteFoxyBeanie"}, ObjectToDestroy.Name) then
                            ObjectToDestroy:Destroy()
                        end
                    end
                elseif property == "Material" then 
                    for _, Part in pairs(object:GetChildren()) do
                        if Part:IsA("BasePart") and Part.Material == Enum.Material.Pebble then
                            Part.Material = Enum.Material.Cobblestone
                        end
                    end
                end
            end
        end
    end
})

Tabs.Visual:AddButton({
    Title = "Black Menu",
    Callback = function()
        local UIStroke = Instance.new("UIStroke")
        local Corner = Instance.new("UICorner")

        local objects = {
            "InvBtn",
            "LootBoxBtn",
            "BorderFrame1",
            "LootBoxFrame",
            "InvFrame",
            "GangBtn"
        }
        
        for _, objname in pairs(objects) do
            local obj = ScreenGui.MenuFrame:FindFirstChild(objname)
            if obj then
                obj:Destroy()
            end
        end

        local frames = {
            ScreenGui.MenuFrame.SkillFrame,
            ScreenGui.MenuFrame.GangFrame,
            ScreenGui.MenuFrame.SpecialFrame,
            ScreenGui.MenuFrame.SettingFrame,
            ScreenGui.MenuFrame.InfoFrame
        }
        
        for _, frame in pairs(frames) do
            frame.BackgroundColor3 = Color3.new(.039216, .039216, .039216)
        end

        local textobj = {
            "NameTxt",
            "RankTxt",
            "StatusTxt",
            "KilledTxt",
            "MSTxt",
            "JFTxt",
            "RepTxt",
            "GuideTxt"
        }
        
        for _, objectName in pairs(textobj) do
            local obj = ScreenGui.MenuFrame.InfoFrame:FindFirstChild(objectName)
            if obj then
                obj.TextColor3 = Color3.new(1, 1, 1)
            end
        end
        
        ScreenGui.MenuFrame.BorderSizePixel = 0
        ScreenGui.MenuFrame.InfoFrame.FSTxt.TextColor3 = Color3.new(1, .352941, .352941)
        ScreenGui.MenuFrame.InfoFrame.BTTxt.TextColor3 = Color3.new(.988235, .364706, .239216)
        ScreenGui.MenuFrame.InfoFrame.PPTxt.TextColor3 = Color3.new(.317647, .623529, .984314)

        local buttons = {
            {name = "InfoBtn", text = "Stats", position = UDim2.new(0, 0, .01, 0)},
            {name = "SkilBtn", text = "Skills", position = UDim2.new(.25, 0, .01, 0)},
            {name = "SpecialBtn", text = "Shop", position = UDim2.new(.50, 0, .01, 0)},
            {name = "SettingBtn", text = "Settings", position = UDim2.new(.75, 0, .01, 0)}
        }
        
        for _, btnConfig in pairs(buttons) do
            local btn = ScreenGui.MenuFrame:FindFirstChild(btnConfig.name)
            if btn then
                btn.Size = UDim2.new(.25, 0, .07, 0)
                btn.Position = btnConfig.position
                btn.Text = btnConfig.text
            end
        end

        local function setuptextobj(frameName, prefix, count)
            local frame = ScreenGui.MenuFrame[frameName]
            for i = 0, count do
                local obj = frame:FindFirstChild(prefix .. tostring(i))
                if obj then
                    obj.TextColor3 = Color3.new(.29,.77,.27)
                end
            end
        end
        
        setuptextobj("SkillFrame", "SkillTxt", 19)
        setuptextobj("SettingFrame", "SettingTxt", 18)

        local buttons = {
            ScreenGui.DailyQuestFrame.LeftBtn,
            ScreenGui.DailyQuestFrame.RightBtn,
            ScreenGui.MenuBtn,
            ScreenGui.MainQuestFrame.RightBtn,
            ScreenGui.SpecialQuestFrame.LeftBtn,
            ScreenGui.SpecialQuestFrame.RightBtn,
            ScreenGui.WeeklyQuestFrame.LeftBtn
        }
        
        for _, button in pairs(buttons) do
            if button then
                button.BackgroundColor3 = Color3.new(0, 0, 0)
                button.TextColor3 = Color3.new(1, 1, 1)
                button.BorderColor3 = Color3.new(0, 0, 0)
            end
        end

        local rewardFrames = {
            ScreenGui.MainQuestFrame,
            ScreenGui.DailyQuestFrame,
            ScreenGui.SpecialQuestFrame,
            ScreenGui.WeeklyQuestFrame
        }
        
        for _, questFrame in pairs(rewardFrames) do
            for _, direction in pairs({"LeftBtn", "RightBtn"}) do
                local btn = questFrame:FindFirstChild(direction .. "Btn")
                if btn then
                    btn.BackgroundColor3 = Color3.new(.039216, .039216, .039216)
                    btn.TextColor3 = Color3.new(1, 1, 1)
                end
            end

            questFrame.ScrollBarImageColor3 = Color3.new(0, 0, 0)
            questFrame.ScrollBarThickness = 12
            questFrame.BackgroundColor3 = Color3.new(.039216, .039216, .039216)
            questFrame.BorderColor3 = Color3.new(0, 0, 0)

            local header = questFrame:FindFirstChild("HeaderTxt1")
            if header then
                header.BackgroundColor3 = Color3.new(.039216, .039216, .039216)
                header.TextColor3 = Color3.new(1, 1, 1)
            end

            for i = 1, 5 do
                local maxFrame = questFrame:FindFirstChild("MaxFrame" .. tostring(i))
                if maxFrame then
                    maxFrame.BackgroundColor3 = Color3.new(.039216, .039216, .039216)
                    
                    local rewardTxt = maxFrame:FindFirstChild("RewardTxt")
                    if rewardTxt then
                        local gemBtn = rewardTxt:FindFirstChild("GemImgBtn")
                        if gemBtn then
                            gemBtn.ImageColor3 = Color3.new(0, 0, 0)
                            
                            local amountTxt = gemBtn:FindFirstChild("AmountTxt")
                            if amountTxt then
                                amountTxt.TextColor3 = Color3.new(.039216, .039216, .039216)
                                amountTxt.TextStrokeColor3 = Color3.new(0, 0, 0)
                            end
                        end
                    end
                end
            end
        end

        Corner.Parent = ScreenGui.MenuFrame.InfoFrame.RankImgBtn
        Corner.CornerRadius = UDim.new(1, 0)
        UIStroke.Parent = ScreenGui.MenuFrame.InfoFrame.RankImgBtn
        UIStroke.Color = Color3.new(.392157, .392157, .392157)
        UIStroke.Thickness = 2.5

        local amountTxtBtn = ScreenGui.CurrentGemImgBtn:FindFirstChild("AmountTxtBtn")
        if amountTxtBtn then
            amountTxtBtn.TextColor3 = Color3.new(.039216, .039216, .039216)
            amountTxtBtn.TextStrokeColor3 = Color3.new(0, 0, 0)
            ScreenGui.CurrentGemImgBtn.ImageColor3 = Color3.new(0, 0, 0)
        end
    end
})

Tabs.Visual:AddButton({
    Title = "Leaderboards On Spawn",
    Callback = function()
        local Positions = {CFrame.new(359, 252, 830),CFrame.new(359, 252, 810),CFrame.new(359, 252, 790),CFrame.new(359, 264, 830),CFrame.new(359, 264, 810)}
        local Index = 0
        for _, object in pairs(Workspace.Main:GetChildren()) do
            if object:IsA("Part") and object.Name:match("LeaderBoardPart") then
                Index += 1
                object.CFrame = Positions[Index]
                object.Orientation = Vector3.new(0, 90, 0)
                object.Size = Vector3.new(20, 12, 2)
                object.Material = Enum.Material.ForceField
                object.CanCollide = false
            end
        end
        Index = nil
    end
})

Tabs.Usual:AddButton({
    Title = "Fast Teleport",
    Callback = function()
        LocalPlayer:GetMouse().KeyDown:Connect(function(Key, P)
            if P then return end
            if Key == "v" then
                if LocalPlayer:GetMouse().Target and isAlive() then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame - (LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(LocalPlayer:GetMouse().Hit.X, LocalPlayer:GetMouse().Hit.Y + 5, LocalPlayer:GetMouse().Hit.Z))
                end
            end
        end)
    end
})

Tabs.Pvp:AddButton({
    Title = "Teleport",
    Callback = function()
        for _, Target in pairs(Targets) do
            if isAlive() and isAlive(Players[Target]) then
                LocalPlayer.Character.HumanoidRootPart.CFrame = Players[Target].Character.HumanoidRootPart.CFrame
            end
        end
    end
})

Tabs.Teleports:AddButton({
    Title = "Teleport To Location",
    Callback = function()
        if isAlive() then
            LocalPlayer.Character.HumanoidRootPart.CFrame = teleportposition[Flags["Locations"].Value]
        end
    end
})

Tabs.Fun:AddButton({
    Title = "Ball",
    Callback = function()
        if isAlive() then
            for _, object in pairs(LocalPlayer.Character:GetDescendants()) do
                if object:IsA("BasePart") then
                    object.CanCollide = false
                end
            end

            local Ball = LocalPlayer.Character.HumanoidRootPart
            Ball.Shape = Enum.PartType.Ball
            Ball.Size = Vector3.new(5, 5, 5)
            local Humanoid = LocalPlayer.Character.Humanoid
            local Params = RaycastParams.new()
            Params.FilterType = Enum.RaycastFilterType.Blacklist
            Params.FilterDescendantsInstances = {LocalPlayer.Character}
            local tc = RunService.PreRender:Connect(function(Delta)
                Ball.CanCollide = true
                Humanoid.PlatformStand = true
                if UserInputService:GetFocusedTextBox() then return end
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    Ball.RotVelocity = Ball.RotVelocity - Camera.CFrame.RightVector * Delta * 30
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    Ball.RotVelocity = Ball.RotVelocity - Camera.CFrame.LookVector * Delta * 30
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    Ball.RotVelocity += Camera.CFrame.RightVector * Delta * 30
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    Ball.RotVelocity += Camera.CFrame.LookVector * Delta * 30
                end
            end)
            UserInputService.JumpRequest:Connect(function()
                local Result = Workspace:Raycast(Ball.Position, Vector3.new(0, -((Ball.Size.Y / 2) + .3), 0), Params)
                if Result then
                    Ball.Velocity += Vector3.new(0, 60, 0)
                end
            end)
            Camera.CameraSubject = Ball
            if not Ball then
                Ball = true
                Humanoid.Died:Connect(function()
                    tc:Disconnect()
                end)
            end
        end
    end
})

Tabs.Settings:AddButton({
    Title = "Re-join",
    Callback = function()
        TeleportService:TeleportToPlaceInstance(PlaceId, JobId, LocalPlayer)
    end
})

Tabs.Settings:AddButton({
    Title = "Leave",
    Callback = function()
        game:Shutdown()
    end
})

Tabs.Settings:AddButton({
    Title = "Fps Booster",
    Callback = function()
        for _, object in pairs(game:GetDescendants()) do
            if object:IsA("Part") or object:IsA("Union") or object:IsA("CornerWedgePart") or object:IsA("TrussPart") or object:IsA("MeshPart") then
                object.Material = "Plastic"
                object.Reflectance = 0
                if object:IsA("MeshPart") then
                    object.TextureID = 10385902758728957
                end
            elseif object:IsA("Decal") or object:IsA("Texture") then
                object.Transparency = 1
            elseif object:IsA("ParticleEmitter") or object:IsA("Trail") then
                object.Lifetime = NumberRange.new(0)
            elseif object:IsA("Explosion") then
                object.BlastPressure = 1
                object.BlastRadius = 1
            elseif object:IsA("Fire") or object:IsA("SpotLight") or object:IsA("Smoke") then
                object.Enabled = false
            end
        end
        
        for _, effect in pairs(Lighting:GetChildren()) do
            if effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect") or effect:IsA("ColorCorrectionEffect") or effect:IsA("BloomEffect") or effect:IsA("DepthOfFieldEffect") then
                effect.Enabled = false
            end
        end
    end
})

Tabs.Settings:AddButton({
    Title = "Infinite Yield",
    Callback = function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})

Tabs.Settings:AddButton({
    Title = "Dex Explorer",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MassiveHubs/loadstring/refs/heads/main/DexXenoAndRezware"))()
    end
})

Tabs.Settings:AddButton({
    Title = "JobId",
    Callback = function()
        Fluent:Notify({
            Title = "Z3XHub",
            Content = "JobId",
            SubContent = "Copied to your clipboard!",
            Duration = 3
        })
        setclipboard(JobId)
    end
})

Tabs.Settings:AddButton({
    Title = "Discord",
    Callback = function()
        Fluent:Notify({
            Title = "Z3XHub",
            Content = "Discord",
            SubContent = "Copied to your clipboard!",
            Duration = 3
        })
        setclipboard("https://discord.gg/x7gt2yqHpx")
    end
})

Tabs.Settings:AddKeybind("Keybind", {
    Title = "Panic Key",
    Default = "Y",
    Mode = "Toggle",
    Callback = function()
        if isAlive() then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(470, 250, 900)
        end
    end
})

Tabs.Settings:AddKeybind("Keybind", {
    Title = "Respawn",
    Default = "F1",
    Mode = "Toggle",
    Callback = function()
        if isAlive() then
            SavedPosition = LocalPlayer.Character.HumanoidRootPart.CFrame
            SavedCameraCFrame = Camera.CFrame
            Camera.CameraType = "Fixed"
            if not LocalPlayer.Character:FindFirstChild("GodModeShield") and not LocalPlayer.Character:FindFirstChild("GodModeShield ") and not LocalPlayer.Character:FindFirstChild("ForceField") and not LocalPlayer.Character:FindFirstChild("SafeZoneShield") then
                RemoteEvent:FireServer({"QuestTalkStart"})
            end
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(math.huge, -math.huge, math.huge)
        end
        RemoteEvent:FireServer({"Respawn"})
    end
})

Tabs.Settings:AddKeybind("Keybind", {
    Title = "ResetCharacter",
    Default = "F2",
    Mode = "Toggle",
    Callback = function()
        RemoteEvent:FireServer({"ResetCharacter"})
    end
})

local UpdatingStats = {
    {"FistStrength", "Fist"},
    {"BodyToughness", "Body"},
    {"PsychicPower", "Psychic"}
}

for _, player in pairs(Players:GetPlayers()) do
    task.spawn(function()
        if player ~= LocalPlayer then
            player:WaitForChild("LocalSoundFolder", math.huge):Destroy()

            CreateESP(player)
            CreateH(player)

            local PrivateStats = player:WaitForChild("PrivateStats", math.huge)
            local leaderstats = player:WaitForChild("leaderstats", math.huge)
            local Status = leaderstats:WaitForChild("Status", math.huge)

            if isAlive(player) then
                player.Character.ChildAdded:Connect(function(object)
                    task.wait()
                    if object.Name == "KillingIntentPart" and Flags["Anti Killing Intent Aura"].Value then
                        object:Destroy()
                    end
                end)
            end

            for _, object in pairs(UpdatingStats) do
                PrivateStats:WaitForChild(object[1], math.huge):GetPropertyChangedSignal("Value"):Connect(function()
                    if CoreGui.ESPFolder:FindFirstChild(player.Name) then
                        CoreGui.ESPFolder[player.Name].Frame[object[2]].Text = object[2] .. ": " .. formatstats(PrivateStats[object[1]].Value)
                    end
                end)
            end

            Status:GetPropertyChangedSignal("Value"):Connect(function()
                if CoreGui.ESPFolder:FindFirstChild(player.Name) then
                    CoreGui.ESPFolder[player.Name].Frame.Names.TextColor3 = updcolor(Status.Value)
                    CoreGui.ESPFolder[player.Name].Frame.Names.TextStrokeColor3 = updcolorstroke(Status.Value)
                end

                if CoreGui.HFolder:FindFirstChild(player.Name) then
                    CoreGui.HFolder[player.Name].FillColor = updcolor(Status.Value)
                    CoreGui.HFolder[player.Name].OutlineColor = updcolor(Status.Value)
                end
            end)

            player.Chatted:Connect(function(message)
                onChatted(player, message)
            end)

            if isAlive(player) then
                local Humanoid = player.Character:FindFirstChild("Humanoid")
                
                CoreGui.ESPFolder[player.Name].Frame.Health.Text = "Health: " .. formatstats(Humanoid.MaxHealth) .. "/" .. formatstats(Humanoid.MaxHealth)

                Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                    CoreGui.ESPFolder[player.Name].Frame.Health.Text = "Health: " .. formatstats(Humanoid.Health) .. "/" .. formatstats(Humanoid.MaxHealth)
                end)

                player.Character.Humanoid.Died:Connect(function()
                    if CoreGui.ESPFolder:FindFirstChild(player.Name) then
                        CoreGui.ESPFolder[player.Name].Adornee = nil
                        CoreGui.ESPFolder[player.Name].Enabled = false
                    end

                    if CoreGui.HFolder:FindFirstChild(player.Name) then
                        CoreGui.HFolder[player.Name].Adornee = nil
                        CoreGui.HFolder[player.Name].Enabled = false
                    end

                    if Flags["Logs"].Value["Dead"] then
                        if Flags["Type Of Logs"].Value["Chat"] then
                            StarterGui:SetCore("ChatMakeSystemMessage", ({Text = player.DisplayName .. " (@" .. player.Name .. ") Dead", Color = Color3.new(1, 0, 0), Font = "GothamBold", TextSize = 20}))
                        end

                        if Flags["Type Of Logs"].Value["Notify"] then
                            Fluent:Notify({
                                Title = "Z3XHub",
                                Content = "[LOGS]",
                                SubContent = player.DisplayName .. " (@" .. player.Name .. ") Dead",
                                Duration = 3
                            })
                        end

                        if Flags["Type Of Logs"].Value["Console"] then
                            print("[LOGS]: " .. player.DisplayName .. " (@" .. player.Name .. ") Dead")
                        end
                    end
                end)
            end

            player.CharacterAdded:Connect(function(character)
                task.spawn(function()
                    local Humanoid = character:WaitForChild("Humanoid", math.huge)

                    if CoreGui.HFolder:FindFirstChild(player.Name) then
                        CoreGui.HFolder[player.Name].Adornee = Flags["Highlights"].Value and character or nil
                        CoreGui.HFolder[player.Name].Enabled = Flags["Highlights"].Value
                    end

                    if CoreGui.ESPFolder:FindFirstChild(player.Name) then
                        CoreGui.ESPFolder[player.Name].Adornee = Flags["ESP"].Value and character:WaitForChild("Head") or nil
                        CoreGui.ESPFolder[player.Name].Enabled = Flags["ESP"].Value
                    end

                    CoreGui.ESPFolder[player.Name].Frame.Health.Text = "Health: " .. formatstats(Humanoid.MaxHealth) .. "/" .. formatstats(Humanoid.MaxHealth)

                    Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                        CoreGui.ESPFolder[player.Name].Frame.Health.Text = "Health: " .. formatstats(Humanoid.Health) .. "/" .. formatstats(Humanoid.MaxHealth)
                    end)

                    Humanoid.Died:Connect(function()     
                        if CoreGui.ESPFolder:FindFirstChild(player.Name) then
                            CoreGui.ESPFolder[player.Name].Adornee = nil
                            CoreGui.ESPFolder[player.Name].Enabled = false
                        end
    
                        if CoreGui.HFolder:FindFirstChild(player.Name) then
                            CoreGui.HFolder[player.Name].Adornee = nil
                            CoreGui.HFolder[player.Name].Enabled = false
                        end
    
                        if Flags["Logs"].Value["Dead"] then
                            if Flags["Type Of Logs"].Value["Chat"] then
                                StarterGui:SetCore("ChatMakeSystemMessage", ({Text = player.DisplayName .. " (@" .. player.Name .. ") Dead", Color = Color3.new(1, 0, 0), Font = "GothamBold", TextSize = 20}))
                            end
    
                            if Flags["Type Of Logs"].Value["Notify"] then
                                Fluent:Notify({
                                    Title = "Z3XHub",
                                    Content = "[LOGS]",
                                    SubContent = player.DisplayName .. " (@" .. player.Name .. ") Dead",
                                    Duration = 3
                                })
                            end
    
                            if Flags["Type Of Logs"].Value["Console"] then
                                print("[LOGS]: " .. player.DisplayName .. " (@" .. player.Name .. ") Dead")
                            end
                        end
                    end)
                end)

                character.ChildAdded:Connect(function(object)
                    task.wait()
                    if object.Name == "KillingIntentPart" and Flags["Anti Killing Intent Aura"].Value then
                        object:Destroy()
                    end
                end)
            end)
        end
    end)
end

Players.PlayerAdded:Connect(function(player)
    CreateESP(player)
    CreateH(player)

    player:WaitForChild("LocalSoundFolder", math.huge):Destroy()

    local PrivateStats = player:WaitForChild("PrivateStats", math.huge)
    local leaderstats = player:WaitForChild("leaderstats", math.huge)
    local Status = leaderstats:WaitForChild("Status", math.huge)

    if Flags["Logs"].Value["Joined/Left"] then
        if Flags["Type Of Logs"].Value["Chat"] then
            StarterGui:SetCore("ChatMakeSystemMessage", {Text = player.DisplayName .. " (@" .. player.Name .. ") Has joined",Color = Color3.new(0, 1, .101961),Font = "GothamBold",TextSize = 20})
        end

        if Flags["Type Of Logs"].Value["Notify"] then
            Fluent:Notify({
                Title = "Z3XHub",
                Content = "[LOGS]",
                SubContent = player.DisplayName .. " (@" .. player.Name .. ") Has joined",
                Duration = 3
            })
        end

        if Flags["Type Of Logs"].Value["Console"] then
            print("[LOGS]: " .. player.DisplayName .. " (@" .. player.Name .. ") Has joined")
        end
    end

    player.Chatted:Connect(function(message)
        onChatted(player, message)
    end)

    player.CharacterAdded:Connect(function(character)
        task.spawn(function()
            local Humanoid = character:WaitForChild("Humanoid", math.huge)

            if CoreGui.HFolder:FindFirstChild(player.Name) then
                CoreGui.HFolder[player.Name].Adornee = Flags["Highlights"].Value and character or nil
                CoreGui.HFolder[player.Name].Enabled = Flags["Highlights"].Value
            end

            if CoreGui.ESPFolder:FindFirstChild(player.Name) then
                CoreGui.ESPFolder[player.Name].Adornee = Flags["ESP"].Value and character:WaitForChild("Head") or nil
                CoreGui.ESPFolder[player.Name].Enabled = Flags["ESP"].Value
            end
            
            CoreGui.ESPFolder[player.Name].Frame.Health.Text = "Health: " .. formatstats(Humanoid.MaxHealth) .. "/" .. formatstats(Humanoid.MaxHealth)

            Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                CoreGui.ESPFolder[player.Name].Frame.Health.Text = "Health: " .. formatstats(Humanoid.Health) .. "/" .. formatstats(Humanoid.MaxHealth)
            end)

            Humanoid.Died:Connect(function()         
                if CoreGui.ESPFolder:FindFirstChild(player.Name) then
                    CoreGui.ESPFolder[player.Name].Adornee = nil
                    CoreGui.ESPFolder[player.Name].Enabled = false
                end

                if CoreGui.HFolder:FindFirstChild(player.Name) then
                    CoreGui.HFolder[player.Name].Adornee = nil
                    CoreGui.HFolder[player.Name].Enabled = false
                end

                if Flags["Logs"].Value["Dead"] then
                    if Flags["Type Of Logs"].Value["Chat"] then
                        StarterGui:SetCore("ChatMakeSystemMessage", ({Text = player.DisplayName .. " (@" .. player.Name .. ") Dead", Color = Color3.new(1, 0, 0), Font = "GothamBold", TextSize = 20}))
                    end

                    if Flags["Type Of Logs"].Value["Notify"] then
                        Fluent:Notify({
                            Title = "Z3XHub",
                            Content = "[LOGS]",
                            SubContent = player.DisplayName .. " (@" .. player.Name .. ") Dead",
                            Duration = 3
                        })
                    end

                    if Flags["Type Of Logs"].Value["Console"] then
                        print("[LOGS]: " .. player.DisplayName .. " (@" .. player.Name .. ") Dead")
                    end
                end
            end)
        end)
    end)

    for _, object in pairs(UpdatingStats) do
        PrivateStats:WaitForChild(object[1], math.huge):GetPropertyChangedSignal("Value"):Connect(function()
            if CoreGui.ESPFolder:FindFirstChild(player.Name) then
                CoreGui.ESPFolder[player.Name].Frame[object[2]].Text = object[2] .. ": " .. formatstats(PrivateStats:WaitForChild(object[1], math.huge).Value)
            end
        end)
    end

    Status:GetPropertyChangedSignal("Value"):Connect(function()
        if CoreGui.ESPFolder:FindFirstChild(player.Name) then
            CoreGui.ESPFolder[player.Name].Frame.Names.TextColor3 = updcolor(Status.Value)
            CoreGui.ESPFolder[player.Name].Frame.Names.TextStrokeColor3 = updcolorstroke(Status.Value)
        end

        if CoreGui.HFolder:FindFirstChild(player.Name) then
            CoreGui.HFolder[player.Name].FillColor = updcolor(Status.Value)
            CoreGui.HFolder[player.Name].OutlineColor = updcolor(Status.Value)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    lastchatted[player.Name] = nil
    
    if CoreGui.ESPFolder:FindFirstChild(player.Name) then
        CoreGui.ESPFolder[player.Name]:Destroy()
    end

    if CoreGui.HFolder:FindFirstChild(player.Name) then
        CoreGui.HFolder[player.Name]:Destroy()
    end
    
    if Flags["Logs"].Value["Joined/Left"] then
        if Flags["Type Of Logs"].Value["Chat"] then
            StarterGui:SetCore("ChatMakeSystemMessage", {Text = player.DisplayName .. " (@" .. player.Name .. ") Has left",Color = Color3.new(1, 0, 0),Font = "GothamBold",TextSize = 20})
        end

        if Flags["Type Of Logs"].Value["Notify"] then
            Fluent:Notify({
                Title = "Z3XHub",
                Content = "[LOGS]",
                SubContent = player.DisplayName .. " (@" .. player.Name .. ") Has left",
                Duration = 3
            })
        end

        if Flags["Type Of Logs"].Value["Console"] then
            print("[LOGS]: " .. player.DisplayName .. " (@" .. player.Name .. ") Has left")
        end
    end

    if table.find(Targets, player.Name) then
        for _, Target in pairs(Targets) do
            if Target == player.Name then
                table.remove(Targets, i)
            end
        end
    end
end)

local function IsAuraEnabled()
    for _, object in pairs(LocalPlayer.Character:GetDescendants()) do
        if object.Name ~= "KillingIntentAuraSound" and object.Name:match("Aura") then
            return true
        end
    end
end

LocalPlayer.CharacterAdded:Connect(function(character)
    Teleported, Changed = false, false
    
    local Humanoid = character:WaitForChild("Humanoid", math.huge)

    if Flags["Stack"].Value then
        task.delay(4, function()
            RemoteEvent:FireServer({"Respawn"})
        end)
    end

    task.spawn(function()
        character.ChildAdded:Connect(function(object)
            task.wait()
            if object.Name == "KillingIntentPart" and Flags["Anti Killing Intent Aura"].Value then
                object:Destroy()
            elseif object.Name == "GodModeShield" and Flags["GodMode"].Value and not Check then
                object.Name = "GodModeShield "
            end
        end)
    end)

    if Flags["GodMode"].Value then
        task.spawn(function()
            repeat task.wait() until LocalPlayer.Character:FindFirstChild("ForceField") and GodCheck
            RemoteEvent:FireServer({"QuestTalkStart"})
        end)
    end

    if SavedPosition and not Flags["Stack"].Value then
        task.spawn(function()
            task.spawn(function()
                character:WaitForChild("HumanoidRootPart", math.huge):GetPropertyChangedSignal("CFrame"):Wait()
                character.HumanoidRootPart.CFrame = SavedPosition
                Teleported = true
                Camera:GetPropertyChangedSignal('CFrame'):Wait()
                Camera.CFrame = SavedCameraCFrame
                Changed = true
            end)
            task.wait(.5)
            if SavedPosition and SavedCameraCFrame then
                if not Teleported then
                    character.HumanoidRootPart.CFrame = SavedPosition
                end
                if not Changed then
                    Camera.CFrame = SavedCameraCFrame
                end
            end
        end)
    end

    if Flags["Spin"].Value then
        task.spawn(function()
            local BodyAngularVelocity = Instance.new("BodyAngularVelocity")
            BodyAngularVelocity.Name = "Spin"
            BodyAngularVelocity.Parent = character:WaitForChild("HumanoidRootPart", math.huge)
            BodyAngularVelocity.MaxTorque = Vector3.new(0, math.huge, 0)
            BodyAngularVelocity.AngularVelocity = Vector3.new(0, Flags["Spin Speed"].Value, 0)
        end)
    end

    if Flags["Auto Super Aura"].Value then
        task.spawn(function()
            task.wait(.5)
            RemoteEvent:FireServer({"ConcealRevealAura", "Start"})
        end)
    elseif Flags["Auto Disable Aura"].Value then
        task.spawn(function()
            repeat task.wait() until IsAuraEnabled()
            RemoteEvent:FireServer({"ConcealRevealAura", "Start"})
        end)
    end

    if Flags["Animations"].Value ~= "None" then
        task.spawn(function()
            for _, object in pairs(Animations[Flags["Animations"].Value]) do
                local Action, SubAction, AssetId = unpack(object)
                character:WaitForChild("Animate", math.huge):WaitForChild(Action, math.huge)[SubAction].AnimationId = AssetId
            end
        end)
    end

    task.spawn(function()
        RespawnFunction = Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            if Humanoid.MaxHealth * RespawnHealth >= Humanoid.Health then
                if not Flags["Stack"].Value then
                    RespawnFunction:Disconnect()
                    SavedPosition = character.HumanoidRootPart.CFrame
                    SavedCameraCFrame = Camera.CFrame
                    Camera.CameraType = "Fixed"
                    if not character:FindFirstChild("GodModeShield") and not character:FindFirstChild("GodModeShield ") and not character:FindFirstChild("ForceField") then
                        RemoteEvent:FireServer({"QuestTalkStart"})
                    end
                    character.HumanoidRootPart.CFrame = CFrame.new(math.huge, -math.huge, math.huge)
                end
                RemoteEvent:FireServer({"Respawn"})
            end
        end)
    end)

    Humanoid.Died:Connect(function()
        task.delay(0, function()
            if not Check then
                TweenService:Create(Camera, TweenInfo.new(0, Enum.EasingStyle.Linear), {CFrame = Camera.CFrame}):Play()
            end
        end)
        if Flags["Logs"].Value["Dead"] then
            if Flags["Type Of Logs"].Value["Chat"] then
                StarterGui:SetCore("ChatMakeSystemMessage", ({Text = LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. ") Dead", Color = Color3.new(1, 0, 0), Font = "GothamBold", TextSize = 20}))
            end
            
            if Flags["Type Of Logs"].Value["Notify"] then
                Fluent:Notify({
                    Title = "Z3XHub",
                    Content = "[LOGS]",
                    SubContent = LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. ") Dead",
                    Duration = 3
                })
            end

            if Flags["Type Of Logs"].Value["Console"] then
                print("[LOGS]: " .. LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. ") Dead")
            end
        end
    end)
end)

Workspace.ChildAdded:Connect(function(object)
    task.wait()
    if object.Name == "Part" then
        if Flags["Custom Lasers"].Value then
            object.Color = Flags["Custom Color"].Value
            object.Transparency = 0
        elseif Flags["Rainbow Lasers"].Value then
            while table.find(Workspace:GetChildren(), object) and task.wait() do
                object.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                object.Transparency = 0
            end
        end
    end
end)

Storage.ChildAdded:Connect(function(object)
    task.wait()
    if object.Name:match("EnergySphere") then
        if Flags["Custom Spheres"].Value then
            object.Color = Flags["Custom Color"].Value
            object.Transparency = 0
        elseif Flags["Rainbow Spheres"].Value then
            while table.find(Storage:GetChildren(), object) and task.wait() do
                object.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                object.Transparency = 0
            end
        end
    end
end)

if isAlive() then
    RemoteEvent:FireServer({"Respawn"})
end

InterfaceManager:SetFolder("Z3X")
InterfaceManager:SetLibrary(Fluent)
InterfaceManager:BuildInterfaceSection(Tabs.Settings)

Fluent:Notify({
    Title = "Z3XHub",
    Content = "Successfully loaded",
    SubContent = "Welcome, " .. LocalPlayer.Name .. "!",
    Duration = 3
})

getgenv().Loaded = true