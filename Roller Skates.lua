local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
if gethui then gui.Parent = gethui() else gui.Parent = game.CoreGui end
gui.Name = "W6AutoCheckpointUI"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 80)
frame.Position = UDim2.new(0.5, -100, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
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
title.Text = "Auto Checkpoint"
title.Size = UDim2.new(1, -30, 0, 25)
title.Position = UDim2.new(0, 5, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 20, 0, 20)
closeBtn.Position = UDim2.new(1, -25, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.TextSize = 14
Instance.new("UICorner", closeBtn)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local toggle = false
local toggleBtn = Instance.new("TextButton", frame)
toggleBtn.Size = UDim2.new(0.9, 0, 0, 35)
toggleBtn.Position = UDim2.new(0.5, -90, 0, 40)
toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
toggleBtn.Text = "OFF"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.TextSize = 16
Instance.new("UICorner", toggleBtn)

local currentCheckpoint = 1
local list = {}

local function getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function flyTo(pos)
    local root = getCharacter():WaitForChild("HumanoidRootPart")
    local startPos = Vector3.new(pos.X, pos.Y + 20, pos.Z)
    root.CFrame = CFrame.new(startPos)
    local tween = TweenService:Create(root, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
        CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
    })
    tween:Play()
    tween.Completed:Wait()
end

local function autoCheckpoint()
    local checkpoints = workspace:FindFirstChild("CheckPoints")
    if not checkpoints then return end

    list = {}
    for _, cp in ipairs(checkpoints:GetChildren()) do
        if cp:IsA("BasePart") then
            table.insert(list, {part = cp, num = tonumber(cp.Name:match("%d+")) or 0})
        end
    end
    table.sort(list, function(a, b) return a.num < b.num end)

    for i = currentCheckpoint, #list do
        if not toggle then return end
        local item = list[i]
        flyTo(item.part.Position)
        currentCheckpoint = i + 1
        task.wait(1)
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    if toggle then
        task.wait(1.5)
        autoCheckpoint()
    end
end)

toggleBtn.MouseButton1Click:Connect(function()
    toggle = not toggle
    toggleBtn.Text = toggle and "ON" or "OFF"
    toggleBtn.BackgroundColor3 = toggle and Color3.fromRGB(60, 180, 75) or Color3.fromRGB(200, 60, 60)
    if toggle then
        currentCheckpoint = 1
        autoCheckpoint()
    end
end)

local credit = Instance.new("TextLabel")
credit.Text = "Script by CraftCodeLua"
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 1, -20)
credit.BackgroundTransparency = 1
credit.Font = Enum.Font.Gotham
credit.TextColor3 = Color3.fromRGB(150, 150, 255)
credit.TextSize = 12
credit.TextStrokeTransparency = 0.5
credit.TextYAlignment = Enum.TextYAlignment.Center
credit.Parent = gui

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(0, 120, 0, 20)
fpsLabel.Position = UDim2.new(0.5, -60, 1, -45)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 14
fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fpsLabel.Text = "FPS: 0"
fpsLabel.Parent = gui

local fps = 0
local last = tick()
RunService.RenderStepped:Connect(function()
    fps = math.floor(1 / (tick() - last))
    last = tick()
    fpsLabel.Text = "FPS: " .. fps
end)
