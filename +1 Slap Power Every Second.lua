local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")

local ui = Instance.new("ScreenGui", game.CoreGui)
ui.Name = "MainUI"
ui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", ui)
mainFrame.Size = UDim2.new(0, 550, 0, 400)
mainFrame.Position = UDim2.new(0.5, -275, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

local logo = Instance.new("ImageLabel", mainFrame)
logo.Image = "https://raw.githubusercontent.com/CodeCraftLua/Item/refs/heads/main/MainLogoUi.png"
logo.Size = UDim2.new(0, 32, 0, 32)
logo.Position = UDim2.new(0, 10, 0, 10)
logo.BackgroundTransparency = 1

local title = Instance.new("TextLabel", mainFrame)
title.Text = "+1 Punch Power Every Second"
title.Position = UDim2.new(0, 50, 0, 10)
title.Size = UDim2.new(1, -60, 0, 32)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local credit = Instance.new("TextLabel", mainFrame)
credit.Text = "script by - codecraftlua"
credit.Size = UDim2.new(1, -20, 0, 20)
credit.Position = UDim2.new(0, 10, 1, -30)
credit.BackgroundTransparency = 1
credit.TextStrokeTransparency = 0.8
credit.TextScaled = true
credit.Font = Enum.Font.GothamBold
credit.Parent = mainFrame

spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			local r = math.sin(2 * math.pi * i)
			local g = math.sin(2 * math.pi * i + 2)
			local b = math.sin(2 * math.pi * i + 4)
			credit.TextColor3 = Color3.new((r+1)/2, (g+1)/2, (b+1)/2)
			wait(0.05)
		end
	end
end)

local tabBar = Instance.new("Frame", mainFrame)
tabBar.Size = UDim2.new(0, 130, 0, 30)
tabBar.Position = UDim2.new(0, 0, 0, 50)
tabBar.BackgroundTransparency = 1

local mainTabBtn = Instance.new("TextButton", tabBar)
mainTabBtn.Size = UDim2.new(0, 130, 0, 30)
mainTabBtn.Text = "Main"
mainTabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainTabBtn.TextColor3 = Color3.new(1, 1, 1)
mainTabBtn.Font = Enum.Font.Gotham
mainTabBtn.TextSize = 14

local moreTabBtn = mainTabBtn:Clone()
moreTabBtn.Text = "More Featured"
moreTabBtn.Position = UDim2.new(0, 0, 0, 35)
moreTabBtn.Parent = tabBar

local mainPage = Instance.new("Frame", mainFrame)
mainPage.Size = UDim2.new(1, 0, 1, -90)
mainPage.Position = UDim2.new(0, 0, 0, 90)
mainPage.BackgroundTransparency = 1

local morePage = mainPage:Clone()
morePage.Visible = false
morePage.Parent = mainFrame

mainTabBtn.MouseButton1Click:Connect(function()
	mainPage.Visible = true
	morePage.Visible = false
end)

moreTabBtn.MouseButton1Click:Connect(function()
	mainPage.Visible = false
	morePage.Visible = true
end)

function tp(pos)
	Player.Character:PivotTo(CFrame.new(pos))
end

local slapOptions = {
	{"Slap Cheol-su", Vector3.new(106, -216, -339)},
	{"Slap Young-he", Vector3.new(123, -216, -341)},
	{"Slap Red Paper", Vector3.new(184, -216, -328)},
	{"Slap Blue Paper", Vector3.new(203, -216, -327)},
	{"Huge Slap", Vector3.new(118, -216, 66)},
	{"Slap Golden", Vector3.new(-75, 184, 43)},
}

for i, data in ipairs(slapOptions) do
	local btn = Instance.new("TextButton", mainPage)
	btn.Size = UDim2.new(0, 200, 0, 25)
	btn.Position = UDim2.new(0, 20, 0, 10 + (i - 1) * 30)
	btn.Text = data[1]
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)

	btn.MouseButton1Click:Connect(function()
		local lastPos = HRP.Position
		tp(data[2])
		wait(1)
		tp(lastPos)
	end)
