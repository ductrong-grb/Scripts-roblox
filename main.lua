-- =================================================================
-- HỆ THỐNG ĐIỀU PHỐI CHÍNH (MAIN HUB) - PREMIUM V10.3.1
-- =================================================================

-- CHÚ Ý: Hãy thay thế toàn bộ link ví dụ dưới đây bằng link RAW thật trên GitHub của bạn!
local AIMBOT_URL = "https://raw.githubusercontent.com/TenGitHubCuaBan/TenRepo/main/aimbot.lua"
local ESP_URL    = "https://raw.githubusercontent.com/TenGitHubCuaBan/TenRepo/main/esp.lua"
local UTILS_URL  = "https://raw.githubusercontent.com/TenGitHubCuaBan/TenRepo/main/utilities.lua"
local UI_URL     = "https://raw.githubusercontent.com/TenGitHubCuaBan/TenRepo/main/ui.lua"

print("[System] Bắt đầu tải các phân đoạn mã nguồn...")

-- Tải an toàn (pcall) để tránh lỗi mạng làm crash script giữa chừng
local function SafeLoad(url, name)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if success and result then
        print("[System] Tải thành công module: " .. name)
        return result
    else
        warn("[Critical Error] Không thể kết nối với: " .. name .. " | Chi tiết: " .. tostring(result))
        return nil
    end
end

-- Thực hiện nạp 3 file logic lõi trước
local AimbotModule   = SafeLoad(AIMBOT_URL, "Aimbot Core")
local ESPModule      = SafeLoad(ESP_URL, "ESP Core")
local UtilitiesModule = SafeLoad(UTILS_URL, "Utilities Core")
local UIModule        = SafeLoad(UI_URL, "User Interface")

if not (AimbotModule and ESPModule and UtilitiesModule and UIModule) then
    error("[Fatal System Error] Quá trình tải thất bại. Vui lòng kiểm tra lại đường dẫn link Raw GitHub.")
end

-- Ráp nối các module vào một bảng trung gian
local Modules = {
    Aimbot = AimbotModule,
    ESP = ESPModule,
    Utilities = UtilitiesModule
}

-- Khởi chạy UI và nhận về đối tượng cấu trúc các thành phần điều khiển
local Menu = UIModule.CreateMenu(Modules)

-- =================================================================
-- ĐỒNG BỘ NÚT BẤM (UI CALLBACKS) VÀ DỮ LIỆU LÕI
-- =================================================================

-- 1. Cấu hình Tab Aimbot
Menu:CreateToggle("Aimbot", "🔥 AIMBOT 4 (SIÊU CẤP ĐÓNG ĐINH Ở GẦN) 🔥", false, function(state) Modules.Aimbot.Settings.aimbot4Enabled = state end)
Menu:CreateToggle("Aimbot", "Aimbot 3 (Khóa Cứng 100%)", false, function(state) Modules.Aimbot.Settings.aimbot3Enabled = state end)
Menu:CreateToggle("Aimbot", "Aimbot 2 (Tự Động Lia Mượt)", false, function(state) Modules.Aimbot.Settings.aimbot2Enabled = state end)
Menu:CreateSlider("Aimbot", "Độ Mượt Lia Tâm (Cho Aimbot 2)", 1, 10, 5, function(value) Modules.Aimbot.Settings.aimSmoothSpeed = value end)
Menu:CreateToggle("Aimbot", "Aimbot 1 (Nhấn Giữ Chuột/Touch)", false, function(state) Modules.Aimbot.Settings.aimbot1Enabled = state end)
Menu:CreateToggle("Aimbot", "Hiển Thị Vòng FOV", false, function(state) Modules.Aimbot.Settings.fovEnabled = state end)
Menu:CreateSlider("Aimbot", "Bán Kính Vòng FOV", 15, 250, 37, function(value) Modules.Aimbot.Settings.fovRadius = value end)
Menu:CreateSlider("Aimbot", "Vị Trí FOV Dọc", 10, 90, 34, function(value) Modules.Aimbot.Settings.fovCenterYPercent = value end)

-- 2. Cấu hình Tab ESP
Menu:CreateToggle("ESP", "ESP Kẻ Địch (Enemy)", false, function(state) Modules.ESP.Settings.espEnemyEnabled = state; Modules.ESP.Refresh() end)
Menu:CreateToggle("ESP", "ESP Đồng Đội (Team)", false, function(state) Modules.ESP.Settings.espTeamEnabled = state; Modules.ESP.Refresh() end)
Menu:CreateToggle("ESP", "ESP Khung 2D (Box)", false, function(state) Modules.ESP.Settings.espBoxEnabled = state end)

-- 3. Cấu hình Tab Khác
Menu:CreateToggle("Khác", "Hack Tốc Độ (Speed)", false, function(state) 
    Modules.Utilities.Settings.speedEnabled = state
    if not state then
        pcall(function() game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16 end)
    end
end)
Menu:CreateSlider("Khác", "Tốc Độ Chạy", 16, 150, 16, function(value) Modules.Utilities.Settings.targetSpeed = value end)

Menu:CreateToggle("Khác", "Hack Nhảy Cao (Jump)", false, function(state) 
    Modules.Utilities.Settings.jumpEnabled = state
    if not state then
        pcall(function() 
            local h = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if h then h.JumpPower = 50; h.UseJumpPower = false end
        end)
    end
end)
Menu:CreateSlider("Khác", "Độ Cao Nhảy", 50, 350, 50, function(value) Modules.Utilities.Settings.targetJumpPower = value end)

Menu:CreateButton("Khác", "💥 FIX LAG CỰC MẠNH - GIẢM ĐỒ HỌA TỐI ĐA 💥", function()
    Modules.Utilities.OptimizeGame()
end)

print("[System] Hệ thống Prime Pro kết nối mô-đun thành công và sẵn sàng!")
