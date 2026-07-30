local UI = {}

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function UI.CreateMenu(Modules)
    local Aimbot = Modules.Aimbot
    local ESP = Modules.ESP
    local Utilities = Modules.Utilities

    -- Khởi tạo ScreenGui
    if CoreGui:FindFirstChild("MyCustomHackMenu") then
        CoreGui.MyCustomHackMenu:Destroy()
    end
    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "MyCustomHackMenu"
    ScreenGui.ResetOnSpawn = false

    -- Kích hoạt cài đặt sâu cho các File logic lõi
    Aimbot.Init(ScreenGui)
    ESP.Init(ScreenGui, Aimbot)
    Utilities.Init()

    -- -----------------------------------------------------------------
    -- TẠO MÀN HÌNH KHỞI ĐỘNG (LOADING SCREEN)
    -- -----------------------------------------------------------------
    local LoadingFrame = Instance.new("Frame", ScreenGui)
    LoadingFrame.Name = "LoadingFrame"
    LoadingFrame.Size = UDim2.new(0, 320, 0, 110)
    LoadingFrame.Position = UDim2.new(0.5, -160, 0.5, -55)
    LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 16, 22)
    LoadingFrame.BorderSizePixel = 0

    local LoadCorner = Instance.new("UICorner", LoadingFrame)
    LoadCorner.CornerRadius = UDim.new(0, 10)

    local LoadStroke = Instance.new("UIStroke", LoadingFrame)
    LoadStroke.Color = Color3.fromRGB(0, 220, 140)
    LoadStroke.Thickness = 1.2

    local LoadTitle = Instance.new("TextLabel", LoadingFrame)
    LoadTitle.Size = UDim2.new(1, 0, 0, 30)
    LoadTitle.Position = UDim2.new(0, 0, 0, 15)
    LoadTitle.Text = "ĐANG KHỞI CHẠY HỆ THỐNG..."
    LoadTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadTitle.Font = Enum.Font.GothamBold
    LoadTitle.TextSize = 13
    LoadTitle.BackgroundTransparency = 1

    local PercentText = Instance.new("TextLabel", LoadingFrame)
    PercentText.Size = UDim2.new(1, 0, 0, 20)
    PercentText.Position = UDim2.new(0, 0, 0, 40)
    PercentText.Text = "0%"
    PercentText.TextColor3 = Color3.fromRGB(0, 220, 140)
    PercentText.Font = Enum.Font.GothamMedium
    PercentText.TextSize = 12
    PercentText.BackgroundTransparency = 1

    local ProgressBarBG = Instance.new("Frame", LoadingFrame)
    ProgressBarBG.Size = UDim2.new(0, 260, 0, 6)
    ProgressBarBG.Position = UDim2.new(0.5, -130, 0, 72)
    ProgressBarBG.BackgroundColor3 = Color3.fromRGB(32, 35, 47)
    ProgressBarBG.BorderSizePixel = 0

    local BarBGUICorner = Instance.new("UICorner", ProgressBarBG)
    BarBGUICorner.CornerRadius = UDim.new(0, 3)

    local ProgressBarFill = Instance.new("Frame", ProgressBarBG)
    ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
    ProgressBarFill.BackgroundColor3 = Color3.fromRGB(0, 220, 140)
    ProgressBarFill.BorderSizePixel = 0

    local BarFillUICorner = Instance.new("UICorner", ProgressBarFill)
    BarFillUICorner.CornerRadius = UDim.new(0, 3)

    -- -----------------------------------------------------------------
    -- THIẾT KẾ MAIN FRAME CHÍNH
    -- -----------------------------------------------------------------
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 480, 0, 320) 
    MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 16, 22)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Visible = false

    local MainCorner = Instance.new("UICorner", MainFrame)
    MainCorner.CornerRadius = UDim.new(0, 10)

    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = Color3.fromRGB(40, 42, 54)
    MainStroke.Thickness = 1.2

    local TitleBar = Instance.new("Frame", MainFrame)
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 38)
    TitleBar.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
    TitleBar.BorderSizePixel = 0

    local TitleCorner = Instance.new("UICorner", TitleBar)
    TitleCorner.CornerRadius = UDim.new(0, 10)

    local TitleText = Instance.new("TextLabel", TitleBar)
    TitleText.Size = UDim2.new(0.7, 0, 1, 0)
    TitleText.Position = UDim2.new(0, 14, 0, 0)
    TitleText.Text = "PRIME PRO V10.3.1 • MODULAR"
    TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleText.Font = Enum.Font.GothamBold
    TitleText.TextSize = 12
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.BackgroundTransparency = 1

    local MinBtn = Instance.new("TextButton", TitleBar)
    MinBtn.Size = UDim2.new(0, 24, 0, 24)
    MinBtn.Position = UDim2.new(1, -32, 0, 7)
    MinBtn.Text = "—"
    MinBtn.TextColor3 = Color3.fromRGB(180, 185, 200)
    MinBtn.BackgroundColor3 = Color3.fromRGB(32, 35, 47)
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = 11
    MinBtn.BorderSizePixel = 0

    local MinCorner = Instance.new("UICorner", MinBtn)
    MinCorner.CornerRadius = UDim.new(0, 6)

    local TabContainer = Instance.new("ScrollingFrame", MainFrame)
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 120, 1, -48)
    TabContainer.Position = UDim2.new(0, 8, 0, 42)
    TabContainer.BackgroundTransparency = 1
    TabContainer.BorderSizePixel = 0
    TabContainer.ScrollBarThickness = 2

    local TabListLayout = Instance.new("UIListLayout", TabContainer)
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 6)

    local ContentContainer = Instance.new("Frame", MainFrame)
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -140, 1, -48)
    ContentContainer.Position = UDim2.new(0, 132, 0, 42)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.BorderSizePixel = 0

    local Pages = {}
    local TabButtons = {}

    local function SwitchTab(tabName)
        for name, page in pairs(Pages) do page.Visible = (name == tabName) end
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
        local btn = Instance.new("TextButton", TabContainer)
        btn.Size = UDim2.new(1, 0, 0, 34)
        btn.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
        btn.Text = tabName
        btn.TextColor3 = Color3.fromRGB(180, 185, 200)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.BorderSizePixel = 0
        
        local corner = Instance.new("UICorner", btn)
        corner.CornerRadius = UDim.new(0, 6)

        local page = Instance.new("ScrollingFrame", ContentContainer)
        page.Name = tabName .. "Page"
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.BorderSizePixel = 0
        page.ScrollBarThickness = 3
        page.ScrollBarImageColor3 = Color3.fromRGB(60, 64, 84)
        page.Visible = false

        local list = Instance.new("UIListLayout", page)
        list.SortOrder = Enum.SortOrder.LayoutOrder
        list.Padding = UDim.new(0, 6)
        
        list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            page.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 10)
        end)

        Pages[tabName] = page
        TabButtons[tabName] = btn
        btn.MouseButton1Click:Connect(function() SwitchTab(tabName) end)

        if #ContentContainer:GetChildren() == 2 then SwitchTab(tabName) end
        return page
    end

    -- Tạo nút Icon nổi của Delta khi ẩn menu
    local DeltaIcon = Instance.new("TextButton", ScreenGui)
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

    local IconCorner = Instance.new("UICorner", DeltaIcon)
    IconCorner.CornerRadius = UDim.new(0.5, 0)

    local IconStroke = Instance.new("UIStroke", DeltaIcon)
    IconStroke.Color = Color3.fromRGB(0, 220, 140)
    IconStroke.Thickness = 1.5

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
            if (UserInputService:GetMouseLocation() - dragStartPos).Magnitude > 5 then draggingIcon = true end
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

    local function GetTargetPage(tab)
        if tab == "Aimbot" then return Pages["Aimbot"]
        elseif tab == "ESP" then return Pages["ESP"]
        else return Pages["Khác"] end
    end

    -- Các Hàm hỗ trợ dựng nút trong UI nội bộ
    local MenuElements = {}

    function MenuElements:CreateToggle(tabName, text, defaultState, callback)
        local parentPage = GetTargetPage(tabName)
        local rowFrame = Instance.new("Frame", parentPage)
        rowFrame.Size = UDim2.new(1, 0, 0, 32)
        rowFrame.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
        rowFrame.BorderSizePixel = 0
        
        local rowCorner = Instance.new("UICorner", rowFrame)
        rowCorner.CornerRadius = UDim.new(0, 6)

        local txtLabel = Instance.new("TextLabel", rowFrame)
        txtLabel.Size = UDim2.new(0.65, 0, 1, 0)
        txtLabel.Position = UDim2.new(0, 10, 0, 0)
        txtLabel.Text = text
        txtLabel.TextColor3 = Color3.fromRGB(215, 218, 230)
        txtLabel.Font = Enum.Font.GothamBold
        txtLabel.TextSize = 11
        txtLabel.TextXAlignment = Enum.TextXAlignment.Left
        txtLabel.BackgroundTransparency = 1

        local switchBG = Instance.new("TextButton", rowFrame)
        switchBG.Size = UDim2.new(0, 38, 0, 20)
        switchBG.Position = UDim2.new(1, -46, 0.5, -10)
        switchBG.Text = ""
        switchBG.BorderSizePixel = 0

        local sbCorner = Instance.new("UICorner", switchBG)
        sbCorner.CornerRadius = UDim.new(0, 10)

        local switchBall = Instance.new("Frame", switchBG)
        switchBall.Size = UDim2.new(0, 14, 0, 14)
        switchBall.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        switchBall.BorderSizePixel = 0

        local ballCorner = Instance.new("UICorner", switchBall)
        ballCorner.CornerRadius = UDim.new(0.5, 0)

        local state = defaultState or false
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

    function MenuElements:CreateSlider(tabName, text, minVal, maxVal, startVal, callback)
        if not startVal then startVal = minVal end
        local parentPage = GetTargetPage(tabName)
        
        local sliderFrame = Instance.new("Frame", parentPage)
        sliderFrame.Size = UDim2.new(1, 0, 0, 42)
        sliderFrame.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
        sliderFrame.BorderSizePixel = 0

        local sfCorner = Instance.new("UICorner", sliderFrame)
        sfCorner.CornerRadius = UDim.new(0, 6)

        local label = Instance.new("TextLabel", sliderFrame)
        label.Size = UDim2.new(1, -16, 0, 18)
        label.Position = UDim2.new(0, 10, 0, 4)
        label.Text = text .. ": " .. startVal
        label.TextColor3 = Color3.fromRGB(160, 165, 185)
        label.Font = Enum.Font.GothamMedium
        label.TextSize = 10
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1

        local track = Instance.new("Frame", sliderFrame)
        track.Size = UDim2.new(1, -20, 0, 4)
        track.Position = UDim2.new(0, 10, 0, 28)
        track.BackgroundColor3 = Color3.fromRGB(48, 51, 69)
        track.BorderSizePixel = 0

        local trackCorner = Instance.new("UICorner", track)
        trackCorner.CornerRadius = UDim.new(0, 2)

        local fill = Instance.new("Frame", track)
        fill.Size = UDim2.new(0, 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(0, 220, 140)
        fill.BorderSizePixel = 0

        local fillCorner = Instance.new("UICorner", fill)
        fillCorner.CornerRadius = UDim.new(0, 2)

        local sliderBall = Instance.new("Frame", track)
        sliderBall.Size = UDim2.new(0, 11, 0, 11)
        sliderBall.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        sliderBall.Position = UDim2.new(0, 0, 0.5, -5.5)
        sliderBall.BorderSizePixel = 0

        local ballCorner = Instance.new("UICorner", sliderBall)
        ballCorner.CornerRadius = UDim.new(0.5, 0)

        local function setFill(val)
            local percent = (val - minVal) / (maxVal - minVal)
            fill.Size = UDim2.new(math.clamp(percent, 0, 1), 0, 1, 0)
            sliderBall.Position = UDim2.new(math.clamp(percent, 0, 1), -5, 0.5, -5.5)
            label.Text = text .. ": " .. math.floor(val)
        end
        
        setFill(startVal)
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
                holding = true; updateSlider()
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then holding = false end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if holding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateSlider() end
        end)
    end

    function MenuElements:CreateButton(tabName, text, callback)
        local parentPage = GetTargetPage(tabName)
        local btn = Instance.new("TextButton", parentPage)
        btn.Size = UDim2.new(1, 0, 0, 32)
        btn.BackgroundColor3 = Color3.fromRGB(220, 50, 70)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.BorderSizePixel = 0

        local btnCorner = Instance.new("UICorner", btn)
        btnCorner.CornerRadius = UDim.new(0, 6)

        btn.MouseButton1Click:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(160, 30, 50)
            task.wait(0.1)
            btn.BackgroundColor3 = Color3.fromRGB(220, 50, 70)
            if callback then pcall(callback) end
        end)
    end

    -- Khởi tạo Tabs
    CreateTab("Aimbot")
    CreateTab("ESP")
    CreateTab("Khác")

    -- Lắng nghe sự kiện chuột/chạm toàn cục cho hệ thống ngắm bắn nhấn giữ
    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Aimbot.Settings.isAiming = true
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Aimbot.Settings.isAiming = false
        end
    end)

    -- Hiệu ứng chạy thanh phần trăm màn hình chờ (Loading)
    task.spawn(function()
        local currentPercent = 0
        while currentPercent < 100 do
            local increment = math.random(4, 9)
            currentPercent = math.min(currentPercent + increment, 100)
            PercentText.Text = tostring(currentPercent) .. "%"
            TweenService:Create(ProgressBarFill, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(currentPercent / 100, 0, 1, 0)
            }):Play()
            task.wait(math.random(3, 10) / 100)
        end
        
        LoadTitle.Text = "HOÀN TẤT KHỞI ĐỘNG!"
        PercentText.TextColor3 = Color3.fromRGB(255, 255, 255)
        task.wait(0.3)
        
        local fadeTween = TweenService:Create(LoadingFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
        TweenService:Create(LoadTitle, TweenInfo.new(0.15), {TextTransparency = 1}):Play()
        TweenService:Create(PercentText, TweenInfo.new(0.15), {TextTransparency = 1}):Play()
        TweenService:Create(ProgressBarBG, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
        TweenService:Create(ProgressBarFill, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
        TweenService:Create(LoadStroke, TweenInfo.new(0.15), {Transparency = 1}):Play()
        
        fadeTween:Play()
        fadeTween.Completed:Wait()
        
        LoadingFrame:Destroy()
        MainFrame.Visible = true
    end)

    return MenuElements
end

return UI
Q
