local Aimbot = {}

-- Các dịch vụ Roblox cần thiết
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Khởi tạo cấu hình mặc định (sẽ đồng bộ với UI sau)
Aimbot.Settings = {
    aimbot1Enabled = false,
    aimbot2Enabled = false,
    aimbot3Enabled = false,
    aimbot4Enabled = false,
    fovEnabled = false,
    fovRadius = 37,
    aimSmoothSpeed = 5,
    fovCenterYPercent = 34,
    isAiming = false
}

-- Hàm thông minh tìm điểm ngắm
local function getAimPart(char)
    if not char then return nil end
    local criticalParts = {"Head", "UpperTorso", "Torso", "HumanoidRootPart"}
    for _, partName in ipairs(criticalParts) do
        local part = char:FindFirstChild(partName)
        if part and part:IsA("BasePart") then return part end
    end
    for _, objName in ipairs(char:GetChildren()) do
        if objName:IsA("BasePart") then return objName end
    end
    return nil
end
Aimbot.getAimPart = getAimPart -- Xuất hàm để file ESP dùng chung

-- Hàm lấy vị trí tâm FOV chính xác theo cấu hình thanh trượt
local function getCustomFOVCenter()
    local targetY = Camera.ViewportSize.Y * (Aimbot.Settings.fovCenterYPercent / 100)
    return Vector2.new(Camera.ViewportSize.X / 2, targetY)
end

-- Kiểm tra xem mục tiêu có bị vật cản che khuất không
local function isTargetVisible(targetChar)
    if not LocalPlayer.Character or not targetChar then return false end
    local myAim = getAimPart(LocalPlayer.Character)
    local targetAim = getAimPart(targetChar)
    if not myAim or not targetAim then return false end
    local parts = Camera:GetPartsObscuringTarget({myAim.Position, targetAim.Position}, {LocalPlayer.Character, targetChar})
    return #parts == 0
end

-- Bộ đệm lưu trạng thái nhìn thấy (Visibility Cache) để tối ưu hiệu năng
local visibilityCache = {}
Aimbot.VisibilityCache = visibilityCache

task.spawn(function()
    while true do
        task.wait(0.1)
        if LocalPlayer.Character then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    visibilityCache[player.Name] = isTargetVisible(player.Character)
                end
            end
        end
    end
end)

-- Thuật toán quét mục tiêu gần tâm FOV nhất
local function getClosestTargetToCustomCenter()
    local closestPlayer = nil
    local shortestDistance = Aimbot.Settings.fovRadius
    local customCenter = getCustomFOVCenter()
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local isEnemy = (player.Team ~= LocalPlayer.Team) or (player.Team == nil and LocalPlayer.Team == nil)
            if isEnemy and player.Character then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                local isAlive = (humanoid and humanoid.Health > 0)
                
                if isAlive then
                    local targetPart = getAimPart(player.Character)
                    if targetPart and visibilityCache[player.Name] then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                        if onScreen then
                            local magnitude = (Vector2.new(screenPos.X, screenPos.Y) - customCenter).Magnitude
                            if magnitude < shortestDistance then
                                shortestDistance = magnitude
                                closestPlayer = player.Character
                            end
                        end
                    end
                end
            end
        end
    end
    return closestPlayer
end

-- Khởi tạo vòng tròn vẽ FOV và kết nối vòng lặp RenderStepped
function Aimbot.Init(ScreenGui)
    local fovCircleFrame = Instance.new("Frame", ScreenGui)
    fovCircleFrame.Name = "FOVCircle"
    fovCircleFrame.BackgroundTransparency = 1
    fovCircleFrame.Visible = false

    local fovStroke = Instance.new("UIStroke", fovCircleFrame)
    fovStroke.Color = Color3.fromRGB(255, 0, 70)
    fovStroke.Thickness = 1.5

    local fovCorner = Instance.new("UICorner", fovCircleFrame)
    fovCorner.CornerRadius = UDim.new(0.5, 0)

    -- Cập nhật vòng FOV và Lia tâm liên tục
    RunService.RenderStepped:Connect(function(deltaTime)
        -- 1. Cập nhật giao diện vòng FOV
        if Aimbot.Settings.fovEnabled then
            local customCenter = getCustomFOVCenter()
            fovCircleFrame.Size = UDim2.new(0, Aimbot.Settings.fovRadius * 2, 0, Aimbot.Settings.fovRadius * 2)
            fovCircleFrame.Position = UDim2.new(0, customCenter.X - Aimbot.Settings.fovRadius, 0, customCenter.Y - Aimbot.Settings.fovRadius)
            fovCircleFrame.Visible = true
        else
            fovCircleFrame.Visible = false
        end

        -- 2. Xử lý khóa mục tiêu (Aimbot logic)
        if not ScreenGui:FindFirstChild("LoadingFrame") then -- Chỉ chạy khi nạp xong menu
            local target = getClosestTargetToCustomCenter()
            if target then
                local targetPart = getAimPart(target)
                if targetPart then
                    if Aimbot.Settings.aimbot4Enabled then
                        local myRoot = getAimPart(LocalPlayer.Character)
                        local distance3D = myRoot and (targetPart.Position - myRoot.Position).Magnitude or 50
                        local baseSpeed = 15
                        local proximityMultiplier = math.clamp(120 / distance3D, 1, 6)
                        local finalSmooth = baseSpeed * proximityMultiplier
                        local targetCFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
                        Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, math.clamp(finalSmooth * deltaTime, 0.15, 1))
                    elseif Aimbot.Settings.aimbot3Enabled then
                        Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
                    elseif Aimbot.Settings.aimbot2Enabled or (Aimbot.Settings.aimbot1Enabled and Aimbot.Settings.isAiming) then
                        local targetCFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
                        local speedFactor = Aimbot.Settings.aimSmoothSpeed * 3.5
                        Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, math.clamp(speedFactor * deltaTime, 0.05, 1))
                    end
                end
            end
        end
    end)
end

return Aimbot

