local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local Rebirth = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Rebirth")
local Ascend = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Ascend")
local GiveOutReward = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Roulette"):WaitForChild("GiveOutReward")
local LayerChanged = ReplicatedStorage:WaitForChild("Events"):WaitForChild("LayerChanged")

local rebirthEnabled = false
local sacrificeEnabled = false
local moneyEnabled = false
local trophiesEnabled = false
local moneyPotionEnabled = false
local luckPotionEnabled = false
local chewingPotionEnabled = false
local jumpPotionEnabled = false

local player = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "MinervaBubbleUI"
screenGui.ResetOnSpawn = false

local uiFrame = Instance.new("Frame")
uiFrame.Size = UDim2.new(0, 370, 0, 440)
uiFrame.Position = UDim2.new(0, 60, 0, 60)
uiFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
uiFrame.BorderSizePixel = 0
uiFrame.Parent = screenGui

uiFrame.Active = true
uiFrame.Draggable = true

local corner = Instance.new("UICorner", uiFrame)
corner.CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", uiFrame)
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "Bubble Gum Jumping"
title.TextColor3 = Color3.fromRGB(255, 0, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 24

task.spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			title.TextColor3 = Color3.fromRGB(127 + 128 * math.sin(tick()*2), 0, 255 * (1 - i))
			task.wait(0.03)
		end
	end
end)

local credit = Instance.new("TextLabel", uiFrame)
credit.Size = UDim2.new(1, 0, 0, 25)
credit.Position = UDim2.new(0, 0, 1, -25)
credit.BackgroundTransparency = 1
credit.Text = "script by - craftcodelua"
credit.Font = Enum.Font.Gotham
credit.TextSize = 14
credit.TextColor3 = Color3.fromRGB(170, 0, 255)

task.spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			local r = 170 + 85 * math.sin(tick()*2)
			local b = 255 + 50 * math.sin(tick()*2 + math.pi)
			credit.TextColor3 = Color3.fromRGB(r, 0, b)
			task.wait(0.03)
		end
	end
end)

local toggleBtn = Instance.new("TextButton", screenGui)
toggleBtn.Size = UDim2.new(0, 140, 0, 32)
toggleBtn.Position = UDim2.new(0, 450, 0, 65)
toggleBtn.Text = "🎭 Hide UI"
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 16

local toggleUICorner = Instance.new("UICorner", toggleBtn)
toggleUICorner.CornerRadius = UDim.new(0, 6)

local uiVisible = true
toggleBtn.MouseButton1Click:Connect(function()
	uiVisible = not uiVisible
	uiFrame.Visible = uiVisible
	toggleBtn.Text = uiVisible and "🎭 Hide UI" or "🎭 Show UI"
end)

local function createToggleButton(name, yOffset, callback)
	local button = Instance.new("TextButton", uiFrame)
	button.Size = UDim2.new(0, 320, 0, 35)
	button.Position = UDim2.new(0, 25, 0, yOffset)
	button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.Font = Enum.Font.Gotham
	button.TextSize = 16
	button.Text = name .. ": OFF"

	local state = false
	button.MouseButton1Click:Connect(function()
		state = not state
		button.Text = name .. ": " .. (state and "ON" or "OFF")
		callback(state)
	end)

	local corner = Instance.new("UICorner", button)
	corner.CornerRadius = UDim.new(0, 6)
end

local spacing = 45
local yStart = 60
createToggleButton("Rebirth", yStart + spacing*0, function(on) rebirthEnabled = on end)
createToggleButton("Sacrifice", yStart + spacing*1, function(on) sacrificeEnabled = on end)
createToggleButton("Infinite Money", yStart + spacing*2, function(on) moneyEnabled = on end)
createToggleButton("Infinite Trophies", yStart + spacing*3, function(on) trophiesEnabled = on end)
createToggleButton("Money Potion", yStart + spacing*4, function(on) moneyPotionEnabled = on end)
createToggleButton("Luck Potion", yStart + spacing*5, function(on) luckPotionEnabled = on end)
createToggleButton("Chewing Power Potion", yStart + spacing*6, function(on) chewingPotionEnabled = on end)
createToggleButton("Jump Power Potion", yStart + spacing*7, function(on) jumpPotionEnabled = on end)

RunService.RenderStepped:Connect(function()
	if rebirthEnabled then
		Rebirth:FireServer()
	end
	if sacrificeEnabled then
		Ascend:FireServer()
	end
	if moneyEnabled then
		GiveOutReward:FireServer({
			value = 9e999999999999,
			type = "Money",
			chance = 0.3
		})
	end
	if trophiesEnabled then
		LayerChanged:FireServer("Layer6")
	end
	if moneyPotionEnabled then
		GiveOutReward:FireServer({
			chance = 0.15,
			type = "Potion",
			name = "Money"
		})
	end
	if luckPotionEnabled then
		GiveOutReward:FireServer({
			chance = 0.15,
			type = "Potion",
			name = "Luck"
		})
	end
	if chewingPotionEnabled then
		GiveOutReward:FireServer({
			chance = 0.15,
			type = "Potion",
			name = "ChewingPower"
		})
	end
	if jumpPotionEnabled then
		GiveOutReward:FireServer({
			chance = 0.15,
			type = "Potion",
			name = "JumpPower"
		})
	end
end)
