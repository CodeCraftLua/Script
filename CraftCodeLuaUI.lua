-- ✅ Rayfield UI Setup
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ✅ Drag UI Function
local function MakeDraggable(gui)
    local dragging, dragInput, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)

    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    RunService.RenderStepped:Connect(function()
        if dragging and dragInput then
            local delta = dragInput.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- ✅ GUI Setup
local Window = Rayfield:CreateWindow({
    Name = "CodeCraftLua",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "CodeCraftLuaUI"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = true,
    KeySettings = {
        Title = "CodeCraftLua KEY",
        Subtitle = "Key System by Luminaprojects",
        Note = "Key valid 1 jam",
        FileName = "CodeCraftLuaKey",
        SaveKey = true,
        GrabKeyFromSite = true,
        Key = "https://getkey-iota.vercel.app/"
    }
})

-- ✅ Tab: Hitbox / Aimbot
local Tab = Window:CreateTab("Hitbox / Aimbot", 4483362458)

-- Aimbot toggle
local aimbotEnabled = false
local aimPart = "Head"

Tab:CreateButton({
    Name = "Toggle Aimbot",
    Callback = function()
        aimbotEnabled = not aimbotEnabled
        Rayfield:Notify({Title = "Aimbot", Content = aimbotEnabled and "ON" or "OFF", Duration = 2})
    end
})

Tab:CreateButton({
    Name = "Switch Aim Part",
    Callback = function()
        aimPart = (aimPart == "Head") and "HumanoidRootPart" or "Head"
        Rayfield:Notify({Title = "AimPart", Content = "Now aiming: " .. aimPart, Duration = 2})
    end
})

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

-- ✅ Tab: More Setting
local MoreTab = Window:CreateTab("More Setting", 4483362458)

MoreTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(state)
        if state then
            game:GetService("UserInputService").JumpRequest:Connect(function()
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end)
        end
    end
})

MoreTab:CreateInput({
    Name = "Custom Walkspeed",
    PlaceholderText = "Enter speed",
    RemoveTextAfterFocusLost = true,
    Callback = function(speed)
        if tonumber(speed) then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = tonumber(speed)
        end
    end
})

MoreTab:CreateToggle({
    Name = "X-Ray",
    CurrentValue = false,
    Callback = function(state)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Transparency < 1 then
                v.Transparency = state and 0.5 or 0
            end
        end
    end
})

MoreTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(state)
        RunService.Stepped:Connect(function()
            if state then
                for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end
})

MoreTab:CreateButton({
    Name = "TP Tool (Infinite Yield)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})
