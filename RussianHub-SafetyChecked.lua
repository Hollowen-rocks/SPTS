--[[ 
I (hollo) consider this verison of wer4er hub Safe.
There is no changes in terms of safety nor hidden code. 
you're safe to use this without risking any private or hidden info <3
]]--

---@diagnostic disable
repeat task.wait() until game:IsLoaded()

local Fluent = loadstring(game:HttpGet("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()
local SaveManager = loadstring(game:HttpGet("https://gist.githubusercontent.com/wer4er/e3850471d61eff8f190afc2a43b92626/raw/6ca53c3360444d3d3c3ad30b202cb9f66abbbe7c/SaveManager"))()
local Flags = Fluent.Options

local isnetworkowner = isnetworkowner or function() return true end
local cloneref = cloneref or function(instance) return instance end
local Services = setmetatable({}, {
    ["__index"] = function(self, Name)
        local Service = cloneref(game:GetService(Name))
        self[Name] = Service
        return Service
    end
})

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
local Client = Players.LocalPlayer
local PrivateStats = Client.PrivateStats
local PlayerGui = Client.PlayerGui
local ScreenGui = PlayerGui.ScreenGui
local MenuFrame = ScreenGui.MenuFrame
local Camera = Workspace.CurrentCamera
local Storage = Workspace.Storage
local PlaceId = game.PlaceId
local JobId = game.JobId
local InjectorName = identifyexecutor and identifyexecutor() or "hueta"
local Check = getsenv and newcclosure and checkcaller and hookmetamethod and hookfunction and not rawequal(InjectorName, "NX")

local RespawnHealth = .1
local StockGravity = 196.1999969482422
local teleportsvalue, teleportposition, oldUtilities, lastChatted = {}, {}, {}, {}
local Targets, Whitelisted, Target = {}, {}, Players:GetPlayers()[math.random(1, #Players:GetPlayers())].Name
local TCAdded, LPCAdded, CChanged, RespawnFunction, Teleported, Changed, SavedCameraCFrame, SavedPosition, GodCheck

if Loaded then
    TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Client)
    return
end

CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function()
    TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Client)
    return
end)

if Check then
    task.spawn(function()
        local Chatted = Instance.new("BindableEvent")
        local MessagePosted = require(Client.PlayerScripts.ChatScript.ChatMain).MessagePosted
        local oldHook, oldCall

        oldCall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local Method, Args = getnamecallmethod(), {...}
            if rawequal(Method:lower(), "fire") and rawequal(self.Name:lower(), "messageposted") then
                return wait(9e9)
            elseif rawequal(Method, "Create") then
                if rawequal(Args[1], Camera) then
                    return setmetatable({}, {
                        ["__index"] = function(self, ...)
                            return function() end
                        end
                    })
                end
            elseif not checkcaller() and rawequal(self, Client.Character) and rawequal(Method, "BreakJoints") then
                return nil
            end
            return oldCall(self, ...)
        end))

        oldHook = hookfunction(MessagePosted.fire, function(self, ...)
            if not checkcaller() and rawequal(self, MessagePosted) then
                return Chatted:Fire(...)
            end
            return oldHook(self, ...)
        end)
    end)
end

task.spawn(function()
    repeat task.wait() until Client.Character
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

UserInputService.WindowFocused:Connect(function()
    if setfpscap then setfpscap(0) end
    RunService:Set3dRenderingEnabled(true)
end)

UserInputService.WindowFocusReleased:Connect(function()
    if setfpscap then setfpscap(45) end
    RunService:Set3dRenderingEnabled(false)
end)

for i, object in pairs(Workspace:GetChildren()) do
    if object.Name:match("SoulAttackBeam") and object:IsA("Beam") then
        object:Destroy()
    elseif rawequal(object.Name, "Town") then
        if object.Halloween.SecretTraining2:FindFirstChild("Part") then
            object.Halloween.SecretTraining2.Part.CanCollide = false
        end
    end
end

for i, object in pairs(game:GetDescendants()) do
    if object:IsA("BillboardGui") and rawequal(object.Name, "WarnBBGui") then
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

if Client.Idled then
    if getconnections then
        for i, connection in pairs(getconnections(Client.Idled)) do
            if not rawequal(typeof(connection), "table") and connection["Disable"] then
                connection:Disable()
            end
        end
    end
    
    Client.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0, 0), Camera:GetPivot())
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0, 0), Camera:GetPivot())
    end)
end

PlayerGui.IntroGui:GetPropertyChangedSignal("Enabled"):Connect(function()
    PlayerGui.IntroGui.Enabled = false
end)

Lighting.Blur:GetPropertyChangedSignal("Enabled"):Connect(function()
    Lighting.Blur.Enabled = false
end)

ScreenGui:GetPropertyChangedSignal("Enabled"):Connect(function()
    ScreenGui.Enabled = true
end)

local function ConvertToLetter(num)
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

local function ConvertTime(time)
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
        player = Client
    end

    return player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0
end

local function onChatted(player, msg)
    if Flags["Logs"].Value["ChatSpy"] then
        local newChatted, Hidden = false, true
        local CCheck, Command, Target = msg:match("^(/)(w)%s+(%S+)")
        local Text
        
        if rawequal(Command, "w") and Players:FindFirstChild(Target) then
            newChatted = true
            lastChatted[player.Name] = Target
        end

        local con = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents", math.huge):WaitForChild("OnMessageDoneFiltering", math.huge).OnClientEvent:Connect(function(packet, channel)
            if rawequal(packet.SpeakerUserId, player.UserId) and rawequal(packet.Message, msg:sub(#msg-#packet.Message + 1)) and rawequal(channel, "All") and not CCheck then
                Hidden = false
                lastChatted[player.Name] = nil
            end
        end)
        task.wait(1)
        con:Disconnect()
        
        if Hidden then
            if lastChatted[player.Name] then
                Text = "[" .. player.Name .. " → " .. (lastChatted[player.Name]) .. "]: " .. (newChatted and msg:sub(msg:find(Target) + #Target + 1) or msg)
            else
                Text = "[" .. player.Name .. "]: " .. (newChatted and msg:sub(msg:find(Target) + #Target + 1) or msg)
            end
            
            if Flags["Type Of Logs"].Value["Chat"] then
                StarterGui:SetCore("ChatMakeSystemMessage", {
                    Text = Text,
                    Color = Color3.new(.988235, 1, .329412),
                    Font = "GothamBold",
                    TextSize = 18
                })
            end
            
            if Flags["Type Of Logs"].Value["Notify"] then
                Fluent:Notify({
                    Title = "Z3XHub",
                    Content = "[LOGS]",
                    SubContent = Text,
                    Duration = 3
                })
            end
            
            if Flags["Type Of Logs"].Value["Console"] then
                print("[LOGS]: " .. Text)
            end
        end
    end
end

local ESPFolder, HighlightsFolder = Instance.new("Folder", CoreGui), Instance.new("Folder", CoreGui)
ESPFolder.Name, HighlightsFolder.Name = "ESPFolder", "HighlightsFolder"
local Highlights, Esp = CoreGui.HighlightsFolder, CoreGui.ESPFolder

local function CreateESP(player)
    task.spawn(function()
        local PrivateStats = player:WaitForChild("PrivateStats", math.huge)
        local LeaderStats = player:WaitForChild("leaderstats", math.huge)
        local Status = LeaderStats:WaitForChild("Status", math.huge)
        local BillboardGui = Instance.new("BillboardGui", Esp)
        local Frame = Instance.new("Frame", BillboardGui)
        local Name = Instance.new("TextLabel", Frame)
        local Distance = Instance.new("TextLabel", Frame)
        local Health = Instance.new("TextLabel", Frame)
        local Body = Instance.new("TextLabel", Frame)
        local Fist = Instance.new("TextLabel", Frame)
        local Psychic = Instance.new("TextLabel", Frame)

        BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
        BillboardGui.AlwaysOnTop = true
        BillboardGui.Size = UDim2.new(0, 2, 0, 2)
        BillboardGui.StudsOffset = Vector3.new(0, 3, 0)
        BillboardGui.Name = player.Name
        BillboardGui.Enabled = false

        Frame.ZIndex = 10
        Frame.BackgroundTransparency = 1
        Frame.Size = UDim2.new(5, 0, 5, 0)

        Name.Name = "Names"
        Name.ZIndex = 10
        Name.Text = player.Name
        Name.BackgroundTransparency = 1
        Name.Position = UDim2.new(0, 0, 0, -55)
        Name.Size = UDim2.new(1, 0, 10, 0)
        Name.Font = "GothamBold"
        Name.TextSize = 14
        Name.TextStrokeTransparency = .5
        Name.TextColor3 = updcolor(Status.Value)
        Name.TextStrokeColor3 = updcolorstroke(Status.Value)

        Distance.Name = "Distance"
        Distance.ZIndex = 10
        Distance.Text = "Distance: nil"
        Distance.BackgroundTransparency = 1
        Distance.Position = UDim2.new(0, 0, 0, -45)
        Distance.Size = UDim2.new(1, 0, 10, 0)
        Distance.Font = "GothamBold"
        Distance.TextColor3 = Color3.new(1, 1, 1)
        Distance.TextSize = 14
        Distance.TextStrokeTransparency = .5

        Health.Name = "Health"
        Health.ZIndex = 10
        Health.BackgroundTransparency = 1
        Health.Position = UDim2.new(0, 0, 0, -35)
        Health.Size = UDim2.new(1, 0, 10, 0)
        Health.Font = "GothamBold"
        Health.TextColor3 = Color3.new(1, 1, 1)
        Health.TextSize = 14
        Health.TextStrokeTransparency = .5

        Body.Name = "Body"
        Body.ZIndex = 10
        Body.BackgroundTransparency = 1
        Body.Position = UDim2.new(0, 0, 0, -25)
        Body.Size = UDim2.new(1, 0, 10, 0)
        Body.Font = "GothamBold"
        Body.TextColor3 = Color3.new(1, 1, 1)
        Body.TextSize = 14
        Body.TextStrokeTransparency = .5
        Body.Text = "Body: " .. ConvertToLetter(PrivateStats:WaitForChild("BodyToughness", math.huge).Value)

        Fist.Name = "Fist"
        Fist.ZIndex = 10
        Fist.BackgroundTransparency = 1
        Fist.Position = UDim2.new(0, 0, 0, -15)
        Fist.Size = UDim2.new(1, 0, 10, 0)
        Fist.Font = "GothamBold"
        Fist.TextColor3 = Color3.new(1, 1, 1)
        Fist.TextSize = 14
        Fist.TextStrokeTransparency = .5
        Fist.Text = "Fist: " .. ConvertToLetter(PrivateStats:WaitForChild("FistStrength", math.huge).Value)

        Psychic.Name = "Psychic"
        Psychic.ZIndex = 10
        Psychic.BackgroundTransparency = 1
        Psychic.Position = UDim2.new(0, 0, 0, -5)
        Psychic.Size = UDim2.new(1, 0, 10, 0)
        Psychic.Font = "GothamBold"
        Psychic.TextColor3 = Color3.new(1, 1, 1)
        Psychic.TextSize = 14
        Psychic.TextStrokeTransparency = .5
        Psychic.Text = "Psychic: " .. ConvertToLetter(PrivateStats:WaitForChild("PsychicPower", math.huge).Value)
    
        task.spawn(function()
            while task.wait() do
                if isAlive() and isAlive(player) then
                    Distance.Text = "Distance: " .. math.floor((Client.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude)
                end
            end
        end)
    end)
end

local function CreateHighlight(player)
    task.spawn(function()
        local LeaderStats = player:WaitForChild("leaderstats", math.huge)
        local Status = LeaderStats:WaitForChild("Status", math.huge)
        local Highlight = Instance.new("Highlight", Highlights)
        
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
    else
        return {"+FS1"}, {"+FS2"}, {"+FS3"}
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
    else
        return {"+PP1"}, {"+PP2"}
    end
end

local function getfspos()
    if PrivateStats.FistStrength.Value >= 1e13 then
        return CFrame.fromMatrix(Vector3.new(-364.10, 15735.15, -7.32), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))
    elseif PrivateStats.FistStrength.Value >= 1e11 then
        return CFrame.fromMatrix(Vector3.new(1380.36, 9273.74, 1652.63), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))
    elseif PrivateStats.FistStrength.Value >= 1e9 then
        return CFrame.fromMatrix(Vector3.new(1175.30, 4789.25, -2293.05), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))
    end
end

local function getbtpos()
    if PrivateStats.BodyToughness.Value >= 5e11 then
        return CFrame.fromMatrix(Vector3.new(-278.40, 281.40, 999.50), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))
    elseif PrivateStats.BodyToughness.Value >= 5e9 then
        return CFrame.fromMatrix(Vector3.new(-275.53, 281.11, 991.48), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))
    elseif PrivateStats.BodyToughness.Value >= 7e7 then
        return CFrame.fromMatrix(Vector3.new(-244.45, 287.11, 978.97), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))
    elseif PrivateStats.BodyToughness.Value >= 1e6 then
        return CFrame.fromMatrix(Vector3.new(-2024.79, 714.25, -1882.21), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))
    elseif PrivateStats.BodyToughness.Value >= 1e5 then
        return CFrame.fromMatrix(Vector3.new(-2297.46, 976.74, 1075.02), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))
    elseif PrivateStats.BodyToughness.Value >= 1e4 then
        return CFrame.fromMatrix(Vector3.new(1634.49, 259.62, 2248.21), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))
    elseif PrivateStats.BodyToughness.Value >= 1e3 then
        return CFrame.fromMatrix(Vector3.new(357.28, 263.74, -492.33), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))
    elseif PrivateStats.BodyToughness.Value >= 1e2 then
        return CFrame.fromMatrix(Vector3.new(367.77, 249.71, -444.75), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))
    end
