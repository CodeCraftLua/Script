--Версия на русском xd
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

local ScreenGui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
ScreenGui.Name = "KillerUI"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 280)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "Убийственные Лестницы"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1

local Toggle = Instance.new("TextButton", MainFrame)
Toggle.Text = "👁️ Скрыть UI"
Toggle.Size = UDim2.new(1, -20, 0, 30)
Toggle.Position = UDim2.new(0, 10, 0, 45)
Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle.Font = Enum.Font.Gotham
Toggle.TextSize = 14
Toggle.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

local AutoWin = Instance.new("TextButton", MainFrame)
AutoWin.Text = "🎯 Авто Победа"
AutoWin.Size = UDim2.new(1, -20, 0, 30)
AutoWin.Position = UDim2.new(0, 10, 0, 90)
AutoWin.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AutoWin.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoWin.Font = Enum.Font.Gotham
AutoWin.TextSize = 14
AutoWin.MouseButton1Click:Connect(function()
	task.wait(1)
	Player.Character:MoveTo(Vector3.new(-3, 601, -1225))
end)

local WalkInput = Instance.new("TextBox", MainFrame)
WalkInput.PlaceholderText = "Введите скорость ходьбы"
WalkInput.Size = UDim2.new(1, -20, 0, 30)
WalkInput.Position = UDim2.new(0, 10, 0, 130)
WalkInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
WalkInput.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkInput.Font = Enum.Font.Gotham
WalkInput.TextSize = 14
WalkInput.FocusLost:Connect(function()
	Player.Character.Humanoid.WalkSpeed = tonumber(WalkInput.Text)
end)

local JumpInput = Instance.new("TextBox", MainFrame)
JumpInput.PlaceholderText = "Введите силу прыжка"
JumpInput.Size = UDim2.new(1, -20, 0, 30)
JumpInput.Position = UDim2.new(0, 10, 0, 170)
JumpInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
JumpInput.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpInput.Font = Enum.Font.Gotham
JumpInput.TextSize = 14
JumpInput.FocusLost:Connect(function()
	Player.Character.Humanoid.JumpPower = tonumber(JumpInput.Text)
end)

local FlyBtn = Instance.new("TextButton", MainFrame)
FlyBtn.Text = "🚀 Летать"
FlyBtn.Size = UDim2.new(1, -20, 0, 30)
FlyBtn.Position = UDim2.new(0, 10, 0, 210)
FlyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.Font = Enum.Font.Gotham
FlyBtn.TextSize = 14
FlyBtn.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)
