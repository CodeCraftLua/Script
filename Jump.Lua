--// UI Roblox - Jumping Tower
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- UI Elements
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "JumpingTowerUI"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 300, 0, 180)
Frame.Position = UDim2.new(0.5, -150, 0.5, -90)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 2
Frame.Active = true
Frame.Draggable = true

-- RGB Border Effect
spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			Frame.BorderColor3 = Color3.fromHSV(i, 1, 1)
			wait(0.01)
		end
	end
end)

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "Jumping Tower"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- Credit
local Credit = Instance.new("TextLabel", Frame)
Credit.Size = UDim2.new(1, 0, 0, 20)
Credit.Position = UDim2.new(0, 0, 1, -20)
Credit.BackgroundTransparency = 1
Credit.Text = "Script by riko"
Credit.TextColor3 = Color3.fromRGB(180, 180, 180)
Credit.Font = Enum.Font.Gotham
Credit.TextSize = 14

-- Toggle UI Button
local Toggle = Instance.new("TextButton", ScreenGui)
Toggle.Size = UDim2.new(0, 100, 0, 30)
Toggle.Position = UDim2.new(0, 10, 0, 10)
Toggle.Text = "📜 Toggle UI"
Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle.Font = Enum.Font.Gotham
Toggle.TextSize = 14

Toggle.MouseButton1Click:Connect(function()
	Frame.Visible = not Frame.Visible
end)

-- Teleport Button
local TeleportBtn = Instance.new("TextButton", Frame)
TeleportBtn.Size = UDim2.new(0.8, 0, 0, 40)
TeleportBtn.Position = UDim2.new(0.1, 0, 0.5, -20)
TeleportBtn.Text = "Teleport"
TeleportBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
TeleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportBtn.Font = Enum.Font.GothamBold
TeleportBtn.TextSize = 16

local active = false

TeleportBtn.MouseButton1Click:Connect(function()
	if active then
		active = false
		TeleportBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
	else
		active = true
		TeleportBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)

		task.delay(2, function()
			local char = LocalPlayer.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				char:MoveTo(Vector3.new(-5, 3, -3782))
			end
		end)
	end
end)