end

local function getpppos()
    if PrivateStats.PsychicPower.Value >= 1e15 then
        return CFrame.fromMatrix(Vector3.new(-2545.08, 5412.33, -491.88), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))
    elseif PrivateStats.PsychicPower.Value >= 1e12 then
        return CFrame.fromMatrix(Vector3.new(-2581.78, 5516.39, -500.41), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))
    elseif PrivateStats.PsychicPower.Value >= 1e9 then
        return CFrame.fromMatrix(Vector3.new(-2561.86, 5500.88, -440.46), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))
    elseif PrivateStats.PsychicPower.Value >= 1e6 then
        return CFrame.fromMatrix(Vector3.new(-2529.78, 5486.39, -534.67), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))
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

debug.traceback = debug.traceback or function() end

local teleports = {
    {"SafeZone", CFrame.fromMatrix(Vector3.new(471, 249, 889), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))},
    {"LeaderBoards", CFrame.fromMatrix(Vector3.new(-766, 249, 750), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))},
    {"FS Rock", CFrame.fromMatrix(Vector3.new(382, 249, 971), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))},
    {"FS Crystal", CFrame.fromMatrix(Vector3.new(-2273, 1943, 1048), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))},
    {"FS 1B", CFrame.fromMatrix(Vector3.new(1176, 4789, -2293), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))},
    {"FS 100B", CFrame.fromMatrix(Vector3.new(1381, 9274, 1648), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))},
    {"FS 10T", CFrame.fromMatrix(Vector3.new(-363, 15735, -3), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))},
    {"PP 1M", CFrame.fromMatrix(Vector3.new(-2527, 5486, -532), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))},
    {"PP 1B", CFrame.fromMatrix(Vector3.new(-2560, 5500, -439), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))},
    {"PP 1T", CFrame.fromMatrix(Vector3.new(-2582, 5516, -504), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))},
    {"PP 1Qa", CFrame.fromMatrix(Vector3.new(-2544, 5412, -495), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))},
    {"BT 100", CFrame.fromMatrix(Vector3.new(365, 249, -445), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))},
    {"BT 10K", CFrame.fromMatrix(Vector3.new(349, 263, -490), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))},
    {"BT 100K", CFrame.fromMatrix(Vector3.new(1640, 258, 2244), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))},
    {"BT 1M", CFrame.fromMatrix(Vector3.new(-2307, 976, 1068), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))},
    {"BT 10M", CFrame.fromMatrix(Vector3.new(-2024, 714, -1860), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))},
    {"BT 1B", CFrame.fromMatrix(Vector3.new(-254, 286, 980), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))},
    {"BT 100B", CFrame.fromMatrix(Vector3.new(-271, 281, 991), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))},
    {"BT 10T", CFrame.fromMatrix(Vector3.new(-279, 281, 1007), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))}
}

for i, teleport in pairs(teleports) do
    table.insert(teleportsvalue, teleport[1])
    teleportposition[teleport[1]] = teleport[2]
end

