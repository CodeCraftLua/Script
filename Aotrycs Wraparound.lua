local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "CraftCodeLua",
    Text = "Don't click auto too much, or you'll get too many commands.",
    Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150",
    Duration = 5
})

local vu = game:GetService("VirtualUser")
player.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

pcall(function() game.CoreGui:FindFirstChild("CraftCodeUI"):Destroy() end)

local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "CraftCodeUI"
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Position = UDim2.new(0.5, -140, 0.5, -170) -- Centered
frame.Size = UDim2.new(0, 280, 0, 340)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.AnchorPoint = Vector2.new(0.5, 0.5)

frame.Size = UDim2.new(0, 0, 0, 0)
frame.Visible = false
local openTween = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
    Size = UDim2.new(0, 280, 0, 340)
})

local border = Instance.new("UIStroke", frame)
border.Thickness = 2
border.LineJoinMode = Enum.LineJoinMode.Round
border.Color = Color3.fromRGB(255, 0, 0)

task.spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            border.Color = Color3.fromHSV(i,1,1)
            task.wait(0.05)
        end
    end
end)

local scrolling = Instance.new("ScrollingFrame", frame)
scrolling.Size = UDim2.new(1, -10, 1, -40)
scrolling.Position = UDim2.new(0, 5, 0, 30)
scrolling.BackgroundTransparency = 1
scrolling.CanvasSize = UDim2.new(0,0,0,700)
scrolling.ScrollBarThickness = 4
scrolling.ScrollBarImageColor3 = Color3.fromRGB(100,100,100)

local title = Instance.new("TextLabel", frame)
title.Text = "Aotrycs Wraparound"
title.Size = UDim2.new(1, -50, 0, 30)
title.Position = UDim2.new(0, 10, 0, 0)
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.BackgroundTransparency = 1

local close = Instance.new("TextButton", frame)
close.Text = "X"
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -30, 0, 0)
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = Color3.fromRGB(40,40,40)
close.Font = Enum.Font.GothamBold
close.TextSize = 16
close.AutoButtonColor = false

close.MouseEnter:Connect(function()
    TweenService:Create(close, TweenInfo.new(0.2), {
        TextColor3 = Color3.new(1,0,0),
        BackgroundColor3 = Color3.fromRGB(60,60,60)
    }):Play()
end)

close.MouseLeave:Connect(function()
    TweenService:Create(close, TweenInfo.new(0.2), {
        TextColor3 = Color3.new(1,1,1),
        BackgroundColor3 = Color3.fromRGB(40,40,40)
    }):Play()
end)

close.MouseButton1Click:Connect(function()
    local closeTween = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 0, 0, 0)
    })
    closeTween:Play()
    closeTween.Completed:Wait()
    frame:Destroy()
end)

local toggleBtn = Instance.new("TextButton", screenGui)
toggleBtn.Text = "⚙️"
toggleBtn.Size = UDim2.new(0,40,0,40)
toggleBtn.Position = UDim2.new(0,10,0,10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Font = Enum.Font.Gotham
toggleBtn.TextSize = 20
toggleBtn.AutoButtonColor = false
toggleBtn.AnchorPoint = Vector2.new(0, 0)

toggleBtn.MouseEnter:Connect(function()
    TweenService:Create(toggleBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(60,60,60),
        Rotation = 45
    }):Play()
end)

toggleBtn.MouseLeave:Connect(function()
    TweenService:Create(toggleBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(40,40,40),
        Rotation = 0
    }):Play()
end)

toggleBtn.MouseButton1Click:Connect(function()
    if frame.Visible then
        frame.Visible = false
    else
        frame.Visible = true
        openTween:Play()
    end
end)

local credit = Instance.new("TextLabel", frame)
credit.Text = "Script by CraftCodeLua"
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 1, -20)
credit.BackgroundTransparency = 1
credit.TextSize = 14
credit.Font = Enum.Font.GothamBold

