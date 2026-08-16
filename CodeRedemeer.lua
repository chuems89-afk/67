-- // [1] GLOBAL SERVICES // --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local GuiService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- // [2] SHARED CONSTANTS & DATA // --
local SammyDB = {
    ["real name"] = "SAMMY", ["sammy real name"] = "SAMMY", ["sammys real name"] = "SAMMY", ["my real name"] = "SAMMY", ["creator real name"] = "SAMMY", ["owner real name"] = "SAMMY", ["creator name"] = "SAMMY", ["who created sab"] = "SAMMY", ["who made sab"] = "SAMMY", ["who is the owner"] = "SAMMY", ["who owns sab"] = "SAMMY", ["creator"] = "SAMMY", ["owner"] = "SAMMY",
    ["roblox username"] = "SPYDERSAMMY", ["my roblox username"] = "SPYDERSAMMY", ["sammy username"] = "SPYDERSAMMY", ["sammy roblox name"] = "SPYDERSAMMY", ["roblox name"] = "SPYDERSAMMY", ["username"] = "SPYDERSAMMY", ["my username"] = "SPYDERSAMMY",
    ["how old am i"] = "24", ["how old is sammy"] = "24", ["my age"] = "24", ["sammy age"] = "24", ["age"] = "24",
    ["birth year"] = "2002", ["year born"] = "2002", ["year i was born"] = "2002", ["born year"] = "2002",
    ["birth day"] = "FRIDAY", ["day i was born"] = "FRIDAY", ["day born"] = "FRIDAY", ["birthday"] = "FRIDAY", ["born on"] = "FRIDAY",
    ["birth month"] = "FEBRUARY", ["month born"] = "FEBRUARY", ["month i was born"] = "FEBRUARY",
    ["where was i born"] = "ALGERIA", ["where was i born at"] = "ALGERIA", ["birthplace"] = "ALGERIA", ["where i was born"] = "ALGERIA",
    ["where am i from"] = "BRAZIL", ["where is sammy from"] = "BRAZIL", ["my country"] = "BRAZIL", ["sammy country"] = "BRAZIL", ["country"] = "BRAZIL",
    ["where do i live"] = "BRAZIL", ["sammy location"] = "BRAZIL", ["nationality"] = "BRAZILIAN", ["sammy nationality"] = "BRAZILIAN", ["my nationality"] = "BRAZILIAN",
    ["state"] = "SAOPAULO", ["my state"] = "SAOPAULO", ["sammy state"] = "SAOPAULO", ["city"] = "SAOPAULO", ["my city"] = "SAOPAULO", ["sammy city"] = "SAOPAULO",
    ["favorite color"] = "BLUE", ["fav color"] = "BLUE", ["my color"] = "BLUE", ["sammy color"] = "BLUE", ["color"] = "BLUE", ["favourite color"] = "BLUE",
    ["favorite sport"] = "FOOTBALL", ["fav sport"] = "FOOTBALL", ["sport"] = "FOOTBALL", ["my sport"] = "FOOTBALL",
    ["football player"] = "RONALDO", ["favorite player"] = "RONALDO", ["fav player"] = "RONALDO", ["ronaldo"] = "RONALDO",
    ["favorite food"] = "PIZZA", ["fav food"] = "PIZZA", ["my food"] = "PIZZA", ["food"] = "PIZZA",
    ["favorite animal"] = "SPIDER", ["fav animal"] = "SPIDER", ["my animal"] = "SPIDER", ["my pet"] = "SPIDER",
    ["favorite game"] = "ROBLOX", ["fav game"] = "ROBLOX",
    ["social media"] = "YOUTUBE", ["youtube channel"] = "YOUTUBE", ["my youtube"] = "YOUTUBE", ["sammy youtube"] = "YOUTUBE",
    ["game name"] = "STEALABRAINROT", ["name of the game"] = "STEALABRAINROT", ["sab"] = "STEALABRAINROT", ["sab stands for"] = "STEAL A BRAINROT", ["full name"] = "STEAL A BRAINROT",
    ["game created on"] = "MAY162025", ["created on"] = "MAY162025", ["release year"] = "2025", ["year sab was made"] = "2025", ["release month"] = "MAY", ["sab release day"] = "16",
    ["first trait"] = "LIGHTNING", ["1st trait"] = "LIGHTNING", ["first mutation"] = "GOLD", ["second mutation"] = "DIAMOND",
    ["third mutation"] = "BLOODROT", ["fourth mutation"] = "RAINBOW", ["fifth mutation"] = "CANDY", ["sixth mutation"] = "LAVA",
    ["seventh mutation"] = "GALAXY", ["eighth mutation"] = "YINYANG", ["ninth mutation"] = "RADIOACTIVE", ["tenth mutation"] = "CURSED",
    ["eleventh mutation"] = "DIVINE", ["twelfth mutation"] = "CYBER", ["thirteenth mutation"] = "PHANTOM", ["fourteenth mutation"] = "CRYSTAL",
    ["rarest brainrot"] = "STRAWBERRYELEPHANT", ["rarest"] = "STRAWBERRYELEPHANT", ["highest rarity"] = "OG", ["lowest rarity"] = "COMMON"
}