local Window = Fluent:AddWindow({
    Title = "Z3XHub 5.5.3",
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

local Components = {
    Fist = Tabs.Farm:AddToggle("Fist Strength", {Title = "Fist Strength", Default = false}),
    Body = Tabs.Farm:AddToggle("Body Toughness", {Title = "Body Toughness", Default = false}),
    Psychic = Tabs.Farm:AddToggle("Psychic Power", {Title = "Psychic Power", Default = false}),
    BodyFist = Tabs.Farm:AddToggle("Body Toughness & Fist Strength", {Title = "Body Toughness & Fist Strength", Default = false}),
    BodyPsychic = Tabs.Farm:AddToggle("Body Toughness & Psychic Power", {Title = "Body Toughness & Psychic Power", Default = false}),
    JumpSpeed = Tabs.Farm:AddToggle("Jump & Speed", {Title = "Jump & Speed", Default = false}),
    GodMode = Tabs.Farm:AddToggle("GodMode", {Title = "GodMode", Default = false}),
    Respawn = Tabs.Farm:AddSlider("Respawn Health", {Title = "Respawn Value", Default = 10, Min = 1, Max = 99, Rounding = 0}),
    Utilities = Tabs.Farm:AddDropdown("Utilities", {Title = "Utilities", Values = {"Stats Checker", "Stats Counter", "Multi Checker"}, Default = {}, Multi = true}),

    Esp = Tabs.Visual:AddToggle("ESP", {Title = "ESP", Default = false}),
    Highlights = Tabs.Visual:AddToggle("Highlights", {Title = "Highlights", Default = false}),
    Time = Tabs.Visual:AddSlider("Time", {Title = "Time", Default = 12, Min = 0, Max = 23, Rounding = 0}),

    SuperAura = Tabs.Usual:AddToggle("Auto Super Aura", {Title = "Auto Super Aura", Default = false}),
    DisableAura = Tabs.Usual:AddToggle("Auto Disable Aura", {Title = "Auto Disable Aura", Default = false}),
    Quests = Tabs.Usual:AddToggle("Auto Claim Quests", {Title = "Auto Claim Quests", Default = false}),
    AntiAura = Tabs.Usual:AddToggle("Anti Killing Intent Aura", {Title = "Anti Killing Intent Aura", Default = false}),
    Animations = Tabs.Usual:AddDropdown("Animations", {Title = "Animations", Values = {"None", "Bubbly", "Astronaut", "Cartoony", "Elder", "Knight", "Levitation", "Mage", "Ninja", "Pirate", "Robot", "Stylish", "Superhero", "Toy", "Vampire", "Werewolf", "Zombie", "Ghost"}, Default = 1, Multi = false}),
    Fov = Tabs.Usual:AddSlider("Fov", {Title = "Fov", Default = 70, Min = 1, Max = 120, Rounding = 0}),

    Targets = Tabs.Pvp:AddInput("Targets", {Title = "Targets", Default = "", Placeholder = "Nickname", Numeric = false, Finished = true}),
    AddToWhitelist = Tabs.Pvp:AddButton({Title = "Add To Whitelist", Callback = function() if Players:FindFirstChild(Target) and not rawequal(Players:FindFirstChild(Target), Client) then if not table.find(Whitelisted, Target) then table.insert(Whitelisted, Target) end end Fluent:Notify({Title = "Z3XHub", Content = "Whitelisted:", SubContent = table.concat(Whitelisted, ", "), Duration = 3}) end}),
    RemoveFromWhitelist = Tabs.Pvp:AddButton({Title = "Remove From Whitelist", Callback = function() if table.find(Whitelisted, Target) then for i, rTarget in pairs(Whitelisted) do if rawequal(rTarget, Target) then table.remove(Whitelisted, i) end end end Fluent:Notify({Title = "Z3XHub", Content = "Whitelisted:", SubContent = table.concat(Whitelisted, ", "), Duration = 3}) end}),
    ClearWhitelist = Tabs.Pvp:AddButton({Title = "Clear Whitelist", Callback = function() Whitelisted = {} Fluent:Notify({Title = "Z3XHub", Content = "Whitelisted:", SubContent = table.concat(Whitelisted, ", "), Duration = 3}) end}),
    AddToTargets = Tabs.Pvp:AddButton({Title = "Add To Targets", Callback = function() if Players:FindFirstChild(Target) and not rawequal(Players:FindFirstChild(Target), Client) then if not table.find(Targets, Target) then table.insert(Targets, Target) end end Fluent:Notify({Title = "Z3XHub", Content = "Targets:", SubContent = table.concat(Targets, ", "), Duration = 3}) end}),
    RemoveFromTargets = Tabs.Pvp:AddButton({Title = "Remove From Targets", Callback = function() if table.find(Targets, Target) then for i, rTarget in pairs(Targets) do if rawequal(rTarget, Target) then table.remove(Targets, i)end end end Fluent:Notify({Title = "Z3XHub", Content = "Targets:", SubContent = table.concat(Targets, ", "), Duration = 3}) end}),
    ClearTargets = Tabs.Pvp:AddButton({Title = "Clear Targets", Callback = function() Targets = {} Fluent:Notify({Title = "Z3XHub", Content = "Targets:", SubContent = table.concat(Targets, ", "), Duration = 3}) end }),

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
    RGBAuras = Tabs.Fun:AddToggle("Rainbow Auras", {Title = "Rainbow Auras", Default = false}),
    RGBNames = Tabs.Fun:AddToggle("Rainbow Names", {Title = "Rainbow Names", Default = false}),
    CustomColor = Tabs.Fun:AddColorpicker("Custom Color", {Title = "Custom Color", Default = Color3.new(0,0,0)}),
    CustomSpheres = Tabs.Fun:AddToggle("Custom Spheres", {Title = "Custom Spheres", Default = false}),
    CustomLasers = Tabs.Fun:AddToggle("Custom Lasers", {Title = "Custom Lasers", Default = false}),
    CustomAuras = Tabs.Fun:AddToggle("Custom Auras", {Title = "Custom Auras", Default = false}),
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
                Client.Character.HumanoidRootPart:PivotTo(getfspos())
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
                Client.Character.HumanoidRootPart:PivotTo(getbtpos())
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
                Client.Character.HumanoidRootPart:PivotTo(getpppos())
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
            if PrivateStats.FistStrength.Value >= 1e9 then
                if getfspos() then
                    Client.Character.HumanoidRootPart:PivotTo(getfspos())
                end
                task.wait(.2)
                for i = 1, #getfs() do
                    RemoteEvent:FireServer({getfs()[i]})
                end
                if getbtpos() then
                    local lastValue = PrivateStats.BodyToughness.Value
                    repeat Client.Character.HumanoidRootPart:PivotTo(getbtpos()) task.wait() until not rawequal(PrivateStats.BodyToughness.Value, lastValue)
                else
                    RemoteEvent:FireServer({"+BT1"})
                end
            else
                if getbtpos() then
                    Client.Character.HumanoidRootPart:PivotTo(getbtpos())
                else
                    RemoteEvent:FireServer({"+BT1"})
                end
                for i = 1, #getfs() do
                    RemoteEvent:FireServer({getfs()[i]})
                end
            end
        end
    end
end)

Components.BodyPsychic:OnChanged(function()
    while Flags["Body Toughness & Psychic Power"].Value and task.wait() do
        if isAlive() then
            if PrivateStats.PsychicPower.Value >= 1e6 then
                if getpppos() then
                    Client.Character.HumanoidRootPart:PivotTo(getpppos())
                end
                task.wait(.2)
                for i = 1, #getpp() do
                    RemoteEvent:FireServer({getpp()[i]})
                end
                if getbtpos() then
                    local lastValue = PrivateStats.BodyToughness.Value
                    repeat Client.Character.HumanoidRootPart:PivotTo(getbtpos()) task.wait() until not rawequal(PrivateStats.BodyToughness.Value, lastValue)
                else
                    RemoteEvent:FireServer({"+BT1"})
                end
            else
                if getbtpos() then
                    Client.Character.HumanoidRootPart:PivotTo(getbtpos())
                else
                    RemoteEvent:FireServer({"+BT1"})
                end
                for i = 1, #getpp() do
                    RemoteEvent:FireServer({getpp()[i]})
                end
            end
        end
    end
end)

Components.JumpSpeed:OnChanged(function()
    if Flags["Psychic Power"].Value or Flags["Body Toughness & Psychic Power"].Value then Flags["Jump & Speed"]:SetValue(false) RemoteEvent:FireServer({"Weight", "Unequip"}) return
    elseif Flags["Jump & Speed"].Value and not Flags["Psychic Power"].Value and not Flags["Body Toughness & Psychic Power"].Value then
        while Flags["Jump & Speed"].Value and task.wait(.2) do
            if Flags["Psychic Power"].Value or Flags["Body Toughness & Psychic Power"].Value then Flags["Jump & Speed"]:SetValue(false) RemoteEvent:FireServer({"Weight", "Unequip"}) return
            elseif isAlive() then
                if PrivateStats.MovementSpeed.Value >= 20 and PrivateStats.JumpForce.Value >= 20 then
                    if not Client.Character:FindFirstChild("LeftWeight4") and not Client.Character:FindFirstChild("RightWeight4") then
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
            if Client.Character:FindFirstChild("GodModeShield ") and not Check then
                Client.Character["GodModeShield "].Name = "GodModeShield"
            end
            RemoteEvent:FireServer({"QuestTalkEnd", "GhostRider"})
        end
    end
end)

Components.Respawn:OnChanged(function()
    RespawnHealth = Flags["Respawn Health"].Value / 100
end)

local function loadUtility(name)
    if rawequal(name, "Stats Checker") then
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
        StatsChecker.MainFrame.Active = true
        StatsChecker.MainFrame.Text = ""
        StatsChecker.MainFrame.AutoButtonColor = false
        StatsChecker.MainFrame.Draggable = true
        
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
            for i, player in pairs(Players:GetPlayers()) do
                if rawequal((string.sub(string.lower(player.Name), 1, string.len(StatsChecker.PlayerTextBox.Text))), string.lower(StatsChecker.PlayerTextBox.Text)) then
                    StatsChecker.PlayerTextBox.Text = player.Name
                    for i, object in pairs(UpdatingStats) do
                        local Stat = Players:FindFirstChild(player.Name):WaitForChild("PrivateStats", math.huge)
                        local Statname = object[3]
                        object[1].Text = Statname .. ": " .. ConvertToLetter(Stat[object[2]].Value)
                        Stat[object[2]]:GetPropertyChangedSignal("Value"):Connect(function()
                            object[1].Text = Statname .. ": " .. ConvertToLetter(Stat[object[2]].Value)
                        end)
                    end
                end
            end
        end)        
    elseif rawequal(name, "Stats Counter") then
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
        StatCounter.MainFrame.Active = true
        StatCounter.MainFrame.Text = ""
        StatCounter.MainFrame.AutoButtonColor = false
        StatCounter.MainFrame.Draggable = true

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

        for i, object in pairs(UpdatingStats) do
            object[1].Text = object[1].Name .. ": " .. 0

            if not rawequal(object[2], "Token") then
                PrivateStats[object[2]]:GetPropertyChangedSignal("Value"):Connect(function()
                    object[1].Text = object[1].Name .. ": " .. ConvertToLetter(PrivateStats[object[2]].Value - object[3])
                end)
            else
                PrivateStats[object[2]]:GetPropertyChangedSignal("Value"):Connect(function()
                    if PrivateStats[object[2]].Value - OldValue > 0 then
                        AllTokens += 5
                    end
                    OldValue = PrivateStats[object[2]].Value
                    object[1].Text = object[1].Name .. ": " .. ConvertToLetter(AllTokens)
                end)
            end
        end

        local startTime = os.time()

        task.spawn(function()
            while task.wait() and Flags["Utilities"].Value["Stats Counter"] do
                StatCounter.TimeFrameText.Text = "Time: " .. ConvertTime(os.time() - startTime)
            end
        end)
    elseif rawequal(name, "Multi Checker") then
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
        MultiChecker.MainFrame.Active = true
        MultiChecker.MainFrame.Text = ""
        MultiChecker.MainFrame.AutoButtonColor = false
        MultiChecker.MainFrame.Draggable = true

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
            for i, player in pairs(Players:GetPlayers()) do
                if rawequal((string.sub(string.lower(player.Name), 1, string.len(MultiChecker.PlayerTextBox.Text))), string.lower(MultiChecker.PlayerTextBox.Text)) then
                    MultiChecker.PlayerTextBox.Text = player.Name
                    local Multiplier = HttpService:JSONDecode(Players[MultiChecker.PlayerTextBox.Text].PrivateStats.Inventory.Value)
                    MultiChecker.FsFrameText.Text = "Fist: x" .. tostring(Multiplier.FSMultiplier)
                    MultiChecker.BtFrameText.Text = "Body: x" .. tostring(Multiplier.BTMultiplier)
                    MultiChecker.PpFrameText.Text = "Psychic: x" .. tostring(Multiplier.PPMultiplier)
                    MultiChecker.MsFrameText.Text = "Speed: x" .. tostring(Multiplier.MSMultiplier)
                    MultiChecker.JfFrameText.Text = "Jump: x" .. tostring(Multiplier.JFMultiplier)
                    MultiChecker.TokensFrameText.Text = "Tokens: " .. ConvertToLetter(Players[MultiChecker.PlayerTextBox.Text].PrivateStats.Token.Value)
                end
            end
        end)
    end
end

local function destroyUtility(name)
    for i, object in pairs(CoreGui:GetChildren()) do
        if rawequal(name, "Stats Checker") and rawequal(object.Name, "Stats Checker") then
            object:Destroy()
        elseif rawequal(name, "Stats Counter") and rawequal(object.Name, "Stats Counter") then
            object:Destroy()
        elseif rawequal(name, "Multi Checker") and rawequal(object.Name, "Multi Checker") then
            object:Destroy()
        end
    end
end

Components.Utilities:OnChanged(function()
    local lenUtility = (function() local count = 0 for i, object in pairs(Flags["Utilities"].Value) do count += 1 end return count end)()
    local lenOldUtility = (function() local count = 0 for i, object in pairs(oldUtilities) do count += 1 end return count end)()

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
    for i, player in pairs(Players:GetPlayers()) do
        if not rawequal(player, Client) and isAlive(player) and Esp:FindFirstChild(player.Name) then
            Esp[player.Name].Adornee = Flags["ESP"].Value and player.Character:WaitForChild("Head") or nil
            Esp[player.Name].Enabled = Flags["ESP"].Value
        end
    end
end)

Components.Highlights:OnChanged(function()
    for i, player in pairs(Players:GetPlayers()) do
        if not rawequal(player, Client) and isAlive(player) and Highlights:FindFirstChild(player.Name) then
            Highlights[player.Name].Adornee = Flags["Highlights"].Value and player.Character or nil
            Highlights[player.Name].Enabled = Flags["Highlights"].Value
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
        for i, quest in pairs({"MS", "PP", "FS", "BT", "JF"}) do
            RemoteEvent:FireServer({"DLQ", quest, "Claim"})
            task.wait()
        end
        for i, quest in pairs({"PP", "FS", "BT"}) do
            for i = 1, 3 do
                RemoteEvent:FireServer({"WLQ", quest .. i, "Claim"})
                task.wait()
            end
        end
    end
end)

Components.AntiAura:OnChanged(function()
    if Flags["Anti Killing Intent Aura"].Value then
        for i, player in pairs(Players:GetPlayers()) do
            if isAlive(player) then
                for i, object in pairs(player.Character:GetChildren()) do
                    if rawequal(object.Name, "KillingIntentPart") then 
                        object:Destroy()
                    end
                end
            end
        end
    end
end)

Components.Animations:OnChanged(function()
    if not rawequal(Flags["Animations"].Value, "None") then
        for i, object in pairs(Animations[Flags["Animations"].Value]) do
            local Action, SubAction, AssetId = unpack(object)
            if isAlive() then
                Client.Character:WaitForChild("Animate", math.huge):WaitForChild(Action, math.huge)[SubAction].AnimationId = AssetId
            end
        end
        if isAlive() then
            Client.Character.Humanoid.Jump = true
        end
    end
end)

Components.Fov:OnChanged(function()
    Camera.FieldOfView = Flags["Fov"].Value
end)

Components.Targets:OnChanged(function()
    for i, player in pairs(Players:GetPlayers()) do
        if string.find(string.lower(player.Name), string.lower(Flags["Targets"].Value)) then
            if not rawequal(player, Client) then
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
end)

