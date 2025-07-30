-- UI Modern Loadstring by Riko

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")
local RGBBorder = Instance.new("UIStroke")
local credit = Instance.new("TextLabel")

local UIS = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

-- Drag Function
Frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Frame.Position
	end
end)

Frame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- Base UI
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 250, 0, 380)
Frame.Active = true

-- RGB Border
RGBBorder.Parent = Frame
RGBBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
RGBBorder.Thickness = 2
RGBBorder.Color = Color3.fromRGB(255, 0, 0)

-- RGB Anim
coroutine.wrap(function()
	local hue = 0
	while wait() do
		hue = (hue + 1) % 255
		RGBBorder.Color = Color3.fromHSV(hue/255, 1, 1)
	end
end)()

-- Title
Title.Name = "Title"
Title.Parent = Frame
Title.Text = "📜 HACK KILLER"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

-- Credit
credit.Parent = Frame
credit.Text = "- (Script by riko) -"
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 1, -20)
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.fromRGB(170, 170, 255)
credit.Font = Enum.Font.Gotham
credit.TextSize = 14

-- Close Button
CloseBtn.Name = "Close"
CloseBtn.Parent = Frame
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

-- Toggle Creator
local toggleY = 40
local function createToggle(text, callback)
	local toggle = Instance.new("TextButton")
	toggle.Parent = Frame
	toggle.Size = UDim2.new(0.9, 0, 0, 30)
	toggle.Position = UDim2.new(0.05, 0, 0, toggleY)
	toggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	toggle.Text = text
	toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	toggle.Font = Enum.Font.GothamBold
	toggle.TextSize = 14
	toggle.AutoButtonColor = false

	local state = false
	toggle.MouseButton1Click:Connect(function()
		state = not state
		toggle.BackgroundColor3 = state and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
		pcall(callback, state)
	end)

	toggleY = toggleY + 35
end

-- Add your scripts below
createToggle("Killer x3", function(on)
	if on then
		-- script killer 3x
	end
end)

createToggle("Player Name ESP", function(on)
	if on then
		-- ESP Name
	end
end)

createToggle("Player Box ESP", function(on)
	if on then
		-- Box ESP
	end
end)

createToggle("Loot Name ESP", function(on)
	if on then
		-- Loot ESP
	end
end)

createToggle("Remove Fog", function(on)
	if on then
		game.Lighting.FogEnd = 100000
	end
end)

createToggle("Field of View", function(on)
	if on then
		game.Workspace.CurrentCamera.FieldOfView = 120
	else
		game.Workspace.CurrentCamera.FieldOfView = 70
	end
end)

createToggle("Double Jump Gamepass", function(on)
	if on then
		local plr = game.Players.LocalPlayer
		local char = plr.Character or plr.CharacterAdded:Wait()
		local hum = char:WaitForChild("Humanoid")
		hum.UseJumpPower = true
	end
end)

createToggle("Infinite Jump", function(on)
	if on then
		_G.InfJump = true
		game:GetService("UserInputService").JumpRequest:Connect(function()
			if _G.InfJump then
				game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
			end
		end)
	else
		_G.InfJump = false
	end
end)

createToggle("Enable WalkSpeed", function(on)
	if on then
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 32
	else
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
	end
end)

createToggle("Speed Walk", function(on)
	if on then
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 80
	else
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
	end
end)
