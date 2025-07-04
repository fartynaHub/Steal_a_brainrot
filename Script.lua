local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local TextService = game:GetService("TextService")
local StarterGui = game:GetService("StarterGui")

-- Константы
local TELEGRAM_LINK = "https://t.me/ggscriptsezz"
local CORRECT_KEY = "1234"

-- Основной GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MobileBrainrotGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Окно авторизации
local AuthFrame = Instance.new("Frame")
AuthFrame.Size = UDim2.new(0, 300, 0, 200)
AuthFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
AuthFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AuthFrame.BorderSizePixel = 0
AuthFrame.Parent = ScreenGui

local UICornerAuth = Instance.new("UICorner")
UICornerAuth.CornerRadius = UDim.new(0, 8)
UICornerAuth.Parent = AuthFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Position = UDim2.new(0, 0, 0, 10)
TitleLabel.Text = "Требуется авторизация"
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 20
TitleLabel.BackgroundTransparency = 1
TitleLabel.Parent = AuthFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
KeyBox.Position = UDim2.new(0.1, 0, 0.3, 0)
KeyBox.PlaceholderText = "Введите ключ доступа"
KeyBox.Text = ""
KeyBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
KeyBox.TextColor3 = Color3.new(1, 1, 1)
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 16
KeyBox.Parent = AuthFrame

local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0.5, 0, 0, 35)
SubmitButton.Position = UDim2.new(0.25, 0, 0.55, 0)
SubmitButton.Text = "Активировать"
SubmitButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
SubmitButton.TextColor3 = Color3.new(1, 1, 1)
SubmitButton.Font = Enum.Font.Gotham
SubmitButton.TextSize = 16
SubmitButton.Parent = AuthFrame

local TelegramButton = Instance.new("TextButton")
TelegramButton.Size = UDim2.new(0.8, 0, 0, 35)
TelegramButton.Position = UDim2.new(0.1, 0, 0.8, 0)
TelegramButton.Text = "Получить ключ (Telegram)"
TelegramButton.BackgroundColor3 = Color3.fromRGB(0, 136, 204)
TelegramButton.TextColor3 = Color3.new(1, 1, 1)
TelegramButton.Font = Enum.Font.Gotham
TelegramButton.TextSize = 14
TelegramButton.Parent = AuthFrame

-- Функция для копирования в буфер обмена
local function copyToClipboard(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "Ссылка скопирована",
            Text = "Теперь вы можете вставить её в браузере",
            Duration = 2
        })
        setclipboard(text)
    end)
end

TelegramButton.MouseButton1Click:Connect(function()
    copyToClipboard(TELEGRAM_LINK)
    TelegramButton.Text = "Ссылка скопирована!"
    task.wait(1.5)
    TelegramButton.Text = "Получить ключ (Telegram)"
end)

local function checkKey(inputKey)
    return inputKey == CORRECT_KEY
end

SubmitButton.MouseButton1Click:Connect(function()
    local inputKey = KeyBox.Text
    if checkKey(inputKey) then
        AuthFrame:Destroy()
        loadMainGUI()
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "Неверный ключ! Попробуйте снова"
    end
end)

