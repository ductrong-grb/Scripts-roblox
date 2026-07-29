-- =================================================================
-- BỘ KHUNG GIAO DIỆN PREMIUM V10.1 - FIX LỖI FOV & AIMBOT DỆT TÂM
-- =================================================================

local Menu = {}
Menu.Elements = {}

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Dọn dẹp menu cũ nếu có
if CoreGui:FindFirstChild("MyCustomHackMenu") then
    CoreGui.MyCustomHackMenu:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MyCustomHackMenu"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- =================================================================
-- TẠO MÀN HÌNH KHỞI ĐỘNG (LOADING SCREEN) CHUYÊN NGHIỆP
-- =================================================================
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Size = UDim2.new(0, 320, 0, 110)
LoadingFrame.Position = UDim2.new(0.5, -160, 0.5, -55)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 16, 22)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Parent = ScreenGui

local LoadCorner = Instance.new("UICorner")
LoadCorner.CornerRadius = UDim.new(0, 10)
LoadCorner.Parent = LoadingFrame

local LoadStroke = Instance.new("UIStroke")
LoadStroke.Color = Color3.fromRGB(0, 220, 140)
LoadStroke.Thickness = 1.2
LoadStroke.Parent = LoadingFrame

local LoadTitle = Instance.new("TextLabel")
LoadTitle.Size = UDim2.new(1, 0, 0, 30)
LoadTitle.Position = UDim2.new(0, 0, 0, 15)
LoadTitle.Text = "ĐANG KHỞI CHẠY HỆ THỐNG..."
LoadTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadTitle.Font = Enum.Font.GothamBold
LoadTitle.TextSize = 13
LoadTitle.BackgroundTransparency = 1
LoadTitle.Parent = LoadingFrame

local PercentText = Instance.new("TextLabel")
PercentText.Size = UDim2.new(1, 0, 0, 20)
PercentText.Position = UDim2.new(0, 0, 0, 40)
PercentText.Text = "0%"
PercentText.TextColor3 = Color3.fromRGB(0, 220, 140)
PercentText.Font = Enum.Font.GothamMedium
PercentText.TextSize = 12
PercentText.BackgroundTransparency = 1
PercentText.Parent = LoadingFrame

local ProgressBarBG = Instance.new("Frame")
ProgressBarBG.Size = UDim2.new(0, 260, 0, 6)
ProgressBarBG.Position = UDim2.new(0.5, -130, 0, 72)
ProgressBarBG.BackgroundColor3 = Color3.fromRGB(32, 35, 47)
ProgressBarBG.BorderSizePixel = 0
ProgressBarBG.Parent = LoadingFrame

local BarBGUICorner = Instance.new("UICorner")
BarBGUICorner.CornerRadius = UDim.new(0, 3)
BarBGUICorner.Parent = ProgressBarBG

local ProgressBarFill = Instance.new("Frame")
ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
ProgressBarFill.BackgroundColor3 = Color3.fromRGB(0, 220, 140)
ProgressBarFill.BorderSizePixel = 0
ProgressBarFill.Parent = ProgressBarBG

local BarFillUICorner = Instance.new("UICorner")
BarFillUICorner.CornerRadius = UDim.new(0, 3)
BarFillUICorner.Parent = ProgressBarFill

-- =================================================================
-- THIẾT KẾ MAIN FRAME CHÍNH (ẨN KHI ĐANG LOADING)
-- =================================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 480, 0, 320) 
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 16, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(40, 42, 54)
MainStroke.Thickness = 1.2
MainStroke.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(0.7, 0, 1, 0)
TitleText.Position = UDim2.new(0, 14, 0, 0)
TitleText.Text = "PRIME PRO V10.1 • TAB SYSTEM"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 12
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.BackgroundTransparency = 1
TitleText.Parent = TitleBar

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 24, 0, 24)
MinBtn.Position = UDim2.new(1, -32, 0, 7)
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.fromRGB(180, 185, 200)
MinBtn.BackgroundColor3 = Color3.fromRGB(32, 35, 47)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 11
MinBtn.BorderSizePixel = 0
MinBtn.Parent = TitleBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinBtn

local TabContainer = Instance.new("ScrollingFrame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(0, 120, 1, -48)
TabContainer.Position = UDim2.new(0, 8, 0, 42)
TabContainer.BackgroundTransparency = 1
TabContainer.BorderSizePixel = 0
TabContainer.ScrollBarThickness = 2
TabContainer.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Parent = TabContainer
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 6)

