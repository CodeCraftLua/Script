-- UI Modern by Riko
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Create ScreenGui
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "ModernUI"
gui.ResetOnSpawn = false

-- Drag frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 350, 0, 240)
frame.Position = UDim2.new(0.5, -175, 0.5, -120)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- RGB Border
local border = Instance.new("UIStroke", frame)
border.Thickness = 2
border.LineJoinMode = Enum.LineJoinMode.Round

-- RGB effect
task.spawn(function()
	while true do
		for i = 0, 255, 4 do
			border.Color = Color3.fromHSV(i/255, 1, 1)
			task.wait()
		end
	end
end)

-- Title
local title = Instance.new("TextLabel", frame)
title.Text = "📜  Modern Script UI"
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 20

-- Credit
local credit = Instance.new("TextLabel", frame)
credit.Text = "⭐ Script by Riko ⭐"
credit.Position = UDim2.new(0.5, -100, 1, -20)
credit.Size = UDim2.new(0, 200, 0, 20)
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.fromRGB(180, 180, 255)
credit.Font = Enum.Font.Gotham
credit.TextSize = 14

-- Close/Open Button
local toggleUI = Instance.new("TextButton", gui)
toggleUI.Text = "🟣 OPEN UI"
toggleUI.Size = UDim2.new(0, 100, 0, 30)
toggleUI.Position = UDim2.new(0, 20, 0, 20)
toggleUI.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleUI.TextColor3 = Color3.new(1,1,1)
toggleUI.Font = Enum.Font.Gotham
toggleUI.TextSize = 14
toggleUI.BorderSizePixel = 0

toggleUI.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
	toggleUI.Text = frame.Visible and "🟣 CLOSE UI" or "🟢 OPEN UI"
end)

-- Function to make toggle buttons
function createButton(name, parent, position, callback)
	local btn = Instance.new("TextButton", parent)
	btn.Size = UDim2.new(0, 300, 0, 30)
	btn.Position = position
	btn.Text = "🔴 "..name
	btn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 16
	btn.BorderSizePixel = 0
	
	local state = false
	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.BackgroundColor3 = state and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(60, 0, 0)
		btn.Text = (state and "🟢 " or "🔴 ")..name
		callback(state)
	end)
end

-- ESP BOX
createButton("ESP Box", frame, UDim2.new(0, 25, 0, 50), function(state)
	if state then
		_G.esp = true
		while _G.esp do
			for _, player in pairs(game.Players:GetPlayers()) do
				if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					if not player.Character:FindFirstChild("espbox") then
						local box = Instance.new("BoxHandleAdornment", player.Character)
						box.Name = "espbox"
						box.Size = Vector3.new(4, 6, 2)
						box.Adornee = player.Character
						box.AlwaysOnTop = true
						box.ZIndex = 10
						box.Transparency = 0.6
						box.Color3 = Color3.new(1, 0, 0)
					end
				end
			end
			wait(1)
		end
	else
		_G.esp = false
		for _, player in pairs(game.Players:GetPlayers()) do
			if player.Character and player.Character:FindFirstChild("espbox") then
				player.Character.espbox:Destroy()
			end
		end
	end
end)

-- Infinite Jump
createButton("Infinite Jump", frame, UDim2.new(0, 25, 0, 90), function(state)
	_G.infjump = state
	UIS.JumpRequest:Connect(function()
		if _G.infjump then
			local lp = game.Players.LocalPlayer
			if lp.Character and lp.Character:FindFirstChild("Humanoid") then
				lp.Character.Humanoid:ChangeState("Jumping")
			end
		end
	end)
end)

-- Killer X3
createButton("Killer X3", frame, UDim2.new(0, 25, 0, 130), function(state)
	if state then
		_G.killx3 = true
		while _G.killx3 do
			for _, player in pairs(game.Players:GetPlayers()) do
				if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					player.Character:BreakJoints()
				end
			end
			wait(3)
		end
	else
		_G.killx3 = false
	end
end)
