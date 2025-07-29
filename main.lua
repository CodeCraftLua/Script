--📜 Script by riko
-- Modern UI Loadstring dengan RGB Border dan Drag + Toggle ON/OFF Button Style
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "Riko_UI"

local function createRGBFrame(parent)
	local frame = Instance.new("Frame", parent)
	frame.BackgroundColor3 = Color3.new(1, 1, 1)
	frame.BorderSizePixel = 0
	frame.Size = UDim2.new(1, 0, 1, 0)
	
	local uiStroke = Instance.new("UIStroke", frame)
	uiStroke.Thickness = 3
	uiStroke.Transparency = 0
	uiStroke.Color = Color3.fromRGB(255, 0, 0)

	-- RGB animation
	coroutine.wrap(function()
		while task.wait() do
			for i = 0, 255, 5 do
				uiStroke.Color = Color3.fromHSV(i / 255, 1, 1)
				task.wait(0.01)
			end
		end
	end)()
	
	return frame
end

-- UI Frame
local Main = Instance.new("Frame")
Main.Name = "MainUI"
Main.Parent = ScreenGui
Main.Size = UDim2.new(0, 460, 0, 540)
Main.Position = UDim2.new(0.3, 0, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

createRGBFrame(Main)

-- Title
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "📜 Script by riko"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20

-- Close Button
local Close = Instance.new("TextButton", Main)
Close.Size = UDim2.new(0, 60, 0, 30)
Close.Position = UDim2.new(1, -70, 0, 10)
Close.Text = "Close"
Close.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.MouseButton1Click:Connect(function()
	Main.Visible = false
end)

-- Fungsi tombol toggle hijau/merah
local function createToggle(name, parent, callback)
	local btn = Instance.new("TextButton", parent)
	btn.Size = UDim2.new(1, -20, 0, 35)
	btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
	btn.Text = name
	btn.Font = Enum.Font.Gotham
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.TextSize = 16
	btn.AutoButtonColor = false

	btn.MouseButton1Click:Connect(function()
		if btn.BackgroundColor3 == Color3.fromRGB(0, 150, 0) then
			btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
		else
			btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
			pcall(callback)
		end
	end)

	return btn
end

-- Scroll Holder
local holder = Instance.new("ScrollingFrame", Main)
holder.Size = UDim2.new(1, -20, 1, -60)
holder.Position = UDim2.new(0, 10, 0, 50)
holder.CanvasSize = UDim2.new(0, 0, 0, 800)
holder.BackgroundTransparency = 1
holder.ScrollBarThickness = 6

local UIListLayout = Instance.new("UIListLayout", holder)
UIListLayout.Padding = UDim.new(0, 5)

-- Toggle Buttons
createToggle("Infinite Jump", holder, function()
	game:GetService("UserInputService").JumpRequest:Connect(function()
		game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
	end)
end)

createToggle("ESP Box (Putih)", holder, function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/rikoazhar/espbox/main/boxwhite.lua"))()
end)

createToggle("ESP Skeleton", holder, function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/rikoazhar/espskeleton/main/skeleton.lua"))()
end)

createToggle("TP Tool", holder, function()
	loadstring(game:HttpGet("https://pastebin.com/raw/LT4Fz3eS"))() -- TP Tool dari Infinite Yield
end)

createToggle("Noclip", holder, function()
	local plr = game.Players.LocalPlayer
	game:GetService("RunService").Stepped:Connect(function()
		if plr.Character then
			for _, part in pairs(plr.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end
	end)
end)

createToggle("Killer x3", holder, function()
	loadstring(game:HttpGet("https://pastebin.com/raw/fZK4AZSu"))()
end)

createToggle("Boost FPS", holder, function()
	for _, v in pairs(game:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Material = Enum.Material.SmoothPlastic
			v.Reflectance = 0
		elseif v:IsA("Decal") then
			v.Transparency = 1
		end
	end
end)

createToggle("Anti Lag", holder, function()
	settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end)

createToggle("Fly", holder, function()
	loadstring(game:HttpGet("https://pastebin.com/raw/7ceYyu2L"))()
end)

createToggle("Carpet", holder, function()
	local carpet = Instance.new("Part", game.Players.LocalPlayer.Character)
	carpet.Size = Vector3.new(5, 0.1, 5)
	carpet.Anchored = false
	carpet.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 3, 0)
	carpet.CanCollide = true
	carpet.Name = "MagicCarpet"
	local weld = Instance.new("WeldConstraint", carpet)
	weld.Part0 = carpet
	weld.Part1 = game.Players.LocalPlayer.Character.HumanoidRootPart
end)

createToggle("No Banned", holder, function()
	local mt = getrawmetatable(game)
	setreadonly(mt, false)
	local namecall = mt.__namecall
	mt.__namecall = newcclosure(function(self, ...)
		if getnamecallmethod() == "Kick" then
			return nil
		end
		return namecall(self, ...)
	end)
end)

createToggle("Anti Kick", holder, function()
	hookmetamethod(game, "__namecall", function(self, ...)
		if getnamecallmethod() == "Kick" then
			return
		end
		return self(...)
	end)
end)

createToggle("ESP Item", holder, function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/rikoazhar/itemesp/main/espitem.lua"))()
end)

createToggle("VIP Mode", holder, function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/rikoazhar/vipaccess/main/vip.lua"))()
end)

createToggle("Add Admin", holder, function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

-- Kick Player by Name
local kickBox = Instance.new("TextBox", holder)
kickBox.PlaceholderText = "Masukkan Nama Player..."
kickBox.Size = UDim2.new(1, -20, 0, 30)
kickBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
kickBox.TextColor3 = Color3.new(1, 1, 1)
kickBox.Text = ""
kickBox.ClearTextOnFocus = false

local kickBtn = createToggle("Kick Player", holder, function()
	local playerToKick = game.Players:FindFirstChild(kickBox.Text)
	if playerToKick then
		playerToKick:Kick("You have been kicked.")
	end
end)
kickBtn.Text = "Kick Player"
kickBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
