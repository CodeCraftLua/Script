local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

local loopEnabled = false

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "AutoLevelUI"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 260, 0, 180)
Frame.Position = UDim2.new(0.5, -130, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 2
Frame.Active = true
Frame.Draggable = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)

local UIStroke = Instance.new("UIStroke", Frame)
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 255, 255)

local Logo = Instance.new("ImageLabel", Frame)
Logo.Size = UDim2.new(0, 24, 0, 24)
Logo.Position = UDim2.new(0, 5, 0, 3)
Logo.BackgroundTransparency = 1
Logo.Image = "https://raw.githubusercontent.com/CodeCraftLua/Item/main/Logo.png"

local Title = Instance.new("TextLabel", Frame)
Title.Text = "Auto Level"
Title.Size = UDim2.new(1, -35, 0, 30)
Title.Position = UDim2.new(0, 35, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

local Credit = Instance.new("TextLabel", Frame)
Credit.Text = "-`~ Script by CraftCodeLua ~`-"
Credit.Size = UDim2.new(1, 0, 0, 20)
Credit.Position = UDim2.new(0, 0, 1, -20)
Credit.BackgroundTransparency = 1
Credit.TextColor3 = Color3.fromRGB(180, 180, 255)
Credit.Font = Enum.Font.Gotham
Credit.TextSize = 12

local StartBtn = Instance.new("TextButton", Frame)
StartBtn.Size = UDim2.new(0, 220, 0, 40)
StartBtn.Position = UDim2.new(0.5, -110, 0.5, -30)
StartBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 75)
StartBtn.Text = "Start Auto Level"
StartBtn.Font = Enum.Font.GothamBold
StartBtn.TextSize = 14
StartBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", StartBtn).CornerRadius = UDim.new(0, 8)

local StopBtn = Instance.new("TextButton", Frame)
StopBtn.Size = UDim2.new(0, 220, 0, 35)
StopBtn.Position = UDim2.new(0.5, -110, 0.5, 20)
StopBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
StopBtn.Text = "Stop Auto Level"
StopBtn.Font = Enum.Font.GothamBold
StopBtn.TextSize = 14
StopBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", StopBtn)

local CloseBtn = Instance.new("TextButton", Frame)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", CloseBtn)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "CraftCodeLua",
        Text = "If there is a bug report to me!",
        Button1 = "Okei",
        Button2 = "Cancel",
        Duration = 30
    })
end)

local function getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function tweenToPosition(pos)
    local char = getCharacter()
    local root = char:WaitForChild("HumanoidRootPart")

    local tweenInfo = TweenInfo.new(
        (root.Position - pos).Magnitude / 60,
        Enum.EasingStyle.Linear
    )

    local tween = TweenService:Create(root, tweenInfo, {CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))})
    tween:Play()
    tween.Completed:Wait()
end

local function autoTouchCheckpoints()
    local checkpoints = workspace:WaitForChild("Checkpoints")
    local sortedCheckpoints = {}

    for _, cp in pairs(checkpoints:GetChildren()) do
        if cp:IsA("BasePart") then
            local num = tonumber(cp.Name:match("%d+")) or 0
            table.insert(sortedCheckpoints, {part = cp, num = num})
        end
    end

    table.sort(sortedCheckpoints, function(a, b)
        return a.num < b.num
    end)

    repeat
        for _, checkpoint in ipairs(sortedCheckpoints) do
            if not loopEnabled then return end
            StartBtn.Text = "Moving to: " .. checkpoint.part.Name
            tweenToPosition(checkpoint.part.Position)
            wait(1)
        end
    until not loopEnabled

    StartBtn.Text = "Finished!"
    StartBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
end

StartBtn.MouseButton1Click:Connect(function()
    if loopEnabled then return end
    loopEnabled = true
    StartBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    StartBtn.Text = "Looping..."
    autoTouchCheckpoints()
end)

StopBtn.MouseButton1Click:Connect(function()
    loopEnabled = false
    StartBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 75)
    StartBtn.Text = "Start Auto Level"
end)