local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -140, 1, -48)
ContentContainer.Position = UDim2.new(0, 132, 0, 42)
ContentContainer.BackgroundTransparency = 1
ContentContainer.BorderSizePixel = 0
ContentContainer.Parent = MainFrame

local Pages = {}
local TabButtons = {}

local function SwitchTab(tabName)
    for name, page in pairs(Pages) do
        page.Visible = (name == tabName)
    end
    for name, btn in pairs(TabButtons) do
        if name == tabName then
            btn.BackgroundColor3 = Color3.fromRGB(0, 220, 140)
            btn.TextColor3 = Color3.fromRGB(15, 16, 22)
        else
            btn.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
            btn.TextColor3 = Color3.fromRGB(180, 185, 200)
        end
    end
end

local function CreateTab(tabName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
    btn.Text = tabName
    btn.TextColor3 = Color3.fromRGB(180, 185, 200)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.BorderSizePixel = 0
    btn.Parent = TabContainer
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    local page = Instance.new("ScrollingFrame")
    page.Name = tabName .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Color3.fromRGB(60, 64, 84)
    page.Visible = false
    page.Parent = ContentContainer

    local list = Instance.new("UIListLayout")
    list.Parent = page
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding = UDim.new(0, 6)
    
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 10)
    end)

    Pages[tabName] = page
    TabButtons[tabName] = btn

    btn.MouseButton1Click:Connect(function()
        SwitchTab(tabName)
    end)

    if #ContentContainer:GetChildren() == 2 then 
        SwitchTab(tabName)
    end

    return page
end

local DeltaIcon = Instance.new("TextButton")
DeltaIcon.Name = "DeltaIcon"
DeltaIcon.Size = UDim2.new(0, 45, 0, 45)
DeltaIcon.Position = UDim2.new(0.05, 0, 0.1, 0)
DeltaIcon.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
DeltaIcon.Text = "▲" 
DeltaIcon.TextColor3 = Color3.fromRGB(0, 220, 140)
DeltaIcon.Font = Enum.Font.GothamBold
DeltaIcon.TextSize = 18
DeltaIcon.Visible = false
DeltaIcon.Active = true
DeltaIcon.Draggable = true 
DeltaIcon.Parent = ScreenGui

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(0.5, 0)
IconCorner.Parent = DeltaIcon

local IconStroke = Instance.new("UIStroke")
IconStroke.Color = Color3.fromRGB(0, 220, 140)
IconStroke.Thickness = 1.5
IconStroke.Parent = DeltaIcon

local draggingIcon = false
local dragStartPos = Vector2.zero

DeltaIcon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingIcon = false
        dragStartPos = UserInputService:GetMouseLocation()
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        if (UserInputService:GetMouseLocation() - dragStartPos).Magnitude > 5 then
            draggingIcon = true
        end
    end
end)

DeltaIcon.MouseButton1Click:Connect(function()
    if not draggingIcon then
        DeltaIcon.Visible = false
        MainFrame.Visible = true
    end
end)

MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    DeltaIcon.Visible = true
end)

-- =================================================================
-- HÀM TẠO THÀNH PHẦN (UI BUILDERS)
-- =================================================================
local function GetTargetPage(tab)
    if tab == "Aimbot" then return Pages["Aimbot"]
    elseif tab == "ESP" then return Pages["ESP"]
    else return Pages["Khác"] end
end

