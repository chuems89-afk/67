-- Bee Merchant Sniper - Target Seleccionable + Spam Rápido
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local ITEMS = {
	"Bumbatron",
	"S'more Serat",
	"Queen Bee",
	"Honey Honey Bear",
	"Conetto Morsetto"
}

local AUTO_SNIPE = false
local CURRENT_TARGET = "Bumbatron"
local selectedIndex = 1

-- ====================== GUI ======================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BeeMerchantSniper"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 240, 0, 168)
Main.Position = UDim2.new(1, -260, 0.35, 0)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new("UIStroke", Main)
stroke.Color = Color3.fromRGB(255, 185, 0)
stroke.Thickness = 1.6

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 26)
Title.BackgroundTransparency = 1
Title.Text = "Bee Merchant Sniper"
Title.TextColor3 = Color3.fromRGB(255, 185, 0)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold

local Sub = Instance.new("TextLabel", Main)
Sub.Size = UDim2.new(1, -12, 0, 16)
Sub.Position = UDim2.new(0, 6, 0, 24)
Sub.BackgroundTransparency = 1
Sub.Text = "Auto buy + Spam"
Sub.TextColor3 = Color3.fromRGB(170, 170, 170)
Sub.TextSize = 11
Sub.Font = Enum.Font.Gotham
Sub.TextXAlignment = Enum.TextXAlignment.Left

-- Toggle Auto Snipe
local ToggleBtn = Instance.new("TextButton", Main)
ToggleBtn.Size = UDim2.new(0, 110, 0, 28)
ToggleBtn.Position = UDim2.new(0, 10, 0, 48)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
ToggleBtn.Text = "Auto Snipe"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 13
ToggleBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)

-- Botón para cambiar Target
local ChangeTargetBtn = Instance.new("TextButton", Main)
ChangeTargetBtn.Size = UDim2.new(0, 100, 0, 28)
ChangeTargetBtn.Position = UDim2.new(0, 130, 0, 48)
ChangeTargetBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
ChangeTargetBtn.Text = "Cambiar Target"
ChangeTargetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ChangeTargetBtn.TextSize = 12
ChangeTargetBtn.Font = Enum.Font.Gotham
Instance.new("UICorner", ChangeTargetBtn).CornerRadius = UDim.new(0, 6)

local TargetLabel = Instance.new("TextLabel", Main)
TargetLabel.Size = UDim2.new(1, -20, 0, 20)
TargetLabel.Position = UDim2.new(0, 10, 0, 88)
TargetLabel.BackgroundTransparency = 1
TargetLabel.Text = "Target: Bumbatron"
TargetLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
TargetLabel.TextSize = 14
TargetLabel.Font = Enum.Font.GothamBold
TargetLabel.TextXAlignment = Enum.TextXAlignment.Left

local StatusLabel = Instance.new("TextLabel", Main)
StatusLabel.Size = UDim2.new(1, -20, 0, 18)
StatusLabel.Position = UDim2.new(0, 10, 0, 115)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Idle"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 12
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

local InfoLabel = Instance.new("TextLabel", Main)
InfoLabel.Size = UDim2.new(1, -20, 0, 16)
InfoLabel.Position = UDim2.new(0, 10, 0, 140)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "Click 'Cambiar Target' para ciclar"
InfoLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
InfoLabel.TextSize = 11
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left

-- ====================== FUNCIONES ======================
local function UpdateUI()
	TargetLabel.Text = "Target: " .. CURRENT_TARGET

	if AUTO_SNIPE then
		ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 70)
		ToggleBtn.Text = "Auto Snipe ON"
		StatusLabel.Text = "Status: Sniping " .. CURRENT_TARGET
		StatusLabel.TextColor3 = Color3.fromRGB(0, 220, 90)
	else
		ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
		ToggleBtn.Text = "Auto Snipe"
		StatusLabel.Text = "Status: Idle"
		StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
	end
end

ToggleBtn.MouseButton1Click:Connect(function()
	AUTO_SNIPE = not AUTO_SNIPE
	UpdateUI()
end)

ChangeTargetBtn.MouseButton1Click:Connect(function()
	selectedIndex = selectedIndex + 1
	if selectedIndex > #ITEMS then
		selectedIndex = 1
	end
	CURRENT_TARGET = ITEMS[selectedIndex]
	UpdateUI()
end)

local function FindButton(text)
	text = string.lower(text)
	for _, v in pairs(PlayerGui:GetDescendants()) do
		if v:IsA("TextButton") and v.Visible and v.AbsoluteSize.X > 8 then
			local btnText = string.lower(v.Text or "")
			if string.find(btnText, text) then
				return v
			end
		end
	end
	return nil
end

local function FastClick(button)
	if not button then return end
	pcall(function()
		for _, conn in pairs(getconnections(button.MouseButton1Click)) do
			conn:Fire()
		end
		button:Activate()
	end)
end

-- ====================== LOOP ULTRA RÁPIDO + SPAM ======================
task.spawn(function()
	while true do
		if AUTO_SNIPE then
			-- Intentar abrir tienda
			local openBtn = FindButton("shop") or FindButton("bee") or FindButton("merchant") or FindButton("view")
			if openBtn then
				FastClick(openBtn)
			end

			-- Spam del target seleccionado (muy agresivo)
			local buyBtn = FindButton(CURRENT_TARGET)
