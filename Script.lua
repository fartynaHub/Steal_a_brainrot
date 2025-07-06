local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local TextService = game:GetService("TextService")
local StarterGui = game:GetService("StarterGui")

local function createNotification(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration
    })
end

local function copyToClipboard(text)
    pcall(function()
        createNotification("Ссылка скопирована", "Теперь вы можете вставить её в браузере", 2)
        setclipboard(text)
    end)
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MobileBrainrotGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

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

local LinkvertiseButton = Instance.new("TextButton")
LinkvertiseButton.Size = UDim2.new(0.8, 0, 0, 35)
LinkvertiseButton.Position = UDim2.new(0.1, 0, 0.8, 0)
LinkvertiseButton.Text = "Получить ключ (Linkvertise)"
LinkvertiseButton.BackgroundColor3 = Color3.fromRGB(0, 180, 120)
LinkvertiseButton.TextColor3 = Color3.new(1, 1, 1)
LinkvertiseButton.Font = Enum.Font.Gotham
LinkvertiseButton.TextSize = 14
LinkvertiseButton.Parent = AuthFrame

local TelegramLink = Instance.new("TextButton")
TelegramLink.Size = UDim2.new(0.4, 0, 0, 20)
TelegramLink.Position = UDim2.new(0.3, 0, 1.05, 0)
TelegramLink.Text = "Telegram"
TelegramLink.BackgroundColor3 = Color3.fromRGB(0, 136, 204)
TelegramLink.TextColor3 = Color3.new(1, 1, 1)
TelegramLink.Font = Enum.Font.Gotham
TelegramLink.TextSize = 12
TelegramLink.Parent = AuthFrame

local LINKVERTISE_LINK = "https://link-center.net/1368071/1swLRhKVHuFF"
local TELEGRAM_LINK = "https://t.me/ggscriptsezz"
local CORRECT_KEY = "10ko57cl69"

local function checkKey(inputKey)
    return inputKey == CORRECT_KEY
end

local function handleKeySubmission(inputKey)
    if checkKey(inputKey) then
        return true
    else
        return false
    end
end

LinkvertiseButton.MouseButton1Click:Connect(function()
    copyToClipboard(LINKVERTISE_LINK)
    LinkvertiseButton.Text = "Ссылка скопирована!"
    task.wait(1.5)
    LinkvertiseButton.Text = "Получить ключ (Linkvertise)"
end)

TelegramLink.MouseButton1Click:Connect(function()
    copyToClipboard(TELEGRAM_LINK)
    TelegramLink.Text = "Скопировано!"
    task.wait(1.5)
    TelegramLink.Text = "Telegram"
end)

SubmitButton.MouseButton1Click:Connect(function()
    local inputKey = KeyBox.Text
    if handleKeySubmission(inputKey) then
        AuthFrame:Destroy()
        loadMainGUI()
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "Неверный ключ! Попробуйте снова"
    end
end)

