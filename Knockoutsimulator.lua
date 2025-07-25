-- UI GetKey System by Luminaprojects x CodeCraftLua
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ValidKeys = {
	"D16pDiH2heS32J6", "GtoulAzqiIsw8rm", "lt4Hl7GCrars5Nk", "MadeBtl7gaxGOS1",
	"OUqvSVb9Oyn8tTa", "RMdfh2v7zERkDJA", "nUVBUo01xWn0ocx", "NzQ1YoSeR99Uu6n",
	"meT5FOsr4EW5LMR", "Ye5r4yqAQm29IKI", "OWoSUGJsw8KhgS5", "kYBMrT1eC6DmcB2",
	"qyDKzINBeaZbNoP", "rWM5CiKehOAVtjc", "QJuidkVwCX8IZLV", "YgSzsCHciYpEmHb",
	"wuOIOaWTbtwB9DK", "p6EwjxKaWsWXeMd", "kFKpkSPnonpDraX", "FVqxJVYgzYdqjuM",
	"V5822B1KdbW8mCT", "cMKfpfn26abHcbr", "9q6QADYon8r3ZqG", "oa3bBfdmBREfsOA",
	"yZnsypKFZn5z7Vi", "GJx5MUe80QkN8kf", "xv1sSlP5eyc33bA", "tdI4F1Btqml7NrA",
	"JD5j7L57hpceySE", "p1LjEhfmuE5vzbw"
}

local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "CodeCraftLuaKeyUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Position = UDim2.new(0.35, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 340, 0, 180)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Frame)
Title.Text = "🔐 CodeCraftLua Key System"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

local Close = Instance.new("TextButton", Frame)
Close.Text = "✖"
Close.Size = UDim2.new(0, 25, 0, 25)
Close.Position = UDim2.new(1, -30, 0, 5)
Close.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.Font = Enum.Font.Gotham
Close.TextSize = 14
Close.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

local InputBox = Instance.new("TextBox", Frame)
InputBox.PlaceholderText = "CodeCraftLuaKey_ExampleKey"
InputBox.Size = UDim2.new(1, -40, 0, 40)
InputBox.Position = UDim2.new(0, 20, 0, 50)
InputBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.Font = Enum.Font.Gotham
InputBox.TextSize = 14

local Button = Instance.new("TextButton", Frame)
Button.Text = "🔓 Verify Key"
Button.Size = UDim2.new(1, -40, 0, 35)
Button.Position = UDim2.new(0, 20, 0, 100)
Button.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 14

Button.MouseButton1Click:Connect(function()
	local text = InputBox.Text
	if string.find(text, "CodeCraftLuaKey_") then
		local key = text:gsub("CodeCraftLuaKey_", "")
		for _, validKey in ipairs(ValidKeys) do
			if key == validKey then
				Button.Text = "✅ Valid Key!"
				Button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
				wait(1)
				ScreenGui:Destroy()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/CodeCraftLua/Script/refs/heads/main/Knowout%20Simulator.lua"))()
				return
			end
		end
	end
	Button.Text = "❌ Invalid or Expired Key!"
	Button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
	wait(1.5)
	Button.Text = "🔓 Verify Key"
	Button.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
end)