local function normalize(str)
    if type(str) ~= "string" then return "" end
    str = string.lower(str)
    str = string.gsub(str, "[^%w%s]", "")
    str = string.gsub(str, "%s+", " ")
    return (string.match(str, "^%s*(.-)%s*$")) or ""
end

local NormalizedDB = {}
for k, v in pairs(SammyDB) do
    NormalizedDB[normalize(k)] = v
end

-- // [3] RECURSIVE UI CONSTRUCTION (ESTILO NEÓN MORADO & BLANCO) // --
local old = PlayerGui:FindFirstChild("TigysCodeRedeemerPillUI")
if old then old:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TigysCodeRedeemerPillUI"
ScreenGui.DisplayOrder = 8
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Main Pill / Ventana Principal
local PillFrame = Instance.new("Frame")
PillFrame.Name = "PillFrame"
PillFrame.Size = UDim2.new(0, 310, 0, 48)
PillFrame.Position = UDim2.new(0.5, -155, 0, 14)
PillFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
PillFrame.BackgroundTransparency = 0.1
PillFrame.Active = true
PillFrame.Draggable = true
PillFrame.BorderSizePixel = 0
PillFrame.ZIndex = 10
PillFrame.Parent = ScreenGui

local PillCorner = Instance.new("UICorner")
PillCorner.CornerRadius = UDim.new(0, 14)
PillCorner.Parent = PillFrame

-- Borde Neón Morado
local PillStroke = Instance.new("UIStroke")
PillStroke.Color = Color3.fromRGB(170, 0, 255)
PillStroke.Thickness = 2
PillStroke.Parent = PillFrame

-- Status dot
local StatusIndicator = Instance.new("Frame")
StatusIndicator.Name = "StatusIndicator"
StatusIndicator.Size = UDim2.new(0, 11, 0, 11)
StatusIndicator.Position = UDim2.new(0, 14, 0.5, -5.5)
StatusIndicator.BackgroundColor3 = Color3.fromRGB(175, 65, 65)
StatusIndicator.BorderSizePixel = 0
StatusIndicator.ZIndex = 11
StatusIndicator.Parent = PillFrame

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(1, 0)
StatusCorner.Parent = StatusIndicator

-- Title con texto normal y limpio
local PillText = Instance.new("TextLabel")
PillText.Name = "PillText"
PillText.Size = UDim2.new(0, 145, 1, 0)
PillText.Position = UDim2.new(0, 32, 0, 0)
PillText.BackgroundTransparency = 1
PillText.Text = "NEON REDEEMER"
PillText.TextColor3 = Color3.fromRGB(255, 255, 255)
PillText.Font = Enum.Font.GothamBold
PillText.TextSize = 13
PillText.TextXAlignment = Enum.TextXAlignment.Left
PillText.ZIndex = 11
PillText.Parent = PillFrame

-- Stats Badge
local StatsBadge = Instance.new("Frame")
StatsBadge.Name = "StatsBadge"
StatsBadge.Size = UDim2.new(0, 76, 0, 24)
StatsBadge.Position = UDim2.new(1, -162, 0.5, -12)
StatsBadge.BackgroundColor3 = Color3.fromRGB(30, 15, 50)
StatsBadge.BorderSizePixel = 0
StatsBadge.ZIndex = 11
StatsBadge.Parent = PillFrame