function loadMainGUI()
    local draggingGG, dragInputGG, dragStartGG, startPosGG
    local draggingMain, dragInputMain, dragStartMain, startPosMain

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
    ToggleBtn.Position = UDim2.new(0, 10, 0.5, -30)
    ToggleBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
    ToggleBtn.Text = "GG"
    ToggleBtn.Font = Enum.Font.GothamBlack
    ToggleBtn.TextSize = 20
    ToggleBtn.ZIndex = 2
    ToggleBtn.Parent = ScreenGui

    local UICornerGG = Instance.new("UICorner")
    UICornerGG.CornerRadius = UDim.new(0, 12)
    UICornerGG.Parent = ToggleBtn

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

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 220, 0, 280)
    MainFrame.Position = UDim2.new(0, 80, 0.5, -140)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BackgroundTransparency = 0.3
    MainFrame.Visible = false
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame

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

    local noclipActive = false
    local espActive = false
    local floatActive = false
    local flyActive = false
    local autoStealActive = false
    local boostSpeedActive = false
    local savedBasePosition = nil
    local savedHeight = nil
    local espHandles = {}
    local flyConnection = nil
    local noclipConnection = nil
    local autoStealConnection = nil
    local boostSpeedConnection = nil
    local espConnection = nil

    local FlyGui = Instance.new("Frame")
    FlyGui.Size = UDim2.new(0, 120, 0, 70)
    FlyGui.Position = UDim2.new(0, 80, 1, -110)
    FlyGui.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    FlyGui.BackgroundTransparency = 0.3
    FlyGui.Visible = false
    FlyGui.Parent = ScreenGui

    local UICornerFly = Instance.new("UICorner")
    UICornerFly.CornerRadius = UDim.new(0, 8)
    UICornerFly.Parent = FlyGui

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

    local function createButton(name, positionY)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0.9, 0, 0.11, 0)
        button.Position = UDim2.new(0.05, 0, positionY, 0)
        button.Text = name
        button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        button.TextColor3 = Color3.new(1, 1, 1)
        button.Font = Enum.Font.Gotham
        button.TextSize = 14
        button.Parent = MainFrame
        return button
    end

    local NoclipBtn = createButton("NoClip: OFF", 0.05)
    local ESPBtn = createButton("ESP: OFF", 0.17)
    local FlyBtn = createButton("Fly: OFF", 0.29)
    local SetBaseBtn = createButton("Set Base Position", 0.41)
    local FloatBtn = createButton("Float to Base", 0.53)
    local AutoStealBtn = createButton("Auto Steal: OFF", 0.65)
    local BoostSpeedBtn = createButton("Boost Speed: OFF", 0.77)

    local function toggleGUI()
        MainFrame.Visible = not MainFrame.Visible
    end

    ToggleBtn.MouseButton1Click:Connect(toggleGUI)

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

    local function toggleESP()
        espActive = not espActive
        ESPBtn.Text = "ESP: " .. (espActive and "ON" or "OFF")
        ESPBtn.BackgroundColor3 = espActive and Color3.fromRGB(50, 120, 50) or Color3.fromRGB(70, 70, 70)
        
        for _, highlight in pairs(espHandles) do
            if highlight then
                highlight:Destroy()
            end
        end
        espHandles = {}
        
        if espConnection then
            espConnection:Disconnect()
            espConnection = nil
        end
        
        if espActive then
            local function createHighlight(targetPlayer)
                if targetPlayer.Character then
                    local highlight = Instance.new("Highlight")
                    highlight.Adornee = targetPlayer.Character
                    highlight.FillTransparency = 1
                    highlight.OutlineColor = Color3.new(1, 1, 1)
                    highlight.Parent = targetPlayer.Character
                    espHandles[targetPlayer] = highlight
                end
            end
            
            local function onPlayerAdded(targetPlayer)
                if targetPlayer ~= player then
                    createHighlight(targetPlayer)
                    
                    targetPlayer.CharacterAdded:Connect(function(character)
                        if espActive then
                            createHighlight(targetPlayer)
                        end
                    end)
                end
            end
            
            for _, targetPlayer in ipairs(Players:GetPlayers()) do
                if targetPlayer ~= player then
                    onPlayerAdded(targetPlayer)
                end
            end
            
            Players.PlayerAdded:Connect(onPlayerAdded)
            
            espConnection = RunService.Heartbeat:Connect(function()
                if not espActive then return end
                
                for targetPlayer, highlight in pairs(espHandles) do
                    if targetPlayer and highlight then
                        if targetPlayer.Character and highlight.Parent ~= targetPlayer.Character then
                            highlight.Adornee = targetPlayer.Character
                            highlight.Parent = targetPlayer.Character
                        end
                    end
                end
            end)
        end
    end

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
                
                local camera = workspace.CurrentCamera
                local lookVector = camera.CFrame.LookVector
                
                verticalSpeed = lookVector.Y * flySpeed
                
                moveDirection = Vector3.new(0, 0, 0)
                
                if forwardActive then
                    moveDirection = moveDirection + lookVector
                end
                
                if backwardActive then
                    moveDirection = moveDirection - lookVector
                end
                
                if moveDirection.Magnitude > 0 then
                    moveDirection = moveDirection.Unit
                end
                
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

    local function floatToBase()
        if floatActive or not savedBasePosition then 
            if not savedBasePosition then
                createNotification("Ошибка", "Базовая позиция не установлена", 3)
            end
            return 
        end
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
        local minDistanceToStop = 3
        local targetHeight = savedBasePosition.Y + 10
        
        local connection
        connection = RunService.Heartbeat:Connect(function()
            if not floatActive or not humanoidRootPart or not humanoid then
                connection:Disconnect()
                FloatBtn.Text = "Float to Base"
                return
            end
            
            local currentPos = humanoidRootPart.Position
            local targetPos = Vector3.new(savedBasePosition.X, targetHeight, savedBasePosition.Z)
            local direction = (targetPos - currentPos)
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
            
            humanoidRootPart.Velocity = direction * speed
        end)
    end

    local function toggleAutoSteal()
        if not savedBasePosition then
            createNotification("Ошибка", "Сначала сохраните позицию базы", 3)
            return
        end
        
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
            
            savedHeight = humanoidRootPart.Position.Y
            
            local targetPosition = humanoidRootPart.Position + Vector3.new(0, 200, 0)
            humanoidRootPart.CFrame = CFrame.new(targetPosition)
            
            task.wait(2)
            
            local skyBase = Vector3.new(savedBasePosition.X, humanoidRootPart.Position.Y, savedBasePosition.Z)
            local originalBase = savedBasePosition
            savedBasePosition = skyBase
            
            floatToBase()
            
            while floatActive do
                task.wait()
            end
            
            local currentPos = humanoidRootPart.Position
            local baseXZ = Vector3.new(originalBase.X, 0, originalBase.Z)
            local currentXZ = Vector3.new(currentPos.X, 0, currentPos.Z)
            
            if (baseXZ - currentXZ).Magnitude < 5 then
                humanoidRootPart.CFrame = CFrame.new(Vector3.new(currentPos.X, originalBase.Y, currentPos.Z))
            else
                local finalPosition = Vector3.new(currentPos.X, savedHeight, currentPos.Z)
                humanoidRootPart.CFrame = CFrame.new(finalPosition)
            end
            
            savedBasePosition = originalBase
            autoStealActive = false
            AutoStealBtn.Text = "Auto Steal: OFF"
            AutoStealBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end
    end

    local function toggleBoostSpeed()
        boostSpeedActive = not boostSpeedActive
        BoostSpeedBtn.Text = "Boost Speed: " .. (boostSpeedActive and "ON" or "OFF")
        BoostSpeedBtn.BackgroundColor3 = boostSpeedActive and Color3.fromRGB(50, 120, 50) or Color3.fromRGB(70, 70, 70)
        
        if boostSpeedConnection then
            boostSpeedConnection:Disconnect()
            boostSpeedConnection = nil
        end
        
        if boostSpeedActive then
            local character = player.Character
            if not character then return end
            
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
            end
            
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            
            local speed = 50
            
            boostSpeedConnection = RunService.Heartbeat:Connect(function()
                if not boostSpeedActive or not character or not character.Parent then
                    if boostSpeedConnection then boostSpeedConnection:Disconnect() end
                    return
                end
                
                if not hrp or not hrp.Parent then
                    if boostSpeedConnection then boostSpeedConnection:Disconnect() end
                    return
                end
                
                local camera = workspace.CurrentCamera
                local lookVector = camera.CFrame.LookVector
                lookVector = Vector3.new(lookVector.X, 0, lookVector.Z).Unit
                
                hrp.Velocity = lookVector * speed
                
                local currentPosition = hrp.Position
                hrp.Position = Vector3.new(currentPosition.X, currentPosition.Y, currentPosition.Z)
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
            for _, highlight in pairs(espHandles) do
                if highlight then
                    highlight:Destroy()
                end
            end
            espHandles = {}
            
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
        
        if boostSpeedActive then
            if boostSpeedConnection then
                boostSpeedConnection:Disconnect()
                boostSpeedConnection = nil
            end
            boostSpeedActive = false
            BoostSpeedBtn.Text = "Boost Speed: OFF"
            BoostSpeedBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end
    end)

    NoclipBtn.MouseButton1Click:Connect(toggleNoclip)
    ESPBtn.MouseButton1Click:Connect(toggleESP)
    FlyBtn.MouseButton1Click:Connect(toggleFly)
    SetBaseBtn.MouseButton1Click:Connect(setBase)
    FloatBtn.MouseButton1Click:Connect(floatToBase)
    AutoStealBtn.MouseButton1Click:Connect(toggleAutoSteal)
    BoostSpeedBtn.MouseButton1Click:Connect(toggleBoostSpeed)
end
