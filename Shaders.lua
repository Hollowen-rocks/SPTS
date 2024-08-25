local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui
screenGui.IgnoreGuiInset = true

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.5, 0, 0.1, 0)  
frame.Position = UDim2.new(0.5, 0, 0.75, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5) 
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui
frame.ClipsDescendants = true 
frame.Active = true 

local shadowFrame = Instance.new("Frame")
shadowFrame.Size = UDim2.new(1, 10, 1, 10)  
shadowFrame.Position = UDim2.new(0.5, 5, 0.5, 5)
shadowFrame.AnchorPoint = Vector2.new(0.5, 0.5)
shadowFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
shadowFrame.BorderSizePixel = 0
shadowFrame.Parent = frame


local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame


local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.Position = UDim2.new(0, 0, 0, 0)
textLabel.Text = "Shaders and GUI made by Hollowen_rocks"
textLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.Font = Enum.Font.SourceSansBold
textLabel.TextSize = 24
textLabel.Parent = frame

local function closeGui()
    local endSize = UDim2.new(0, 0, 0, 0)
    local endPosition = UDim2.new(0.5, 0, 0.5, 0)
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local sizeTween = TweenService:Create(frame, tweenInfo, {Size = endSize})
    local positionTween = TweenService:Create(frame, tweenInfo, {Position = endPosition})

    sizeTween:Play()
    positionTween:Play()

    sizeTween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        closeGui()
    end
end)

game.MaterialService.Use2022Materials = true

for i, v in pairs(workspace.Main.Waterfall:GetDescendants()) do
    if v:IsA("Part") or v:IsA("Mesh") or v:IsA("BasePart") then
        if v.Color == Color3.fromRGB(128, 187, 219) or v.Transparency == 0.5 or v.Color == Color3.fromRGB(17, 17, 17) then
            v.Color = Color3.fromRGB(17, 17, 17)
        else
            v.Color = Color3.fromRGB(66, 66, 66)
        end
        if v.ClassName == "UnionOperation" then v.UsePartColor = true end
    end
end

for i, v in pairs(workspace.Main.Waterfall:GetChildren()) do
    if v.Name == "Waterfall" then
        v:Destroy()
    end
end

workspace.Terrain.WaterColor = Color3.fromRGB(30, 156, 237)
workspace.Terrain.WaterTransparency = 1
workspace.Terrain.WaterReflectance = 0.7

for i, v in pairs(workspace.Main.OceanFloor:GetChildren()) do
    v.Color = Color3.fromRGB(176, 146, 98)
end

for i, v in pairs(workspace.Main.WaterWalkFloor:GetChildren()) do
    v.Color = Color3.fromRGB(17, 17, 17)
end

for i, v in pairs(workspace.Town.Color.Floor:GetChildren()) do
    v.Color = Color3.fromRGB(109, 145, 81)
end

for i, v in pairs(workspace.Town.Core:GetDescendants()) do
    if v:IsA("SpotLight") then
        v.Color = Color3.fromRGB(120, 0, 255)
    end
end

local BubbleChatUI = playerGui:WaitForChild("BubbleChat")
BubbleChatUI.DescendantAdded:Connect(function(Descendant)
    if Descendant:IsA("ImageLabel") then
        Descendant.ImageColor3 = Color3.fromRGB(59, 59, 59)
    elseif Descendant:IsA("TextLabel") then
        Descendant.TextColor3 = Color3.new(1,1,1)
    end
end)

if game.Lighting:FindFirstChild("SunRays") then game.Lighting.SunRays:Destroy() end

local Skybox = Instance.new("Sky", game.Lighting)
Skybox.SkyboxBk = "http://www.roblox.com/asset/?id=159454299"
Skybox.SkyboxDn = "http://www.roblox.com/asset/?id=159454296"
Skybox.SkyboxFt = "http://www.roblox.com/asset/?id=159454293"
Skybox.SkyboxLf = "http://www.roblox.com/asset/?id=159454286"
Skybox.SkyboxRt = "http://www.roblox.com/asset/?id=159454300"
Skybox.SkyboxUp = "http://www.roblox.com/asset/?id=159454288"
Skybox.CelestialBodiesShown = false

game.Lighting:GetPropertyChangedSignal("TimeOfDay"):Connect(function() game.Lighting.TimeOfDay = 9 end)

wait(0.5)

for s, a in pairs({1, 2, 3}) do
    local treeColor
    if s == 1 then
        treeColor = Color3.fromRGB(34, 139, 34)  
    elseif s == 2 then
        treeColor = Color3.fromRGB(60, 179, 113) 
    else
        treeColor = Color3.fromRGB(46, 139, 87)  
    end

    local trunkColor
    if s == 1 then
        trunkColor = Color3.fromRGB(101, 67, 33)  
    elseif s == 2 then
        trunkColor = Color3.fromRGB(139, 69, 19) 
    else
        trunkColor = Color3.fromRGB(160, 82, 45) 
    end

    for i, v in pairs(workspace.Town.Color["Tree"..s].Leaf:GetChildren()) do
        v.Color = treeColor
    end
    for i, v in pairs(workspace.Town.Color["Tree"..s].Trunk:GetChildren()) do
        v.Color = trunkColor
    end
end

local function changeColorToBlack(folder)
    for _, obj in ipairs(folder:GetChildren()) do
        if obj:IsA("BasePart") then
            obj.BrickColor = BrickColor.new("Really black")
        elseif obj:IsA("Folder") then
            changeColorToBlack(obj)
        end
    end
end

local mainFolder = workspace:FindFirstChild("Main")
if mainFolder then
    local oceanFloorModel = mainFolder:FindFirstChild("OceanFloor")
    if oceanFloorModel then
        changeColorToBlack(oceanFloorModel)
    end
end

wait(0.1)

local terrain = workspace:FindFirstChild("Terrain")
if terrain then
    terrain.WaterTransparency = 0.25
end

wait(0.01)

local function findAndDelete(folder, path)
    local folders = path:split("/")
    local target = folder
    for _, name in ipairs(folders) do
        target = target:FindFirstChild(name)
        if not target then
            return
        end
    end
    target:Destroy()
    print("Removed: ", path)
end

local function findAndColor(folder, path)
    local folders = path:split("/")
    local target = folder
    for _, name in ipairs(folders) do
        target = target:FindFirstChild(name)
        if not target then
            return
        end
    end

    local unionOperations = {}
    local baseParts = {}
    local wedges = {}
    for _, obj in pairs(target:GetDescendants()) do
        if obj:IsA("UnionOperation") then
            table.insert(unionOperations, obj)
        elseif obj:IsA("BasePart") then
            table.insert(baseParts, obj)
        elseif obj:IsA("WedgePart") then
            table.insert(wedges, obj)
        end
    end

    for _, obj in ipairs(unionOperations) do
        obj.Color = Color3.fromRGB(120, 0, 255)
        obj.UsePartColor = true
    end

    for _, obj in ipairs(baseParts) do
        obj.Color = Color3.fromRGB(120, 0, 255)
    end

    for _, obj in ipairs(wedges) do
        obj.Color = Color3.fromRGB(120, 0, 255)
    end
end

findAndDelete(workspace, "Main/OceanFloor/Rocks")
findAndDelete(workspace, "Main/OceanFloor/Ocean Floor")
findAndColor(workspace, "Main/OceanFloor/Structures")
findAndColor(workspace, "Main/OceanFloor/Sand")