function Menu:CreateToggle(tabName, text, defaultState, callback)
    local state = defaultState or false
    local parentPage = GetTargetPage(tabName)
    
    local rowFrame = Instance.new("Frame")
    rowFrame.Size = UDim2.new(1, 0, 0, 32)
    rowFrame.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
    rowFrame.BorderSizePixel = 0
    rowFrame.Parent = parentPage
    
    local rowCorner = Instance.new("UICorner")
    rowCorner.CornerRadius = UDim.new(0, 6)
    rowCorner.Parent = rowFrame

    local txtLabel = Instance.new("TextLabel")
    txtLabel.Size = UDim2.new(0.65, 0, 1, 0)
    txtLabel.Position = UDim2.new(0, 10, 0, 0)
    txtLabel.Text = text
    txtLabel.TextColor3 = Color3.fromRGB(215, 218, 230)
    txtLabel.Font = Enum.Font.GothamBold
    txtLabel.TextSize = 11
    txtLabel.TextXAlignment = Enum.TextXAlignment.Left
    txtLabel.BackgroundTransparency = 1
    txtLabel.Parent = rowFrame

    local switchBG = Instance.new("TextButton")
    switchBG.Size = UDim2.new(0, 38, 0, 20)
    switchBG.Position = UDim2.new(1, -46, 0.5, -10)
    switchBG.Text = ""
    switchBG.BorderSizePixel = 0
    switchBG.Parent = rowFrame

    local sbCorner = Instance.new("UICorner")
    sbCorner.CornerRadius = UDim.new(0, 10)
    sbCorner.Parent = switchBG

    local switchBall = Instance.new("Frame")
    switchBall.Size = UDim2.new(0, 14, 0, 14)
    switchBall.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    switchBall.BorderSizePixel = 0
    switchBall.Parent = switchBG

    local ballCorner = Instance.new("UICorner")
    ballCorner.CornerRadius = UDim.new(0.5, 0)
    ballCorner.Parent = switchBall

    local function toggleUI(animate)
        local targetPos = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
        local targetColor = state and Color3.fromRGB(0, 220, 140) or Color3.fromRGB(48, 51, 69)
        if animate then
            TweenService:Create(switchBall, TweenInfo.new(0.12), {Position = targetPos}):Play()
            TweenService:Create(switchBG, TweenInfo.new(0.12), {BackgroundColor3 = targetColor}):Play()
        else
            switchBall.Position = targetPos
            switchBG.BackgroundColor3 = targetColor
        end
    end
    toggleUI(false)

    switchBG.MouseButton1Click:Connect(function()
        state = not state
        toggleUI(true)
        if callback then pcall(callback, state) end
    end)
end

function Menu:CreateSlider(tabName, text, minVal, maxVal, startVal, callback)
    if not startVal then startVal = minVal end
    local parentPage = GetTargetPage(tabName)
    
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, 0, 0, 42)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Parent = parentPage

    local sfCorner = Instance.new("UICorner")
    sfCorner.CornerRadius = UDim.new(0, 6)
    sfCorner.Parent = sliderFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -16, 0, 18)
    label.Position = UDim2.new(0, 10, 0, 4)
    label.Text = text .. ": " .. startVal
    label.TextColor3 = Color3.fromRGB(160, 165, 185)
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Parent = sliderFrame

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -20, 0, 4)
    track.Position = UDim2.new(0, 10, 0, 28)
    track.BackgroundColor3 = Color3.fromRGB(48, 51, 69)
    track.BorderSizePixel = 0
    track.Parent = sliderFrame

    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(0, 2)
    trackCorner.Parent = track

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 220, 140)
    fill.BorderSizePixel = 0
    fill.Parent = track

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 2)
    fillCorner.Parent = fill

    local sliderBall = Instance.new("Frame")
    sliderBall.Size = UDim2.new(0, 11, 0, 11)
    sliderBall.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderBall.Position = UDim2.new(0, 0, 0.5, -5.5)
    sliderBall.BorderSizePixel = 0
    sliderBall.Parent = track

    local ballCorner = Instance.new("UICorner")
    ballCorner.CornerRadius = UDim.new(0.5, 0)
    ballCorner.Parent = sliderBall

    local function setFill(val)
        local percent = (val - minVal) / (maxVal - minVal)
        fill.Size = UDim2.new(math.clamp(percent, 0, 1), 0, 1, 0)
        sliderBall.Position = UDim2.new(math.clamp(percent, 0, 1), -5, 0.5, -5.5)
        label.Text = text .. ": " .. math.floor(val)
    end
    
    setFill(startVal)
    if callback then pcall(callback, startVal) end

    local holding = false
    local function updateSlider()
        local mousePos = UserInputService:GetMouseLocation().X
        local trackPos = track.AbsolutePosition.X
        local trackWidth = track.AbsoluteSize.X
        local percentage = math.clamp((mousePos - trackPos) / trackWidth, 0, 1)
        local currentVal = math.floor(minVal + (maxVal - minVal) * percentage)
        setFill(currentVal)
        if callback then pcall(callback, currentVal) end
    end

    sliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            holding = true
            updateSlider()
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            holding = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if holding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider()
        end
    end)
