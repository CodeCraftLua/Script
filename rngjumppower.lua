local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "RNGJumpPowerUI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 280, 0, 240)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 2
MainFrame.Active = true
MainFrame.Draggable = true

spawn(function()
	while true do
		for i = 0, 255, 4 do
			MainFrame.BorderColor3 = Color3.fromHSV(i / 255, 1, 1)
			wait()
		end
	end
end)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "RNG JUMPPOWER 🤾"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

spawn(function()
	while true do
		for i = 0, 255, 4 do
			Title.TextColor3 = Color3.fromHSV(i / 255, 1, 1)
			wait()
		end
	end
end)

local JumpInput = Instance.new("TextBox", MainFrame)
JumpInput.Position = UDim2.new(0.1, 0, 0.3, 0)
JumpInput.Size = UDim2.new(0.8, 0, 0, 30)
JumpInput.PlaceholderText = "Masukkan JumpPower"
JumpInput.Text = ""
JumpInput.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
JumpInput.TextColor3 = Color3.new(1,1,1)
JumpInput.Font = Enum.Font.Gotham
JumpInput.TextSize = 14

JumpInput.FocusLost:Connect(function()
	local val = tonumber(JumpInput.Text)
	if val then
		LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = val
	end
end)

local TPButton = Instance.new("TextButton", MainFrame)
TPButton.Position = UDim2.new(0.1, 0, 0.55, 0)
TPButton.Size = UDim2.new(0.8, 0, 0, 30)
TPButton.Text = "250K WIN 🏆"
TPButton.BackgroundColor3 = Color3.fromRGB(60, 90, 60)
TPButton.TextColor3 = Color3.new(1,1,1)
TPButton.Font = Enum.Font.GothamBold
TPButton.TextSize = 14

TPButton.MouseButton1Click:Connect(function()
	task.wait(2)
	LocalPlayer.Character:MoveTo(Vector3.new(895, 40, -131))
end)

local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 100, 0, 30)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -15)
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleButton.Text = "🎭"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 16

ToggleButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

local Credit = Instance.new("TextLabel", MainFrame)
Credit.Size = UDim2.new(1, 0, 0, 25)
Credit.Position = UDim2.new(0, 0, 1, -25)
Credit.BackgroundTransparency = 1
Credit.Text = "Script By - CraftCodeLua"
Credit.Font = Enum.Font.Gotham
Credit.TextSize = 13
Credit.TextColor3 = Color3.new(1,1,1)

spawn(function()
	while true do
		for i = 0, 255, 4 do
			Credit.TextColor3 = Color3.fromHSV(i / 255, 1, 1)
			wait()
		end
	end
end)
