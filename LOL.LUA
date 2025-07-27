-- UI Modern: Parkour Running by riko
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Create UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "ParkourRunningUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 320, 0, 160)
Frame.Position = UDim2.new(0.5, -160, 0.4, -80)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

-- RGB Border
local RGBBorder = Instance.new("UIStroke", Frame)
RGBBorder.Thickness = 2
RGBBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			RGBBorder.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, Color3.fromHSV(i, 1, 1)),
				ColorSequenceKeypoint.new(1, Color3.fromHSV((i + 0.2) % 1, 1, 1))
			}
			wait()
		end
	end
end)

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "📜 Parkour Running"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- Toggle UI Button
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 120, 0, 35)
ToggleBtn.Position = UDim2.new(0.5, -60, 0.8, 0)
ToggleBtn.Text = "👄👅 Show UI"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 14
ToggleBtn.Visible = false

-- Credit
local Credit = Instance.new("TextLabel", Frame)
Credit.Size = UDim2.new(1, 0, 0, 20)
Credit.Position = UDim2.new(0, 0, 1, -20)
Credit.BackgroundTransparency = 1
Credit.Text = "⭐ SCRIPT BY RIKO GG ⭐"
Credit.TextColor3 = Color3.fromRGB(200, 200, 200)
Credit.Font = Enum.Font.Gotham
Credit.TextSize = 13

-- Toggle Button (Teleport ON/OFF)
local TPBtn = Instance.new("TextButton", Frame)
TPBtn.Size = UDim2.new(0, 200, 0, 40)
TPBtn.Position = UDim2.new(0.5, -100, 0.5, -20)
TPBtn.Text = "🔘 Teleport: OFF"
TPBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0) -- Merah saat OFF
TPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TPBtn.Font = Enum.Font.GothamBold
TPBtn.TextSize = 16

local Teleporting = false
local coord = Vector3.new(31, 219, 76)

TPBtn.MouseButton1Click:Connect(function()
	Teleporting = not Teleporting
	TPBtn.Text = Teleporting and "✅ Teleport: ON" or "🔘 Teleport: OFF"
	TPBtn.BackgroundColor3 = Teleporting and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
end)

-- Close Button
local CloseBtn = Instance.new("TextButton", Frame)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -28, 0, 4)
CloseBtn.Text = "✕"
CloseBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14

CloseBtn.MouseButton1Click:Connect(function()
	Frame.Visible = false
	ToggleBtn.Visible = true
end)

ToggleBtn.MouseButton1Click:Connect(function()
	Frame.Visible = true
	ToggleBtn.Visible = false
end)

-- Teleport Loop
task.spawn(function()
	while true do
		if Teleporting and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			player.Character:MoveTo(coord)
		end
		task.wait(1) -- 1 detik
	end
end)