-- Основной GUI
function loadMainGUI()
    -- Переменные для перемещения GUI
    local draggingGG, dragInputGG, dragStartGG, startPosGG
    local draggingMain, dragInputMain, dragStartMain, startPosMain

    -- Кнопка GG (80x80)
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 80, 0, 80)
    ToggleBtn.Position = UDim2.new(0, 20, 0.5, -40)
    ToggleBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
    ToggleBtn.Text = "GG"
    ToggleBtn.Font = Enum.Font.GothamBlack
    ToggleBtn.TextSize = 24
    ToggleBtn.ZIndex = 2
    ToggleBtn.Parent = ScreenGui

    local UICornerGG = Instance.new("UICorner")
    UICornerGG.CornerRadius = UDim.new(0, 12)
    UICornerGG.Parent = ToggleBtn

    -- Функции для перемещения GG кнопки
    local function updateGGInput(input)
        local delta = input.Position - dragStartGG
        ToggleBtn.Position = UDim2.new(0, startPosGG.X.Offset + delta.X, 0, startPosGG.Y.Offset + delta.Y)
    end

    ToggleBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingGG = true
            dragStartGG = input.Position
            startPosGG = ToggleBtn.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    draggingGG = false
                end
            end)
        end
    end)

    ToggleBtn.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInputGG = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if draggingGG and (input == dragInputGG) then
            updateGGInput(input)
        end
    end)

    -- Главное окно
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 240, 0, 260)
    MainFrame.Position = UDim2.new(0, 110, 0.5, -130)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BackgroundTransparency = 0.3
    MainFrame.Visible = false
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame

    -- Функции для перемещения главного окна
    local function updateMainInput(input)
        local delta = input.Position - dragStartMain
        MainFrame.Position = UDim2.new(0, startPosMain.X.Offset + delta.X, 0, startPosMain.Y.Offset + delta.Y)
    end

    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingMain = true
            dragStartMain = input.Position
            startPosMain = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    draggingMain = false
                end
            end)
        end
    end)

    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInputMain = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if draggingMain and (input == dragInputMain) then
            updateMainInput(input)
        end
    end)

    -- Переменные состояния
    local noclipActive = false
    local espActive = false
    local floatActive = false
    local flyActive = false
    local autoStealActive = false
    local savedBasePosition = nil
    local savedHeight = nil
    local espHandles = {}
    local random = Random.new()
    local flyConnection = nil
    local noclipConnection = nil
    local autoStealConnection = nil

    -- GUI для полета
    local FlyGui = Instance.new("Frame")
    FlyGui.Size = UDim2.new(0, 150, 0, 80)
    FlyGui.Position = UDim2.new(0, 100, 1, -130)
    FlyGui.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    FlyGui.BackgroundTransparency = 0.3
    FlyGui.Visible = false
    FlyGui.Parent = ScreenGui

    local UICornerFly = Instance.new("UICorner")
    UICornerFly.CornerRadius = UDim.new(0, 8)
    UICornerFly.Parent = FlyGui

    -- Кнопки для управления полетом
    local FlyForwardBtn = Instance.new("TextButton")
    FlyForwardBtn.Size = UDim2.new(0.4, 0, 0.4, 0)
    FlyForwardBtn.Position = UDim2.new(0.3, 0, 0.1, 0)
    FlyForwardBtn.Text = "↑"
    FlyForwardBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    FlyForwardBtn.TextColor3 = Color3.new(1, 1, 1)
    FlyForwardBtn.Parent = FlyGui

    local FlyBackwardBtn = Instance.new("TextButton")
    FlyBackwardBtn.Size = UDim2.new(0.4, 0, 0.4, 0)
    FlyBackwardBtn.Position = UDim2.new(0.3, 0, 0.5, 0)
    FlyBackwardBtn.Text = "↓"
    FlyBackwardBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    FlyBackwardBtn.TextColor3 = Color3.new(1, 1, 1)
    FlyBackwardBtn.Parent = FlyGui

    -- Стиль для кнопок
    local function createButton(name, positionY)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0.9, 0, 0.12, 0)
        button.Position = UDim2.new(0.05, 0, positionY, 0)
        button.Text = name
        button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        button.TextColor3 = Color3.new(1, 1, 1)
        button.Parent = MainFrame
        return button
    end

    -- Создаем кнопки
    local NoclipBtn = createButton("NoClip: OFF", 0.05)
    local ESPBtn = createButton("ESP: OFF", 0.18)
    local FlyBtn = createButton("Fly: OFF", 0.31)
    local SetBaseBtn = createButton("Set Base Position", 0.44)
    local FloatBtn = createButton("Float to Base", 0.57)
    local AutoStealBtn = createButton("Auto Steal: OFF", 0.70)

    -- Функция для сворачивания/разворачивания GUI
    local function toggleGUI()
        MainFrame.Visible = not MainFrame.Visible
    end

    ToggleBtn.MouseButton1Click:Connect(toggleGUI)

    -- NoClip функция
    local function toggleNoclip()
        noclipActive = not noclipActive
        NoclipBtn.Text = "NoClip: " .. (noclipActive and "ON" or "OFF")
        NoclipBtn.BackgroundColor3 = noclipActive and Color3.fromRGB(50, 120, 50) or Color3.fromRGB(70, 70, 70)
        
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        
        if noclipActive then
            noclipConnection = RunService.Stepped:Connect(function()
                if player.Character then
                    for _, part in pairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end
    end

    -- ESP функция
    local function toggleESP()
        espActive = not espActive
        ESPBtn.Text = "ESP: " .. (espActive and "ON" or "OFF")
        ESPBtn.BackgroundColor3 = espActive and Color3.fromRGB(50, 120, 50) or Color3.fromRGB(70, 70, 70)
        
        if espActive then
            for _, targetPlayer in ipairs(Players:GetPlayers()) do
                if targetPlayer ~= player then
                    if targetPlayer.Character then
                        local highlight = Instance.new("Highlight")
                        highlight.Adornee = targetPlayer.Character
                        highlight.FillTransparency = 1
                        highlight.OutlineColor = Color3.new(1, 1, 1)
                        highlight.Parent = targetPlayer.Character
                        espHandles[targetPlayer] = highlight
                    end
                    
                    targetPlayer.CharacterAdded:Connect(function(char)
                        if espActive then
                            local newHighlight = Instance.new("Highlight")
                            newHighlight.Adornee = char
                            newHighlight.FillTransparency = 1
                            newHighlight.OutlineColor = Color3.new(1, 1, 1)
                            newHighlight.Parent = char
                            espHandles[targetPlayer] = newHighlight
                        end
                    end)
                end
            end
        else
            for _, highlight in pairs(espHandles) do
                if highlight then
                    highlight:Destroy()
                end
            end
            espHandles = {}
        end
    end

    -- Fly функция с исправленными направлениями
    local function toggleFly()
        flyActive = not flyActive
        FlyBtn.Text = "Fly: " .. (flyActive and "ON" or "OFF")
        FlyBtn.BackgroundColor3 = flyActive and Color3.fromRGB(50, 120, 50) or Color3.fromRGB(70, 70, 70)
        FlyGui.Visible = flyActive
        
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        
        if flyActive then
            local character = player.Character
            if not character then return end
            
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
            end
            
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            
            local flySpeed = 50
            local moveDirection = Vector3.new(0, 0, 0)
            local verticalSpeed = 0
            
            -- Обработчики кнопок полета
            local forwardActive = false
            local backwardActive = false
            
            FlyForwardBtn.MouseButton1Down:Connect(function()
                forwardActive = true
            end)
            
            FlyForwardBtn.MouseButton1Up:Connect(function()
                forwardActive = false
            end)
            
            FlyBackwardBtn.MouseButton1Down:Connect(function()
                backwardActive = true
            end)
            
            FlyBackwardBtn.MouseButton1Up:Connect(function()
                backwardActive = false
            end)
            
            flyConnection = RunService.Heartbeat:Connect(function()
                if not flyActive or not character or not character.Parent then
                    if flyConnection then flyConnection:Disconnect() end
                    return
                end
                
                if not hrp or not hrp.Parent then
                    if flyConnection then flyConnection:Disconnect() end
                    return
                end
                
                -- Получаем направление взгляда камеры
                local camera = workspace.CurrentCamera
                local lookVector = camera.CFrame.LookVector
                
                -- Вертикальное движение
                verticalSpeed = lookVector.Y * flySpeed
                
                -- Сбрасываем направление движения
                moveDirection = Vector3.new(0, 0, 0)
                
                -- Управление с исправленными направлениями
                if forwardActive then
                    moveDirection = moveDirection + lookVector  -- Вперёд
                end
                
                if backwardActive then
                    moveDirection = moveDirection - lookVector  -- Назад
                end
                
                -- Нормализация вектора
                if moveDirection.Magnitude > 0 then
                    moveDirection = moveDirection.Unit
                end
                
                -- Применяем движение
                hrp.Velocity = Vector3.new(
                    moveDirection.X * flySpeed,
                    verticalSpeed,
                    moveDirection.Z * flySpeed
                )
            end)
        else
            if player.Character then
                local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.Velocity = Vector3.new(0, 0, 0)
                end
            end
        end
    end

    -- Set Base функция
    local function setBase()
        local character = player.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        savedBasePosition = humanoidRootPart.Position + Vector3.new(0, 2, 0)
        SetBaseBtn.Text = "Base Saved ✓"
        task.delay(1, function()
            SetBaseBtn.Text = "Set Base Position"
        end)
    end

    -- Float функция
    local function floatToBase()
        if floatActive or not savedBasePosition then return end
        floatActive = true
        
        local character = player.Character
        if not character then 
            floatActive = false
            return
        end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then 
            floatActive = false
            return
        end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
        end
        
        FloatBtn.Text = "Floating..."
        local startTime = tick()
        local speed = 40
        local maxHeight = 5
        local minDistanceToStop = 3
        
        local connection
        connection = RunService.Heartbeat:Connect(function()
            if not floatActive or not humanoidRootPart or not humanoid then
                connection:Disconnect()
                FloatBtn.Text = "Float to Base"
                return
            end
            
            local direction = (savedBasePosition - humanoidRootPart.Position)
            local distance = direction.Magnitude
            direction = direction.Unit
            
            if distance < minDistanceToStop then
                floatActive = false
                humanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                connection:Disconnect()
                FloatBtn.Text = "Float to Base"
                return
            end
            
            if tick() - startTime > 30 then
                floatActive = false
                humanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                connection:disconnect()
                FloatBtn.Text = "Float to Base"
                return
            end
            
            local currentHeight = math.min(maxHeight, distance / 10)
            local moveDirection = Vector3.new(direction.X, 0, direction.Z).Unit
            local verticalAdjust = Vector3.new(0, currentHeight, 0)
            humanoidRootPart.Velocity = (moveDirection * speed) + verticalAdjust
            
            if random:NextNumber() < 0.15 then
                humanoidRootPart.Velocity = humanoidRootPart.Velocity - moveDirection * 30
            end
        end)
    end

    -- Auto Steal функция с увеличенной высотой
    local function toggleAutoSteal()
        autoStealActive = not autoStealActive
        AutoStealBtn.Text = "Auto Steal: " .. (autoStealActive and "ON" or "OFF")
        AutoStealBtn.BackgroundColor3 = autoStealActive and Color3.fromRGB(50, 120, 50) or Color3.fromRGB(70, 70, 70)
        
        if autoStealConnection then
            autoStealConnection:Disconnect()
            autoStealConnection = nil
        end
        
        if autoStealActive then
            local character = player.Character
            if not character then return end
            
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then return end
            
            -- Сохраняем текущую высоту
            savedHeight = humanoidRootPart.Position.Y
            
            -- Телепортируем вверх на 200 шагов (увеличенная высота)
            local targetPosition = humanoidRootPart.Position + Vector3.new(0, 200, 0)
            humanoidRootPart.CFrame = CFrame.new(targetPosition)
            
            -- Ждем 2 секунды
            task.wait(2)
            
            -- Активируем Float к базе (если база сохранена)
            if savedBasePosition then
                -- Модифицируем позицию базы, чтобы она была в небе
                local skyBase = Vector3.new(savedBasePosition.X, humanoidRootPart.Position.Y, savedBasePosition.Z)
                
                -- Временно сохраняем оригинальную базу
                local originalBase = savedBasePosition
                savedBasePosition = skyBase
                
                -- Активируем Float
                floatToBase()
                
                -- Ждем пока Float завершится
                while floatActive do
                    task.wait()
                end
                
                -- Восстанавливаем оригинальную базу
                savedBasePosition = originalBase
                
                -- Телепортируем вниз к сохраненной высоте
                local finalPosition = Vector3.new(humanoidRootPart.Position.X, savedHeight, humanoidRootPart.Position.Z)
                humanoidRootPart.CFrame = CFrame.new(finalPosition)
            else
                StarterGui:SetCore("SendNotification", {
                    Title = "Ошибка",
                    Text = "Базовая позиция не установлена",
                    Duration = 3
                })
            end
            
            -- Выключаем Auto Steal после выполнения
            autoStealActive = false
            AutoStealBtn.Text = "Auto Steal: OFF"
            AutoStealBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end
    end

    -- Автовосстановление после смерти
    player.CharacterAdded:Connect(function(character)
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                if not part:FindFirstChild("OriginalSize") then
                    local originalSize = Instance.new("Vector3Value")
                    originalSize.Name = "OriginalSize"
                    originalSize.Value = part.Size
                    originalSize.Parent = part
                end
            end
        end
        
        if noclipActive then
            if noclipConnection then
                noclipConnection:Disconnect()
                noclipConnection = nil
            end
            noclipActive = false
            NoclipBtn.Text = "NoClip: OFF"
            NoclipBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end
        if espActive then
            toggleESP()
            toggleESP()
        end
        if flyActive then
            if flyConnection then
                flyConnection:Disconnect()
                flyConnection = nil
            end
            flyActive = false
            FlyBtn.Text = "Fly: OFF"
            FlyBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            FlyGui.Visible = false
        end
        if floatActive then
            floatActive = false
            FloatBtn.Text = "Float to Base"
        end
        if autoStealActive then
            if autoStealConnection then
                autoStealConnection:Disconnect()
                autoStealConnection = nil
            end
            autoStealActive = false
            AutoStealBtn.Text = "Auto Steal: OFF"
            AutoStealBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end
    end)

    -- Подключение кнопок
    NoclipBtn.MouseButton1Click:Connect(toggleNoclip)
    ESPBtn.MouseButton1Click:Connect(toggleESP)
    FlyBtn.MouseButton1Click:Connect(toggleFly)
    SetBaseBtn.MouseButton1Click:Connect(setBase)
    FloatBtn.MouseButton1Click:Connect(floatToBase)
    AutoStealBtn.MouseButton1Click:Connect(toggleAutoSteal)
end