local StatsCorner = Instance.new("UICorner")
StatsCorner.CornerRadius = UDim.new(0, 8)
StatsCorner.Parent = StatsBadge

local StatsStroke = Instance.new("UIStroke")
StatsStroke.Color = Color3.fromRGB(200, 50, 255)
StatsStroke.Thickness = 1
StatsStroke.Parent = StatsBadge

local StatsText = Instance.new("TextLabel")
StatsText.Name = "StatsText"
StatsText.Size = UDim2.new(1, 0, 1, 0)
StatsText.BackgroundTransparency = 1
StatsText.Text = "60fps|0ms"
StatsText.TextColor3 = Color3.fromRGB(255, 255, 255)
StatsText.Font = Enum.Font.GothamMedium
StatsText.TextSize = 11
StatsText.TextXAlignment = Enum.TextXAlignment.Center
StatsText.ZIndex = 12
StatsText.Parent = StatsBadge

-- Start button
local StartPillBtn = Instance.new("TextButton")
StartPillBtn.Name = "StartPillBtn"
StartPillBtn.Size = UDim2.new(0, 62, 0, 26)
StartPillBtn.Position = UDim2.new(1, -82, 0.5, -13)
StartPillBtn.BackgroundColor3 = Color3.fromRGB(48, 150, 82)
StartPillBtn.Text = "START"
StartPillBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StartPillBtn.Font = Enum.Font.GothamBold
StartPillBtn.TextSize = 12
StartPillBtn.AutoButtonColor = true
StartPillBtn.BorderSizePixel = 0
StartPillBtn.ZIndex = 11
StartPillBtn.Parent = PillFrame

local StartCorner = Instance.new("UICorner")
StartCorner.CornerRadius = UDim.new(0, 8)
StartCorner.Parent = StartPillBtn

-- Expand Button
local ExpandBtn = Instance.new("TextButton")
ExpandBtn.Name = "ExpandBtn"
ExpandBtn.Size = UDim2.new(0, 24, 0, 24)
ExpandBtn.Position = UDim2.new(1, -28, 0.5, -12)
ExpandBtn.BackgroundColor3 = Color3.fromRGB(30, 15, 50)
ExpandBtn.Text = "▼"
ExpandBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExpandBtn.Font = Enum.Font.GothamBold
ExpandBtn.TextSize = 12
ExpandBtn.AutoButtonColor = true
ExpandBtn.BorderSizePixel = 0
ExpandBtn.ZIndex = 11
ExpandBtn.Parent = PillFrame

local ExpandCorner = Instance.new("UICorner")
ExpandCorner.CornerRadius = UDim.new(0, 8)
ExpandCorner.Parent = ExpandBtn

local ExpandStroke = Instance.new("UIStroke")
ExpandStroke.Color = Color3.fromRGB(200, 50, 255)
ExpandStroke.Thickness = 1
ExpandStroke.Parent = ExpandBtn

-- Tray (Menú Desplegable)
local TrayFrame = Instance.new("Frame")
TrayFrame.Name = "TrayFrame"
TrayFrame.Size = UDim2.new(1, 0, 0, 0)
TrayFrame.Position = UDim2.new(0, 0, 1, 6)
TrayFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
TrayFrame.BackgroundTransparency = 0.05
TrayFrame.ClipsDescendants = true
TrayFrame.Visible = false
TrayFrame.BorderSizePixel = 0
TrayFrame.ZIndex = 9
TrayFrame.Parent = PillFrame

local TrayCorner = Instance.new("UICorner")
TrayCorner.CornerRadius = UDim.new(0, 12)
TrayCorner.Parent = TrayFrame

local TrayStroke = Instance.new("UIStroke")
TrayStroke.Color = Color3.fromRGB(170, 0, 255)
TrayStroke.Thickness = 2
TrayStroke.Transparency = 0.2
TrayStroke.Parent = TrayFrame