Components.CBring:OnChanged(function()
    while Flags["CBring"].Value and task.wait() do
        for i, Target in pairs(Targets) do
            if not rawequal(Target, Client) and isAlive() and isAlive(Players:FindFirstChild(Target)) then
                Players:FindFirstChild(Target).Character.HumanoidRootPart:PivotTo(Client.Character.HumanoidRootPart:GetPivot() * CFrame.fromMatrix(Vector3.new(0, 0, -1), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0)))
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
        for i, sphere in pairs(Storage:GetChildren()) do
            task.spawn(function()
                if isAlive() and rawequal(sphere.Name, getball()) and isnetworkowner(sphere) then
                    sphere:PivotTo(Client.Character.HumanoidRootPart:GetPivot())
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
            Workspace.Town.Parent = Client
        elseif Client:FindFirstChild("Town") and not Flags["Stack"].Value then
            Client.Town.Parent = Workspace
        end
        task.spawn(function()
            while Flags["Stack"].Value and task.wait() do
                if isAlive() then
                    Client.Character.HumanoidRootPart:PivotTo(CFrame.fromMatrix(Vector3.new(math.random(-1e3, 1e3), -1e6, math.random(-1e3, 1e3)), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0)))
                end
                RemoteEvent:FireServer({"Skill_SpherePunch", Vector3.new(0, 1e20, 0)})
                for i, Target in pairs(Targets) do
                    task.spawn(function()
                        if isAlive() and isAlive(Players:FindFirstChild(Target)) then
                            Players:FindFirstChild(Target).Character.HumanoidRootPart:PivotTo(CFrame.fromMatrix(Vector3.new(0, 1e5, 0), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0)))
                            for i, sphere in pairs(Storage:GetChildren()) do
                                if not Client.Character:FindFirstChild("GodModeShield") and not Client.Character:FindFirstChild("GodModeShield ") and not Client.Character:FindFirstChild("ForceField") and not Client.Character:FindFirstChild("SafeZoneShield") then
                                    task.spawn(function()
                                        firetouchinterest(Players:FindFirstChild(Target).Character.HumanoidRootPart, sphere, 0)
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
        for i, Target in pairs(Targets) do
            if isAlive(Players:FindFirstChild(Target)) then
                Camera.CameraSubject = Players:FindFirstChild(Target).Character
            end
            TCAdded = Players:FindFirstChild(Target).CharacterAdded:Connect(function(character)
                Camera.CameraSubject = character:WaitForChild("Humanoid", math.huge)
            end)
            LPCAdded = Client.CharacterAdded:Connect(function()
                if Players:FindFirstChild(Target) and isAlive(Players:FindFirstChild(Target)) then
                    Camera.CameraSubject = Players:FindFirstChild(Target).Character.Humanoid
                end
            end)
            CChanged = Camera:GetPropertyChangedSignal("CameraSubject"):Connect(function()
                if Players:FindFirstChild(Target) and isAlive(Players:FindFirstChild(Target)) then
                    Camera.CameraSubject = Players:FindFirstChild(Target).Character.Humanoid
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
            Camera.CameraSubject = Client.Character
        end
    end
end)

Components.SoulAttack:OnChanged(function()
    while Flags["Soul Attack"].Value and task.wait() do
        for i, Target in pairs(Targets) do
            if isAlive() and isAlive(Players:FindFirstChild(Target)) and not Players:FindFirstChild(Target).Character:FindFirstChild("ForceField") and not Players:FindFirstChild(Target).Character:FindFirstChild("SafeZoneShield") and not Players:FindFirstChild(Target).Character:FindFirstChild("GodModeShield") then
                Client.Character.HumanoidRootPart:PivotTo(Players:FindFirstChild(Target).Character.HumanoidRootPart:GetPivot() + Players:FindFirstChild(Target).Character.HumanoidRootPart:GetPivot().UpVector * 40)
                RemoteEvent:FireServer({"Skill_SoulAttack_Start", Players:FindFirstChild(Target)})
                RemoteEvent:FireServer({"Skill_SoulAttack_End"})
                break
            end
        end
    end
end)

Components.SoulReap:OnChanged(function()
    while Flags["Soul Reap"].Value and task.wait() do
        for i, Target in pairs(Targets) do
            if isAlive() and isAlive(Players:FindFirstChild(Target)) and not Players:FindFirstChild(Target).Character:FindFirstChild("ForceField") and not Players:FindFirstChild(Target).Character:FindFirstChild("SafeZoneShield") and not Players:FindFirstChild(Target).Character:FindFirstChild("GodModeShield") then
                RemoteEvent:FireServer({"Skill_SoulReap", Players:FindFirstChild(Target)})
                break
            end
        end
    end
end)

Components.HellFire:OnChanged(function()
    while Flags["Hell Fire"].Value and task.wait() do
        for i, Target in pairs(Targets) do
            if isAlive() and isAlive(Players:FindFirstChild(Target)) then
                RemoteEvent:FireServer({"Skill_DevilFlame", Players:FindFirstChild(Target)})
                break
            end
        end
    end
end)

Components.LoopTeleport:OnChanged(function()
    while Flags["Loop Teleport"].Value and task.wait() do
        for i, Target in pairs(Targets) do
            if isAlive() and isAlive(Players:FindFirstChild(Target)) then
                Client.Character.HumanoidRootPart:PivotTo(Players:FindFirstChild(Target).Character.HumanoidRootPart:GetPivot())
            end
        end
    end
end)

Components.SitOnHead:OnChanged(function()
    while Flags["Sit On Head"].Value and task.wait() do
        for i, Target in pairs(Targets) do
            if isAlive() and isAlive(Players:FindFirstChild(Target)) then
                Client.Character.Humanoid.Sit = true
                Client.Character.HumanoidRootPart:PivotTo(Players:FindFirstChild(Target).Character:WaitForChild("Head", math.huge):GetPivot() * CFrame.fromMatrix(Vector3.new(0, 2.5, 0), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0)))
            end
        end
    end
end)

Components.CBringAll:OnChanged(function()
    while Flags["CBring All"].Value and task.wait() do
        for i, player in pairs(Players:GetPlayers()) do
            if not rawequal(player, Client) and not table.find(Whitelisted, player.Name) and isAlive() and isAlive(player) then
                player.Character.HumanoidRootPart:PivotTo(Client.Character.HumanoidRootPart:GetPivot() + Client.Character.HumanoidRootPart:GetPivot().LookVector * 1)
            end
        end
    end
end)

Components.StackAll:OnChanged(function()
    while Flags["Stack All"].Value and task.wait() do
        RemoteEvent:FireServer({"Skill_SpherePunch", Vector3.new(0, 1e20, 0)})
        for i, player in pairs(Players:GetPlayers()) do
            task.spawn(function()
                if (not rawequal(player, Client) and isAlive() and isAlive(player) and not table.find(Whitelisted, player.Name)) and (not player.Character:FindFirstChild("SafeZoneShield") and not player.Character:FindFirstChild("ForceField") and not player.Character:FindFirstChild("GodModeShield")) and (not Client.Character:FindFirstChild("SafeZoneShield") and not Client.Character:FindFirstChild("ForceField") and not Client.Character:FindFirstChild("GodModeShield") and not Client.Character:FindFirstChild("GodModeShield ")) and (player.PrivateStats.BodyToughness.Value <= PrivateStats.FistStrength.Value * 1.5) then
                    player.Character.HumanoidRootPart:PivotTo(CFrame.fromMatrix(Vector3.new(15e2, -55e2, -25e2), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0)))
                    for i, sphere in pairs(Storage:GetChildren()) do
                        task.spawn(function()
                            if rawequal(sphere.Name, getball()) then
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
        for i, player in pairs(Players:GetPlayers()) do
            if (not rawequal(player, Client) and isAlive() and isAlive(player) and not table.find(Whitelisted, player.Name)) and (not player.Character:FindFirstChild("SafeZoneShield") and not player.Character:FindFirstChild("ForceField") and not player.Character:FindFirstChild("GodModeShield")) and (not Client.Character:FindFirstChild("SafeZoneShield") and not Client.Character:FindFirstChild("ForceField") and not Client.Character:FindFirstChild("GodModeShield") and not Client.Character:FindFirstChild("GodModeShield ")) and (player.PrivateStats.PsychicPower.Value * 10 <= PrivateStats.PsychicPower.Value) then
                Client.Character.HumanoidRootPart:PivotTo(player.Character.HumanoidRootPart:GetPivot() * CFrame.fromMatrix(Vector3.new(player.Character.HumanoidRootPart.Velocity / 10), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0)))
                RemoteEvent:FireServer({"Skill_SoulAttack_Start", player})
                RemoteEvent:FireServer({"Skill_SoulAttack_End"})
                break
            end
        end
    end
end)

Components.HellFireAll:OnChanged(function()
    while Flags["Hell Fire All"].Value and task.wait() do
        for i, player in pairs(Players:GetPlayers()) do
            if (not rawequal(player, Client) and isAlive() and isAlive(player) and not table.find(Whitelisted, player.Name)) and (not player.Character:FindFirstChild("SafeZoneShield") and not player.Character:FindFirstChild("ForceField") and not player.Character:FindFirstChild("GodModeShield")) and (not Client.Character:FindFirstChild("SafeZoneShield") and not Client.Character:FindFirstChild("ForceField") and not Client.Character:FindFirstChild("GodModeShield") and not Client.Character:FindFirstChild("GodModeShield ")) and (player.PrivateStats.PsychicPower.Value * 100 <= PrivateStats.PsychicPower.Value) then
                Client.Character.HumanoidRootPart:PivotTo(player.Character.HumanoidRootPart:GetPivot() * CFrame.fromMatrix(Vector3.new(player.Character.HumanoidRootPart.Velocity / 10), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0)))
                RemoteEvent:FireServer({"Skill_DevilFlame", player})
                break
            end
        end
    end
end)

Components.SoulReapAll:OnChanged(function()
    while Flags["Soul Reap All"].Value and task.wait() do
        for i, player in pairs(Players:GetPlayers()) do
            if (not rawequal(player, Client) and isAlive() and isAlive(player) and not table.find(Whitelisted, player.Name)) and (not player.Character:FindFirstChild("SafeZoneShield") and not player.Character:FindFirstChild("ForceField") and not player.Character:FindFirstChild("GodModeShield")) and (not Client.Character:FindFirstChild("SafeZoneShield") and not Client.Character:FindFirstChild("ForceField")) and (player.PrivateStats.PsychicPower.Value * 1000 <= PrivateStats.PsychicPower.Value) then
                RemoteEvent:FireServer({"Skill_SoulReap", player})
                break
            end
        end
    end
end)

Components.LoopTeleportToLocation:OnChanged(function()
    while Flags["Loop Teleport To Location"].Value and task.wait() do
        if isAlive() then
            Client.Character.HumanoidRootPart:PivotTo(teleportposition[Flags["Locations"].Value])
        end
    end
end)

Components.SpamS:OnChanged(function()
    while Flags["Spam Sounds"].Value and task.wait(Flags["Cooldown Of Spam Sounds"].Value) do
        if isAlive() then
            for i, object in pairs(Client.Character:GetDescendants()) do
                if object:IsA("Sound") then
                    object:Play()
                end
            end
        end
    end
end)

Components.LagS:OnChanged(function()
    while Flags["Spam Z"].Value and task.wait() do
        RemoteEvent:FireServer({"Skill_KillingIntent_Start"})
    end
end)

Components.Teleport:OnChanged(function()
    while Flags["Teleport To Starter Camera"].Value and task.wait() do
        if isAlive() then
            Client.Character.HumanoidRootPart:PivotTo(CFrame.fromMatrix(Vector3.new(705, 942, 846), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0)))
        end
    end
end)