end

function Menu:CreateButton(tabName, text, callback)
    local parentPage = GetTargetPage(tabName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(220, 50, 70)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.BorderSizePixel = 0
    btn.Parent = parentPage

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(160, 30, 50)
        task.wait(0.1)
        btn.BackgroundColor3 = Color3.fromRGB(220, 50, 70)
        if callback then pcall(callback) end
    end)
end

-- KHỞI TẠO CÁC TAB CHÍNH
CreateTab("Aimbot")
CreateTab("ESP")
CreateTab("Khác")

-- =================================================================
-- LOGIC TÍNH NĂNG ĐÃ ĐƯỢC FIX LỖI AIMBOT & DYNAMIC FOV
-- =================================================================
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local aimbot1Enabled = false
local aimbot2Enabled = false
local aimbot3Enabled = false 
local fovEnabled = false
local fovRadius = 37 
local aimSmoothSpeed = 5
local fovCenterYPercent = 34 

local espEnemyEnabled = false
local espTeamEnabled = false
local espBoxEnabled = false
local speedEnabled = false
local targetSpeed = 16
local jumpEnabled = false
local targetJumpPower = 50

local isAiming = false
local espFolder = Instance.new("Folder", ScreenGui)
espFolder.Name = "ESP_Storage"

local fovCircleFrame = Instance.new("Frame", ScreenGui)
fovCircleFrame.Name = "FOVCircle"
fovCircleFrame.BackgroundTransparency = 1
fovCircleFrame.Visible = false

local fovStroke = Instance.new("UIStroke")
fovStroke.Color = Color3.fromRGB(255, 0, 70)
fovStroke.Thickness = 1.5
fovStroke.Parent = fovCircleFrame

local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(0.5, 0)
fovCorner.Parent = fovCircleFrame

-- Hàm lấy vị trí tâm FOV chính xác theo cấu hình thanh trượt
local function getCustomFOVCenter()
    local targetY = Camera.ViewportSize.Y * (fovCenterYPercent / 100)
    return Vector2.new(Camera.ViewportSize.X / 2, targetY)
end

-- Cập nhật đồng bộ hiển thị vòng FOV liên tục
RunService.RenderStepped:Connect(function()
    if fovEnabled then
        local customCenter = getCustomFOVCenter()
        fovCircleFrame.Size = UDim2.new(0, fovRadius * 2, 0, fovRadius * 2)
        fovCircleFrame.Position = UDim2.new(0, customCenter.X - fovRadius, 0, customCenter.Y - fovRadius)
        fovCircleFrame.Visible = true
    else
        fovCircleFrame.Visible = false
    end
end)

local function isTargetVisible(targetChar)
    if not LocalPlayer.Character or not targetChar then return false end
    local myHead = LocalPlayer.Character:FindFirstChild("Head")
    local targetHead = targetChar:FindFirstChild("Head")
    if not myHead or not targetHead then return false end
    local parts = Camera:GetPartsObscuringTarget({myHead.Position, targetHead.Position}, {LocalPlayer.Character, targetChar})
    return #parts == 0
end

local visibilityCache = {}
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

-- Thuật toán tìm kiếm mục tiêu tối ưu, sửa lỗi mất tác dụng khi đổi kích thước FOV
local function getClosestTargetToCustomCenter()
    local closestPlayer = nil
    -- RẤT QUAN TRỌNG: Khoảng cách ngắn nhất ban đầu phải khớp chính xác với bán kính FOV hiện tại
    local shortestDistance = fovRadius 
    local customCenter = getCustomFOVCenter()
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local isEnemy = (player.Team ~= LocalPlayer.Team) or (player.Team == nil and LocalPlayer.Team == nil)
            if isEnemy and player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChildOfClass("Humanoid") and player.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                if isTargetVisible(player.Character) then
                    local headPos, onScreen = Camera:WorldToViewportPoint(player.Character.Head.Position)
                    if onScreen then
                        -- Tính khoảng cách từ đầu mục tiêu đến TÂM FOV HIỆN TẠI chứ không tính đến tâm màn hình cũ
                        local magnitude = (Vector2.new(headPos.X, headPos.Y) - customCenter).Magnitude
                        if magnitude < shortestDistance then
                            shortestDistance = magnitude
                            closestPlayer = player.Character
                        end
                    end
                end
            end
        end
    end
    return closestPlayer
