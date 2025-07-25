local Players          = game:GetService("Players")
local ReplicatedStorage= game:GetService("ReplicatedStorage")
local LocalPlayer      = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "KnockoutUI"
ScreenGui.ResetOnSpawn = false

local main = Instance.new("Frame", ScreenGui)
main.Size            = UDim2.new(0, 320, 0, 220)
main.Position        = UDim2.new(0.5, -160, 0.5, -110)
main.BackgroundColor3= Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.Visible         = false
main.Active          = true
main.Draggable       = true

local UIStroke = Instance.new("UIStroke", main)
UIStroke.Thickness = 2
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			UIStroke.Color = Color3.fromHSV(i, 1, 1)
			wait()
		end
	end
end)

local toggleBtn = Instance.new("TextButton", ScreenGui)
toggleBtn.Size            = UDim2.new(0, 30, 0, 30)
toggleBtn.Position        = UDim2.new(0.5, -15, 0.5, -145)
toggleBtn.Text            = ">"
toggleBtn.TextScaled      = true
toggleBtn.BackgroundColor3= Color3.fromRGB(40, 40, 40)
toggleBtn.TextColor3      = Color3.fromRGB(255, 255, 255)
toggleBtn.BorderSizePixel = 0

toggleBtn.MouseButton1Click:Connect(function()
	main.Visible    = not main.Visible
	toggleBtn.Text  = main.Visible and "<" or ">"
end)

local title = Instance.new("TextLabel", main)
title.Size              = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.Text              = "Knockout Simulator"
title.TextScaled        = true
title.TextColor3        = Color3.fromRGB(255, 255, 255)
title.Font              = Enum.Font.GothamBold

local winBox = Instance.new("TextBox", main)
winBox.Size              = UDim2.new(0, 280, 0, 30)
winBox.Position          = UDim2.new(0, 20, 0, 50)
winBox.PlaceholderText   = "Enter Win Amount"
winBox.TextColor3        = Color3.fromRGB(255, 255, 255)
winBox.BackgroundColor3  = Color3.fromRGB(30, 30, 30)
winBox.BorderSizePixel   = 0

local winButton = Instance.new("TextButton", main)
winButton.Size            = UDim2.new(0, 280, 0, 30)
winButton.Position        = UDim2.new(0, 20, 0, 90)
winButton.Text            = "Modif"
winButton.TextColor3      = Color3.fromRGB(255, 255, 255)
winButton.BackgroundColor3= Color3.fromRGB(50, 50, 50)
winButton.BorderSizePixel = 0

local trainBox = Instance.new("TextBox", main)
trainBox.Size             = UDim2.new(0, 280, 0, 30)
trainBox.Position         = UDim2.new(0, 20, 0, 130)
trainBox.PlaceholderText  = "Enter Train Amount"
trainBox.TextColor3       = Color3.fromRGB(255, 255, 255)
trainBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
trainBox.BorderSizePixel  = 0

local trainButton = Instance.new("TextButton", main)
trainButton.Size           = UDim2.new(0, 280, 0, 30)
trainButton.Position       = UDim2.new(0, 20, 0, 170)
trainButton.Text           = "Modif"
trainButton.TextColor3     = Color3.fromRGB(255, 255, 255)
trainButton.BackgroundColor3= Color3.fromRGB(50, 50, 50)
trainButton.BorderSizePixel = 0

local function fireRemote(eventName, amount)
	local val = tonumber(amount)
	if val then
		local args = { val }
		ReplicatedStorage:WaitForChild("Event"):WaitForChild(eventName):FireServer(unpack(args))
	end
end

winBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		fireRemote("WinGain", winBox.Text)
	end
end)
trainBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		fireRemote("Train", trainBox.Text)
	end
end)

winButton.MouseButton1Click:Connect(function()
	fireRemote("WinGain", winBox.Text)
end)
trainButton.MouseButton1Click:Connect(function()
	fireRemote("Train", trainBox.Text)
end)

local credit = Instance.new("TextLabel", ScreenGui)
credit.Size              = UDim2.new(0, 300, 0, 20)
credit.Position          = UDim2.new(0.5, -150, 0.5, 125)
credit.BackgroundTransparency = 1
credit.Text              = "script by - codecraftlua"
credit.TextScaled        = true
credit.Font              = Enum.Font.GothamBold

spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			credit.TextColor3 = Color3.fromHSV(i, 1, 1)
			wait()
		end
	end
end)