Components.SpamX:OnChanged(function()
    while Flags["Spam X"].Value and task.wait() do
        RemoteEvent:FireServer({"ConcealRevealAura"})
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

Components.RGBAuras:OnChanged(function()
    if Flags["Rainbow Auras"].Value then
        while Flags["Rainbow Auras"].Value and task.wait() do
            for i, player in pairs(Players:GetPlayers()) do
                if isAlive(player) then
                    for i, object in pairs(player.Character:GetDescendants()) do
                        if object.Name:match("Aura") and not rawequal(object.Name, "KillingIntentAuraSound") then
                            object.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(tick() % 5 / 5, 1, 1)),ColorSequenceKeypoint.new(.5, Color3.fromHSV(tick() % 5 / 5, 1, 1)),ColorSequenceKeypoint.new(1, Color3.fromHSV(tick() % 5 / 5, 1, 1))})
                        end
                    end
                end
            end
        end
    else
        for i, player in pairs(Players:GetPlayers()) do
            if isAlive(player) then
                for i, object in pairs(player.Character:GetDescendants()) do
                    if object.Name:match("Aura") and not rawequal(object.Name, "KillingIntentAuraSound") then
                        if rawequal(player, Client) and not Flags["Auto Super Aura"].Value then
                            RemoteEvent:FireServer({"ConcealRevealAura"})
                        else
                            object:Destroy()
                        end
                    end
                end
            end
        end
    end
end)

Components.RGBNames:OnChanged(function()
    if Flags["Rainbow Names"].Value then
        while Flags["Rainbow Names"].Value and task.wait() do
            for i, player in pairs(Players:GetPlayers()) do
                if isAlive(player) then
                    player.Character:WaitForChild("Head", math.huge):WaitForChild("NameBbGui", math.huge):WaitForChild("NameTxt", math.huge).TextColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                    player.Character:WaitForChild("Head", math.huge):WaitForChild("NameBbGui", math.huge):WaitForChild("NameTxt", math.huge).TextStrokeColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                end
            end
        end
    else
        task.wait(.1)
        for i, player in pairs(Players:GetPlayers()) do
            if isAlive(player) then
                player.Character:WaitForChild("Head", math.huge):WaitForChild("NameBbGui", math.huge):WaitForChild("NameTxt", math.huge).TextColor3 = updcolor(player:WaitForChild("leaderstats", math.huge).Status.Value)
                player.Character:WaitForChild("Head", math.huge):WaitForChild("NameBbGui", math.huge):WaitForChild("NameTxt", math.huge).TextStrokeColor3 = updcolorstroke(player:WaitForChild("leaderstats", math.huge).Status.Value)
            end
        end
    end
end)

Components.CustomAuras:OnChanged(function()
    if Flags["Custom Auras"].Value then
        while Flags["Custom Auras"].Value and task.wait() do
            for i, player in pairs(Players:GetPlayers()) do
                if isAlive(player) then
                    for i, object in pairs(player.Character:GetDescendants()) do
                        if object.Name:match("Aura") and not rawequal(object.Name, "KillingIntentAuraSound") then
                            object.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Flags["Custom Color"].Value),ColorSequenceKeypoint.new(.5, Flags["Custom Color"].Value),ColorSequenceKeypoint.new(1, Flags["Custom Color"].Value)})
                        end
                    end
                end
            end
        end
    else
        for i, player in pairs(Players:GetPlayers()) do
            if isAlive(player) then
                for i, object in pairs(player.Character:GetDescendants()) do
                    if object.Name:match("Aura") and not rawequal(object.Name, "KillingIntentAuraSound") then
                        if rawequal(player, Client) and not Flags["Auto Super Aura"].Value then
                            RemoteEvent:FireServer({"ConcealRevealAura"})
                        else
                            object:Destroy()
                        end
                    end
                end
            end
        end
    end
end)

Components.CustomNames:OnChanged(function()
    if Flags["Custom Names"].Value then
        while Flags["Custom Names"].Value and task.wait() do
            for i, player in pairs(Players:GetPlayers()) do
                if isAlive(player) then
                    player.Character:WaitForChild("Head", math.huge):WaitForChild("NameBbGui", math.huge):WaitForChild("NameTxt", math.huge).TextColor3 = Flags["Custom Color"].Value
                    player.Character:WaitForChild("Head", math.huge):WaitForChild("NameBbGui", math.huge):WaitForChild("NameTxt", math.huge).TextStrokeColor3 = Flags["Custom Color"].Value
                end
            end
        end
    else
        task.wait(.1)
        for i, player in pairs(Players:GetPlayers()) do
            if isAlive(player) then
                player.Character:WaitForChild("Head", math.huge):WaitForChild("NameBbGui", math.huge):WaitForChild("NameTxt", math.huge).TextColor3 = updcolor(player:WaitForChild("leaderstats", math.huge).Status.Value)
                player.Character:WaitForChild("Head", math.huge):WaitForChild("NameBbGui", math.huge):WaitForChild("NameTxt", math.huge).TextStrokeColor3 = updcolorstroke(player:WaitForChild("leaderstats", math.huge).Status.Value)
            end
        end
    end
end)

Components.Spin:OnChanged(function()
    if isAlive() then
        for i, object in pairs(Client.Character.HumanoidRootPart:GetChildren()) do
            if rawequal(object.Name, "Spin") then
                object:Destroy()
            end
        end
        if Flags["Spin"].Value then
            local Body = Instance.new("BodyAngularVelocity")
            Body.Name = "Spin"
            Body.Parent = Client.Character.HumanoidRootPart
            Body.MaxTorque = Vector3.new(0, math.huge, 0)
            Body.AngularVelocity = Vector3.new(0, Flags["Spin Speed"].Value, 0)
        end
    end
end)

