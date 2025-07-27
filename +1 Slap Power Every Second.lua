-- Rayfield UI Version + Full Feature Integration

-- Load Rayfield UI Library (no key system)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- UI Window Setup
local Window = Rayfield:CreateWindow({
    Name = "+1 Punch Power Every Second",
    LoadingTitle = "CodeCraftLua",
    LoadingSubtitle = "Script by CodeCraftLua",
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

-- Services
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")

function tp(pos)
    Player.Character:PivotTo(CFrame.new(pos))
end

-- Main Tab
local MainTab = Window:CreateTab("🌐 Main", 4483362458)

-- Auto Win
MainTab:CreateButton({
    Name = "🏆 Auto Win",
    Callback = function()
        while true do tp(Vector3.new(-83, 197, 8)) task.wait(1) end
    end
})

-- Auto King
MainTab:CreateButton({
    Name = "👑 Auto King Slap",
    Callback = function()
        while true do tp(Vector3.new(47, -216, 50)) task.wait(1) end
    end
})

-- Auto Secret
MainTab:CreateButton({
    Name = "🔐 Auto Secret (1-5)",
    Callback = function()
        local secrets = {
            Vector3.new(98, -215, 188),
            Vector3.new(312, -226, 48),
            Vector3.new(133, -260, -1),
            Vector3.new(-15, 51, 763),
            Vector3.new(-683, -11, 140)
        }
        for _, pos in ipairs(secrets) do
            tp(pos)
            task.wait(1)
        end
    end
})

-- Auto Slap (Teleport Enemies In Front)
MainTab:CreateToggle({
    Name = "🧨 Auto Slap",
    CurrentValue = false,
    Callback = function(state)
        getgenv().autoSlap = state
        while getgenv().autoSlap do
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local enemyHRP = plr.Character.HumanoidRootPart
                    enemyHRP.CFrame = HRP.CFrame * CFrame.new(0, 0, -3)
                end
            end
            task.wait(0.5)
        end
    end
})

-- Slap Specific NPCs (with return to original position)
local slapTargets = {
    {"Slap Cheol-su", Vector3.new(106, -216, -339)},
    {"Slap Young-he", Vector3.new(123, -216, -341)},
    {"Slap Red Paper", Vector3.new(184, -216, -328)},
    {"Slap Blue Paper", Vector3.new(203, -216, -327)},
    {"Huge Slap", Vector3.new(118, -216, 66)},
    {"Slap Golden", Vector3.new(-75, 184, 43)}
}

for _, target in ipairs(slapTargets) do
    MainTab:CreateButton({
        Name = target[1],
        Callback = function()
            local last = HRP.Position
            tp(target[2])
            task.wait(1)
            tp(last)
        end
    })
end

-- More Tab
local MoreTab = Window:CreateTab("🎮 More Featured", 4483362458)

-- Infinite Jump
MoreTab:CreateToggle({
    Name = "🕊️ Infinite Jump",
    CurrentValue = false,
    Callback = function(state)
        getgenv().infJump = state
    end
})
game:GetService("UserInputService").JumpRequest:Connect(function()
    if getgenv().infJump then
        Character:ChangeState("Jumping")
    end
end)

-- Noclip
MoreTab:CreateToggle({
    Name = "🧱 Noclip",
    CurrentValue = false,
    Callback = function(state)
        getgenv().noclip = state
    end
})
game:GetService("RunService").Stepped:Connect(function()
    if getgenv().noclip then
        for _, v in pairs(Player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- TP Tool
MoreTab:CreateButton({
    Name = "🛠️ TP Tool",
    Callback = function()
        local tool = Instance.new("Tool", Player.Backpack)
        tool.RequiresHandle = false
        tool.Name = "TP Tool"
        tool.Activated:Connect(function()
            local mouse = Player:GetMouse()
            if mouse.Target then
                Player.Character:MoveTo(mouse.Hit.p)
            end
        end)
    end
})
