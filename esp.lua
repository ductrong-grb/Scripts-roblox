local ESP = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

ESP.Settings = {
    espEnemyEnabled = false,
    espTeamEnabled = false,
    espBoxEnabled = false
}

local espFolder

function ESP.Init(ScreenGui, AimbotModule)
    espFolder = Instance.new("Folder", ScreenGui)
    espFolder.Name = "ESP_Storage"

    local function createESP(player)
        if player == LocalPlayer then return end
        local function initChar(char)
            if espFolder:FindFirstChild(player.Name) then espFolder[player.Name]:Destroy() end
            local mainStorage = Instance.new("Folder", espFolder)
            mainStorage.Name = player.Name
            
            local boxHighlight = Instance.new("Highlight", mainStorage)
            boxHighlight.Name = "BoxESP"
            boxHighlight.FillTransparency = 1 
            boxHighlight.OutlineTransparency = 0
            boxHighlight.Adornee = char
            boxHighlight.Enabled = false
            
            local targetPart = AimbotModule.getAimPart(char)
            local bGui = Instance.new("BillboardGui", mainStorage)
            bGui.Name = "TagESP"
            bGui.Size = UDim2.new(0, 180, 0, 40)
            bGui.AlwaysOnTop = true
            bGui.StudsOffset = Vector3.new(0, 3, 0)
            bGui.Adornee = targetPart or char
            bGui.Enabled = false
            
            local label = Instance.new("TextLabel", bGui)
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.TextStrokeTransparency = 0 
            label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            label.Font = Enum.Font.SourceSansBold
            label.TextSize = 12
            label.Text = player.DisplayName

            char.Destroying:Connect(function() mainStorage:Destroy() end)
        end
        if player.Character then initChar(player.Character) end
        player.CharacterAdded:Connect(initChar)
    end

    -- Đăng ký ESP liên tục thông qua RenderStepped
    RunService.RenderStepped:Connect(function()
        local localChar = LocalPlayer.Character
        local myRoot = localChar and AimbotModule.getAimPart(localChar)
        if not myRoot then return end
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local mainStorage = espFolder:FindFirstChild(player.Name)
                local char = player.Character
                local targetPart = char and AimbotModule.getAimPart(char)
                
                if mainStorage and char and targetPart then
                    local highlight = mainStorage:FindFirstChild("BoxESP")
                    local tagGui = mainStorage:FindFirstChild("TagESP")
                    local _, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    
                    local isAlive = (humanoid and humanoid.Health > 0)
                    local isEnemy = (player.Team ~= LocalPlayer.Team) or (player.Team == nil and LocalPlayer.Team == nil)
                    local allowedToShow = (isEnemy and ESP.Settings.espEnemyEnabled) or (not isEnemy and ESP.Settings.espTeamEnabled)

                    if onScreen and allowedToShow and isAlive then
                        local visible = AimbotModule.VisibilityCache[player.Name] or false
                        local color = isEnemy and (visible and Color3.fromRGB(255, 0, 50) or Color3.fromRGB(255, 140, 0)) or (visible and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(0, 100, 40))
                        
                        if highlight then
                            highlight.Enabled = ESP.Settings.espBoxEnabled
                            highlight.OutlineColor = color
                        end
                        if tagGui and tagGui:FindFirstChild("TextLabel") then
                            tagGui.Enabled = true
                            local dist = (targetPart.Position - myRoot.Position).Magnitude
                            tagGui.TextLabel.Text = player.DisplayName .. " [" .. math.floor(dist) .. "m]"
                            tagGui.TextLabel.TextColor3 = color
                        end
                    else
                        if highlight then highlight.Enabled = false end
                        if tagGui then tagGui.Enabled = false end
                    end
                end
            end
        end
    end)

    Players.PlayerAdded:Connect(createESP)
    for _, p in ipairs(Players:GetPlayers()) do createESP(p) end
end

function ESP.Refresh()
    if espFolder then
        espFolder:ClearAllChildren()
        if ESP.Settings.espEnemyEnabled or ESP.Settings.espTeamEnabled then
            for _, p in ipairs(Players:GetPlayers()) do
                -- Lệnh này sẽ được xử lý tự động nhờ kết nối kích hoạt CharacterAdded ở hàm Init
                pcall(function() p.CharacterAdded:Wait() end)
            end
        end
    end
end

return ESP