Components.SpinSpeed:OnChanged(function()
    if Flags["Spin"].Value and isAlive() then
        if Client.Character.HumanoidRootPart:FindFirstChild("Spin") then
            Client.Character.HumanoidRootPart.Spin.AngularVelocity = Vector3.new(0, Flags["Spin Speed"].Value, 0)
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
        
        for i, objects1 in pairs(objects) do
            local object = objects1[1]
            local property = objects1[2]
        
            if object and property then
                if rawequal(property, "Water") then
                    object.WaterColor = Color3.new(0, 0, 0)
                    object.WaterTransparency = 0
                elseif rawequal(property, "Rock") then
                    object.Color = Color3.new(0, 0, 0)
                elseif rawequal(property, "Crystal") then
                    for i, Child in pairs(object:GetChildren()) do
                        if rawequal(Child.Name, "Part") then
                            Child.Color = Color3.new(0, 0, 0)
                            Child.Material = Enum.Material.Foil
                        elseif rawequal(Child.Name, "CyanGem") then
                            for i, Child1 in pairs(Child:GetChildren()) do
                                Child1.Color = Color3.new(0, 0, 0)
                            end
                        elseif rawequal(Child.Name, "cloud") then
                            for i, Child1 in pairs(Child:GetChildren()) do
                                Child1.Color = Color3.new(0, 0, 0)
                            end
                        end
                    end
                elseif rawequal(property, "Waterfall") then
                    for i, Child in pairs(object:GetChildren()) do
                        if Child:IsA("BasePart") then
                            Child.Color = Color3.new(0, 0, 0)
                            if rawequal(Child.Name, "Union") then
                                Child.UsePartColor = true
                            end
                        end
                    end
                elseif rawequal(property, "Volcano") then
                    for i, Child in pairs(object:GetChildren()) do
                        if rawequal(Child.Name, "LavaFloor") then
                            Child.Color = Color3.new(0, 0, 0)
                            Child.UsePartColor = true
                        elseif rawequal(Child.Name, "Lava") then
                            for i, Child1 in pairs(Child:GetChildren()) do
                                if rawequal(Child1.Name, "LavaPart") or rawequal(Child1.Name, "TouchPart") then
                                    Child1.Color = Color3.new(0, 0, 0)
                                elseif rawequal(Child1.Name, "SmokeEmitter") then
                                    Child1.Color = Color3.new(0, 0, 0)
                                elseif rawequal(Child1.Name, "Splash") then
                                    Child1.Color = Color3.new(0, 0, 0)
                                end
                            end
                        elseif rawequal(Child.Name, "Parts") then
                            for i, Child1 in pairs(Child:GetChildren()) do
                                Child1.Color = Color3.new(0, 0, 0)
                            end
                        end
                    end
                elseif rawequal(property, "IceMountain") then
                    for i, Child in pairs(object:GetChildren()) do
                        Child.Color = Color3.new(0, 0, 0)
                    end
                elseif rawequal(property, "Tornado") then
                    for i, Child in pairs(object:GetChildren()) do
                        if rawequal(Child.Name, "Dust") then
                            Child.Color = Color3.new(0, 0, 0)
                        else
                            Child.Color = Color3.new(0, 0, 0)
                        end
                    end
                elseif rawequal(property, "TrainingArea") then
                    for i, Child in pairs(object:GetChildren()) do
                        if Child.Name:match("StarFSTraining%d") then
                            Child.Color = Color3.new(0, 0, 0)
                            for i, Child1 in pairs(Child:GetChildren()) do
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
                elseif rawequal(property, "Tree") then
                    for i, Leaf in pairs(object.Leaf:GetChildren()) do
                        Leaf.Color = Color3.new(0, 0, 0)
                    end
                    for i, Trunk in pairs(object.Trunk:GetChildren()) do
                        Trunk.Color = Color3.new(0, 0, 0)
                    end
                elseif rawequal(property, "Children") then
                    for i, Child in pairs(object:GetChildren()) do
                        if Child:IsA("BasePart") then
                            Child.Color = Color3.new(0, 0, 0)
                            if rawequal(Child.Name, "Union") then
                                Child.UsePartColor = true
                            end
                        end
                    end
                elseif rawequal(property, "SpotLight") then
                    for i, Light in pairs(object) do
                        if Light:IsA("SpotLight") then
                            Light.Color = Color3.new(0, 0, 0)
                            Light:GetPropertyChangedSignal("Color"):Connect(function()
                                Light.Color = Color3.new(0, 0, 0)
                            end)
                        end
                    end
                elseif rawequal(property, "object") then 
                    for i, ObjectToDestroy in pairs(object:GetChildren()) do
                        if table.find({"Halloween", "GhostRiderCollisionPart", "GrimCollisionPart", "DangerSign", "NPCBlockPart1", "NPCBlockPart2", "CuteFoxyBeanie"}, ObjectToDestroy.Name) then
                            ObjectToDestroy:Destroy()
                        end
                    end
                elseif rawequal(property, "Material") then 
                    for i, Part in pairs(object:GetChildren()) do
                        if Part:IsA("BasePart") and rawequal(Part.Material, Enum.Material.Pebble) then
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
        
        for i, objects1 in pairs(objects) do
            local object = objects1[1]
            local property = objects1[2]
        
            if object and property then
                if rawequal(property, "Water") then
                    object.WaterColor = Color3.new(.5, .7, 1)
                    object.WaterTransparency = 1
                elseif rawequal(property, "Rock") then
                    object.Color = Color3.new(.8, .8, .8)
                elseif rawequal(property, "Crystal") then
                    for i, Child in pairs(object:GetChildren()) do
                        if rawequal(Child.Name, "Part") then
                            Child.Color = Color3.new(.624, .953, .914)
                            Child.Material = Enum.Material.Foil
                        elseif rawequal(Child.Name, "CyanGem") then
                            for i, Child1 in pairs(Child:GetChildren()) do
                                Child1.Color = Color3.new(.016, .687, .926)
                            end
                        elseif rawequal(Child.Name, "cloud") then
                            for i, Child1 in pairs(Child:GetChildren()) do
                                Child1.Color = Color3.new(.950, .953, .953)
                            end
                        end
                    end
                elseif rawequal(property, "Waterfall") then
                    for i, Child in pairs(object:GetChildren()) do
                        if Child:IsA("BasePart") then
                            Child.Color = Color3.new(.471, .565, .510)
                            if rawequal(Child.Name, "Union") then
                                Child.UsePartColor = true
                            end
                        end
                    end
                elseif rawequal(property, "Volcano") then
                    for i, Child in pairs(object:GetChildren()) do
                        if rawequal(Child.Name, "LavaFloor") then
                            Child.Color = Color3.new(1, 0, 0)
                            Child.UsePartColor = true
                        elseif rawequal(Child.Name, "Lava") then
                            for i, Child1 in pairs(Child:GetChildren()) do
                                if rawequal(Child1.Name, "LavaPart") or rawequal(Child1.Name, "TouchPart") then
                                    Child1.Color = Color3.new(1, 0, 0)
                                elseif rawequal(Child1.Name, "SmokeEmitter") then
                                    Child1.Color = Color3.new(.640, .636, .648)
                                elseif rawequal(Child1.Name, "Splash") then
                                    Child1.Color = Color3.new(.973, .973, .973)
                                end
                            end
                        elseif rawequal(Child.Name, "Parts") then
                            for i, Child1 in pairs(Child:GetChildren()) do
                                Child1.Color = Color3.new(.412, .251, .157)
                            end
                        end
                    end
                elseif rawequal(property, "IceMountain") then
                    for i, Child in pairs(object:GetChildren()) do
                        Child.Color = Color3.new(.906, .906, .926)
                    end
                elseif rawequal(property, "Tornado") then
                    for i, Child in pairs(object:GetChildren()) do
                        if rawequal(Child.Name, "Dust") then
                            Child.Color = Color3.new(.389, .373, .385)
                        else
                            Child.Color = Color3.new(.640, .636, .648)
                        end
                    end
                elseif rawequal(property, "Children") then
                    for i, Child in pairs(object:GetChildren()) do
                        if Child:IsA("BasePart") then
                            Child.Color = Color3.new(.632, .769, .550)
                            if rawequal(Child.Name, "Union") then
                                Child.UsePartColor = true
                            end
                        end
                    end
                elseif rawequal(property, "TrainingArea") then
                    for i, Child in pairs(object:GetChildren()) do
                        if rawequal(Child.Name, "StarFSTraining1") then
                            Child.Color = Color3.new(.016, .687, .926)
                            for i, Child1 in pairs(Child:GetChildren()) do
                                if Child1:IsA("BasePart") then
                                    if rawequal(Child1.Name, "Atmosphere1") then
                                        Child1.Color = Color3.new(1, 1, 1)
                                    else
                                        Child1.Color = Color3.new(1, 1, 1)
                                    end
                                end
                            end
                        elseif rawequal(Child.Name, "StarFSTraining2") then
                            Child.Color = Color3.new(0, 1, 0)
                            for i, Child1 in pairs(Child:GetChildren()) do
                                if Child1:IsA("BasePart") then
                                    if rawequal(Child1.Name, "Atmosphere1") then
                                        Child1.Color = Color3.new(0, 1, 0)
                                    else
                                        Child1.Color = Color3.new(1, 1, 0)
                                    end
                                end
                            end
                        elseif rawequal(Child.Name, "StarFSTraining3") then
                            Child.Color = Color3.new(1, 0, 0)
                            for i, Child1 in pairs(Child:GetChildren()) do
                                if Child1:IsA("BasePart") then
                                    if rawequal(Child1.Name, "Atmosphere1") then
                                        Child1.Color = Color3.new(1, .2, 0)
                                    elseif rawequal(Child1.Name, "Atmosphere2") then
                                        Child1.Color = Color3.new(1, .3, 0)
                                    else
                                        Child1.Color = Color3.new(1, .2, 0)
                                    end
                                end
                            end
                        elseif Child.Name:match("PPTrainingPart") then
                            Child.Color = Color3.new(.228, .491, .083)
                        elseif Child.Name:match("GreenFirePart") then
                            Child.Color = Color3.new(.640, .636, .648)
                        elseif Child.Name:match("AcidPart") then
                            Child.Color = Color3.new(0, 1, 0)
                        elseif Child.Name:match("LavaPart2") then
                            Child.Color = Color3.new(1, 0, 0) 
                        end
                    end
                elseif rawequal(property, "Tree") then
                    for i, Leaf in pairs(object.Leaf:GetChildren()) do
                        if rawequal(object.Name, "Tree1") then
                            Leaf.Color = Color3.new(.133333, .545098, .133333)  
                        elseif rawequal(object.Name, "Tree2") then
                            Leaf.Color = Color3.new(.235294, .701961, .443137) 
                        elseif rawequal(object.Name, "Tree3") then
                            Leaf.Color = Color3.new(.180392, .545098, .341176)   
                        end
                    end
                    for i, Trunk in pairs(object.Trunk:GetChildren()) do
                        Trunk.Color = Color3.new(.487, .361, .275)
                    end                 
                elseif rawequal(property, "SpotLight") then
                    for i, Light in pairs(object) do
                        if Light:IsA("SpotLight") then
                            Light.Color = Color3.new(1, .843137, 0)
                            Light:GetPropertyChangedSignal("Color"):Connect(function()
                                Light.Color = Color3.new(1, .843137, 0)
                            end)
                        end
                    end
                elseif rawequal(property, "object") then 
                    for i, ObjectToDestroy in pairs(object:GetChildren()) do
                        if table.find({"Halloween", "GhostRiderCollisionPart", "GrimCollisionPart", "DangerSign", "NPCBlockPart1", "NPCBlockPart2", "CuteFoxyBeanie"}, ObjectToDestroy.Name) then
                            ObjectToDestroy:Destroy()
                        end
                    end
                elseif rawequal(property, "Material") then 
                    for i, Part in pairs(object:GetChildren()) do
                        if Part:IsA("BasePart") and rawequal(Part.Material, Enum.Material.Pebble) then
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

        local specialColors = {
            FS = Color3.new(1, .35, .35),
            BT = Color3.new(.99, .36, .24),
            PP = Color3.new(.32, .62, .98)
        }

        for _, btnName in pairs({'LootBoxBtn', 'InvBtn'}) do
            if MenuFrame:FindFirstChild(btnName) then MenuFrame[btnName]:Destroy() end
        end

        MenuFrame.BackgroundTransparency = 1
        MenuFrame.InfoFrame.BackgroundTransparency = .1
        MenuFrame.InfoFrame.BackgroundColor3 = Color3.new(.04, .04, .04)

        for _, frameName in pairs({"SkillFrame", "GangFrame", "SpecialFrame", "SettingFrame"}) do
            if MenuFrame:FindFirstChild(frameName) then MenuFrame[frameName].BackgroundColor3 = Color3.new(.04, .04, .04) end
        end

        for _, textName in pairs({"NameTxt", "RankTxt", "StatusTxt", "KilledTxt", "MSTxt", "JFTxt", "RepTxt"}) do
            if MenuFrame.InfoFrame:FindFirstChild(textName) then MenuFrame.InfoFrame[textName].TextColor3 = Color3.new(1, 1, 1) end
        end

        for prefix, color in pairs(specialColors) do
            if MenuFrame.InfoFrame:FindFirstChild(prefix .. "Txt") then MenuFrame.InfoFrame[prefix .. "Txt"].TextColor3 = color end
        end

        local menuButtons = {
            {name = "InfoBtn", text = "Stats", size = UDim2.new(.25, 0, .07, 0), pos = UDim2.new(0, 0, .01, 0)},
            {name = "SkilBtn", text = "Skills", size = UDim2.new(.25, 0, .07, 0), pos = UDim2.new(.25, 0, .01, 0)},
            {name = "SpecialBtn", text = "Shop", size = UDim2.new(.25, 0, .07, 0), pos = UDim2.new(.50, 0, .01, 0)},
            {name = "SettingBtn", text = "Settings", size = UDim2.new(.25, 0, .07, 0), pos = UDim2.new(.75, 0, .01, 0)}
        }

        for _, btn in pairs(menuButtons) do
            if MenuFrame:FindFirstChild(btn.name) then
                local button = MenuFrame[btn.name]
                button.Text = btn.text
                button.Size = btn.size
                button.Position = btn.pos
            end
        end

        if MenuFrame:FindFirstChild("CloseBtn") then
            MenuFrame.CloseBtn.TextScaled = false
            MenuFrame.CloseBtn.TextColor3 = Color3.new(.04, .04, .04)
            MenuFrame.CloseBtn.TextSize = 33
        end

        if MenuFrame.InfoFrame:FindFirstChild("RankImgBtn") then
            MenuFrame.InfoFrame.RankImgBtn.Image = game.Players:GetUserThumbnailAsync(game.Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
            local corner = Corner:Clone()
            corner.CornerRadius = UDim.new(1, 0)
            corner.Parent = MenuFrame.InfoFrame.RankImgBtn
            local stroke = UIStroke:Clone()
            stroke.Color = Color3.new(.39, .39, .39)
            stroke.Thickness = 2.5
            stroke.Parent = MenuFrame.InfoFrame.RankImgBtn
        end

        local infoPositions = {
            {"PPMultiplierTxt", UDim2.new(.75, 0, .671774209, 0)},
            {"MSMultiplierTxt", UDim2.new(.75, 0, .893548429, 0)},
            {"PPUpgradeImgBtn", UDim2.new(.93, 0, .674758077, 0)},
            {"MSUpgradeImgBtn", UDim2.new(.93, 0, .898548424, 0)},
            {"Img5", UDim2.new(.025, 0, .663157105, 0)},
            {"Img3", UDim2.new(.025, 0, .88, 0)},
            {"MSTxt", UDim2.new(.11, 0, .89, 0)},
            {"PPTxt", UDim2.new(.11, 0, .67, 0)}
        }

        for _, item in pairs(infoPositions) do
            if MenuFrame.InfoFrame:FindFirstChild(item[1]) then MenuFrame.InfoFrame[item[1]].Position = item[2] end
        end

        for _, element in pairs({"GuideImg", "GuideTxt"}) do
            if MenuFrame.InfoFrame:FindFirstChild(element) then MenuFrame.InfoFrame[element].Visible = false end
        end

        if MenuFrame:FindFirstChild("GangBtn") then MenuFrame.GangBtn.Visible = false end

        if ScreenGui:FindFirstChild("MenuBtn") then
            ScreenGui.MenuBtn.BackgroundColor3 = Color3.new(.04, .04, .04)
            ScreenGui.MenuBtn.BorderColor3 = Color3.new(0, 0, 0)
            ScreenGui.MenuBtn.TextColor3 = Color3.new(0, 0, 0)
        end

        if ScreenGui:FindFirstChild("CurrentGemImgBtn") then
            ScreenGui.CurrentGemImgBtn.ImageColor3 = Color3.new(0, 0, 0)
            if ScreenGui.CurrentGemImgBtn:FindFirstChild("AmountTxtBtn") then
                ScreenGui.CurrentGemImgBtn.AmountTxtBtn.TextColor3 = Color3.new(.04, .04, .04)
                ScreenGui.CurrentGemImgBtn.AmountTxtBtn.TextStrokeColor3 = Color3.new(0, 0, 0)
            end
        end

        for i = 1, 19 do
            local textName = "SkillTxt" .. i
            if MenuFrame.SkillFrame:FindFirstChild(textName) then MenuFrame.SkillFrame[textName].TextColor3 = Color3.new(.29, .76, .27) end
        end

        for i = 0, 18 do
            local textName = "SettingTxt" .. i
            if MenuFrame.SettingFrame:FindFirstChild(textName) then MenuFrame.SettingFrame[textName].TextColor3 = Color3.new(.29, .76, .27) end
        end

        local questFrames = {"MainQuestFrame", "DailyQuestFrame", "SpecialQuestFrame", "WeeklyQuestFrame"}

        for _, frameName in pairs(questFrames) do
            if ScreenGui:FindFirstChild(frameName) then
                local frame = ScreenGui[frameName]
                frame.BackgroundColor3 = Color3.new(.04, .04, .04)
                frame.BorderColor3 = Color3.new(0, 0, 0)
                
                for _, btnName in pairs({"LeftBtn", "RightBtn"}) do
                    if frame:FindFirstChild(btnName) then frame[btnName].BackgroundColor3 = Color3.new(.04, .04, .04) end
                end
                
                frame.ScrollBarImageColor3 = Color3.new(0, 0, 0)
                frame.ScrollBarThickness = 12
                
                if frame:FindFirstChild("HeaderTxt1") then
                    frame.HeaderTxt1.BackgroundColor3 = Color3.new(.04, .04, .04)
                    frame.HeaderTxt1.TextColor3 = Color3.new(0, 0, 0)
                end
                
                for i = 1, 9 do
                    local maxFrameName = "MaxFrame" .. i
                    if frame:FindFirstChild(maxFrameName) then
                        frame[maxFrameName].BackgroundColor3 = Color3.new(.04, .04, .04)
                        if frame[maxFrameName]:FindFirstChild("RewardTxt") and frame[maxFrameName].RewardTxt:FindFirstChild("GemImgBtn") then
                            frame[maxFrameName].RewardTxt.GemImgBtn.ImageColor3 = Color3.new(0, 0, 0)
                            if frame[maxFrameName].RewardTxt.GemImgBtn:FindFirstChild("AmountTxt") then
                                frame[maxFrameName].RewardTxt.GemImgBtn.AmountTxt.TextColor3 = Color3.new(.04, .04, .04)
                                frame[maxFrameName].RewardTxt.GemImgBtn.AmountTxt.TextStrokeColor3 = Color3.new(0, 0, 0)
                            end
                        end
                    end
                end
            end
        end
    end
})

