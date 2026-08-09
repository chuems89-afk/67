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
ToggleButton.Position = UDim2.new(0.02, 0, 0.4, 0)
ToggleButton.Size = UDim2.new(0, 150, 0, 45)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "ACTIVAR"
ToggleButton.TextColor3 = Color3.fromRGB(75, 255, 75) -- Verde por defecto al estar apagado
ToggleButton.TextSize = 16.00

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = ToggleButton

-- Configurar el Botón de Bloqueo
LockButton.Parent = ToggleButton
LockButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
LockButton.Position = UDim2.new(1, 5, 0, 0)
LockButton.Size = UDim2.new(0, 35, 1, 0)
LockButton.Font = Enum.Font.SourceSansBold
LockButton.Text = "🔓"
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

LockButton.MouseButton1Click:Connect(function()
	isLocked = not isLocked
	if isLocked then
		LockButton.Text = "🔒"
		LockButton.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
	else
		LockButton.Text = "🔓"
		LockButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	end
end)

-- ===================================================
-- LÓGICA DEL SCRIPT (INSTANT PROMPTS)
-- ===================================================
local activo = false
local conexion = nil
local tiemposOriginales = {} -- Tabla para guardar el tiempo real de cada prompt

-- Función para activar el modo instantáneo
local function activarInstant()
	for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
		if v:IsA("ProximityPrompt") then
			if tiemposOriginales[v] == nil then
				tiemposOriginales[v] = v.HoldDuration
			end
			v.HoldDuration = 0
		end
	end
end

-- Función para restaurar los tiempos normales
local function desactivarInstant()
	for prompt, tiempoOriginal in pairs(tiemposOriginales) do
		if prompt and prompt.Parent then
			prompt.HoldDuration = tiempoOriginal
		end
	end
	tiemposOriginales = {}
end

-- Activar / Desactivar con el botón
ToggleButton.MouseButton1Click:Connect(function()
	if dragging then return end 
	
	activo = not activo
	
	if activo then
		-- Estado: ENCENDIDO (el botón ofrece la opción de "DESACTIVAR")
		ToggleButton.Text = "DESACTIVAR"
		ToggleButton.TextColor3 = Color3.fromRGB(255, 75, 75) -- Rojo
		
		-- Modifica los prompts actuales
		activarInstant()
		
		-- Escucha por si aparece uno nuevo
		conexion = game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(v)
			if activo then
				if tiemposOriginales[v] == nil then
					tiemposOriginales[v] = v.HoldDuration
				end
				v.HoldDuration = 0
			end
		end)
	else
		-- Estado: APAGADO (el botón ofrece la opción de "ACTIVAR")
		ToggleButton.Text = "ACTIVAR"
		ToggleButton.TextColor3 = Color3.fromRGB(75, 255, 75) -- Verde
		
		-- Restaura los tiempos originales
		desactivarInstant()
		
		-- Desconecta el evento
		if conexion then
			conexion:Disconnect()
			conexion = nil
		end
	end
end)