local TrayInner = Instance.new("Frame")
TrayInner.Name = "TrayInner"
TrayInner.Size = UDim2.new(1, -16, 1, -16)
TrayInner.Position = UDim2.new(0, 8, 0, 8)
TrayInner.BackgroundTransparency = 1
TrayInner.ZIndex = 10
TrayInner.Parent = TrayFrame

local ModeListContainer = Instance.new("Frame")
ModeListContainer.Name = "ModeListContainer"
ModeListContainer.Size = UDim2.new(1, 0, 0, 180)
ModeListContainer.BackgroundTransparency = 1
ModeListContainer.ZIndex = 11
ModeListContainer.Parent = TrayInner

local ModeListLayout = Instance.new("UIListLayout")
ModeListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ModeListLayout.Padding = UDim.new(0, 6)
ModeListLayout.Parent = ModeListContainer

local function createModeButton(text, order)
    local btn = Instance.new("TextButton")
    btn.Name = text:gsub("[^%w]", "")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(30, 15, 50)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 12
    btn.AutoButtonColor = true
    btn.BorderSizePixel = 0
    btn.LayoutOrder = order
    btn.ZIndex = 12
    btn.Parent = ModeListContainer
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = btn
    
    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(170, 0, 255)
    s.Thickness = 1
    s.Parent = btn
    
    return btn
end

local AutoRiddleBtn = createModeButton("AUTO RIDDLE: OFF", 1)
local Msg1Btn = createModeButton("1 Message", 2)
local Msg2Btn = createModeButton("2 Messages", 3)
local Msg3Btn = createModeButton("3 Messages", 4)
local Msg4Btn = createModeButton("4 Messages", 5)

local FooterLabel = Instance.new("TextLabel")
FooterLabel.Name = "FooterLabel"
FooterLabel.Size = UDim2.new(1, 0, 0, 16)
FooterLabel.Position = UDim2.new(0, 0, 1, -16)
FooterLabel.BackgroundTransparency = 1
FooterLabel.Text = "NEON SCRIPTS"
FooterLabel.TextColor3 = Color3.fromRGB(200, 150, 255)
FooterLabel.Font = Enum.Font.GothamMedium
FooterLabel.TextSize = 11
FooterLabel.TextXAlignment = Enum.TextXAlignment.Center
FooterLabel.ZIndex = 11
FooterLabel.Parent = TrayInner

-- // [4] FUNCTIONAL LOGIC & SIGNAL CONNECTIONS // --
local isExpanded = false
local isSniping = false
local autoRiddle = false
local selectedMessages = 1
local currentCount = 0
local lastAnswer = ""
local snipingThread = nil

task.spawn(function()
    while ScreenGui and ScreenGui.Parent do
        local fps = math.floor(1 / RunService.RenderStepped:Wait())
        local ping = math.floor((LocalPlayer:GetNetworkPing() or 0) * 1000)
        StatsText.Text = string.format("%dfps|%dms", fps, ping)
        task.wait(0.3)
    end
end)

local function setExpanded(state)
    isExpanded = state
    if state then
        TrayFrame.Visible = true
        TweenService:Create(TrayFrame, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, 0, 0, 210)
        }):Play()
        ExpandBtn.Text = "▲"
    else
        local tw = TweenService:Create(TrayFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = UDim2.new(1, 0, 0, 0)
        })
        tw:Play()
        tw.Completed:Wait()
        TrayFrame.Visible = false
        ExpandBtn.Text = "▼"
    end
end

ExpandBtn.MouseButton1Click:Connect(function()
    setExpanded(not isExpanded)
end)

local function answerRiddle(question)
    if type(question) ~= "string" or #question < 2 then return nil end
    local key = normalize(question)
    if NormalizedDB[key] then return NormalizedDB[key] end
    for k, v in pairs(NormalizedDB) do
        if string.find(key, k, 1, true) or string.find(k, key, 1, true) then
            return v
        end
    end
    return nil
end

local function findRelevantTextBoxes()
    local results = {}
    for _, obj in ipairs(PlayerGui:GetDescendants()) do
        if obj:IsA("TextBox") then
            local n = string.lower(obj.Name)
            if n:find("code") or n:find("redeem") or n:find("answer") or n:find("riddle") or n:find("chat") or n:find("message") or n:find("input") or n:find("text") then
                table.insert(results, obj)
            end
        end
    end
    return results