end

local autoPos = {
	{"🏆 Auto Win", Vector3.new(-83, 197, 8)},
	{"👑 Auto King Slap", Vector3.new(47, -216, 50)}
}

for i, data in ipairs(autoPos) do
	local btn = Instance.new("TextButton", mainPage)
	btn.Position = UDim2.new(0, 250, 0, 10 + (i - 1) * 40)
	btn.Size = UDim2.new(0, 250, 0, 30)
	btn.Text = data[1]
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	Instance.new("UICorner", btn)
	btn.MouseButton1Click:Connect(function()
		while true do tp(data[2]) wait(1) end
	end)
end

local btnRebirth = Instance.new("TextButton", mainPage)
btnRebirth.Position = UDim2.new(0, 250, 0, 90)
btnRebirth.Size = UDim2.new(0, 250, 0, 30)
btnRebirth.Text = "♻️ Auto Rebirth"
btnRebirth.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
btnRebirth.TextColor3 = Color3.fromRGB(255, 255, 255)
btnRebirth.Font = Enum.Font.Gotham
btnRebirth.TextSize = 14
Instance.new("UICorner", btnRebirth)

btnRebirth.MouseButton1Click:Connect(function()
	while true do
		game:GetService("ReplicatedStorage"):WaitForChild("Rebirth"):FireServer()
		wait(1)
	end
end)

local secrets = {
	Vector3.new(98, -215, 188),
	Vector3.new(312, -226, 48),
	Vector3.new(133, -260, -1),
	Vector3.new(-15, 51, 763),
	Vector3.new(-683, -11, 140)
}

local btnSecret = btnRebirth:Clone()
btnSecret.Position = UDim2.new(0, 250, 0, 130)
btnSecret.Text = "🔐 Auto Secret 1-5"
btnSecret.Parent = mainPage
btnSecret.MouseButton1Click:Connect(function()
	while true do
		for _, pos in ipairs(secrets) do
			tp(pos)
			wait(1)
		end
	end
end)

local infJumpBtn = Instance.new("TextButton", morePage)
infJumpBtn.Size = UDim2.new(0, 200, 0, 30)
infJumpBtn.Position = UDim2.new(0, 20, 0, 20)
infJumpBtn.Text = "🕊️ Inf Jump"
infJumpBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
infJumpBtn.TextColor3 = Color3.new(1,1,1)
infJumpBtn.Font = Enum.Font.Gotham
infJumpBtn.TextSize = 14
Instance.new("UICorner", infJumpBtn)

infJumpBtn.MouseButton1Click:Connect(function()
	local UIS = game:GetService("UserInputService")
	UIS.JumpRequest:Connect(function()
		Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
	end)
end)

local noclipBtn = infJumpBtn:Clone()
noclipBtn.Text = "🧱 Noclip"
noclipBtn.Position = UDim2.new(0, 20, 0, 60)
noclipBtn.Parent = morePage
noclipBtn.MouseButton1Click:Connect(function()
	game:GetService("RunService").Stepped:Connect(function()
		for _, part in pairs(Player.Character:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = false end
		end
	end)
end)

local tpToolBtn = infJumpBtn:Clone()
tpToolBtn.Text = "🛠️ TP Tool"
tpToolBtn.Position = UDim2.new(0, 20, 0, 100)
tpToolBtn.Parent = morePage
tpToolBtn.MouseButton1Click:Connect(function()
	local tool = Instance.new("Tool", Player.Backpack)
	tool.RequiresHandle = false
	tool.Name = "TP Tool"
	tool.Activated:Connect(function()
		local mouse = Player:GetMouse()
		if mouse.Target then
			Player.Character:MoveTo(mouse.Hit.p)
		end
	end)
end)
