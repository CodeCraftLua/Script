-- 📜 Survei the killer UI | Script by riko

-- UI Library
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local Credit = Instance.new("TextLabel")
local Close = Instance.new("TextButton")
local ToggleFrame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")

-- Drag + RGB border
local RGB = Instance.new("UIStroke")
RGB.Thickness = 2
RGB.Name = "RGB"
RGB.Parent = Frame
task.spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			RGB.Color = ColorSequence.new(Color3.fromHSV(i, 1, 1))
			task.wait()
		end
	end
end)

ScreenGui.Name = "SurveiUI"
Frame.Size = UDim2.new(0, 350, 0, 400)
Frame.Position = UDim2.new(0.5, -175, 0.5, -200)
Frame.BackgroundTransparency = 0.15
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Parent = ScreenGui
Frame.Active = true
Frame.Draggable = true

UICorner.Parent = Frame

Title.Text = "📜 Survei the killer"
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.BackgroundTransparency = 1
Title.Parent = Frame

Credit.Text = "- Script by riko -"
Credit.Size = UDim2.new(1, -20, 0, 20)
Credit.Position = UDim2.new(0, 10, 0, 35)
Credit.TextColor3 = Color3.fromRGB(200, 200, 200)
Credit.Font = Enum.Font.Code
Credit.TextScaled = true
Credit.BackgroundTransparency = 1
Credit.Parent = Frame

Close.Text = "X"
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -35, 0, 5)
Close.TextColor3 = Color3.fromRGB(255, 100, 100)
Close.Font = Enum.Font.GothamBold
Close.TextScaled = true
Close.BackgroundTransparency = 1
Close.Parent = Frame

Close.MouseButton1Click:Connect(function()
	Frame.Visible = not Frame.Visible
end)

ToggleFrame.Name = "Toggles"
ToggleFrame.Parent = Frame
ToggleFrame.Size = UDim2.new(1, -20, 1, -70)
ToggleFrame.Position = UDim2.new(0, 10, 0, 65)
ToggleFrame.BackgroundTransparency = 1

UIListLayout.Parent = ToggleFrame
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Utility Toggle Generator
function createToggle(name, onFunction)
	local toggle = Instance.new("TextButton")
	toggle.Size = UDim2.new(1, 0, 0, 35)
	toggle.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
	toggle.TextColor3 = Color3.new(1, 1, 1)
	toggle.Font = Enum.Font.Gotham
	toggle.TextSize = 14
	toggle.Text = name.." [OFF]"
	toggle.Parent = ToggleFrame

	local state = false

	toggle.MouseButton1Click:Connect(function()
		state = not state
		toggle.BackgroundColor3 = state and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
		toggle.Text = name.." ["..(state and "ON" or "OFF").."]"
		onFunction(state)
	end)
end

-- ESP Box (Putih)
createToggle("ESP Box", function(state)
	if state then
		loadstring(game:HttpGet("https://pastebin.com/raw/P3n4VK9j"))()
	end
end)

-- Infinite Jump
createToggle("Infinite Jump", function(state)
	if state then
		game:GetService("UserInputService").JumpRequest:Connect(function()
			if state then
				game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
			end
		end)
	end
end)

-- Speed Custom
createToggle("Speed Custom", function(state)
	if state then
		local speed = tonumber(game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):PromptInput("Enter WalkSpeed:"))
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed or 16
	else
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
	end
end)

-- Killer x3 (Teleport Musuh ke depan)
createToggle("Killer x3", function(state)
	if state then
		local lp = game.Players.LocalPlayer
		for i = 1, 3 do
			for _,v in pairs(game.Players:GetPlayers()) do
				if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
					v.Character.HumanoidRootPart.CFrame = lp.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
				end
			end
			task.wait(0.5)
		end
	end
end)

-- ESP Item (Dummy)
createToggle("ESP Item", function(state)
	if state then
		for _, item in pairs(workspace:GetDescendants()) do
			if item:IsA("Tool") then
				local b = Instance.new("BillboardGui", item)
				b.Size = UDim2.new(0,100,0,40)
				b.AlwaysOnTop = true
				local t = Instance.new("TextLabel", b)
				t.Size = UDim2.new(1,0,1,0)
				t.BackgroundTransparency = 1
				t.Text = item.Name
				t.TextColor3 = Color3.new(1,1,1)
				t.TextScaled = true
			end
		end
	end
end)

-- Infinite Money (Dummy)
createToggle("Infinite Money", function(state)
	if state then
		print("💰 Infinite money script activated - Ganti dengan fungsi game yang sesuai")
	end
end)

-- Unlock Sword (Dummy)
createToggle("Unlock Sword", function(state)
	if state then
		print("🗡️ Unlock sword activated - Ganti dengan unlock asli jika ada")
	end
end)

-- Boost FPS
createToggle("Boost FPS", function(state)
	if state then
		for _, v in pairs(game:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Material = Enum.Material.SmoothPlastic
				v.Reflectance = 0
			elseif v:IsA("Decal") then
				v.Transparency = 1
			end
		end
	end
end)

-- Anti Lag
createToggle("Anti Lag", function(state)
	if state then
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
	end
end)
