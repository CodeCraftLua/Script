local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer


pcall(function()
	StarterGui:SetCore("SendNotification", {
		Title = "CraftCodeLua",
		Text = "If there is a bug let me know.",
		Button1 = "Okei",
		Button2 = "Cancel",
		Duration = 30
	})
end)

local gui = Instance.new("ScreenGui")
if gethui then
	gui.Parent = gethui()
elseif syn and syn.protect_gui then
	syn.protect_gui(gui)
	gui.Parent = game.CoreGui
elseif game:FindFirstChild("CoreGui") then
	gui.Parent = game.CoreGui
else
	gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

gui.Name = "AutoObbyUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 220)
frame.Position = UDim2.new(0.5, -140, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

spawn(function()
	while gui and stroke do
		for h = 0, 1, 0.01 do
			stroke.Color = Color3.fromHSV(h, 1, 1)
			task.wait(0.03)
		end
	end
end)

local title = Instance.new("TextLabel", frame)
title.Text = "Impossible Obby Ranking"
title.Size = UDim2.new(1, -10, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left

local function createButton(text, position, color)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0.8, 0, 0, 35)
	btn.Position = position
	btn.BackgroundColor3 = color
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.TextColor3 = Color3.new(1, 1, 1)
	Instance.new("UICorner", btn)
	return btn
end

local startBtn = createButton("Start Auto Play", UDim2.new(0.5, -112, 0.5, -30), Color3.fromRGB(60, 180, 75))
local stopBtn = createButton("Stop Auto Play", UDim2.new(0.5, -112, 0.5, 25), Color3.fromRGB(200, 60, 60))
local removeBtn = createButton("Remove Spike", UDim2.new(0.5, -112, 0.5, 80), Color3.fromRGB(100, 100, 255))

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", closeBtn)
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

local credit = Instance.new("TextLabel", frame)
credit.Text = "-~ Script by CraftCodeLua ~-"
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 1, -20)
credit.BackgroundTransparency = 1
credit.Font = Enum.Font.Gotham
credit.TextColor3 = Color3.fromRGB(160, 160, 255)
credit.TextSize = 12

local flying = false

local function getCharacter()
	return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function flyTo(pos)
	local root = getCharacter():WaitForChild("HumanoidRootPart")
	local time = (root.Position - pos).Magnitude / 100
	TweenService:Create(root, TweenInfo.new(time, Enum.EasingStyle.Linear), {
		CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
	}):Play()
	task.wait(time)
end

local function autoPlay()
	local folder = workspace:FindFirstChild("Checkpoints")
	if not folder then return end

	local list = {}
	for _, cp in ipairs(folder:GetChildren()) do
		if cp:IsA("BasePart") then
			table.insert(list, {part = cp, num = tonumber(cp.Name:match("%d+")) or 0})
		end
	end
	table.sort(list, function(a, b) return a.num < b.num end)

	repeat
		for _, checkpoint in ipairs(list) do
			if not flying then return end
			startBtn.Text = "Going to: " .. checkpoint.num
			flyTo(checkpoint.part.Position)
			task.wait(0.5)
		end
	until not flying
	startBtn.Text = "Start Auto Play"
end

startBtn.MouseButton1Click:Connect(function()
	if flying then return end
	flying = true
	startBtn.Text = "Looping..."
	autoPlay()
end)

stopBtn.MouseButton1Click:Connect(function()
	flying = false
	startBtn.Text = "Start Auto Play"
end)

removeBtn.MouseButton1Click:Connect(function()
	local folder = workspace:FindFirstChild("ClientParts")
	if folder then
		local kill = folder:FindFirstChild("KillBricks")
		if kill then
			kill:Destroy()
			removeBtn.Text = "Spike Removed!"
			task.wait(1)
			removeBtn.Text = "Remove Spike"
		else
			removeBtn.Text = "Not Found"
			task.wait(1)
			removeBtn.Text = "Remove Spike"
		end
	end
end)

local fpsLabel = Instance.new("TextLabel", gui)
fpsLabel.Size = UDim2.new(0, 120, 0, 25)
fpsLabel.Position = UDim2.new(0.5, -60, 1, -60)
fpsLabel.BackgroundTransparency = 0.5
fpsLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
fpsLabel.TextColor3 = Color3.new(1, 1, 1)
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 14
fpsLabel.Text = "FPS: ..."
Instance.new("UICorner", fpsLabel)

local fps, last = 0, tick()
RunService.RenderStepped:Connect(function()
	fps += 1
	if tick() - last >= 1 then
		fpsLabel.Text = "FPS: " .. fps
		fps = 0
		last = tick()
	end
end)
