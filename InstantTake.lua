-- ===================================================
-- CREACIÓN DE LA INTERFAZ (UI)
-- ===================================================
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- Colocar la UI en la pantalla del jugador local
ScreenGui.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "InstantPromptUI"

-- Configurar el Botón
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ToggleButton.Position = UDim2.new(0.02, 0, 0.4, 0) -- Lado izquierdo de la pantalla
ToggleButton.Size = UDim2.new(0, 150, 0, 45)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "Instant Prompts: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 75, 75) -- Rojo cuando está apagado
ToggleButton.TextSize = 16.00

-- Bordes redondeados para el botón
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = ToggleButton

-- ===================================================
-- LÓGICA DEL SCRIPT
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
