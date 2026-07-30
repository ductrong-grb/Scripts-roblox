local Utilities = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

Utilities.Settings = {
    speedEnabled = false,
    targetSpeed = 16,
    jumpEnabled = false,
    targetJumpPower = 50
}

function Utilities.Init()
    -- Vòng lặp duy trì Tốc độ chạy ổn định
    task.spawn(function()
        while true do
            task.wait()
            if Utilities.Settings.speedEnabled and LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid.WalkSpeed = Utilities.Settings.targetSpeed end
            end
        end
    end)

    -- Đồng bộ độ cao lực nhảy liên tục thông qua RenderStepped
    RunService.RenderStepped:Connect(function()
        if Utilities.Settings.jumpEnabled and LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = Utilities.Settings.targetJumpPower
                humanoid.UseJumpPower = true
            end
        end
    end)
end

-- Tính năng giảm cấu trúc đồ họa tối đa
function Utilities.OptimizeGame()
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
end

return Utilities