Tabs.Visual:AddButton({
    Title = "Leaderboards On Spawn",
    Callback = function()
        local Positions = {
            CFrame.fromMatrix(Vector3.new(359, 252, 830), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0)),
            CFrame.fromMatrix(Vector3.new(359, 252, 810), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0)),
            CFrame.fromMatrix(Vector3.new(359, 252, 790), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0)),
            CFrame.fromMatrix(Vector3.new(359, 264, 830), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0)),
            CFrame.fromMatrix(Vector3.new(359, 264, 810), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0))
        }

        local Index = 0
        for i, object in pairs(Workspace.Main:GetChildren()) do
            if object:IsA("Part") and object.Name:match("LeaderBoardPart") then
                Index += 1
                object:PivotTo(Positions[Index])
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
        Client:GetMouse().KeyDown:Connect(function(Key, P)
            if P then return end
            if rawequal(Key, "v") then
                if Client:GetMouse().Target and isAlive() then
                    if Check then
                        if not getsenv(Client.PlayerScripts.MainScript).CanTeleport then
                            Client.Character.HumanoidRootPart:PivotTo(Client.Character.HumanoidRootPart:GetPivot() - (Client.Character.HumanoidRootPart.Position - Vector3.new(Client:GetMouse().Hit.X, Client:GetMouse().Hit.Y + 5, Client:GetMouse().Hit.Z)))
                        end
                    else
                        Client.Character.HumanoidRootPart:PivotTo(Client.Character.HumanoidRootPart:GetPivot() - (Client.Character.HumanoidRootPart.Position - Vector3.new(Client:GetMouse().Hit.X, Client:GetMouse().Hit.Y + 5, Client:GetMouse().Hit.Z)))
                    end
                end
            end
        end)
    end
})

Tabs.Pvp:AddButton({
    Title = "Teleport",
    Callback = function()
        for i, Target in pairs(Targets) do
            if isAlive() and isAlive(Players:FindFirstChild(Target)) then
                Client.Character.HumanoidRootPart:PivotTo(Players:FindFirstChild(Target).Character.HumanoidRootPart:GetPivot())
            end
        end
    end
})

Tabs.Teleports:AddButton({
    Title = "Teleport To Location",
    Callback = function()
        if isAlive() then
            Client.Character.HumanoidRootPart:PivotTo(teleportposition[Flags["Locations"].Value])
        end
    end
})

Tabs.Fun:AddButton({
    Title = "Ball",
    Callback = function()
        if isAlive() then
            for i, object in pairs(Client.Character:GetDescendants()) do
                if object:IsA("BasePart") then
                    object.CanCollide = false
                end
            end

            local Ball = Client.Character.HumanoidRootPart
            Ball.Shape = Enum.PartType.Ball
            Ball.Size = Vector3.new(5, 5, 5)
            local Humanoid = Client.Character.Humanoid
            local Params = RaycastParams.new()
            Params.FilterType = Enum.RaycastFilterType.Blacklist
            Params.FilterDescendantsInstances = {Client.Character}
            local tc = RunService.PreRender:Connect(function(Delta)
                Ball.CanCollide = true
                Humanoid.PlatformStand = true
                if UserInputService:GetFocusedTextBox() then return end
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    Ball.RotVelocity = Ball.RotVelocity - Camera:GetPivot().RightVector * Delta * 30
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    Ball.RotVelocity = Ball.RotVelocity - Camera:GetPivot().LookVector * Delta * 30
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    Ball.RotVelocity += Camera:GetPivot().RightVector * Delta * 30
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    Ball.RotVelocity += Camera:GetPivot().LookVector * Delta * 30
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
        TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Client)
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
        for i, object in pairs(game:GetDescendants()) do
            pcall(function()
                object.Material = "Plastic"
                object.Reflectance = 0
                object.TextureID = 10385902758728957
                object.Transparency = 1
                object.Lifetime = NumberRange.new(0)
                object.BlastPressure = 1
                object.BlastRadius = 1
                object.Enabled = false
            end)
        end
        
        for i, effect in pairs(Lighting:GetChildren()) do
            pcall(function()
                effect.Enabled = false
            end)
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
            Client.Character.HumanoidRootPart:PivotTo(CFrame.fromMatrix(Vector3.new(470, 250, 900), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0)))
        end
    end
})

Tabs.Settings:AddKeybind("Keybind", {
    Title = "Respawn",
    Default = "F1",
    Mode = "Toggle",
    Callback = function()
        if isAlive() then
            SavedPosition = Client.Character.HumanoidRootPart:GetPivot()
            SavedCameraCFrame = Camera:GetPivot()
            Camera.CameraType = "Fixed"
            if not Client.Character:FindFirstChild("GodModeShield") and not Client.Character:FindFirstChild("GodModeShield ") and not Client.Character:FindFirstChild("ForceField") and not Client.Character:FindFirstChild("SafeZoneShield") and not rawequal(Client.Character.Humanoid.Health, 0) then
                RemoteEvent:FireServer({"QuestTalkStart"})
            end
            Client.Character.HumanoidRootPart:PivotTo(CFrame.fromMatrix(Vector3.new(math.huge, -math.huge, math.huge), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0)))
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

for i, player in pairs(Players:GetPlayers()) do
    if not rawequal(player, Client) then
        local PrivateStats = player:WaitForChild("PrivateStats", math.huge)
        local LeaderStats = player:WaitForChild("leaderstats", math.huge)
        local Status = LeaderStats:WaitForChild("Status", math.huge)

        CreateESP(player)
        CreateHighlight(player)

        player:WaitForChild("LocalSoundFolder", math.huge):Destroy()
        player.Chatted:Connect(function(message)
            onChatted(player, message)
        end)
        
        for i, object in pairs(UpdatingStats) do
            PrivateStats:WaitForChild(object[1], math.huge):GetPropertyChangedSignal("Value"):Connect(function()
                if Esp:FindFirstChild(player.Name) then
                    Esp[player.Name].Frame[object[2]].Text = object[2] .. ": " .. ConvertToLetter(PrivateStats[object[1]].Value)
                end
            end)
        end

        Status:GetPropertyChangedSignal("Value"):Connect(function()
            if Esp:FindFirstChild(player.Name) then
                Esp[player.Name].Frame.Names.TextColor3 = updcolor(Status.Value)
                Esp[player.Name].Frame.Names.TextStrokeColor3 = updcolorstroke(Status.Value)
            end

            if Highlights:FindFirstChild(player.Name) then
                Highlights[player.Name].FillColor = updcolor(Status.Value)
                Highlights[player.Name].OutlineColor = updcolor(Status.Value)
            end
        end)

        if isAlive(player) then
            local Humanoid = player.Character:FindFirstChild("Humanoid")
            
            Esp[player.Name].Frame.Health.Text = "Health: " .. ConvertToLetter(Humanoid.MaxHealth) .. "/" .. ConvertToLetter(Humanoid.MaxHealth)
            
            Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                Esp[player.Name].Frame.Health.Text = "Health: " .. ConvertToLetter(Humanoid.Health) .. "/" .. ConvertToLetter(Humanoid.MaxHealth)
            end)

            player.Character.ChildAdded:Connect(function(object)
                task.wait()
                if rawequal(object.Name, "KillingIntentPart") and Flags["Anti Killing Intent Aura"].Value then
                    object:Destroy()
                end
            end)

            player.Character.Humanoid.Died:Connect(function()
                if Esp:FindFirstChild(player.Name) then
                    Esp[player.Name].Adornee = nil
                    Esp[player.Name].Enabled = false
                end

                if Highlights:FindFirstChild(player.Name) then
                    Highlights[player.Name].Adornee = nil
                    Highlights[player.Name].Enabled = false
                end

                if Flags["Logs"].Value["Dead"] then
                    if Flags["Type Of Logs"].Value["Chat"] then
                        StarterGui:SetCore("ChatMakeSystemMessage", ({Text = player.DisplayName .. " (@" .. player.Name .. ") Dead", Color = Color3.new(1, 0, 0), Font = "GothamBold", TextSize = 18}))
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
            local Humanoid = character:WaitForChild("Humanoid", math.huge)

            if Highlights:FindFirstChild(player.Name) then
                Highlights[player.Name].Adornee = Flags["Highlights"].Value and character or nil
                Highlights[player.Name].Enabled = Flags["Highlights"].Value
            end

            if Esp:FindFirstChild(player.Name) then
                Esp[player.Name].Adornee = Flags["ESP"].Value and character:WaitForChild("Head") or nil
                Esp[player.Name].Enabled = Flags["ESP"].Value
            end

            Esp[player.Name].Frame.Health.Text = "Health: " .. ConvertToLetter(Humanoid.MaxHealth) .. "/" .. ConvertToLetter(Humanoid.MaxHealth)

            Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                Esp[player.Name].Frame.Health.Text = "Health: " .. ConvertToLetter(Humanoid.Health) .. "/" .. ConvertToLetter(Humanoid.MaxHealth)
            end)

            Humanoid.Died:Connect(function()     
                if Esp:FindFirstChild(player.Name) then
                    Esp[player.Name].Adornee = nil
                    Esp[player.Name].Enabled = false
                end

                if Highlights:FindFirstChild(player.Name) then
                    Highlights[player.Name].Adornee = nil
                    Highlights[player.Name].Enabled = false
                end

                if Flags["Logs"].Value["Dead"] then
                    if Flags["Type Of Logs"].Value["Chat"] then
                        StarterGui:SetCore("ChatMakeSystemMessage", ({Text = player.DisplayName .. " (@" .. player.Name .. ") Dead", Color = Color3.new(1, 0, 0), Font = "GothamBold", TextSize = 18}))
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

            character.ChildAdded:Connect(function(object)
                task.wait()
                if rawequal(object.Name, "KillingIntentPart") and Flags["Anti Killing Intent Aura"].Value then
                    object:Destroy()
                end
            end)
        end)
    end