task.spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            credit.TextColor3 = Color3.fromHSV(i, 1, 1)
            task.wait(0.05)
        end
    end
end)

local function createToggle(name, callback)
    local button = Instance.new("TextButton", scrolling)
    button.Size = UDim2.new(0.9, 0, 0, 30)
    button.Position = UDim2.new(0.05, 0, 0, #scrolling:GetChildren() * 35 + 5)
    button.BackgroundColor3 = Color3.fromRGB(40,40,40)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Text = name
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    
    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 5)
    
    local stroke = Instance.new("UIStroke", button)
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(80,80,80)
    
    local on = false
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(60,60,60)
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = on and Color3.fromRGB(0, 80, 0) or Color3.fromRGB(80, 0, 0) or Color3.fromRGB(40,40,40)
        }):Play()
    end)
    
    button.MouseButton1Click:Connect(function()
        on = not on
        local newColor = on and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(120, 0, 0)
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = newColor
        }):Play()
        callback(on)
    end)
end

local lastCheckpoint = -1
createToggle("Auto Play", function(state)
    if state then
        task.spawn(function()
            while wait(1) and state do
                local cp = workspace:FindFirstChild("Checkpoints")
                if cp then
                    local nextCP = cp:FindFirstChild(tostring(lastCheckpoint + 1))
                    if nextCP then
                        player.Character.HumanoidRootPart.CFrame = nextCP.CFrame + Vector3.new(0,2,0)
                        lastCheckpoint = lastCheckpoint + 1
                    end
                end
            end
        end)
    else
        lastCheckpoint = -1
    end
end)

createToggle("Remove Spike", function(on)
    if on then
        if workspace:FindFirstChild("killbrick") then
            workspace.killbrick:Destroy()
        end
    end
end)

createToggle("Noclip", function(state)
    if state then
        game:GetService("RunService").Stepped:Connect(function()
            if player.Character then
                for _, v in pairs(player.Character:GetDescendants()) do
                    if v:IsA("BasePart") and v.CanCollide == true then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end
end)

createToggle("Inf Jump", function(state)
    if state then
        _G.infJump = true
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if _G.infJump and player.Character then
                player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
    else
        _G.infJump = false
    end
end)

local jumpBox = Instance.new("TextBox", scrolling)
jumpBox.Size = UDim2.new(0.9, 0, 0, 30)
jumpBox.Position = UDim2.new(0.05, 0, 0, #scrolling:GetChildren() * 35 + 5)
jumpBox.PlaceholderText = "JumpPower"
jumpBox.Text = ""
jumpBox.TextColor3 = Color3.new(1,1,1)
jumpBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
jumpBox.Font = Enum.Font.Gotham
jumpBox.TextSize = 14
jumpBox.ClearTextOnFocus = false

local corner = Instance.new("UICorner", jumpBox)
corner.CornerRadius = UDim.new(0, 5)

local stroke = Instance.new("UIStroke", jumpBox)
stroke.Thickness = 1
stroke.Color = Color3.fromRGB(80,80,80)

jumpBox.Focused:Connect(function()
    TweenService:Create(jumpBox, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(60,60,60)
    }):Play()
end)

jumpBox.FocusLost:Connect(function()
    TweenService:Create(jumpBox, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(40,40,40)
    }):Play()
    local val = tonumber(jumpBox.Text)
    if val and player.Character then
        player.Character:FindFirstChildOfClass("Humanoid").JumpPower = val
    end
end)

createToggle("TP Tool", function(state)
    if state then
        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "ClickTP"
        tool.Activated:Connect(function()
            local pos = mouse.Hit + Vector3.new(0,3,0)
            if player.Character then
                player.Character:MoveTo(pos.Position)
            end
        end)
        tool.Parent = player.Backpack
    else
        local t = player.Backpack:FindFirstChild("ClickTP")
        if t then t:Destroy() end
    end
end)

frame.Visible = true
openTween:Play()
