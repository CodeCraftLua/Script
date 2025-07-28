local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- SETTINGS
_G.AimbotEnabled = true
_G.AimbotPart = "Head" -- Head, HumanoidRootPart, LeftFoot
_G.TeamCheck = true
_G.WallCheck = true
_G.CircleRadius = 150
_G.CircleColor = Color3.fromRGB(0, 255, 255)
_G.CircleThickness = 2
_G.CircleFilled = false
_G.HitboxSize = 15
_G.HitboxColor = BrickColor.new("Lime green")
_G.HitboxEnabled = false

-- UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "MurderSherifUI"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 230, 0, 240)
Frame.Position = UDim2.new(0.01, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 2
Frame.BorderColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "🎭 Murder - Sherif Duel"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

local AimbotDropdown = Instance.new("TextButton", Frame)
AimbotDropdown.Text = "Target: Head"
AimbotDropdown.Position = UDim2.new(0, 10, 0, 40)
AimbotDropdown.Size = UDim2.new(0, 210, 0, 30)
AimbotDropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
AimbotDropdown.TextColor3 = Color3.new(1, 1, 1)
AimbotDropdown.MouseButton1Click:Connect(function()
    if _G.AimbotPart == "Head" then _G.AimbotPart = "HumanoidRootPart" AimbotDropdown.Text = "Target: Body"
    elseif _G.AimbotPart == "HumanoidRootPart" then _G.AimbotPart = "LeftFoot" AimbotDropdown.Text = "Target: Leg"
    else _G.AimbotPart = "Head" AimbotDropdown.Text = "Target: Head" end
end)

local CircleSlider = Instance.new("TextButton", Frame)
CircleSlider.Text = "Circle Radius: " .. tostring(_G.CircleRadius)
CircleSlider.Position = UDim2.new(0, 10, 0, 80)
CircleSlider.Size = UDim2.new(0, 210, 0, 30)
CircleSlider.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
CircleSlider.TextColor3 = Color3.new(1, 1, 1)
CircleSlider.MouseButton1Click:Connect(function()
    _G.CircleRadius = _G.CircleRadius + 50
    if _G.CircleRadius > 400 then _G.CircleRadius = 50 end
    CircleSlider.Text = "Circle Radius: " .. tostring(_G.CircleRadius)
end)

local ToggleHitbox = Instance.new("TextButton", Frame)
ToggleHitbox.Text = "Toggle Hitbox: OFF"
ToggleHitbox.Position = UDim2.new(0, 10, 0, 120)
ToggleHitbox.Size = UDim2.new(0, 210, 0, 30)
ToggleHitbox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ToggleHitbox.TextColor3 = Color3.new(1, 1, 1)
ToggleHitbox.MouseButton1Click:Connect(function()
    _G.HitboxEnabled = not _G.HitboxEnabled
    ToggleHitbox.Text = "Toggle Hitbox: " .. (_G.HitboxEnabled and "ON" or "OFF")
end)

-- Draggable
Frame.Active = true
Frame.Draggable = true

-- Circle Drawing
local DrawingCircle = Drawing.new("Circle")
DrawingCircle.Radius = _G.CircleRadius
DrawingCircle.Thickness = _G.CircleThickness
DrawingCircle.Color = _G.CircleColor
DrawingCircle.Transparency = 1
DrawingCircle.Filled = _G.CircleFilled
DrawingCircle.Visible = true

-- Aimbot Functions
function GetClosestPlayer()
    local closest, dist = nil, _G.CircleRadius
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(_G.AimbotPart) then
            if _G.TeamCheck and player.Team == LocalPlayer.Team then continue end
            local part = player.Character[_G.AimbotPart]
            local pos, visible = Camera:WorldToViewportPoint(part.Position)
            local mag = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
            if mag < dist then
                if _G.WallCheck and not Camera:FindPartOnRayWithIgnoreList(Ray.new(Camera.CFrame.Position, (part.Position - Camera.CFrame.Position).Unit * 1000), {LocalPlayer.Character}) then continue end
                dist = mag
                closest = part
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    DrawingCircle.Position = UserInputService:GetMouseLocation()
    DrawingCircle.Radius = _G.CircleRadius

    if _G.AimbotEnabled then
        local target = GetClosestPlayer()
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        end
    end

    -- Hitbox Loop
    if _G.HitboxEnabled then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local part = plr.Character.HumanoidRootPart
                pcall(function()
                    part.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                    part.Transparency = 0.7
                    part.BrickColor = _G.HitboxColor
                    part.Material = Enum.Material.Neon
                    part.CanCollide = false
                end)
            end
        end
    end
end)
