local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- UI
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.ResetOnSpawn = false
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 300, 0, 200)
Main.Position = UDim2.new(0.5, -150, 0.5, -100)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 4
Main.Active = true
Main.Draggable = true

-- RGB Border + Title
local RGBColor = 0
game:GetService("RunService").RenderStepped:Connect(function()
	RGBColor = RGBColor + 1
	local color = Color3.fromHSV((RGBColor % 360) / 360, 1, 1)
	Main.BorderColor3 = color
end)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "-(Impossible Glass Bridge Obby!)-"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18
Title.TextColor3 = Color3.new(1, 1, 1)

-- RGB Title
game:GetService("RunService").RenderStepped:Connect(function()
	local color = Color3.fromHSV((tick() * 60 % 360) / 360, 1, 1)
	Title.TextColor3 = color
end)

-- Toggle Button (⚙️)
local Toggle = Instance.new("TextButton", ScreenGui)
Toggle.Size = UDim2.new(0, 40, 0, 40)
Toggle.Position = UDim2.new(0, 10, 0, 10)
Toggle.Text = "⚙️"
Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Toggle.TextColor3 = Color3.new(1, 1, 1)
Toggle.Font = Enum.Font.GothamBold
Toggle.TextSize = 20

Toggle.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

-- Teleport Button
local TPButton = Instance.new("TextButton", Main)
TPButton.Size = UDim2.new(0.8, 0, 0, 40)
TPButton.Position = UDim2.new(0.1, 0, 0.5, -20)
TPButton.Text = "Teleport"
TPButton.Font = Enum.Font.GothamBold
TPButton.TextSize = 18
TPButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
TPButton.TextColor3 = Color3.new(1, 1, 1)

local toggled = false
TPButton.MouseButton1Click:Connect(function()
	toggled = not toggled
	if toggled then
		TPButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
		task.wait(2)
		LocalPlayer.Character:MoveTo(Vector3.new(1091, 61, 111))
	else
		TPButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
	end
end)

-- Credit
local Credit = Instance.new("TextLabel", Main)
Credit.Size = UDim2.new(1, 0, 0, 25)
Credit.Position = UDim2.new(0, 0, 1, -25)
Credit.BackgroundTransparency = 1
Credit.Text = "-(Script by riko)-"
Credit.Font = Enum.Font.Gotham
Credit.TextSize = 14
Credit.TextColor3 = Color3.new(1, 1, 1)

-- RGB Credit
game:GetService("RunService").RenderStepped:Connect(function()
	local color = Color3.fromHSV((tick() * 60 % 360) / 360, 1, 1)
	Credit.TextColor3 = color
end)
