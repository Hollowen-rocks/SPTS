function clear()
    for i,v in next, game.CoreGui:GetChildren() do
        if v.Name == "ScreenGui" then
            v:Destroy()
        end
    end
  end
  
  clear()
  
  local playerlist = {};
  for i,v in pairs(game.Players:GetPlayers())do 
  table.insert(playerlist,v.Name)
  end
  
  game.StarterGui:SetCore("SendNotification", {
	Title = "Notification",
	Text = "The script is made by Wer4eryyy" ,
	Button1 = "Ok",
	Duration = math.huge
})
  
function PlayerJoined(text)
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = text;
        Color = Color3.fromRGB(0, 255, 26);
        Font = Enum.Font.SourceSansBold;
        TextSize = 20
    })
end


function PlayerLeft(text)
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = text;
        Color = Color3.fromRGB(255, 0, 0);
        Font = Enum.Font.SourceSansBold;
        TextSize = 20
    })
end


game:GetService("Players").PlayerAdded:Connect(function(whojoined)
    PlayerJoined(whojoined.DisplayName.." (@"..whojoined.Name..") has joined the game")
end)

game:GetService("Players").PlayerRemoving:Connect(function(wholeft)
    PlayerLeft(wholeft.DisplayName.." (@"..wholeft.Name..") has left the game")
end)

  local remote = game:GetService("ReplicatedStorage").RemoteEvent
  
  function getfs()
      if game.Players.LocalPlayer.PrivateStats.FistStrength.Value  >= 1e13 then return "+FS6"
      elseif game.Players.LocalPlayer.PrivateStats.FistStrength.Value  >= 1e11 then return "+FS5"
      elseif game.Players.LocalPlayer.PrivateStats.FistStrength.Value  >= 1e9 then return "+FS4"
      elseif game.Players.LocalPlayer.PrivateStats.FistStrength.Value  < 1e9 then return "+FS3"
      end
  end
  
  function getpp()
      if game.Players.LocalPlayer.PrivateStats.PsychicPower.Value >= 1e15 then return "+PP6"
      elseif game.Players.LocalPlayer.PrivateStats.PsychicPower.Value >= 1e12 then return "+PP5"
      elseif game.Players.LocalPlayer.PrivateStats.PsychicPower.Value >= 1e9 then return "+PP4"
      elseif game.Players.LocalPlayer.PrivateStats.PsychicPower.Value <= 1e6 then return "+PP3"
      elseif game.Players.LocalPlayer.PrivateStats.PsychicPower.Value < 1e6 then return "+PP2"
      end
  end
  
  function getfspos()
      if game.Players.LocalPlayer.PrivateStats.FistStrength.Value >= 1e13 then return -364.097198, 15735.1455, -7.32395744
      elseif game.Players.LocalPlayer.PrivateStats.FistStrength.Value >= 1e11 then return 1380.3583984375, 9273.736328125, 1652.6295166015625
      elseif game.Players.LocalPlayer.PrivateStats.FistStrength.Value >= 1e9 then return 1175.2962646484375, 4789.25341796875, -2293.052978515625
      end
  end
  
  function getbtpos()
      if game.Players.LocalPlayer.PrivateStats.BodyToughness.Value >= 4e13 then return -278.3638916015625, 281.3877868652344, 1005.1320190429688
      elseif game.Players.LocalPlayer.PrivateStats.BodyToughness.Value >= 4e11 then return -275.5314025878906, 281.6444396972656, 991.4784545898438
      elseif game.Players.LocalPlayer.PrivateStats.BodyToughness.Value >= 4e9 then return -244.4465789794922, 287.1148986816406, 978.9732666015625
      elseif game.Players.LocalPlayer.PrivateStats.BodyToughness.Value >= 4e7 then return -2024.790283203125, 714.248779296875, -1882.2078857421875
      elseif game.Players.LocalPlayer.PrivateStats.BodyToughness.Value >= 4e6 then return -2297.46484375, 976.7352294921875, 1075.0213623046875
      elseif game.Players.LocalPlayer.PrivateStats.BodyToughness.Value >= 4e5 then return 1634.4921875, 259.62298583984375, 2248.2060546875
      elseif game.Players.LocalPlayer.PrivateStats.BodyToughness.Value >= 4e4 then return 357.2840881347656, 263.7413635253906, -492.33245849609375
      elseif game.Players.LocalPlayer.PrivateStats.BodyToughness.Value >= 4e2 then return 367.770751953125, 249.7052459716797, -444.747802734375
      end
  end
  
  function getpppos()
      if game.Players.LocalPlayer.PrivateStats.PsychicPower.Value >= 1000000000000000 then return -2545.082763671875, 5412.32958984375, -491.8777160644531
      elseif game.Players.LocalPlayer.PrivateStats.PsychicPower.Value >= 1000000000 and game.Players.LocalPlayer.PrivateStats.PsychicPower.Value <= 999999999999 then return -2581.781005859375, 5516.38818359375, -500.4078674316406
      elseif game.Players.LocalPlayer.PrivateStats.PsychicPower.Value >= 1000000000 and game.Players.LocalPlayer.PrivateStats.PsychicPower.Value <= 999999999999 then return -2561.86328125, 5500.8828125, -440.46112060546875
      elseif game.Players.LocalPlayer.PrivateStats.PsychicPower.Value <= 1000000 and game.Players.LocalPlayer.PrivateStats.PsychicPower.Value <= 999999999 then return -2529.778076171875, 5486.39208984375, -534.6697998046875
      end
  end
  
  local playerfiststat = game:GetService("Players").LocalPlayer.PrivateStats.FistStrength.Value
  local ballstat = ""
  
  repeat wait() until game.Players.LocalPlayer.PrivateStats:FindFirstChild("FistStrength")
  
  if playerfiststat >= 999 and playerfiststat <= 10000 then ballstat = "EnergySphere1"
  elseif playerfiststat >= 9999 and playerfiststat <= 100000 then ballstat = "EnergySphere2"
  elseif playerfiststat >= 99999 and playerfiststat <= 1000000 then ballstat = "EnergySphere3"
  elseif playerfiststat >= 999999 and playerfiststat <= 10000000 then ballstat = "EnergySphere4"
  elseif playerfiststat >= 9999999 and playerfiststat <= 100000000 then ballstat = "EnergySphere5"
  elseif playerfiststat >= 99999999 and playerfiststat <= 10000000000 then ballstat = "EnergySphere6"
  elseif playerfiststat >= 9999999999 and playerfiststat <= 1000000000000 then ballstat = "EnergySphere7"
  elseif playerfiststat >= 999999999999 and playerfiststat <= 1000000000000000 then ballstat = "EnergySphere8"
  elseif playerfiststat >= 999999999999999 then ballstat = "EnergySphere9"
  end

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local Window = Fluent:CreateWindow({
    Title = "Z3XHub ",
    SubTitle = "by Wer4eryyy",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.F1
})
local Tabs = {
    Farm = Window:AddTab({ Title = "Farm & More", Icon = "axe" }),
    Useful = Window:AddTab({ Title = "Useful", Icon = "plus-circle" }),
    Pvp = Window:AddTab({ Title = "Pvp", Icon = "swords" }),
    Teleports = Window:AddTab({ Title = "Teleports", Icon = "navigation-2" }),
    Fun = Window:AddTab({ Title = "Fun", Icon = "smile-plus" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),

};

Window:SelectTab(1)

local targets = {}
local target = game.Players.LocalPlayer.Name
local Input = Tabs.Pvp:AddInput("Input", {
    Title = "Targets",
    Default = "",
    Placeholder = "Nickname",
    Numeric = false,
    Finished = true, 
    Callback = function(Value)
        for i,v in next, game.Players:GetChildren() do
            if string.find(string.lower(v.Name), string.lower(Value)) then
                target = v.Name
            end
        end
        Fluent:Notify({
            Title = "Selected",
            Content = target,
            SubContent = "", -- Optional
            Duration = 5 -- Set to nil to make the notification not disappear
        })
    end
})

Tabs.Pvp:AddButton({
    Title = "Add",
    Description = "",
    Callback = function()
        if game.Players:FindFirstChild(target) then
            if not table.find(targets, target) then
                table.insert(targets, target)
            end
        end
        Fluent:Notify({
            Title = "Targets",
            Content = table.concat(targets, ', '),
            SubContent = "", -- Optional
            Duration = 5 -- Set to nil to make the notification not disappear
        })
    end
})
Tabs.Pvp:AddButton({
    Title = "Remove",
    Description = "",
    Callback = function()
        if table.find(targets, target) then
            for i,v in next, targets do
                if targets[i] == target then
                    table.remove(targets, i)
                end
            end
        end
        Fluent:Notify({
            Title = "Targets",
            Content = table.concat(targets, ', '),
            SubContent = "", -- Optional
            Duration = 5 -- Set to nil to make the notification not disappear
        })
    end
})

local Toggle = Tabs.Pvp:AddToggle("M1", {Title = "SoulReap", Default = false })

Toggle:OnChanged(function()
    soulreap = Fluent.Options.M1.Value
    while soulreap and task.wait() do
        if targets[1] then
            for i,v in next, targets do
                if workspace:FindFirstChild(targets[i]) then
                    if workspace[targets[i]].Humanoid.Health > 0 and not workspace[targets[i]]:FindFirstChild('ForceField') and not workspace[targets[i]]:FindFirstChild('SafeZoneShield') then
                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer({"Skill_SoulReap",game.Players[targets[i]]})
                        repeat task.wait(0) until workspace[targets[i]].Humanoid.Health == 0
                    end
                end
            end
        end
    end
end)

coroutine.wrap(function()
    while task.wait(0) do
        pcall(function()
            if Fluent.Options.P4.Value then
                if targets[1] then
                    for i,v in next, targets do
                        if workspace:FindFirstChild(targets[i]) then
                            if not workspace[targets[i]]:FindFirstChild('ForceField') and not workspace[targets[i]]:FindFirstChild('SafeZoneShield') and workspace[targets[i]].Humanoid.Health ~= 0 then
                                workspace[targets[i]].HumanoidRootPart.CFrame = 
                                workspace[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame 
                                + workspace[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame.LookVector * 1
                            end
                        end
                    end
                end
            end
       end)
    end
end)()

game.Players.PlayerRemoving:Connect(function(player)
    if table.find(targets, player.Name) then
        for i,v in next, targets do
            if targets[i] == player.Name then
                table.remove(targets, i)
            end
        end
    end
end)

local Toggls = {
    fs = Tabs.Farm:AddToggle("F1", {Title = "Fist Strength", Default = false });
    bt = Tabs.Farm:AddToggle("F2", {Title = "Body Toughness", Default = false });
    pp = Tabs.Farm:AddToggle("F3", {Title = "Psychic Power", Default = false });
    js = Tabs.Farm:AddToggle("F4", {Title = "Jump & Speed", Default = false });
    rg = Tabs.Farm:AddToggle("F5", {Title = "Respawn 95%", Default = false });
    rs = Tabs.Farm:AddToggle("F6", {Title = "Respawn 5%", Default = false });
    st = Tabs.Pvp:AddToggle("P1", {Title = "AutoC", Default = false });
    sr = Tabs.Pvp:AddToggle("P2", {Title = "Stack", Default = false });
    sy = Tabs.Pvp:AddToggle("P3", {Title = "X10PP", Default = false });
    cb = Tabs.Pvp:AddToggle("P4", {Title = "Cbring", Default = false });
    vb = Tabs.Pvp:AddToggle("A1", {Title = "Stack All", Default = false });
    vn = Tabs.Pvp:AddToggle("A2", {Title = "SoulReap All", Default = false });
    vm = Tabs.Pvp:AddToggle("A3", {Title = "PP All", Default = false });
    zxc = Tabs.Fun:AddToggle("G1", {Title = "Lag Server", Default = false });
    zx = Tabs.Fun:AddToggle("G2", {Title = "RGB Rank", Default = false });
    zc = Tabs.Fun:AddToggle("G3", {Title = "RGB Weight", Default = false });
    mh = Tabs.Fun:AddToggle("G4", {Title = "On/Off Aura", Default = false });
    mj = Tabs.Useful:AddToggle("U1", {Title = "Auto Invisible", Default = false });
  };

  --// functions
Toggls.fs:OnChanged(function() 
    isfarming = Fluent.Options.F1.Value
    while isfarming and task.wait() do
        pcall(function()
            workspace[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame = CFrame.new(getfspos())
            remote:FireServer({getfs()})
        end)
    end
end)
Toggls.bt:OnChanged(function()
    isfarming = Fluent.Options.F2.Value
    while isfarming and task.wait() do
        pcall(function()
            workspace[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame = CFrame.new(getbtpos())
        end)
    end
end)

Toggls.pp:OnChanged(function()
    isfarming = Fluent.Options.F3.Value
    while isfarming and task.wait() do
        pcall(function()
            workspace[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame = CFrame.new(getpppos())
            remote:FireServer({getpp()})
        end)
    end
end)

Toggls.js:OnChanged(function(state)
    isfarming = Fluent.Options.F4.Value
    while isfarming and task.wait() do
        pcall(function()
            local RemoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent")
            shared.wei = state
            if shared.wei then
                local eq = { [1] = { [1] = "Weight", [2] = "Weight4" } }
                RemoteEvent:FireServer(unpack(eq))
                while shared.wei and task.wait() do
                    local speed = { [1] = { [1] = "+MS1" } }
                    local jump = { [1] = { [1] = "+JF1" } }
                    RemoteEvent:FireServer(unpack(speed))
                    task.wait()
                    RemoteEvent:FireServer(unpack(jump))  
                end
            else
                local uneq = { [1] = { [1] = "Weight", [2] = "Unequip" } }
                RemoteEvent:FireServer(unpack(uneq))
            end
        end)
    end
end)

Toggls.rg:OnChanged(function()
  resp = Fluent.Options.F5.Value
  while resp do task.wait()
  pcall(function()
    game.Lighting.Blur.Enabled = false
    game.Players.LocalPlayer.PlayerGui.IntroGui.Enabled = false
    game.Players.LocalPlayer.PlayerGui.ScreenGui.Enabled = true
            if game.Players.LocalPlayer.Character.Humanoid.Health < game.Players.LocalPlayer.Character.Humanoid.MaxHealth * .95 then
                local j = game.Players.LocalPlayer.Character:GetPrimaryPartCFrame()
                local s = game.Players.LocalPlayer.Character:GetPrimaryPartCFrame()
                local z = game.Players.LocalPlayer.Character:GetPrimaryPartCFrame()                    
                task.wait()
                game.Players.LocalPlayer.Character:Destroy()
                game.ReplicatedStorage.RemoteEvent:FireServer({"Respawn"})
                task.wait(2.1)
                game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(j)
                wait()
                game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(s)
                wait()
                game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(z)
                local plr = game.Players.LocalPlayer
                local tps = game:GetService("TeleportService")
              end
            end)
            end
            end)
            
Toggls.rs:OnChanged(function()
  resp = Fluent.Options.F6.Value
  while resp do task.wait()
  pcall(function()
    game.Lighting.Blur.Enabled = false
    game.Players.LocalPlayer.PlayerGui.IntroGui.Enabled = false
    game.Players.LocalPlayer.PlayerGui.ScreenGui.Enabled = true
            if game.Players.LocalPlayer.Character.Humanoid.Health < game.Players.LocalPlayer.Character.Humanoid.MaxHealth * .05 then
                local j = game.Players.LocalPlayer.Character:GetPrimaryPartCFrame()
                local s = game.Players.LocalPlayer.Character:GetPrimaryPartCFrame()
                local z = game.Players.LocalPlayer.Character:GetPrimaryPartCFrame()                    
                task.wait()
                game.Players.LocalPlayer.Character:Destroy()
                game.ReplicatedStorage.RemoteEvent:FireServer({"Respawn"})
                task.wait(2.1)
                game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(j)
                wait()
                game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(s)
                wait()
                game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(z)
                local plr = game.Players.LocalPlayer
                local tps = game:GetService("TeleportService")
              end
            end)
            end
            end)
Toggls.st:OnChanged(function()
    autoc = Fluent.Options.P1.Value
    while autoc and task.wait() do
        pcall(function()
          local args = {[1] = {[1] = "Skill_Punch",[2] = "Left"}}
          game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
          local args = {[1] = {[1] = "Skill_Punch",[2] = "Right"}}
          game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))    
        end)
      end
      end)

Toggls.sr:OnChanged(function()
  stack = Fluent.Options.P2.Value
  while stack and task.wait() do
      pcall(function()
          local cf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
          remote:FireServer({"Skill_SpherePunch",Vector3.new(x,100000000000000000000000000,z)})
          for i,v in pairs(game.Workspace.Storage:GetChildren()) do
              if v.Name == ballstat then
                  v.CFrame = cf
              end
          end
      end)
  end
end)


Toggls.sy:OnChanged(function()
    pp1 = Fluent.Options.P3.Value
    while pp1 and task.wait() do
        if targets[1] then
            for i,v in next, targets do
                pcall(function()
                    for d = 1,10 do
                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer({"Skill_SoulAttack_Start",game:GetService("Players")[targets[i]]})
                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Skill_SoulAttack_End")
                    end
                end)
            end
        end
    end
end)
Toggls.vb:OnChanged(function()
    stackall = Fluent.Options.A1.Value
    while stackall and task.wait() do
        pcall(function()
            local Random = game.Players:GetPlayers()[math.random(1,#game.Players:GetPlayers())]
            if Random.PrivateStats.BodyToughness.Value <= game:GetService("Players").LocalPlayer.PrivateStats.FistStrength.Value * 2 then
                if Random.Character.Humanoid.Health ~= 0 then
                    if not Random.Character:FindFirstChild("SafeZoneShield") then 
                        local x = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.x
                        local z = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.z

                        local x2 = Random.Character.HumanoidRootPart.Position.x
                        local y = Random.Character.HumanoidRootPart.Position.y
                        local z2 = Random.Character.HumanoidRootPart.Position.z
                        local args = {[1] = {[1] = "Skill_SpherePunch",[2] = Vector3.new(x, 10000, z)}}
                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
                        for i, v in ipairs (game:GetService("Workspace").Storage:GetChildren()) do
                            if v.Name == ballstat then
                                v.CFrame = CFrame.new(x2, y, z2)
                            end 
                        end
                    end
                end
            end
        end)
    end
end)
Toggls.vn:OnChanged(function()
    soul1 = Fluent.Options.A2.Value
    while soul1 do task.wait()
    pcall(function()
        for i,v in pairs(game.Players:GetPlayers()) do
            local Random = game.Players:GetPlayers()[math.random(1,#game.Players:GetPlayers())]
                if Random.PrivateStats.PsychicPower.Value <= game:GetService("Players").LocalPlayer.PrivateStats.PsychicPower.Value * 1000 then
                        for i,v in pairs(game.Players:GetPlayers()) do
        
                        game.ReplicatedStorage.RemoteEvent:FireServer({"Skill_SoulReap",game.Players[v.Name]})
                        end
                    end
                end
            end)
        end
    end)
Toggls.vm:OnChanged(function()
    soul = Fluent.Options.A3.Value
    while soul do task.wait()
    pcall(function()
        for i,v in pairs(game.Players:GetPlayers()) do
            local Random = game.Players:GetPlayers()[math.random(1,#game.Players:GetPlayers())]
                if Random.PrivateStats.PsychicPower.Value <= game:GetService("Players").LocalPlayer.PrivateStats.PsychicPower.Value * 100 then
                        game.ReplicatedStorage.RemoteEvent:FireServer({"Skill_SoulAttack_Start",game.Players[v.Name]})
        game.ReplicatedStorage.RemoteEvent:FireServer({"Skill_SoulAttack_End"})
                end
            end
        end)
    end
end)
Toggls.sy:OnChanged(function()
    soulattack = Fluent.Options.P3.Value
    while soulattack and task.wait() do
        pcall(function()
            if targets[1] then
                for i,v in next, targets do
                    game.ReplicatedStorage.RemoteEvent:FireServer({"Skill_SoulAttack_Start",game.Players[targets[i]]})
                    game.ReplicatedStorage.RemoteEvent:FireServer({"Skill_SoulAttack_End"})
                    game.ReplicatedStorage.RemoteEvent:FireServer({"Skill_SoulAttack_Start",game.Players[targets[i]]})
                    game.ReplicatedStorage.RemoteEvent:FireServer({"Skill_SoulAttack_End"})
                end
            end
        end)
    end
end)
Toggls.zx:OnChanged(function()
    soulattack = Fluent.Options.G2.Value
    while soulattack and task.wait() do
        pcall(function()
            local args = {[1] = {[1] = "ChangeRankEmblem",[2] = 1}}
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
            wait()
            local args = {[1] = {[1] = "ChangeRankEmblem",[2] = 2}}
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
            wait()
            local args = {[1] = {[1] = "ChangeRankEmblem",[2] = 3}}
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
            wait()
            local args = {[1] = {[1] = "ChangeRankEmblem",[2] = 4}}
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
            wait()
            local args = {[1] = {[1] = "ChangeRankEmblem",[2] = 5}}
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
            wait()
            local args = {[1] = {[1] = "ChangeRankEmblem",[2] = 6}}
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
            wait()
            local args = {[1] = {[1] = "ChangeRankEmblem",[2] = 7}}
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
            wait()
            local args = {[1] = {[1] = "ChangeRankEmblem",[2] = 8}}
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
            wait()
            local args = {[1] = {[1] = "ChangeRankEmblem",[2] = 9}}
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
            wait()
            local args = {[1] = {[1] = "ChangeRankEmblem",[2] = 10}}
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
            wait()
        end)
    end
end)
Toggls.zc:OnChanged(function()
    soulattack = Fluent.Options.G3.Value
    while soulattack and task.wait() do
        pcall(function()
            local args = {[1] = {[1] = "Weight",[2] = "Weight1"}}
game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
wait()
local args = {[1] = {[1] = "Weight",[2] = "Weight2"}}
game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
wait()
local args = {[1] = {[1] = "Weight",[2] = "Weight3"}}
game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
wait()
local args = {[1] = {[1] = "Weight",[2] = "Weight4"}}
game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
        end)
    end
end)
Toggls.zxc:OnChanged(function()
    soulattack = Fluent.Options.G1.Value
    while soulattack and task.wait() do
        pcall(function()
            local args = {[1] = {[1] = "Skill_KillingIntent_Start"}}
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
            end)
        end
end)
Toggls.mh:OnChanged(function()
    aura = Fluent.Options.G4.Value
    while aura and task.wait(1) do
        pcall(function()
            args = {[1] = {[1] = "ConcealRevealAura"}}
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
        end)
    end
end)
Toggls.mj:OnChanged(function()
    invis = Fluent.Options.U1.Value
    while invis and task.wait() do
        pcall(function()
            game.ReplicatedStorage.RemoteEvent:FireServer({"Skill_Invisible","Start"})
        end)
    end
end)
Tabs.Pvp:AddButton({
    Title = "Stack Tosin (Qa)",
    Description = "",
    Callback = function()
      loadstring(game:HttpGet("https://gist.githubusercontent.com/Wer4er/77560afb2f6092c6d2a1da16ca254cb8/raw/bae31615d5f132b3ea41992b20ef92b50502c1dd/gistfile1.txt"))()
    end
  })
Tabs.Pvp:AddButton({
    Title = "Dead-log",
    Description = "",
    Callback = function()
            for i,v in pairs(game.Players:GetPlayers()) do
    
    
local PlayerN = game.Players[v.Name].Name.." "

local Ymer = {

"  "..PlayerN.."[💀] Dead",
}

local function SendMessage(chatProperties) 
game:GetService('StarterGui'):SetCore('ChatMakeSystemMessage',chatProperties)
end

local player = game.Players[v.Name]

player.Character.Humanoid.Died:Connect(function()



SendMessage({
Text = Ymer[math.random(#Ymer)],
Color = Color3.fromRGB(225,0,0)
})

end)

player.CharacterAdded:Connect(function(Character)
Character:WaitForChild("Humanoid").Died:Connect(function()

SendMessage({
Text = Ymer[math.random(#Ymer)],
Color = Color3.fromRGB(225,0,0)
})
end)
end)
end
    end
  })
Tabs.Settings:AddButton({
    Title = "Rejoin",
    Description = "",
    Callback = function()
        local placeId = 2202352383
        game:GetService("TeleportService"):Teleport(placeId)
    end
  })
Tabs.Fun:AddButton({
    Title = "RTX",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Fallkonf2/Prm/main/PR'))()
    end
  })
Tabs.Fun:AddButton({
    Title = "BallFE",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/Wer4er/bde3ece3ab4ee412447a2e48c8618e4d/raw/7ca011bed3ad4cb5f7dd9a6724d8da8c9205c26b/gistfile1.txt"))()
    end
  })
Tabs.Fun:AddButton({
    Title = "HackerChat",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/rouxhaver/scripts-3/main/hacker%20chat.lua"))()
    end
  }) 
Tabs.Fun:AddButton({
    Title = "ChatSPY",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/qNMunbP8"))()
    end
  })  
Tabs.Fun:AddButton({
    Title = "RemoveAura",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.character.LeftHand.Aura1: Destroy()
        game.Players.LocalPlayer.character.RightHand.Aura1: Destroy()
        game.Players.LocalPlayer.character.LeftHand.Aura2: Destroy()
        game.Players.LocalPlayer.character.RightHand.Aura2: Destroy()
        game.Players.LocalPlayer.character.LeftUpperLeg.Aura1: Destroy()
        game.Players.LocalPlayer.character.RightUpperLeg.Aura1: Destroy()
        game.Players.LocalPlayer.character.UpperTorso.Aura1: Destroy()
        game.Players.LocalPlayer.character.UpperTorso.Aura2: Destroy()
    end
  })  

Tabs.Farm:AddButton({
  Title = "GodMode",
  Description = "",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/1ArcX/Scripts/main/God%20Mode"))()
  end
})

Tabs.Teleports:AddButton({
    Title = "SafeZone",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(471, 249, 889)
    end
  })
Tabs.Teleports:AddButton({
    Title = "LeaderBoards",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-766, 249, 750)
    end
  })
Tabs.Teleports:AddButton({
    Title = "FS Rock X10",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(382, 249, 971)
    end
  })
Tabs.Teleports:AddButton({
    Title = "FS Crystal X100",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2273, 1943, 1048)
    end
  })
Tabs.Teleports:AddButton({
    Title = "FS 1B",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1176, 4789, -2293)
    end
  })
Tabs.Teleports:AddButton({
    Title = "FS 100B",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1381, 9274, 1648)
    end
  })
Tabs.Teleports:AddButton({
    Title = "FS 10T",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-363, 15735, -3)
    end
  })
Tabs.Teleports:AddButton({
    Title = "PP 1M",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2527, 5486, -532)
    end
  })
Tabs.Teleports:AddButton({
    Title = "PP 1B",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2560, 5500, -439)
    end
  })
Tabs.Teleports:AddButton({
    Title = "PP 1T",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2582, 5516, -504)
    end
  })
Tabs.Teleports:AddButton({
    Title = "PP 1Qa",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2544, 5412, -495)
    end
  })
Tabs.Teleports:AddButton({
    Title = "BT 100",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(365, 249, -445)
    end
  })
Tabs.Teleports:AddButton({
    Title = "BT 10K",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(349, 263, -490)
    end
  })
Tabs.Teleports:AddButton({
    Title = "BT 100K",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1640, 258, 2244)
    end
  })
Tabs.Teleports:AddButton({
    Title = "BT 1M",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2307, 976, 1068)
    end
  })
Tabs.Teleports:AddButton({
    Title = "BT 10M",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2024, 714, -1860)
    end
  })
Tabs.Teleports:AddButton({
    Title = "BT 1B",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-254, 286, 980)
    end
  })
Tabs.Teleports:AddButton({
    Title = "BT 100B",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-271, 279, 991)
    end
  })
Tabs.Teleports:AddButton({
    Title = "BT 10T",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-279, 279, 1007)
    end
  })

local Keybind = Tabs.Settings:AddKeybind("Keybind", {
    Title = "Panic Key",
    Mode = "Toggle", 
    Default = "F2", 
    Callback = function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(471, 249, 889)
    end
})

local Keybind = Tabs.Settings:AddKeybind("Keybind", {
    Title = "Respawn",
    Mode = "Toggle", 
    Default = "F1", 
    Callback = function()
        task.wait()
        game.Lighting.Blur.Enabled = false
            game.Players.LocalPlayer.PlayerGui.IntroGui.Enabled = false
            game.Players.LocalPlayer.PlayerGui.ScreenGui.Enabled = true
             lastlocationx = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.x
                lastlocationy = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.y
                lastlocationz = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.z
                task.wait()
                game.Players.LocalPlayer.Character.Health:Destroy()
                game.Players.LocalPlayer.Character.Animate:Destroy()
                game.ReplicatedStorage.RemoteEvent:FireServer({"Respawn"})
                wait(3)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(lastlocationx, lastlocationy, lastlocationz)
    end
})

InterfaceManager:SetLibrary(Fluent)
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
game:GetService('Players').LocalPlayer.Idled:connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
