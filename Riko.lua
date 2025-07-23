loadstring([[
--🌉 $456,000 Glass Bridge UI by RIKO
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 280, 0, 180)
Main.Position = UDim2.new(0.5, -140, 0.5, -90)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

-- Border RGB
local UIStroke = Instance.new("UIStroke", Main)
UIStroke.Thickness = 2
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
spawn(function()
	while task.wait() do
		UIStroke.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
	end
end)

-- Title
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "$456,000 Glass Bridge"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
spawn(function()
	while task.wait() do
		Title.TextColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
	end
end)

-- Credit
local Credit = Instance.new("TextLabel", Main)
Credit.Size = UDim2.new(1, -10, 0, 20)
Credit.Position = UDim2.new(0, 5, 1, -25)
Credit.BackgroundTransparency = 1
Credit.Text = "SCRIPT BY - RIKO"
Credit.TextColor3 = Color3.fromRGB(255, 255, 255)
Credit.Font = Enum.Font.GothamBold
Credit.TextSize = 14
Credit.TextXAlignment = Enum.TextXAlignment.Left
spawn(function()
	while task.wait() do
		Credit.TextColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
	end
end)

-- Toggle Button 📜
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -20)
ToggleButton.Text = "📜"
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 20
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.AutoButtonColor = true

local uiVisible = true
ToggleButton.MouseButton1Click:Connect(function()
	uiVisible = not uiVisible
	Main.Visible = uiVisible
end)

-- Teleport Button
local TPButton = Instance.new("TextButton", Main)
TPButton.Size = UDim2.new(0.9, 0, 0, 40)
TPButton.Position = UDim2.new(0.05, 0, 0.5, -20)
TPButton.Text = "TELEPORT"
TPButton.Font = Enum.Font.GothamBold
TPButton.TextSize = 18
TPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TPButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

local isTeleporting = false
TPButton.MouseButton1Click:Connect(function()
	if not isTeleporting then
		isTeleporting = true
		TPButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
		wait(2)
		local char = LocalPlayer.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			char.HumanoidRootPart.CFrame = CFrame.new(185, 18, -399)
		end
		wait(1)
		isTeleporting = false
		TPButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
	end
end)
]])()