end

local function fireConfirmButtons()
    for _, obj in ipairs(PlayerGui:GetDescendants()) do
        if obj:IsA("GuiButton") then
            local n = string.lower(obj.Name)
            local t = string.lower(obj.Text or "")
            if n:find("confirm") or n:find("submit") or n:find("redeem") or n:find("send") or t:find("confirm") or t:find("submit") or t:find("redeem") or t:find("send") then
                pcall(function()
                    obj.MouseButton1Click:Fire()
                end)
            end
        end
    end
end

local function snipingLoop()
    while isSniping and ScreenGui and ScreenGui.Parent do
        if autoRiddle then
            for _, label in ipairs(PlayerGui:GetDescendants()) do
                if (label:IsA("TextLabel") or label:IsA("TextButton")) and label.Text then
                    local txt = label.Text
                    if #txt > 3 and #txt < 90 then
                        local ans = answerRiddle(txt)
                        if ans and ans ~= lastAnswer then
                            lastAnswer = ans
                            local boxes = findRelevantTextBoxes()
                            for _, box in ipairs(boxes) do
                                box.Text = ans
                            end
                            task.wait(0.12)
                            fireConfirmButtons()
                            currentCount = currentCount + 1
                            if currentCount >= selectedMessages then
                                currentCount = 0
                            end
                            task.wait(0.35)
                        end
                    end
                end
            end
        end
        task.wait(0.3)
    end
end

StartPillBtn.MouseButton1Click:Connect(function()
    isSniping = not isSniping
    if isSniping then
        StartPillBtn.Text = "STOP"
        StartPillBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
        StatusIndicator.BackgroundColor3 = Color3.fromRGB(65, 205, 105)
        snipingThread = task.spawn(snipingLoop)
    else
        StartPillBtn.Text = "START"
        StartPillBtn.BackgroundColor3 = Color3.fromRGB(48, 150, 82)
        StatusIndicator.BackgroundColor3 = Color3.fromRGB(175, 65, 65)
    end
end)

AutoRiddleBtn.MouseButton1Click:Connect(function()
    autoRiddle = not autoRiddle
    AutoRiddleBtn.Text = autoRiddle and "AUTO RIDDLE: ON" or "AUTO RIDDLE: OFF"
    AutoRiddleBtn.BackgroundColor3 = autoRiddle and Color3.fromRGB(60, 20, 100) or Color3.fromRGB(30, 15, 50)
end)

local function selectMessageCount(n)
    selectedMessages = n
    currentCount = 0
    local list = {Msg1Btn, Msg2Btn, Msg3Btn, Msg4Btn}
    for i, btn in ipairs(list) do
        btn.BackgroundColor3 = (i == n) and Color3.fromRGB(80, 25, 140) or Color3.fromRGB(30, 15, 50)
    end
end

Msg1Btn.MouseButton1Click:Connect(function() selectMessageCount(1) end)
Msg2Btn.MouseButton1Click:Connect(function() selectMessageCount(2) end)
Msg3Btn.MouseButton1Click:Connect(function() selectMessageCount(3) end)
Msg4Btn.MouseButton1Click:Connect(function() selectMessageCount(4) end)

_G.AnswerSammy = function(q)
    local a = answerRiddle(q)
    print("[Tigy] →", a or "NOT FOUND")
    return a
end
_G.SammyDB = SammyDB
_G.TigyRedeemer = {
    Start = function() if not isSniping then StartPillBtn.MouseButton1Click:Fire() end end,
    Stop = function() if isSniping then StartPillBtn.MouseButton1Click:Fire() end end,
    ToggleAutoRiddle = function() AutoRiddleBtn.MouseButton1Click:Fire() end,
    SetMessages = selectMessageCount,
}

-- // [5] INITIALIZATION // --
selectMessageCount(1)
StatusIndicator.BackgroundColor3 = Color3.fromRGB(175, 65, 65)
print("══════════════════════════════════════")
print(" Redeemer | NEON PURPLE EDITION")
print(" • UI + complete riddle DB")
print(" • Auto Riddle scanner")
print(" • Code / Confirm button firer")
print(" • No key required")
print("══════════════════════════════════════")
