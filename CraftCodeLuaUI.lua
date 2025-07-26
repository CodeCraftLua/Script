local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local hitboxEnabled = false
local hitboxTransparency = 0.5
local hitboxSize = 10
local hitboxColor = Color3.fromRGB(255, 0, 0)
local aimbotEnabled = false
local aimPart = "Head"

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("CodeCraftLua", "DarkTheme")

local MainTab = Window:NewTab("🌐 Main")
local HitboxTab = Window:NewTab("🎯 Hitbox")
local ExtraTab = Window:NewTab("🛠️ More Settings")
local LogoTab = Window:NewTab("🖼️ Logo")

local AimbotSection = HitboxTab:NewSection("Aimbot")
local HitboxSection = HitboxTab:NewSection("Hitbox Settings")
local ExtraSection = ExtraTab:NewSection("Extra Settings")

AimbotSection:NewButton("Toggle Aimbot", "Enable/Disable Aimbot", function()
    aimbotEnabled = not aimbotEnabled
end)

AimbotSection:NewButton("Switch AimPart", "Head / HumanoidRootPart", function()
    aimPart = (aimPart == "Head") and "HumanoidRootPart" or "Head"
end)


HitboxSection:NewToggle("Hitbox Enabled", "Toggle hitbox visibility", function(state)
    hitboxEnabled = state
end)

HitboxSection:NewSlider("Transparency", "Set hitbox transparency", 1, 0, function(val)
    hitboxTransparency = val
end)

HitboxSection:NewSlider("Hitbox Size", "Adjust hitbox size", 100, 0, function(val)
    hitboxSize = val
end)

HitboxSection:NewColorPicker("Hitbox Color", "Set hitbox color", hitboxColor, function(color)
    hitboxColor = color
end)

ExtraSection:NewButton("Walkspeed", "Like Infinite Yield", function()
    LocalPlayer.Character.Humanoid.WalkSpeed = 50
end)

ExtraSection:NewToggle("Infinite Jump", "Like Infinite Yield", function(state)
    getgenv().infjump = state
end)

UserInputService.JumpRequest:Connect(function()
    if getgenv().infjump then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

ExtraSection:NewToggle("Noclip", "Like Infinite Yield", function(state)
    getgenv().noclip = state
end)

RunService.Stepped:Connect(function()
    if getgenv().noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

ExtraSection:NewButton("TP Tool", "Survive respawn", function()
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "TP Tool"
    tool.Activated:Connect(function()
        local mouse = LocalPlayer:GetMouse()
        if mouse then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0, 3, 0))
        end
    end)
    tool.Parent = LocalPlayer.Backpack
end)

local function getClosestPlayer()
    local closest, shortest = nil, math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(aimPart) then
            local distance = (Camera.CFrame.Position - player.Character[aimPart].Position).Magnitude
            if distance < shortest then
                shortest = distance
                closest = player
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild(aimPart) then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character[aimPart].Position)
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if hitboxEnabled then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local part = v.Character.HumanoidRootPart
                if not part:FindFirstChild("Hitbox") then
                    local selectionBox = Instance.new("BoxHandleAdornment")
                    selectionBox.Name = "Hitbox"
                    selectionBox.Adornee = part
                    selectionBox.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                    selectionBox.Color3 = hitboxColor
                    selectionBox.Transparency = hitboxTransparency
                    selectionBox.AlwaysOnTop = true
                    selectionBox.ZIndex = 5
                    selectionBox.Parent = part
                else
                    local selectionBox = part:FindFirstChild("Hitbox")
                    selectionBox.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                    selectionBox.Color3 = hitboxColor
                    selectionBox.Transparency = hitboxTransparency
                end
            end
        end
    else
        for _, v in pairs(Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local adorn = v.Character.HumanoidRootPart:FindFirstChild("Hitbox")
                if adorn then adorn:Destroy() end
            end
        end
    end
end)

local function checkKey()
    local HttpService = game:GetService("HttpService")
    local inputKey = tostring(game:HttpGet("https://getkey-iota.vercel.app/api/verify?key=YOUR_KEY_HERE"))
    if not string.match(inputKey, "^CodeCraftLuaKey_.*_codecraftlua$") then
        game.Players.LocalPlayer:Kick("Invalid or Expired Key. Get one at https://getkey-iota.vercel.app/")
    end
end
pcall(checkKey)

local logoSection = LogoTab:NewSection("Logo")
logoSection:NewLabel("Logo Below:")
logoSection:NewLabel("https://raw.githubusercontent.com/CodeCraftLua/Item/refs/heads/main/MainLogoUi.png")
