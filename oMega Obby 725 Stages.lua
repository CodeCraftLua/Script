local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "oMegaObbyUI"
ScreenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", ScreenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 340)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 4
mainFrame.Active = true
mainFrame.Draggable = true

local UICorner = Instance.new("UICorner", mainFrame)
UICorner.CornerRadius = UDim.new(0, 10)

local credit = Instance.new("TextLabel", ScreenGui)
credit.Size = UDim2.new(0, 400, 0, 25)
credit.Position = UDim2.new(0.5, -200, 1, -30)
credit.Text = "script by - craftcodelua"
credit.Font = Enum.Font.GothamBold
credit.TextSize = 16
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.new(1, 1, 1)

local hue = 0
RunService.RenderStepped:Connect(function()
	hue = (hue + 1) % 255
	local color = Color3.fromHSV(hue/255, 1, 1)
	mainFrame.BorderColor3 = color
	credit.TextColor3 = color
end)

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Text = "oMega Obby 725 Stages"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.new(1, 1, 1)
title.Size = UDim2.new(1, -70, 0, 40)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)

local minimizeBtn = Instance.new("TextButton", mainFrame)
minimizeBtn.Text = "-"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 16
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -70, 0, 5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

local contentVisible = true
minimizeBtn.MouseButton1Click:Connect(function()
	contentVisible = not contentVisible
	for _, v in ipairs(mainFrame:GetChildren()) do
		if v:IsA("Frame") and v.Name ~= "Tabs" then
			v.Visible = contentVisible
		end
	end
end)

local openBtn = Instance.new("TextButton", ScreenGui)
openBtn.Text = "OPEN UI"
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 14
openBtn.Size = UDim2.new(0, 100, 0, 35)
openBtn.Position = UDim2.new(0, 10, 0.5, -100)
openBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 150)
openBtn.TextColor3 = Color3.new(1, 1, 1)
openBtn.BorderSizePixel = 0

openBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

local tabHolder = Instance.new("Frame", mainFrame)
tabHolder.Name = "Tabs"
tabHolder.Size = UDim2.new(1, 0, 0, 35)
tabHolder.Position = UDim2.new(0, 0, 0, 45)
tabHolder.BackgroundTransparency = 1

local mainTabBtn = Instance.new("TextButton", tabHolder)
mainTabBtn.Text = "Main"
mainTabBtn.Size = UDim2.new(0.5, 0, 1, 0)
mainTabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
mainTabBtn.Font = Enum.Font.GothamBold
mainTabBtn.TextSize = 14

local moreTabBtn = mainTabBtn:Clone()
moreTabBtn.Text = "More Function"
moreTabBtn.Position = UDim2.new(0.5, 0, 0, 0)
moreTabBtn.Parent = tabHolder

local mainTabFrame = Instance.new("Frame", mainFrame)
mainTabFrame.Position = UDim2.new(0, 0, 0, 85)
mainTabFrame.Size = UDim2.new(1, 0, 1, -85)
mainTabFrame.BackgroundTransparency = 1

local moreTabFrame = mainTabFrame:Clone()
moreTabFrame.Parent = mainFrame
moreTabFrame.Visible = false

local autoBtn = Instance.new("TextButton", mainTabFrame)
autoBtn.Text = "Auto Stage [OFF]"
autoBtn.Size = UDim2.new(0.9, 0, 0, 40)
autoBtn.Position = UDim2.new(0.05, 0, 0, 10)
autoBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
autoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoBtn.Font = Enum.Font.GothamBold
autoBtn.TextSize = 16
autoBtn.BorderSizePixel = 0

local autoRunning = false
autoBtn.MouseButton1Click:Connect(function()
    autoRunning = not autoRunning
    autoBtn.Text = autoRunning and "Auto Stage [ON]" or "Auto Stage [OFF]"
    autoBtn.BackgroundColor3 = autoRunning and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 0)

    if autoRunning then
        local function goToStage(stageNum)
            local folders = {workspace:FindFirstChild("Stages"), workspace:FindFirstChild("FolderStages")}
            for _, folder in ipairs(folders) do
                if folder then
                    for _, part in ipairs(folder:GetChildren()) do
                        if part:IsA("BasePart") and string.find(part.Name:lower(), tostring(stageNum)) then
                            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 5, 0)
                            end
                            return
                        end
                    end
                end
            end
        end

        coroutine.wrap(function()
            for i = 1, 725 do
                if not autoRunning then break end
                goToStage(i)
                task.wait(0.1)
            end
        end)()
    end
end)

local wsBox = Instance.new("TextBox", moreTabFrame)
wsBox.PlaceholderText = "Set WalkSpeed"
wsBox.Size = UDim2.new(0.9, 0, 0, 30)
wsBox.Position = UDim2.new(0.05, 0, 0, 10)
wsBox.TextSize = 14
wsBox.Font = Enum.Font.Gotham
wsBox.TextColor3 = Color3.new(1, 1, 1)
wsBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

wsBox.FocusLost:Connect(function()
    local value = tonumber(wsBox.Text)
    if value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

local jpBox = wsBox:Clone()
jpBox.PlaceholderText = "Set JumpPower"
jpBox.Position = UDim2.new(0.05, 0, 0, 50)
jpBox.Parent = moreTabFrame

jpBox.FocusLost:Connect(function()
    local value = tonumber(jpBox.Text)
    if value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = value
    end
end)

local tpToolBtn = Instance.new("TextButton", moreTabFrame)
tpToolBtn.Text = "TP Tool"
tpToolBtn.Size = UDim2.new(0.9, 0, 0, 30)
tpToolBtn.Position = UDim2.new(0.05, 0, 0, 90)
tpToolBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
tpToolBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpToolBtn.Font = Enum.Font.GothamBold
tpToolBtn.TextSize = 14
tpToolBtn.Parent = moreTabFrame

tpToolBtn.MouseButton1Click:Connect(function()
    local function giveTool()
        if not LocalPlayer.Backpack:FindFirstChild("TPTool") then
            local tool = Instance.new("Tool")
            tool.Name = "TPTool"
            tool.RequiresHandle = false
            tool.CanBeDropped = false

            tool.Activated:Connect(function()
                local mouse = LocalPlayer:GetMouse()
                if mouse then
                    local pos = mouse.Hit.Position
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
                    end
                end
            end)
            tool.Parent = LocalPlayer.Backpack
        end
    end

    giveTool()
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        giveTool()
    end)
end)

mainTabBtn.MouseButton1Click:Connect(function()
    mainTabFrame.Visible = true
    moreTabFrame.Visible = false
end)
moreTabBtn.MouseButton1Click:Connect(function()
    mainTabFrame.Visible = false
    moreTabFrame.Visible = true
end)