end

-- Xử lý chuyển động lia tâm Camera mượt mà
RunService.RenderStepped:Connect(function(deltaTime)
    if LoadingFrame.Parent == ScreenGui then return end -- Không chạy aimbot khi đang loading
    
    local target = getClosestTargetToCustomCenter()
    if target and target:FindFirstChild("Head") then
        if aimbot3Enabled then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Head.Position)
        elseif aimbot2Enabled or (aimbot1Enabled and isAiming) then
            local targetCFrame = CFrame.new(Camera.CFrame.Position, target.Head.Position)
            local speedFactor = aimSmoothSpeed * 3.5 
            Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, math.clamp(speedFactor * deltaTime, 0.05, 1))
        end
    end
end)

-- =================================================================
-- CÁC CHỨC NĂNG PHỤ TRỢ KHÁC (ESP, SPEED, JUMP, FIX LAG)
-- =================================================================
local function createESP(player)
    if player == LocalPlayer then return end
    local function initChar(char)
        if espFolder:FindFirstChild(player.Name) then espFolder[player.Name]:Destroy() end
        local mainStorage = Instance.new("Folder")
        mainStorage.Name = player.Name
        mainStorage.Parent = espFolder
        
        local boxHighlight = Instance.new("Highlight")
        boxHighlight.Name = "BoxESP"
        boxHighlight.FillTransparency = 1 
        boxHighlight.OutlineTransparency = 0
        boxHighlight.Adornee = char
        boxHighlight.Enabled = false
        boxHighlight.Parent = mainStorage
        
        local bGui = Instance.new("BillboardGui")
        bGui.Name = "TagESP"
        bGui.Size = UDim2.new(0, 180, 0, 40)
        bGui.AlwaysOnTop = true
        bGui.StudsOffset = Vector3.new(0, 3, 0)
        bGui.Adornee = char:FindFirstChild("Head")
        bGui.Enabled = false
        bGui.Parent = mainStorage
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextStrokeTransparency = 0 
        label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        label.Font = Enum.Font.SourceSansBold
        label.TextSize = 12
        label.Text = player.DisplayName
        label.Parent = label

        char.Destroying:Connect(function() mainStorage:Destroy() end)
    end
    if player.Character then initChar(player.Character) end
    player.CharacterAdded:Connect(initChar)
end

RunService.RenderStepped:Connect(function()
    local localChar = LocalPlayer.Character
    if not localChar or not localChar:FindFirstChild("HumanoidRootPart") then return end
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local mainStorage = espFolder:FindFirstChild(player.Name)
            local char = player.Character
            if mainStorage and char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Head") then
                local root = char.HumanoidRootPart
                local highlight = mainStorage:FindFirstChild("BoxESP")
                local tagGui = mainStorage:FindFirstChild("TagESP")
                local _, onScreen = Camera:WorldToViewportPoint(root.Position)
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                local isEnemy = (player.Team ~= LocalPlayer.Team) or (player.Team == nil and LocalPlayer.Team == nil)
                local allowedToShow = (isEnemy and espEnemyEnabled) or (not isEnemy and espTeamEnabled)

                if onScreen and allowedToShow and humanoid and humanoid.Health > 0 then
                    local visible = visibilityCache[player.Name] or false
                    local color = isEnemy and (visible and Color3.fromRGB(255, 0, 50) or Color3.fromRGB(255, 140, 0)) or (visible and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(0, 100, 40))
                    if highlight then
                        highlight.Enabled = espBoxEnabled
                        highlight.OutlineColor = color
                    end
                    if tagGui and tagGui:FindFirstChild("TextLabel") then
                        tagGui.Enabled = true
                        local dist = (root.Position - localChar.HumanoidRootPart.Position).Magnitude
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

local function refreshESPSystem()
    espFolder:ClearAllChildren()
    if espEnemyEnabled or espTeamEnabled then
        for _, p in ipairs(Players:GetPlayers()) do createESP(p) end
    end
end

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isAiming = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isAiming = false
    end
end)

task.spawn(function()
    while true do
        task.wait()
        if speedEnabled and LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.WalkSpeed = targetSpeed end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if jumpEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = targetJumpPower
            humanoid.UseJumpPower = true
        end
    end
end)

Players.PlayerAdded:Connect(createESP)
for _, p in ipairs(Players:GetPlayers()) do createESP(p) end

