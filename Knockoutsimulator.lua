-- UI GetKey System by Luminaprojects
local validKeys = {
	"D16pDiH2heS32J6", "GtoulAzqiIsw8rm", "lt4Hl7GCrars5Nk", "MadeBtl7gaxGOS1",
	"OUqvSVb9Oyn8tTa", "RMdfh2v7zERkDJA", "nUVBUo01xWn0ocx", "NzQ1YoSeR99Uu6n",
	"meT5FOsr4EW5LMR", "Ye5r4yqAQm29IKI", "OWoSUGJsw8KhgS5", "kYBMrT1eC6DmcB2",
	"qyDKzINBeaZbNoP", "rWM5CiKehOAVtjc", "QJuidkVwCX8IZLV", "YgSzsCHciYpEmHb",
	"wuOIOaWTbtwB9DK", "p6EwjxKaWsWXeMd", "kFKpkSPnonpDraX", "FVqxJVYgzYdqjuM",
	"V5822B1KdbW8mCT", "cMKfpfn26abHcbr", "9q6QADYon8r3ZqG", "oa3bBfdmBREfsOA",
	"yZnsypKFZn5z7Vi", "GJx5MUe80QkN8kf", "xv1sSlP5eyc33bA", "tdI4F1Btqml7NrA",
	"JD5j7L57hpceySE", "p1LjEhfmuE5vzbw"
}

local storedKey, storedTime = nil, nil
local duration = 3600 -- 1 jam (3600 detik)

local function isKeyValid(k)
	for _, v in ipairs(validKeys) do
		if k == ("CodeCraftLuaKey_"..v.."_codecraftlua") then
			return true
		end
	end
	return false
end

-- UI
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "KeySystemUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 200)
frame.Position = UDim2.new(0.5, -200, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local uicorner = Instance.new("UICorner", frame)
uicorner.CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🔐 Enter Your Key"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255,255,255)

local input = Instance.new("TextBox", frame)
input.Position = UDim2.new(0.05, 0, 0.35, 0)
input.Size = UDim2.new(0.9, 0, 0, 35)
input.PlaceholderText = "CodeCraftLuaKey_ExampleKey"
input.Text = ""
input.Font = Enum.Font.Gotham
input.TextColor3 = Color3.new(1,1,1)
input.BackgroundColor3 = Color3.fromRGB(40,40,40)
input.ClearTextOnFocus = false
Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)

local statusLabel = Instance.new("TextLabel", frame)
statusLabel.Position = UDim2.new(0, 0, 0.65, 0)
statusLabel.Size = UDim2.new(1, 0, 0, 25)
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.new(1, 0.4, 0.4)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 14

local checkButton = Instance.new("TextButton", frame)
checkButton.Text = "✅ Check Key"
checkButton.Position = UDim2.new(0.05, 0, 0.8, 0)
checkButton.Size = UDim2.new(0.4, 0, 0, 30)
checkButton.BackgroundColor3 = Color3.fromRGB(60, 130, 250)
checkButton.TextColor3 = Color3.new(1,1,1)
checkButton.Font = Enum.Font.GothamBold
Instance.new("UICorner", checkButton).CornerRadius = UDim.new(0, 6)

local getKeyBtn = Instance.new("TextButton", frame)
getKeyBtn.Text = "🔑 GetKey"
getKeyBtn.Position = UDim2.new(0.55, 0, 0.8, 0)
getKeyBtn.Size = UDim2.new(0.4, 0, 0, 30)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(70, 200, 100)
getKeyBtn.TextColor3 = Color3.new(1,1,1)
getKeyBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", getKeyBtn).CornerRadius = UDim.new(0, 6)

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Text = "❌"
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

-- Events
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

getKeyBtn.MouseButton1Click:Connect(function()
	setclipboard("https://getkey-iota.vercel.app/")
	statusLabel.Text = "✅ Link copied to clipboard!"
	statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
end)

checkButton.MouseButton1Click:Connect(function()
	local inputKey = input.Text
	if isKeyValid(inputKey) then
		storedKey = inputKey
		storedTime = tick()
		statusLabel.Text = "✅ Key Valid! Opening UI..."
		statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
		wait(1)
		gui:Destroy()
		-- 🟩 Load Main UI
		loadstring(game:HttpGet("https://raw.githubusercontent.com/CodeCraftLua/Script/refs/heads/main/Knowout%20Simulator.lua"))()
	else
		statusLabel.Text = "❌ Invalid or Expired Key"
		statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
	end
end)

-- Auto-check expired
spawn(function()
	while wait(5) do
		if storedTime and tick() - storedTime > duration then
			storedKey = nil
			storedTime = nil
			warn("Key expired. Please get a new one.")
			gui.Enabled = true
		end
	end
end)
