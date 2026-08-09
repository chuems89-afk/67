local UserInputService = game:GetService("UserInputService")

-- ===================================================
-- CREACIÓN DE LA INTERFAZ (UI)
-- ===================================================
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- Botón para Bloquear / Desbloquear movimiento
local LockButton = Instance.new("TextButton")
local LockCorner = Instance.new("UICorner")

-- Colocar la UI en la pantalla del jugador local
ScreenGui.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "InstantPromptUI"

-- Configurar el Botón Principal
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ToggleButton.Position = UDim2.new(0.02, 0, 0.4, 0) -- Lado izquierdo de la pantalla
ToggleButton.Size = UDim2.new(0, 150, 0, 45)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "Instant Prompts: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 75, 75) -- Rojo cuando está apagado
ToggleButton.TextSize = 16.00

-- Bordes redondeados para el botón principal
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = ToggleButton

-- Configurar el Botón de Bloqueo (fijado a la derecha del botón principal)
LockButton.Parent = ToggleButton
LockButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
LockButton.Position = UDim2.new(1, 5, 0, 0) -- Aparece pegado al lado derecho
LockButton.Size = UDim2.new(0, 35, 1, 0)
LockButton.Font = Enum.Font.SourceSansBold
LockButton.Text = "🔓" -- Desbloqueado por defecto
LockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LockButton.TextSize = 18.00

LockCorner.CornerRadius = UDim.new(0, 8)
LockCorner.Parent = LockButton

-- ===================================================
-- LÓGICA DE ARRASTRE Y BLOQUEO
-- ===================================================
local isLocked = false
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	ToggleButton.Position = UDim2.new(
		startPos.X.Scale, 
		startPos.X.Offset + delta.X, 
		startPos.Y.Scale, 
		startPos.Y.Offset + delta.Y
	)
end

-- Detectar когда el usuario toca/haz clic para arrastrar
ToggleButton.InputBegan:Connect(function(input)
	if not isLocked and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
		dragging = true
		dragStart = input.Position
		startPos = ToggleButton.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

ToggleButton.InputChanged:Connect(function(input)
	if not isLocked and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input == dragInput then
		update(input)
	end
end)

-- Acción al presionar el botón de candado/fijado
LockButton.MouseButton1Click:Connect(function()
	isLocked = not isLocked
	if isLocked then
		LockButton.Text = "🔒" -- Cambia a candado cerrado
		LockButton.BackgroundColor3 = Color3.fromRGB(150, 40, 40) -- Se pone rojo
	else
		LockButton.Text = "🔓" -- Cambia a candado abierto
		LockButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	end
end)

-- ===================================================
-- LÓGICA DEL SCRIPT (INSTANT PROMPTS)
-- ===================================================
local activo = false
local conexion = nil

local function aplicarInstantPrompts()
	if not activo then return end
	
	-- 1. Modificar los existentes en Workspace
	for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
		if v:IsA("ProximityPrompt") then
			v.HoldDuration = 0
		end
	end
end

-- Activar / Desactivar con el botón
ToggleButton.MouseButton1Click:Connect(function()
	-- Si estábamos arrastrando el botón, no ejecuta el clic de activación para evitar confusiones
	if dragging then return end 
	
	activo = not activo -- Cambia entre true y false
	
	if activo then
		-- Estado: ACTIVADO
		ToggleButton.Text = "Instant Prompts: ON"
		ToggleButton.TextColor3 = Color3.fromRGB(75, 255, 75) -- Verde
		
		-- Aplicar a los actuales
		aplicarInstantPrompts()
		
		-- 2. Escuchar a los nuevos que el jugador intente presionar
		conexion = game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(v)
			if activo then
				v.HoldDuration = 0
			end
		end)
	else
		-- Estado: DESACTIVADO
		ToggleButton.Text = "Instant Prompts: OFF"
		ToggleButton.TextColor3 = Color3.fromRGB(255, 75, 75) -- Rojo
		
		-- Desconectar el evento para ahorrar recursos
		if conexion then
			conexion:Disconnect()
			conexion = nil
		end
	end
end)
