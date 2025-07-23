local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- UI Setup
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "TeleportUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 150)
frame.Position = UDim2.new(0.5, -125, 0.5, -75)
frame.BackgroundTransparency = 0.2
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 4
frame.Draggable = true
frame.Active = true

-- RGB Border Effect
task.spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			frame.BorderColor3 = Color3.fromHSV(i, 1, 1)
			task.wait()
		end
	end
end)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "📜 Parkour Running"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- Credit
local credit = Instance.new("TextLabel", frame)
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 1, -20)
credit.Text = "Script by riko"
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.fromRGB(255, 255, 255)
credit.Font = Enum.Font.Gotham
credit.TextSize = 14

-- RGB Credit
task.spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			credit.TextColor3 = Color3.fromHSV(i, 1, 1)
			task.wait()
		end
	end
end)

-- Toggle Button
local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(0, 120, 0, 35)
toggle.Position = UDim2.new(0.5, -60, 0.5, -15)
toggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
toggle.Text = "Teleport: OFF"
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 14
toggle.BorderSizePixel = 0
toggle.AutoButtonColor = false

local isOn = false

toggle.MouseButton1Click:Connect(function()
	isOn = not isOn
	if isOn then
		toggle.Text = "Teleport: ON"
		toggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		task.delay(2, function()
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-5, 3, -3782))
			end
		end)
	else
		toggle.Text = "Teleport: OFF"
		toggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

-- Toggle UI
local toggleKey = Enum.KeyCode.RightShift
local uivisible = true

local button = Instance.new("TextButton", gui)
button.Size = UDim2.new(0, 40, 0, 40)
button.Position = UDim2.new(0, 10, 0.5, -20)
button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
button.Text = "👁️"
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.GothamBold
button.TextSize = 20
button.Active = true
button.Draggable = true

button.MouseButton1Click:Connect(function()
	uivisible = not uivisible
	frame.Visible = uivisible
end)
