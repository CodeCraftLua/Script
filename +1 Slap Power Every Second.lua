-- Load UI Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local humanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")

-- Save Previous Position
local lastPosition = nil

-- Buat Window
local Window = OrionLib:MakeWindow({
    Name = "+1 Punch Power Every Second",
    HidePremium = false,
    SaveConfig = false,
    IntroText = "CodeCraftLua",
    ConfigFolder = "SlapScript"
})

-- Buat Tab dan Section
local MainTab = Window:MakeTab({Name = "Main", Icon = "rbxassetid://4483345998", PremiumOnly = false})

-- Slap Coordinates Table
local slapLocations = {
    ["Slap Cheol-su"] = Vector3.new(106, -216, -339),
    ["Slap Young-he"] = Vector3.new(123, -216, -341),
    ["Slap Red Paper"] = Vector3.new(184, -216, -328),
    ["Slap Blue Paper"] = Vector3.new(203, -216, -327),
    ["Huge Slap"] = Vector3.new(118, -216, 66),
    ["Slap Golden"] = Vector3.new(-75, 184, 43)
}

-- Slap Selection Dropdown
MainTab:AddDropdown({
    Name = "🥊 Slap Selection",
    Default = "Slap Cheol-su",
    Options = table.getn(slapLocations) > 0 and (function()
        local keys = {}
        for name in pairs(slapLocations) do table.insert(keys, name) end
        return keys
    end)() or {},
    Callback = function(option)
        if humanoidRootPart then
            lastPosition = humanoidRootPart.Position -- Simpan posisi sebelum teleport
            task.wait(0.1)
            humanoidRootPart.CFrame = CFrame.new(slapLocations[option])
            task.wait(1.5)
            -- Teleport kembali ke posisi awal
            if lastPosition then
                humanoidRootPart.CFrame = CFrame.new(lastPosition)
            end
        end
    end
})

-- Auto Win Button
MainTab:AddButton({
    Name = "🏆 Auto Win (Delay 1s)",
    Callback = function()
        while true do
            humanoidRootPart.CFrame = CFrame.new(-83, 197, 8)
            task.wait(1)
        end
    end
})

-- Auto King Slap
MainTab:AddButton({
    Name = "👑 Auto King Slap",
    Callback = function()
        while true do
            humanoidRootPart.CFrame = CFrame.new(47, -216, 50)
            task.wait(1)
        end
    end
})

-- Auto Rebirth
MainTab:AddToggle({
    Name = "♻️ Auto Rebirth",
    Default = false,
    Callback = function(state)
        _G.autoRebirth = state
        while _G.autoRebirth do
            game:GetService("ReplicatedStorage"):WaitForChild("Rebirth"):FireServer()
            task.wait(2)
        end
    end
})

-- Auto Secret Teleport 1-5
local secretCoords = {
    Vector3.new(98, -215, 188),
    Vector3.new(312, -226, 48),
    Vector3.new(133, -260, -1),
    Vector3.new(-15, 51, 763),
    Vector3.new(-683, -11, 140)
}

MainTab:AddButton({
    Name = "🗝️ Auto Secret (1-5)",
    Callback = function()
        for _, pos in ipairs(secretCoords) do
            humanoidRootPart.CFrame = CFrame.new(pos)
            task.wait(1)
        end
    end
})

OrionLib:Init()
