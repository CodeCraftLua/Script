local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "🎯 AimbotUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") -- Compatible with Delta

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 230, 0, 160)
MainFrame.Position = UDim2.new(0.5, -115, 0.5, -80)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

local Title = Instance.new("TextLabel")
Title.Text = "🎯 Aimbot UI"
Title.Size = UDim2.new(1, 0, 0, 25)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = MainFrame

local Close = Instance.new("TextButton")
Close.Text = "🎭"
Close.Size = UDim2.new(0, 30, 0, 25)
Close.Position = UDim2.new(1, -30, 0, 0)
Close.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Close.TextColor3 = Color3.new(1, 1, 1)
Close.Parent = MainFrame

local isClosed = false
Close.MouseButton1Click:Connect(function()
	isClosed = not isClosed
	MainFrame.Visible = not isClosed
end)



local AimbotEnabled = true
local SelectedPart = "HumanoidRootPart" -- Options: Head, HumanoidRootPart, LeftFoot
local FOVRadius = 80
local TeamCheck = true
local WallCheck = true

local fovCircle = Drawing.new("Circle")
fovCircle.Radius = FOVRadius
fovCircle.Thickness = 1.5
fovCircle.Filled = false
fovCircle.Color = Color3.fromRGB(255, 255, 255)
fovCircle.Visible = true

local function IsVisible(part)
	local origin = Camera.CFrame.Position
	local direction = (part.Position - origin).Unit * 1000
	local result = workspace:Raycast(origin, direction, RaycastParams.new())
	if result and result.Instance:IsDescendantOf(part.Parent) then
		return true
	end
	return false
end

local function GetClosest()
	local closest, distance = nil, math.huge
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(SelectedPart) then
			if TeamCheck and player.Team == LocalPlayer.Team then continue end
			local part = player.Character[SelectedPart]
			if WallCheck and not IsVisible(part) then continue end

			local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
			local mousePos = UserInputService:GetMouseLocation()
			local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(mousePos.X, mousePos.Y)).Magnitude
			if mag < FOVRadius and mag < distance then
				distance = mag
				closest = part
			end
		end
	end
	return closest
end

RunService.RenderStepped:Connect(function()
	fovCircle.Position = UserInputService:GetMouseLocation()
	fovCircle.Radius = FOVRadius

	if AimbotEnabled then
		local target = GetClosest()
		if target then
			Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
		end
	end
end)

print("Aimbot UI Loaded!")
