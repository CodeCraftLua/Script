-- 📜 UI Modern Script by riko 📜

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "ModernUI"
ScreenGui.ResetOnSpawn = false

-- FRAME UTAMA
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 300, 0, 350)
Frame.Position = UDim2.new(0.5, -150, 0.5, -175)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 0

-- DRAG
local UIS = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos
Frame.Active = true
Frame.Draggable = true

-- RGB Border
local UIStroke = Instance.new("UIStroke", Frame)
UIStroke.Thickness = 2
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
task.spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			UIStroke.Color = Color3.fromHSV(i, 1, 1)
			task.wait()
		end
	end
end)

-- TITLE 📜
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "📜 Script Hub - by Riko"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

-- CLOSE BUTTON
local ToggleBtn = Instance.new("TextButton", Frame)
ToggleBtn.Size = UDim2.new(0, 60, 0, 25)
ToggleBtn.Position = UDim2.new(1, -70, 0, 5)
ToggleBtn.Text = "CLOSE"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 12

local isOpen = true
ToggleBtn.MouseButton1Click:Connect(function()
	isOpen = not isOpen
	Frame.Visible = isOpen
end)

-- CREDIT
local Credit = Instance.new("TextLabel", Frame)
Credit.Text = "⭐ Script by riko ⭐"
Credit.Size = UDim2.new(1, 0, 0, 20)
Credit.Position = UDim2.new(0, 0, 1, -20)
Credit.BackgroundTransparency = 1
Credit.TextColor3 = Color3.new(1, 1, 1)
Credit.Font = Enum.Font.Gotham
Credit.TextSize = 12

-- Fungsi tombol
function createToggle(name, yPos, scriptFunc)
	local toggle = Instance.new("TextButton", Frame)
	toggle.Size = UDim2.new(0.9, 0, 0, 30)
	toggle.Position = UDim2.new(0.05, 0, 0, yPos)
	toggle.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
	toggle.TextColor3 = Color3.new(1, 1, 1)
	toggle.Font = Enum.Font.Gotham
	toggle.TextSize = 14
	toggle.Text = name

	local state = false
	toggle.MouseButton1Click:Connect(function()
		state = not state
		if state then
			toggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
			scriptFunc(true)
		else
			toggle.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
			scriptFunc(false)
		end
	end)
end

-- 1. Infinite Jump
createToggle("Infinite Jump", 40, function(state)
	if state then
		_G.infjump = true
		game:GetService("UserInputService").JumpRequest:Connect(function()
			if _G.infjump then
				game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
			end
		end)
	else
		_G.infjump = false
	end
end)

-- 2. TP Tool (Persistent)
createToggle("TP Tool", 80, function(state)
	if state then
		local tool = Instance.new("Tool", game.Players.LocalPlayer.Backpack)
		tool.RequiresHandle = false
		tool.Name = "TP Tool"
		tool.Activated:Connect(function()
			local pos = game:GetService("Players").LocalPlayer:GetMouse().Hit+Vector3.new(0,2.5,0)
			game.Players.LocalPlayer.Character:MoveTo(pos.Position)
		end)
	else
		local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("TP Tool")
		if tool then tool:Destroy() end
	end
end)

-- 3. TP to Player (manual input)
createToggle("TP to Player", 120, function(state)
	if state then
		local plrName = game:GetService("Players").LocalPlayer:PromptInput("Masukkan Nama Player:")
		local target = game:GetService("Players"):FindFirstChild(plrName)
		if target and target.Character then
			game.Players.LocalPlayer.Character:MoveTo(target.Character:WaitForChild("HumanoidRootPart").Position)
		end
	end
end)

-- 4. ESP Box (White)
createToggle("ESP Box", 160, function(state)
	if state then
		_G.esp = true
		while _G.esp do
			for _,v in pairs(game.Players:GetPlayers()) do
				if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
					if not v.Character:FindFirstChild("ESPBox") then
						local box = Instance.new("BoxHandleAdornment", v.Character)
						box.Name = "ESPBox"
						box.Adornee = v.Character:FindFirstChild("HumanoidRootPart")
						box.Size = Vector3.new(4,6,1.5)
						box.AlwaysOnTop = true
						box.ZIndex = 5
						box.Color3 = Color3.new(1,1,1)
						box.Transparency = 0.5
					end
				end
			end
			task.wait(1)
		end
	else
		for _,v in pairs(game.Players:GetPlayers()) do
			if v.Character and v.Character:FindFirstChild("ESPBox") then
				v.Character.ESPBox:Destroy()
			end
		end
		_G.esp = false
	end
end)

-- 5. Wall Hop
createToggle("Wall Hop", 200, function(state)
	if state then
		loadstring(game:HttpGet("https://pastebin.com/raw/3DkzHvN9"))()
	end
end)

-- 6. Kill All
createToggle("Kill All", 240, function(state)
	if state then
		for _,v in pairs(game.Players:GetPlayers()) do
			if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") then
				v.Character.Humanoid.Health = 0
			end
		end
	end
end)