-- NẠP CHỨC NĂNG VÀO CÁC TAB
Menu:CreateToggle("Aimbot", "Aimbot 3 (Khóa Cứng Cực Nhanh)", false, function(state) aimbot3Enabled = state end)
Menu:CreateToggle("Aimbot", "Aimbot 2 (Tự Động Khóa + Lia)", false, function(state) aimbot2Enabled = state end)
Menu:CreateSlider("Aimbot", "Độ Lia Tâm (Cho Aimbot 2)", 1, 10, 5, function(value) aimSmoothSpeed = value end)
Menu:CreateToggle("Aimbot", "Aimbot Pro (Nhấn Giữ)", false, function(state) aimbot1Enabled = state end)
Menu:CreateToggle("Aimbot", "Hiển Thị Vòng FOV", false, function(state) fovEnabled = state end)
Menu:CreateSlider("Aimbot", "Bán Kính Vòng FOV", 15, 250, 37, function(value) fovRadius = value end)
Menu:CreateSlider("Aimbot", "Vị Trí FOV Dọc", 10, 90, 34, function(value) fovCenterYPercent = value end)

Menu:CreateToggle("ESP", "ESP Kẻ Địch (Enemy)", false, function(state) espEnemyEnabled = state; refreshESPSystem() end)
Menu:CreateToggle("ESP", "ESP Đồng Đội (Team)", false, function(state) espTeamEnabled = state; refreshESPSystem() end)
Menu:CreateToggle("ESP", "ESP Khung 2D (Box)", false, function(state) espBoxEnabled = state end)

Menu:CreateToggle("Khác", "Hack Tốc Độ (Speed)", false, function(state) 
    speedEnabled = state
    if not speedEnabled and LocalPlayer.Character then
        local h = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = 16 end
    end
end)
Menu:CreateSlider("Khác", "Tốc Độ Chạy", 16, 150, 16, function(value) targetSpeed = value end)

Menu:CreateToggle("Khác", "Hack Nhảy Cao (Jump)", false, function(state) 
    jumpEnabled = state
    if not jumpEnabled and LocalPlayer.Character then
        local h = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then h.JumpPower = 50; h.UseJumpPower = false end
    end
end)
Menu:CreateSlider("Khác", "Độ Cao Nhảy", 50, 350, 50, function(value) targetJumpPower = value end)

Menu:CreateButton("Khác", "💥 FIX LAG CỰC MẠNH - GIẢM ĐỒ HỌA TỐI ĐA 💥", function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    Lighting.GlobalShadows = false
    Lighting.ShadowSoftness = 0
    Lighting.Brightness = 2
    Lighting.ClockTime = 12
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Sparkles") or obj:IsA("Explosion") or obj:IsA("Fire") then
            obj.Enabled = false
        elseif obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("MeshPart") then
            obj.Transparency = 0.5
        elseif obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
        end
    end
    pcall(function()
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") then v.Enabled = false end
        end
    end)
    collectgarbage("collect")
end)

-- =================================================================
-- CHẠY HIỆU ỨNG LOADING SCREEN (TỪ 0% ĐẾN 100%)
-- =================================================================
task.spawn(function()
    local currentPercent = 0
    while currentPercent < 100 do
        local increment = math.random(3, 8)
        currentPercent = math.min(currentPercent + increment, 100)
        PercentText.Text = tostring(currentPercent) .. "%"
        
        local progressTween = TweenService:Create(ProgressBarFill, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(currentPercent / 100, 0, 1, 0)
        })
        progressTween:Play()
        task.wait(math.random(5, 15) / 100)
    end
    
    LoadTitle.Text = "HOÀN TẤT KHỞI ĐỘNG!"
    PercentText.TextColor3 = Color3.fromRGB(255, 255, 255)
    task.wait(0.4)
    
    local fadeTween = TweenService:Create(LoadingFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    })
    TweenService:Create(LoadTitle, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
    TweenService:Create(PercentText, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
    TweenService:Create(ProgressBarBG, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
    TweenService:Create(ProgressBarFill, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
    TweenService:Create(LoadStroke, TweenInfo.new(0.2), {Transparency = 1}):Play()
    
    fadeTween:Play()
    fadeTween.Completed:Wait()
    
    LoadingFrame:Destroy()
    MainFrame.Visible = true
end)