end

Players.PlayerAdded:Connect(function(player)
    local PrivateStats = player:WaitForChild("PrivateStats", math.huge)
    local LeaderStats = player:WaitForChild("leaderstats", math.huge)
    local Status = LeaderStats:WaitForChild("Status", math.huge)

    CreateESP(player)
    CreateHighlight(player)

    player:WaitForChild("LocalSoundFolder", math.huge):Destroy()
    player.Chatted:Connect(function(message)
        onChatted(player, message)
    end)
    
    for i, object in pairs(UpdatingStats) do
        PrivateStats:WaitForChild(object[1], math.huge):GetPropertyChangedSignal("Value"):Connect(function()
            if Esp:FindFirstChild(player.Name) then
                Esp[player.Name].Frame[object[2]].Text = object[2] .. ": " .. ConvertToLetter(PrivateStats:WaitForChild(object[1], math.huge).Value)
            end
        end)
    end

    Status:GetPropertyChangedSignal("Value"):Connect(function()
        if Esp:FindFirstChild(player.Name) then
            Esp[player.Name].Frame.Names.TextColor3 = updcolor(Status.Value)
            Esp[player.Name].Frame.Names.TextStrokeColor3 = updcolorstroke(Status.Value)
        end

        if Highlights:FindFirstChild(player.Name) then
            Highlights[player.Name].FillColor = updcolor(Status.Value)
            Highlights[player.Name].OutlineColor = updcolor(Status.Value)
        end
    end)
    
    if Flags["Logs"].Value["Joined/Left"] then
        if Flags["Type Of Logs"].Value["Chat"] then
            StarterGui:SetCore("ChatMakeSystemMessage", {Text = player.DisplayName .. " (@" .. player.Name .. ") Has joined",Color = Color3.new(0, 1, .101961),Font = "GothamBold",TextSize = 18})
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

    player.CharacterAdded:Connect(function(character)
        local Humanoid = character:WaitForChild("Humanoid", math.huge)

        if Highlights:FindFirstChild(player.Name) then
            Highlights[player.Name].Adornee = Flags["Highlights"].Value and character or nil
            Highlights[player.Name].Enabled = Flags["Highlights"].Value
        end

        if Esp:FindFirstChild(player.Name) then
            Esp[player.Name].Adornee = Flags["ESP"].Value and character:WaitForChild("Head") or nil
            Esp[player.Name].Enabled = Flags["ESP"].Value
        end
        
        Esp[player.Name].Frame.Health.Text = "Health: " .. ConvertToLetter(Humanoid.MaxHealth) .. "/" .. ConvertToLetter(Humanoid.MaxHealth)

        Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            Esp[player.Name].Frame.Health.Text = "Health: " .. ConvertToLetter(Humanoid.Health) .. "/" .. ConvertToLetter(Humanoid.MaxHealth)
        end)

        Humanoid.Died:Connect(function()         
            if Esp:FindFirstChild(player.Name) then
                Esp[player.Name].Adornee = nil
                Esp[player.Name].Enabled = false
            end

            if Highlights:FindFirstChild(player.Name) then
                Highlights[player.Name].Adornee = nil
                Highlights[player.Name].Enabled = false
            end

            if Flags["Logs"].Value["Dead"] then
                if Flags["Type Of Logs"].Value["Chat"] then
                    StarterGui:SetCore("ChatMakeSystemMessage", ({Text = player.DisplayName .. " (@" .. player.Name .. ") Dead", Color = Color3.new(1, 0, 0), Font = "GothamBold", TextSize = 18}))
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

Players.PlayerRemoving:Connect(function(player)
    lastChatted[player.Name] = nil
    
    if Esp:FindFirstChild(player.Name) then
        Esp[player.Name]:Destroy()
    end

    if Highlights:FindFirstChild(player.Name) then
        Highlights[player.Name]:Destroy()
    end
    
    if Flags["Logs"].Value["Joined/Left"] then
        if Flags["Type Of Logs"].Value["Chat"] then
            StarterGui:SetCore("ChatMakeSystemMessage", {Text = player.DisplayName .. " (@" .. player.Name .. ") Has left",Color = Color3.new(1, 0, 0),Font = "GothamBold",TextSize = 18})
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
        for i, rTarget in pairs(Targets) do
            if rawequal(rTarget, player.Name) then
                table.remove(Targets, i)
            end
        end
    end

    if table.find(Whitelisted, player.Name) then
        for i, rTarget in pairs(Whitelisted) do
            if rawequal(rTarget, player.Name) then
                table.remove(Whitelisted, i)
            end
        end
    end
end)

local function IsAuraEnabled()
    for i, object in pairs(Client.Character:GetDescendants()) do
        if not rawequal(object.Name, "KillingIntentAuraSound") and object.Name:match("Aura") then
            return true
        end
    end
end

Client.CharacterAdded:Connect(function(character)
    local Humanoid = character:WaitForChild("Humanoid", math.huge)
    local HumanoidRootPart = character:WaitForChild("HumanoidRootPart", math.huge)

    if Flags["Stack"].Value then
        task.spawn(function()
            repeat task.wait() until character:FindFirstChild("ForceField")
            task.wait(4.2)
            RemoteEvent:FireServer({"Respawn"})
        end)
    end

    if Flags["GodMode"].Value then
        task.spawn(function()
            repeat task.wait() until character:FindFirstChild("ForceField") and GodCheck
            RemoteEvent:FireServer({"QuestTalkStart"})
        end)
    end

    if Flags["Spin"].Value then
        task.spawn(function()
            local BodyAngularVelocity = Instance.new("BodyAngularVelocity")
            BodyAngularVelocity.Name = "Spin"
            BodyAngularVelocity.Parent = HumanoidRootPart
            BodyAngularVelocity.MaxTorque = Vector3.new(0, math.huge, 0)
            BodyAngularVelocity.AngularVelocity = Vector3.new(0, Flags["Spin Speed"].Value, 0)
        end)
    end

    if Flags["Auto Super Aura"].Value then
        task.spawn(function()
            task.wait(.5)
            RemoteEvent:FireServer({"ConcealRevealAura"})
        end)
    elseif Flags["Auto Disable Aura"].Value then
        task.spawn(function()
            repeat task.wait() until IsAuraEnabled()
            RemoteEvent:FireServer({"ConcealRevealAura"})
        end)
    end

    if not rawequal(Flags["Animations"].Value, "None") then
        task.spawn(function()
            for i, object in pairs(Animations[Flags["Animations"].Value]) do
                local Action, SubAction, AssetId = unpack(object)
                character:WaitForChild("Animate", math.huge):WaitForChild(Action, math.huge)[SubAction].AnimationId = AssetId
            end
        end)
    end

    if SavedPosition and SavedCameraCFrame and not Flags["Stack"].Value then
        task.spawn(function()
            HumanoidRootPart:PivotTo(SavedPosition)
            HumanoidRootPart:GetPropertyChangedSignal("CFrame"):Wait()
            HumanoidRootPart:PivotTo(SavedPosition)
        end)
        task.spawn(function()
            Camera:PivotTo(SavedCameraCFrame)
            Camera:GetPropertyChangedSignal("CFrame"):Wait()
            Camera:PivotTo(SavedCameraCFrame)
        end)
    end

    RespawnFunction = Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
        if Humanoid.MaxHealth * RespawnHealth >= Humanoid.Health then
            if not Flags["Stack"].Value then
                RespawnFunction:Disconnect()
                SavedPosition = HumanoidRootPart:GetPivot()
                SavedCameraCFrame = Camera:GetPivot()
                Camera.CameraType = "Fixed"
                if not character:FindFirstChild("GodModeShield") and not character:FindFirstChild("GodModeShield ") and not character:FindFirstChild("ForceField") and not rawequal(Humanoid.Health, 0) then
                    RemoteEvent:FireServer({"QuestTalkStart"})
                end
                HumanoidRootPart:PivotTo(CFrame.fromMatrix(Vector3.new(math.huge, -math.huge, math.huge), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0)))
                RemoteEvent:FireServer({"Respawn"})
            end
        end
    end)

    character.ChildAdded:Connect(function(object)
        task.wait()
        if rawequal(object.Name, "KillingIntentPart") and Flags["Anti Killing Intent Aura"].Value then
            object:Destroy()
        elseif rawequal(object.Name, "GodModeShield") and Flags["GodMode"].Value and not Check then
            object.Name = "GodModeShield "
        end
    end)
    
    Humanoid.Died:Connect(function()
        task.delay(0, function()
            if not Check then
                TweenService:Create(Camera, TweenInfo.new(0, Enum.EasingStyle.Linear), {CFrame = Camera:GetPivot()}):Play()
            end
        end)

        if Flags["Stack"].Value then
            RemoteEvent:FireServer({"Respawn"})
        end
        
        if Flags["Logs"].Value["Dead"] then
            if Flags["Type Of Logs"].Value["Chat"] then
                StarterGui:SetCore("ChatMakeSystemMessage", ({Text = Client.DisplayName .. " (@" .. Client.Name .. ") Dead", Color = Color3.new(1, 0, 0), Font = "GothamBold", TextSize = 18}))
            end
            
            if Flags["Type Of Logs"].Value["Notify"] then
                Fluent:Notify({
                    Title = "Z3XHub",
                    Content = "[LOGS]",
                    SubContent = Client.DisplayName .. " (@" .. Client.Name .. ") Dead",
                    Duration = 3
                })
            end

            if Flags["Type Of Logs"].Value["Console"] then
                print("[LOGS]: " .. Client.DisplayName .. " (@" .. Client.Name .. ") Dead")
            end
        end
    end)
end)

Workspace.ChildAdded:Connect(function(object)
    task.wait()
    if rawequal(object.Name, "Part") then
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
    SubContent = "Welcome, " .. Client.Name .. "!",
    Duration = 3
})

getgenv().Loaded = true
