
game.Workspace:WaitForChild(game:GetService("Players").LocalPlayer.Name)
local hp=85 -- SET AS RESPAWN VALUE (WHAT U WANNA RESPAWN AT)
local setlocation = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
while true do
    if (game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health / game.Players.LocalPlayer.Character:WaitForChild("Humanoid").MaxHealth * 100) <= hp then
        setlocation = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 100000, 0)
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer{"Respawn"}
        game.Workspace:WaitForChild(game:GetService("Players").LocalPlayer.Name)
        local Players = game:GetService("Players")
        local Camera = game:GetService("Workspace"):FindFirstChild("Camera")
        Players.LocalPlayer.CameraMaxZoomDistance = 400
        Players.LocalPlayer.CameraMinZoomDistance = 0.5
        Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic
        Camera.FieldOfView = 70
        Camera.CameraType = "Custom"
        game:GetService("UserInputService").MouseIconEnabled = true
        game:GetService("UserInputService").MouseBehavior = Enum.MouseBehavior.Default
        task.wait(1.543225)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = setlocation
        if game:GetService("Players").LocalPlayer.PlayerGui.IntroGui.Enabled == true then
            game:GetService("Players").LocalPlayer.PlayerGui.IntroGui.Enabled = false
            game.Lighting.Blur.Enabled = false
            game.Players.LocalPlayer.PlayerGui.ScreenGui.Enabled = true
        end
    else
        task.wait()
        if game:GetService("Players").LocalPlayer.PlayerGui.IntroGui.Enabled == true then
            game:GetService("Players").LocalPlayer.PlayerGui.IntroGui.Enabled = false
            game.Lighting.Blur.Enabled = false
            game.Players.LocalPlayer.PlayerGui.ScreenGui.Enabled = true
        end
    end
end
