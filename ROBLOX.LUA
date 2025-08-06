-- Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local HighlightTable = {}

-- Highlight maker
local function createHighlight(obj,color)
  local h=Instance.new("Highlight")
  h.Adornee=obj
  h.FillColor=color
  h.FillTransparency=0.5
  h.OutlineColor=Color3.new(0,0,0)
  h.OutlineTransparency=0
  h.Parent=CoreGui
  table.insert(HighlightTable,h)
end
local function removeHighlights()
  for _,h in ipairs(HighlightTable) do h:Destroy() end
  HighlightTable = {}
end

-- State toggles
local state = {onPemain=false,onMusuh=false,onItem=false}

-- GUI Setup
local ScreenGui=Instance.new("ScreenGui",CoreGui);ScreenGui.Name="EspLuaUI";ScreenGui.ResetOnSpawn=false
local Main=Instance.new("Frame",ScreenGui);Main.Size=UDim2.new(0,260,0,340);Main.Position=UDim2.new(0.5,-130,0.5,-170)
Main.BackgroundColor3=Color3.fromRGB(25,25,35);Main.ClipsDescendants=true
local grad=Instance.new("UIGradient",Main)
grad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(85,0,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,170,255))})
task.spawn(function() while task.wait() do grad.Rotation+=1 end end)
Instance.new("UICorner",Main).CornerRadius=UDim.new(0,10)
local title=Instance.new("TextLabel",Main)
title.Size=UDim2.new(1,0,0,30);title.Text="🔍 Esp Lua STK";title.Font=Enum.Font.GothamBold;title.TextSize=16
title.TextColor3=Color3.new(1,1,1);title.BackgroundTransparency=1

-- Close & minimize
local close=Instance.new("TextButton",Main)
close.Size=UDim2.new(0,30,0,30);close.Position=UDim2.new(1,-30,0,0)
close.Text="❌";close.Font=Enum.Font.Gotham;close.TextSize=14;close.BackgroundTransparency=1;close.TextColor3=Color3.new(1,0.3,0)
close.MouseButton1Click:Connect(function()
  removeHighlights()
  ScreenGui:Destroy()
end)
local minBtn=Instance.new("TextButton",Main)
minBtn.Size=UDim2.new(0,30,0,30);minBtn.Position=UDim2.new(1,-60,0,0)
minBtn.Text="➖";minBtn.Font=Enum.Font.Gotham;minBtn.TextSize=14;minBtn.BackgroundTransparency=1;minBtn.TextColor3=Color3.new(0.8,0.8,0.8)
local minimized=false
minBtn.MouseButton1Click:Connect(function()
  minimized = not minimized
  for _,v in ipairs(Main:GetChildren()) do
    if v:IsA("TextButton") and v~=minBtn and v~=close then v.Visible = not minimized end
  end
  Main.Size = minimized and UDim2.new(0,260,0,30) or UDim2.new(0,260,0,340)
end)

-- Utility to build button
local function makeBtn(posY,txt,col,cb)
  local b=Instance.new("TextButton",Main)
  b.Size=UDim2.new(0.9,0,0,30);b.Position=UDim2.new(0.05,0,0,posY)
  b.Text=txt;b.Font=Enum.Font.GothamSemibold;b.TextSize=14;b.BackgroundColor3=col;b.TextColor3=Color3.new(1,1,1)
  Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
  b.MouseButton1Click:Connect(cb)
end

-- Buttons
makeBtn(40,"Toggle Pemain Biasa (Biru)",Color3.fromRGB(50,100,200),function()
  state.onPemain = not state.onPemain; removeHighlights()
end)
makeBtn(80,"Toggle Musuh (Merah)",Color3.fromRGB(180,50,50),function()
  state.onMusuh = not state.onMusuh; removeHighlights()
end)
makeBtn(120,"Toggle Item (Putih/Ungu)",Color3.fromRGB(100,100,100),function()
  state.onItem = not state.onItem; removeHighlights()
end)
makeBtn(160,"Remove All ESP",Color3.fromRGB(60,60,60),removeHighlights)

-- Drag logic
local drag,dragInput,startPos,dragStart
Main.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then
  drag=true;dragStart=i.Position;startPos=Main.Position
  i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then drag=false end end)
end end)
Main.InputChanged:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseMovement then dragInput=i end end)
UIS.InputChanged:Connect(function(i) if i==dragInput and drag then
  local delta=i.Position-dragStart
  Main.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
end end)

-- Loop ESP update setiap frame
task.spawn(function()
  while task.wait(0.5) do
    removeHighlights()
    if state.onPemain then
      for _,p in ipairs(Players:GetPlayers()) do
        if p~=Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
          createHighlight(p.Character,Color3.new(0,0.5,1))
        end
      end
    end
    if state.onMusuh then
      for _,p in ipairs(Players:GetPlayers()) do
        if p~=Players.LocalPlayer and p:GetAttribute("Role")=="Killer" and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
          createHighlight(p.Character,Color3.new(1,0,0))
        end
      end
    end
    if state.onItem then
      for _,v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name=="Loot" then
          -- cek rarity via attribute atau folder
          local rarity = v:GetAttribute("rarity")
          local col = (rarity=="Common") and Color3.new(1,1,1) or Color3.new(0.6,0,1)
          createHighlight(v,col)
        end
      end
    end
  end
end)
