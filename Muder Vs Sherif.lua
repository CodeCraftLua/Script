local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/CodeCraftLua/UILib/main/Orion.lua"))()

local Window = OrionLib:MakeWindow({
    Name = "🎯 Aimbot - Murder vs Sheriff",
    HidePremium = false,
    SaveConfig = false,
    ConfigFolder = "AimDroid",
})

local targetPart = "HumanoidRootPart"
local fovRadius = 100
local aimbotEnabled = true
local teamCheck = true
local wallCheck = true
local hitboxSize = 15
local hitboxTransparency = 0.7
local hitboxColor = BrickColor.new("Lime green")
local hitboxEnabled = true

local uiVisible = true
local function toggleUI()
    uiVisible = not uiVisible
    for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
        if v.Name == "Orion" then
            v.Enabled = uiVisible
        end
    end
end

local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = game.CoreGui
toggleBtn.Text = "🎭"
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0, 10, 0.5, -25)
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 25
toggleBtn.Active = true
toggleBtn.Draggable = true
toggleBtn.MouseButton1Click:Connect(toggleUI)

local Tab = Window:MakeTab({
    Name = "Aimbot",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Tab:AddToggle({
    Name = "Enable Aimbot",
    Default = true,
    Callback = function(Value)
        aimbotEnabled = Value
    end
})

Tab:AddToggle({
    Name = "Team Check",
    Default = true,
    Callback = function(Value)
        teamCheck = Value
    end
})

Tab:AddToggle({
    Name = "Wall Check (Raycast)",
    Default = true,
    Callback = function(Value)
        wallCheck = Value
    end
})

Tab:AddSlider({
    Name = "FOV Radius",
    Min = 30,
    Max = 300,
    Default = 100,
    Color = Color3.fromRGB(0, 200, 255),
    Increment = 1,
    ValueName = "px",
    Callback = function(Value)
        fovRadius = Value
        fovCircle.Radius = fovRadius
    end
})

Tab:AddDropdown({
    Name = "Target Part",
    Default = "Body",
    Options = {"Head", "Body", "Leg"},
    Callback = function(Value)
        if Value == "Head" then
            targetPart = "Head"
        elseif Value == "Body" then
            targetPart = "HumanoidRootPart"
        elseif Value == "Leg" then
            targetPart = "LeftFoot"
        end
    end
})

Tab:AddToggle({
    Name = "Enable Hitbox Expander",
    Default = true,
    Callback = function(Value)
        hitboxEnabled = Value
    end
})

Tab:AddSlider({
    Name = "Hitbox Size",
    Min = 5,
    Max = 50,
    Default = 15,
    Increment = 1,
    Callback = function(Value)
        hitboxSize = Value
    end
})

Tab:AddSlider({
    Name = "Hitbox Transparency",
    Min = 0,
    Max = 1,
    Default = 0.7,
    Increment = 0.1,
    Callback = function(Value)
        hitboxTransparency = Value
    end
})

Tab:AddColorPicker({
    Name = "Hitbox Color",
    Default = Color3.fromRGB(0, 255, 0),
    Callback = function(Value)
        hitboxColor = BrickColor.new(Value)
    end
})

local fovCircle = Drawing.new("Circle")
fovCircle.Color = Color3.fromRGB(255, 255, 255)
fovCircle.Thickness = 2
fovCircle.Radius = fovRadius
fovCircle.Filled = false
fovCircle.Transparency = 0.5
fovCircle.Visible = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

function isVisible(part)
    local origin = Camera.CFrame.Position
    local direction = (part.Position - origin)
    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    rayParams.IgnoreWater = true
    local result = workspace:Raycast(origin, direction, rayParams)
    if result and result.Instance then
        return result.Instance:IsDescendantOf(part.Parent)
    end
    return true
end

function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = fovRadius

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(targetPart) then
            if teamCheck and player.Team == LocalPlayer.Team then continue end

            local part = player.Character[targetPart]
            local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)

            if onScreen then
                local distance = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                if distance < shortestDistance then
                    if wallCheck and not isVisible(part) then continue end
                    shortestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end

    return closestPlayer
end

RunService.RenderStepped:Connect(function()
    fovCircle.Position = Vector2.new(Mouse.X, Mouse.Y)

    if not aimbotEnabled then return end

    local target = getClosestPlayer()
    if target and target.Character and target.Character:FindFirstChild(targetPart) then
        local aimPos = target.Character[targetPart].Position
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, aimPos)
    end
end)

RunService.RenderStepped:Connect(function()
    if hitboxEnabled then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local part = plr.Character.HumanoidRootPart
                pcall(function()
                    part.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                    part.Transparency = hitboxTransparency
                    part.BrickColor = hitboxColor
                    part.Material = Enum.Material.Neon
                    part.CanCollide = false
                end)
            end
        end
    end
end)
