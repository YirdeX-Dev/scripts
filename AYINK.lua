local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local repo = "https://raw.githubusercontent.com/YirdeX-Dev/obsidian_UI/refs/heads/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local SaveManager =loadstring(game:HttpGet(repo .. "SaveManager.lua"))()
local ThemeManager =loadstring(game:HttpGet(repo .. "ThemeManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

local Window = Library:CreateWindow({
    Title = "AY-墨水游戏",
    Footer = "AY-墨水游戏 | YirdeX 秋辞 开发",
    Size = UDim2.fromOffset(750, 650),
    Icon = "rbxassetid://135482947625817",
    AutoShow = true,
    NotifySide = "Right",
    ShowCustomCursor = true,
    IconSize = UDim2.fromOffset(30, 30),
    Resizable = true,
    MobileButtonsSide = "Left",
    DisableSearch = false,
    SearchbarSize = UDim2.new(0.8, 0, 1, 0),
    GlobalSearch = false,
    Position = UDim2.fromOffset(100, 100),
    Center = true,
    EnableSidebarResize = true,
    EnableCompacting = true,
    SidebarCompacted = false,
    MinContainerWidth = 256,
})

local Tabs = {
    Main = Window:AddTab("游戏", "info"),
    battle = Window:AddTab("战斗", "sword"),
    Wanjia = Window:AddTab("杂项", "layout-grid"),
    Players = Window:AddTab("玩家信息", "user"),
    guard = Window:AddTab("守卫", "shield"),
    Settings = Window:AddTab("设置", "settings"),
}

local LeftGroup = Tabs.Main:AddLeftGroupbox("红绿灯" , "siren")
local Afmsktb = Tabs.Main:AddLeftGroupbox("抠糖饼", "cookie")
local Tug_Of_War = Tabs.Main:AddLeftGroupbox("拔河", "git-commit-horizontal")
local Qctiaos = Tabs.Main:AddLeftGroupbox("跳绳", "zodiac-libra")
local Qcplq = Tabs.Main:AddLeftGroupbox("破璃桥", "grid-2x2")
local RightGroup = Tabs.Main:AddRightGroupbox("熄灯", "lightbulb-off")
local Qczmcgn = Tabs.Main:AddRightGroupbox("捉迷藏", "door-closed")
local Fpgn = Tabs.Main:AddRightGroupbox("反叛", "skull")
local Miong = Tabs.Main:AddRightGroupbox("旋转木马", "drama")
local Znrdjd = Tabs.Main:AddRightGroupbox("鱿鱼游戏", "shapes")
local Tkyx = Tabs.Main:AddLeftGroupbox("天空游戏", "tower-control")

local Remotes = nil
local pullRopeRemote = nil
local qteRemote = nil
local temporaryReached = nil

pcall(function()
    Remotes = ReplicatedStorage:WaitForChild("Remotes", 15)
end)

if Remotes then
    pullRopeRemote = Remotes:FindFirstChild("PullRope")
    qteRemote = Remotes:FindFirstChild("QTE")
    temporaryReached = Remotes:FindFirstChild("TemporaryReachedBindable")
end

-- ==================== Maid ====================
local Maid = {}
Maid.__index = Maid

function Maid.new()
    return setmetatable({ Tasks = {} }, Maid)
end

function Maid:GiveTask(task)
    table.insert(self.Tasks, task)
    return task
end

function Maid:DoCleaning()
    for _, task in ipairs(self.Tasks) do
        pcall(function()
            if typeof(task) == "RBXScriptConnection" then
                task:Disconnect()
            elseif typeof(task) == "Instance" then
                task:Destroy()
            elseif typeof(task) == "function" then
                task()
            elseif typeof(task) == "thread" then
                task:cancel()
            end
        end)
    end
    self.Tasks = {}
end

local tugMaid = Maid.new()
local mode = "合法"

-- ==================== 发送拉绳请求 ====================
local function sendPullRequest()
    pcall(function()
        if temporaryReached then
            temporaryReached:FireServer({})
        end
    end)
    pcall(function()
        if pullRopeRemote then
            pullRopeRemote:FireServer()
        end
    end)
    pcall(function()
        if qteRemote then
            qteRemote:FireServer("Press")
        end
    end)
end

-- ==================== 自动拔河开关 ====================
Tug_Of_War:AddToggle("AutoTug", {
    Text = "自动拔河",
    Default = false,
    Tooltip = "开启后自动进行拔河操作",
    Callback = function(enabled)
        if enabled then
            tugMaid:DoCleaning()
            tugMaid:GiveTask(task.spawn(function()
                while Toggles.AutoTug and Toggles.AutoTug.Value do
                    if mode == "暴力" then
                        -- 暴力模式：1秒20次 = 每0.05秒一次
                        task.wait(0.05)
                    else
                        -- 合法模式：1秒5次 = 每0.2秒一次
                        task.wait(0.2)
                    end
                    sendPullRequest()
                end
            end))
        else
            tugMaid:DoCleaning()
        end
    end
})

-- ==================== 模式选择 ====================
Tug_Of_War:AddDropdown("ModeDropdown", {
    Text = "操作模式",
    Values = {"合法", "暴力"},
    Default = "合法",
    Callback = function(value)
        mode = value
        if Toggles.AutoTug and Toggles.AutoTug.Value then
            Toggles.AutoTug:SetValue(false)
            Toggles.AutoTug:SetValue(true)
        end
    end
})

-- ==================== 卸载清理 ====================
Library:OnUnload(function()
    tugMaid:DoCleaning()
end)
--红绿灯
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    warn("等待玩家加载...")
    LocalPlayer = Players.LocalPlayer
end
LeftGroup:AddButton("传送到终点", function()
    if not LocalPlayer then
        warn("LocalPlayer 不存在")
        return
    end    
    local Character = LocalPlayer.Character
    if not Character then
        warn("角色不存在，等待角色加载...")
        Character = LocalPlayer.CharacterAdded:Wait()
    end
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 5)
    if not HumanoidRootPart then
        warn("未找到 HumanoidRootPart")
        return
    end
    if not HumanoidRootPart:IsA("BasePart") then
        warn("HumanoidRootPart 不是 BasePart")
        return
    end
    local targetPosition = Vector3.new(-45, 1026, 136.7)
    HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if Humanoid then
        Humanoid.PlatformStand = true
        task.wait(0.1)
        Humanoid.PlatformStand = false
    end    
    print("传送完成！位置: " .. tostring(targetPosition))
end)

LeftGroup:AddButton("移除受伤状态", function()
    local Player = LocalPlayer
    local Char = Player.Character
    local Hum = Char:FindFirstChild("Humanoid")
    local RootPart = Char:FindFirstChild("HumanoidRootPart")
    local Torso = Char:FindFirstChild("Torso")    
    Hum.PlatformStand = false
    Hum:ChangeState(Enum.HumanoidStateType.GettingUp)
    Hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
    Hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    Hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
    Hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    Hum:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
    Hum:SetStateEnabled(Enum.HumanoidStateType.Flying, false)
    Hum:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, false)
    Hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)    
    for _, Constraint in pairs(RootPart:GetChildren()) do
        if Constraint:IsA("BallSocketConstraint") then
            Constraint:Destroy()
        end
    end    
    for _, Part in pairs(Char:GetChildren()) do
        if Part:IsA("BasePart") and Part:FindFirstChild("BoneCustom") then
            Part.BoneCustom:Destroy()
        end
    end    
    local RagdollTag = Char:FindFirstChild("Ragdoll")
    if RagdollTag then RagdollTag:Destroy() end    
    local StunTag = Char:FindFirstChild("Stun")
    if StunTag then StunTag:Destroy() end    
    local RotateDisabled = Char:FindFirstChild("RotateDisabled")
    if RotateDisabled then RotateDisabled:Destroy() end    
    local WakeupImmunity = Char:FindFirstChild("RagdollWakeupImmunity")
    if WakeupImmunity then WakeupImmunity:Destroy() end    
    local LocalRagdoll = workspace:FindFirstChild("Effects"):FindFirstChild("LocalRagdolls"):FindFirstChild(Player.Name)
    if LocalRagdoll then LocalRagdoll:Destroy() end
end)
LeftGroup:AddToggle('TeleportToggle_Hide', {
    Text = '上帝模式',
    Default = false,
    Tooltip = '传送',
    Callback = function(Value)
        local LocalPlayer = game:GetService("Players").LocalPlayer
        local Character = LocalPlayer.Character
        if not Character then return end        
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        if not RootPart then return end
        
        local Position = RootPart.Position
        local TargetY = Value and Position.Y + 200 or Position.Y - 100
        local Part = Instance.new("Part")
        Part.Size = Vector3.new(10, 10, 10)
        Part.Position = RootPart.Position
        Part.Anchored = true
        Part.Transparency = 0.8
        Part.Material = Enum.Material.Neon
        Part.BrickColor = BrickColor.new("Bright blue")
        Part.Parent = workspace
        RootPart.CFrame = CFrame.new(Vector3.new(Position.X, TargetY, Position.Z))
        task.wait(0.5)
        Part:Destroy()
    end
})
Afmsktb:AddToggle("DalgonaGodMode", {
    Text = "饼干不碎",
    Default = false,
    Tooltip = "通过阻止裂纹效果使你不可能折断椪糖饼干。",
    Callback = function(Value)
        if Value then
            local success, err = pcall(function()
                local SharedFunctions = require(ReplicatedStorage.Modules.SharedFunctions)
                local oldPlaySound = SharedFunctions.PlaySound

                -- Hook PlaySound 阻止裂纹声音和效果触发
                SharedFunctions.PlaySound = newcclosure(function(...)
                    local args = {...}
                    local soundId = args[1]
                    -- 阻止裂纹相关的声音播放
                    if soundId and (tostring(soundId):find("crack") or tostring(soundId):find("break")) then
                        return nil
                    end
                    return oldPlaySound(...)
                end)

                -- 同时Hook原始函数引用
                hookfunction(oldPlaySound, newcclosure(function(...)
                    local args = {...}
                    local soundId = args[1]
                    if soundId and (tostring(soundId):find("crack") or tostring(soundId):find("break")) then
                        return nil
                    end
                    return oldPlaySound(...)
                end))
            end)

            if success then
                Library:Notify({
                    Time = 5,
                    Description = "饼干无敌模式已就绪，你不会折断饼干。",
                    Title = "抠糖饼"
                })
            else
                Library:Notify({
                    Time = 5,
                    Description = "启用失败: " .. tostring(err),
                    Title = "抠糖饼"
                })
            end
        end
    end
})

Afmsktb:AddButton({
    Text = "完成抠糖饼",
    Tooltip = "立即完成抠糖饼挑战",
    Func = function()
        if workspace.Values.CurrentGame.Value ~= "Dalgona" then
            Library:Notify({
                Time = 4,
                Description = "只在抠糖饼游戏中有效。",
                Title = "抠糖饼"
            })
            return
        end

        -- 方法1: 通过远程事件直接完成
        local success = pcall(function()
            local remotes = ReplicatedStorage:WaitForChild("Remotes")
            if remotes:FindFirstChild("Dalgona") then
                remotes.Dalgona:FireServer("Complete")
            end
        end)

        -- 方法2: 修改本地完成状态
        pcall(function()
            local playerGui = LocalPlayer:WaitForChild("PlayerGui")
            local dalgonaGui = playerGui:FindFirstChild("DalgonaGUI") or playerGui:FindFirstChild("Dalgona")
            if dalgonaGui then
                -- 触发完成逻辑
                for _, v in pairs(dalgonaGui:GetDescendants()) do
                    if v:IsA("BindableEvent") and v.Name:find("Complete") then
                        v:Fire()
                    end
                    if v:IsA("RemoteEvent") and v.Name:find("Complete") then
                        v:FireServer()
                    end
                end
            end
        end)

        -- 方法3: 直接修改游戏状态值
        pcall(function()
            local values = workspace:WaitForChild("Values")
            if values:FindFirstChild("DalgonaCompleted") then
                values.DalgonaCompleted.Value = true
            end
            if values:FindFirstChild("ShapeCompleted") then
                values.ShapeCompleted.Value = true
            end
        end)

        Library:Notify({
            Time = 4,
            Description = "图案已完成！",
            Title = "抠糖饼"
        })
    end
})

Afmsktb:AddButton("免费打火机", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ergergq2/erge.github.io/refs/heads/main/free.lua"))()
end)
--熄灯
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    warn("等待玩家加载...")
    LocalPlayer = Players.LocalPlayer
end
local originalPosition = nil
local isTeleportEnabled = false
local targetPosition = Vector3.new(189.0, 144.5, -84.9)
local function getCharacter()
    if not LocalPlayer then
        warn("LocalPlayer 不存在")
        return nil
    end    
    local Character = LocalPlayer.Character
    if not Character then
        warn("角色不存在，等待角色加载...")
        Character = LocalPlayer.CharacterAdded:Wait()
    end    
    return Character
end
local function teleportToTarget()
    local Character = getCharacter()
    if not Character then return end    
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 5)
    if not HumanoidRootPart then
        warn("未找到 HumanoidRootPart")
        return
    end    
    if not HumanoidRootPart:IsA("BasePart") then
        warn("HumanoidRootPart 不是 BasePart")
        return
    end    
    if originalPosition == nil then
        originalPosition = HumanoidRootPart.CFrame
        print("已保存原始位置")
    end    
    HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if Humanoid then
        Humanoid.PlatformStand = true
        task.wait(0.1)
        Humanoid.PlatformStand = false
    end    
    print("已传送到终点！位置: " .. tostring(targetPosition))
end
local function teleportToOriginal()
    if originalPosition == nil then
        print("没有保存的原始位置")
        return
    end    
    local Character = getCharacter()
    if not Character then return end    
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then
        warn("未找到 HumanoidRootPart")
        return
    end    
    if not HumanoidRootPart:IsA("BasePart") then
        warn("HumanoidRootPart 不是 BasePart")
        return
    end    
    HumanoidRootPart.CFrame = originalPosition
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if Humanoid then
        Humanoid.PlatformStand = true
        task.wait(0.1)
        Humanoid.PlatformStand = false
    end    
    print("已回到原始位置！")
end
RightGroup:AddToggle('TeleportToggle', {
    Text = '传送到安全区',
    Default = false,
    Tooltip = '开启后传送到安全区，关闭后回到原地',
    Callback = function(Value)
        print('[回调] 传送开关状态:', Value)
        
        if Value then
            isTeleportEnabled = true
            teleportToTarget()
        else
            isTeleportEnabled = false
            teleportToOriginal()
        end
    end
})
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    print("角色重生，重置原始位置")
    originalPosition = nil
    isTeleportEnabled = false
    task.wait(0.5)
    local toggle = LeftGroup:GetToggle('TeleportToggle')
    if toggle and toggle.Value then
        teleportToTarget()
    end
end)
--跳绳
Qctiaos:AddButton("删除绳子", function()
    pcall(function()
        -- 删除真正的绳子
        local rope = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("AwesomePiggy12223") and workspace.Map.AwesomePiggy12223:FindFirstChild("ropeMeshPart")
        if rope then
            rope:Destroy()
            print("已删除 ropeMeshPart")
        end
        
        -- 备份：搜索 ropeMeshPart
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "ropeMeshPart" then
                pcall(function() obj:Destroy() end)
                print("已删除: " .. obj:GetFullName())
            end
        end
    end)
    
    Library:Notify("绳子已删除", 3)
end)






local function revealGlassBridge()
    local bridge = Workspace:FindFirstChild("GlassBridge")
    if not bridge then return end

    local glassHolder = bridge:FindFirstChild("GlassHolder")
    if not glassHolder then return end
    for _, obj in pairs(glassHolder:GetDescendants()) do
        if obj.Name == "BlossomPlatform" then
            obj:Destroy()
        end
    end

    for _, step in pairs(glassHolder:GetChildren()) do
        for _, tile in pairs(step:GetChildren()) do
            if tile:IsA("Model") and tile.PrimaryPart then
                local glass = tile.PrimaryPart
                local isKiller = glass:GetAttribute("exploitingisevil")

                if isKiller then
                    glass.Color = Color3.fromRGB(248, 87, 87)
                else
                    glass.Color = Color3.fromRGB(28, 235, 87)
                end
                glass.Transparency = 0
                glass.Material = Enum.Material.Neon
            end
        end
    end
end

Qcplq:AddToggle('RevealGlass', {
    Text = '透视玻璃桥',
    Default = false,
    Callback = function(state)
        glassRevealActive = state
        if state then
            revealGlassBridge()
        end
    end
})
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    warn("等待玩家加载...")
    LocalPlayer = Players.LocalPlayer
end
Qcplq:AddButton("传送到终点", function()
    if not LocalPlayer then
        warn("LocalPlayer 不存在")
        return
    end    
    local Character = LocalPlayer.Character
    if not Character then
        warn("角色不存在，等待角色加载...")
        Character = LocalPlayer.CharacterAdded:Wait()
    end
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 5)
    if not HumanoidRootPart then
        warn("未找到 HumanoidRootPart")
        return
    end
    if not HumanoidRootPart:IsA("BasePart") then
        warn("HumanoidRootPart 不是 BasePart")
        return
    end
    local targetPosition = Vector3.new(-198.9, 520.7, -1530.9)
    HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if Humanoid then
        Humanoid.PlatformStand = true
        task.wait(0.1)
        Humanoid.PlatformStand = false
    end    
    print("传送完成！位置: " .. tostring(targetPosition))
end)

local platforms = {}

Qcplq:AddToggle('FallProtectionToggle', {
    Text = '防坠落',
    Default = false,
    Tooltip = '开启后生成防坠落平台，关闭后自动删除',
    Callback = function(Value)
        if Value then
            spawnPlatforms()
        else
            removePlatforms()
        end
    end
})

function spawnPlatforms()
    removePlatforms()
    
    local Effects = Workspace:FindFirstChild("Effects")
    if Effects and Effects:FindFirstChild("rope") then
        Effects.rope:Destroy()
    end
    
    local startPos = Vector3.new(15.6, 520.6, -1536.0)
    local endPos = Vector3.new(-182.8, 520.4, -1529.4)
    local platformCount = 15
    local platformSize = Vector3.new(35, 1, 35)
    local transparency = 0.9
    local step = (endPos - startPos) / (platformCount - 1)
    
    for i = 0, platformCount - 1 do
        local pos = startPos + step * i
        
        local platform = Instance.new("Part")
        platform.Size = platformSize
        platform.Anchored = true
        platform.CanCollide = true
        platform.Position = pos
        platform.Material = Enum.Material.SmoothPlastic
        platform.Color = Color3.fromRGB(120, 120, 120)
        platform.Transparency = transparency
        platform.Parent = Workspace
        table.insert(platforms, platform)
    end
    
    print('[防坠落] 已生成 ' .. platformCount .. ' 个平台')
end

function removePlatforms()
    for _, obj in ipairs(platforms) do
        if obj and obj.Parent then
            obj:Destroy()
        end
    end
    platforms = {}
    print('[防坠落] 已删除所有平台')
end
Qczmcgn:AddButton("传送至随机躲藏者", function()
    for _, Player in ipairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and Player:FindFirstChild("Backpack") then
            if Player.Backpack:FindFirstChild("DODGE!") then
                local Live = Workspace:FindFirstChild("Live")
                if Live then
                    local TargetChar = Live:FindFirstChild(Player.Name)
                    if TargetChar then
                        local RootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local TargetRoot = TargetChar:FindFirstChild("HumanoidRootPart")
                        if RootPart and TargetRoot then
                            RootPart.CFrame = TargetRoot.CFrame + Vector3.new(0, 2, 0)
                            break
                        end
                    end
                end
            end
        end
    end
end)
local TeleportUpToggle = false
local OriginalPosition = nil
Qczmcgn:AddToggle("TeleportUpToggle", {
    Text = "传送到安全区",
    Default = false,
    Callback = function(State)
        TeleportUpToggle = State
        
        if State then
            local RootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if RootPart then
                OriginalPosition = RootPart.Position
                local Position = RootPart.Position
                RootPart.CFrame = CFrame.new(Vector3.new(Position.X, Position.Y + 100, Position.Z))
            end
        else
            if OriginalPosition then
                local RootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if RootPart then
                    RootPart.CFrame = CFrame.new(OriginalPosition)
                end
                OriginalPosition = nil
            end
        end
    end
})

local PlatformObject = nil

Qczmcgn:AddToggle('SpikeProtectionToggle', {
    Text = '删除尖刺伤害',
    Default = false,
    Tooltip = '开启后生成保护平台，关闭后自动删除',
    Callback = function(Value)
        if Value then
            spawnPlatform()
        else
            removePlatform()
        end
    end
})

function spawnPlatform()
    removePlatform()
    
    local SafePlatform = Instance.new("Part")
    SafePlatform.Size = Vector3.new(35, 0.5, 35)
    SafePlatform.Anchored = true
    SafePlatform.CanCollide = true
    SafePlatform.Position = Vector3.new(191.0, 1029.5, 154.7)
    SafePlatform.Material = Enum.Material.SmoothPlastic
    SafePlatform.Color = Color3.fromRGB(120, 120, 120)
    SafePlatform.Transparency = 0.9
    SafePlatform.Name = "SpikeProtectionPlatform"
    SafePlatform.Parent = Workspace
    
    PlatformObject = SafePlatform
end

function removePlatform()
    if PlatformObject then
        PlatformObject:Destroy()
        PlatformObject = nil
    end
    
    local ExistingPlatform = Workspace:FindFirstChild("SpikeProtectionPlatform")
    if ExistingPlatform then
        ExistingPlatform:Destroy()
    end
end
Qczmcgn:AddToggle('HeavyAttackTPToggle', {
    Text = '尖刺击杀',
    Default = false,
    Tooltip = '打出重击后传送到陷阱里',
    Callback = function(Value)
        if Value then
            startHeavyAttackDetection()
        else
            stopHeavyAttackDetection()
        end
    end
})
local heavyAttackConnection = nil
local isTeleporting = false
local originalPosition = nil
local targetPosition = Vector3.new(191.0, 1029.5, 154.7)

function startHeavyAttackDetection()
    if heavyAttackConnection then return end
    
    heavyAttackConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if isTeleporting then return end
        
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            local animator = humanoid:FindFirstChild("Animator")
            if animator then
                local isHeavyAttacking = false
                for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                    if track.Animation and track.Animation.AnimationId then
                        local animId = track.Animation.AnimationId
                        if animId and (string.find(animId, "Heavy") or string.find(animId, "重击")) then
                            isHeavyAttacking = true
                            break
                        end
                    end
                end
                
                if isHeavyAttacking and not isTeleporting then
                    performTeleport()
                end
            end
        end
    end)
end

function stopHeavyAttackDetection()
    if heavyAttackConnection then
        heavyAttackConnection:Disconnect()
        heavyAttackConnection = nil
    end
end

function performTeleport()
    pcall(function()
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character
        if not character then return end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        
        originalPosition = rootPart.Position
        isTeleporting = true
        
        rootPart.CFrame = CFrame.new(targetPosition)
        
        task.wait(2.5)
        
        if originalPosition and rootPart then
            rootPart.CFrame = CFrame.new(originalPosition)
        end
        
        isTeleporting = false
        originalPosition = nil
    end)
end

Qczmcgn:AddToggle('AutoDodgeToggle', {
    Text = '自动闪避',
    Default = false,
    Tooltip = '附近一米内有人挥刀时自动闪避',
    Callback = function(Value)
        if Value then
            startAutoDodge()
        else
            stopAutoDodge()
        end
    end
})

local dodgeConnection = nil
local dodgeCooldown = false

function startAutoDodge()
    if dodgeConnection then return end
    
    dodgeConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if dodgeCooldown then return end
        
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
        
        local rootPart = character.HumanoidRootPart
        local rootPos = rootPart.Position
        
        for _, otherPlayer in pairs(game:GetService("Players"):GetPlayers()) do
            if otherPlayer ~= player then
                local otherChar = otherPlayer.Character
                if otherChar and otherChar:FindFirstChild("HumanoidRootPart") then
                    local otherRoot = otherChar.HumanoidRootPart
                    local distance = (rootPos - otherRoot.Position).Magnitude
                    
                    if distance <= 1 then
                        if otherChar:FindFirstChild("Knife") or otherChar:FindFirstChild("Tool") then
                            performDodge()
                            dodgeCooldown = true
                            task.wait(0)
                            dodgeCooldown = false
                            break
                        end
                    end
                end
            end
        end
    end)
end

function stopAutoDodge()
    if dodgeConnection then
        dodgeConnection:Disconnect()
        dodgeConnection = nil
    end
end

function performDodge()
    pcall(function()
        local args = {
            buffer.fromstring("\v\r\014\r\014\014\014\014\014\014\2541\n\001\014\014\014[}g`iCaxkM{}zac\r\014\014\014\014\014\014\014N\b\015\014\r\014\014\014\014\014\014\030N\v\015\014\n\t\014\014\014O{za[}k\015"),
            {
                game:GetService("Players").LocalPlayer:WaitForChild("Backpack"):WaitForChild("DODGE!")
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UsedTool"):FireServer(unpack(args))
    end)
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    warn("等待玩家加载...")
    LocalPlayer = Players.LocalPlayer
end

local teleportOriginalPos = nil
local targetPosition = Vector3.new(191.0, 1029.5, 154.7)

local function getCharacter()
    if not LocalPlayer then
        warn("LocalPlayer 不存在")
        return nil
    end
    
    local Character = LocalPlayer.Character
    if not Character then
        warn("角色不存在，等待角色加载...")
        Character = LocalPlayer.CharacterAdded:Wait()
    end
    
    return Character
end

Qczmcgn:AddToggle('TeleportToggle', {
    Text = '传送陷阱房',
    Default = false,
    Tooltip = '开启传送到目标位置，关闭回到原点',
    Callback = function(Value)
        print('[回调] 传送开关状态:', Value)
        
        local Character = getCharacter()
        if not Character then 
            print('[传送] 无法获取角色')
            return 
        end
        
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if not HumanoidRootPart then
            warn("未找到 HumanoidRootPart")
            return
        end
        
        if not HumanoidRootPart:IsA("BasePart") then
            warn("HumanoidRootPart 不是 BasePart")
            return
        end
        
        if Value then
            teleportOriginalPos = HumanoidRootPart.Position
            print('[传送] 已保存原始位置:', teleportOriginalPos)
            
            HumanoidRootPart.Position = targetPosition
            print('[传送] 已传送到陷阱房:', targetPosition)
        else
            if teleportOriginalPos then
                HumanoidRootPart.Position = teleportOriginalPos
                print('[传送] 已回到原点:', teleportOriginalPos)
                teleportOriginalPos = nil
            else
                print('[传送] 没有保存的原始位置')
            end
        end
    end
})
--反叛
Fpgn:AddToggle('GuardHitboxToggle', {
    Text = '启用碰撞箱扩展',
    Default = false,
    Tooltip = '开启后扩大碰撞箱',
    Callback = function(State)
        pcall(function()
            local live = workspace:FindFirstChild("Live")
            if not live then return end
            
            for _, model in pairs(live:GetChildren()) do
                if model:IsA("Model") then
                    local head = model:FindFirstChild("Head")
                    if head and head:IsA("BasePart") then
                        if State then
                            -- 保存原始透明度
                            if not head:GetAttribute("OriginalTransparency") then
                                head:SetAttribute("OriginalTransparency", head.Transparency)
                            end
                            head.Size = Vector3.new(Options.GuardHitboxSizeSlider.Value, Options.GuardHitboxSizeSlider.Value, Options.GuardHitboxSizeSlider.Value)
                            head.CanCollide = false
                            head.CanQuery = false
                            head.CanTouch = false
                            head.Massless = true
                            head.Transparency = Options.GuardHitboxTransparencySlider.Value
                        else
                            head.Size = Vector3.new(2, 1, 1)
                            head.CanCollide = true
                            head.CanQuery = true
                            head.CanTouch = true
                            head.Massless = false
                            -- 恢复原始透明度
                            local origTrans = head:GetAttribute("OriginalTransparency")
                            head.Transparency = origTrans ~= nil and origTrans or 0
                        end
                    end
                end
            end
        end)
    end
})

Fpgn:AddSlider('GuardHitboxSizeSlider', {
    Text = '碰撞箱大小',
    Default = 4,
    Min = 1,
    Max = 30,
    Rounding = 0,
    Tooltip = '调整守卫头部碰撞箱大小',
    Callback = function(Value)
        if not Toggles.GuardHitboxToggle.Value then return end
        pcall(function()
            local live = workspace:FindFirstChild("Live")
            if not live then return end
            
            for _, model in pairs(live:GetChildren()) do
                if model:IsA("Model") then
                    local head = model:FindFirstChild("Head")
                    if head and head:IsA("BasePart") then
                        head.Size = Vector3.new(Value, Value, Value)
                        head.CanCollide = false
                    end
                end
            end
        end)
    end
})

Fpgn:AddSlider('GuardHitboxTransparencySlider', {
    Text = '碰撞箱透明度',
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Tooltip = '调整碰撞箱可见度（渐隐渐现）',
    Callback = function(Value)
        if not Toggles.GuardHitboxToggle.Value then return end
        pcall(function()
            local live = workspace:FindFirstChild("Live")
            if not live then return end
            
            for _, model in pairs(live:GetChildren()) do
                if model:IsA("Model") then
                    local head = model:FindFirstChild("Head")
                    if head and head:IsA("BasePart") then
                        TweenService:Create(head, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Transparency = Value
                        }):Play()
                    end
                end
            end
        end)
    end
})

-- 动态监控
task.spawn(function()
    while true do
        task.wait(0.5)
        if Toggles.GuardHitboxToggle and Toggles.GuardHitboxToggle.Value then
            pcall(function()
                local live = workspace:FindFirstChild("Live")
                if not live then return end
                
                for _, model in pairs(live:GetChildren()) do
                    if model:IsA("Model") then
                        local head = model:FindFirstChild("Head")
                        if head and head:IsA("BasePart") then
                            local targetSize = Vector3.new(Options.GuardHitboxSizeSlider.Value, Options.GuardHitboxSizeSlider.Value, Options.GuardHitboxSizeSlider.Value)
                            if head.Size ~= targetSize then
                                head.Size = targetSize
                                head.CanCollide = false
                            end
                            if head.Transparency ~= Options.GuardHitboxTransparencySlider.Value then
                                head.Transparency = Options.GuardHitboxTransparencySlider.Value
                            end
                        end
                    end
                end
            end)
        end
    end
end)
--旋转木马
local Wjgjgn = Tabs.battle:AddLeftGroupbox("攻击", "users")
local Cxwjgn = Tabs.battle:AddLeftGroupbox("朝向", "users")
local ESPLeftGroup = Tabs.battle:AddRightGroupbox("透视", "eye")
local Boots = Tabs.Wanjia:AddLeftGroupbox("篡改", "activity")
local meun = Tabs.Wanjia:AddLeftGroupbox("杂项", "database")
local Owner = Tabs.Wanjia:AddRightGroupbox("通行证", "ticket")
local Csgn = Tabs.battle:AddRightGroupbox("传送", "ticket")
local ControlGroup = Tabs.battle:AddLeftGroupbox("旋转", "ticket")

local ESP = {
    Unloaded = false,
    Connections = {},
    Maid = {},
    ESPUpdateConnection = nil,
    ESPTable = {
        Player = {},
        Seeker = {},
        Hider = {},
        Guard = {},
        Door = {},
        None = {},
        Key = {},
    },
    Cache = {},
}

local function SafeDisconnect(connection)
    if connection then
        pcall(function()
            connection:Disconnect()
        end)
    end
end

local function SafeDestroy(instance)
    if instance then
        pcall(function()
            instance:Destroy()
        end)
    end
end
function ESP.GetRootPart()
    local character = LocalPlayer.Character
    if not character then
        return nil
    end
    return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
end
function ESP.GetHumanoid()
    local character = LocalPlayer.Character
    if not character then
        return nil
    end
    return character:FindFirstChildOfClass("Humanoid")
end
function ESP.DistanceFromCharacter(position)
    if not position then
        return 0
    end
    if typeof(position) == "Instance" then
        local success, pivot = pcall(function()
            return position:GetPivot()
        end)
        if success and pivot then
            position = pivot.Position
        else
            return 0
        end
    end    
    if typeof(position) ~= "Vector3" then
        return 0
    end    
    local root = ESP.GetRootPart()
    if root then
        return (root.Position - position).Magnitude
    end    
    if Camera then
        return (Camera.CFrame.Position - position).Magnitude
    end
    return 0
end
function ESP.Alert(message, duration)
    pcall(function()
        Library:Notify(message, duration or 5)
    end)
end
function ESP.IsESPExists(object)
    if not object then
        return false
    end    
    for _, espList in pairs(ESP.ESPTable) do
        for _, esp in pairs(espList) do
            if esp and not esp.Destroyed and esp.Object == object then
                return esp
            end
        end
    end
    
    return false
end

function ESP.CreateESP(args)
    if ESP.Unloaded then
        return nil
    end    
    if not args or not args.Object then
        return nil
    end    
    local object = args.Object    
    if not object:IsDescendantOf(workspace) then
        return nil
    end    
    local existing = ESP.IsESPExists(object)
    if existing then
        return existing
    end    
    local espType = args.Type or "None"    
    if not ESP.ESPTable[espType] then
        ESP.ESPTable[espType] = {}
    end    
    local espData = {
        Object = object,
        Text = args.Text or "无文本",
        Color = args.Color or Color3.new(1, 1, 1),
        Offset = args.Offset or Vector3.new(0, 3, 0),
        Type = espType,
        Highlight = nil,
        Billboard = nil,
        Destroyed = false,
    }    
    
    function espData:Destroy()
        if self.Destroyed then
            return
        end        
        self.Destroyed = true        
        if self.Highlight then
            SafeDestroy(self.Highlight)
            self.Highlight = nil
        end        
        if self.Billboard then
            SafeDestroy(self.Billboard)
            self.Billboard = nil
        end
    end
    
    function espData:SetColor(color)
        if self.Destroyed then
            return
        end        
        self.Color = color        
        if self.Highlight then
            self.Highlight.FillColor = color
            self.Highlight.OutlineColor = color
        end        
        if self.Billboard then
            local label = self.Billboard:FindFirstChild("TextLabel")
            if label then
                label.TextColor3 = color
            end
        end
    end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "AFHub_ESP_Highlight"
    highlight.Adornee = object
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = espData.Color
    highlight.FillTransparency = Options.ESPFillTransparency and Options.ESPFillTransparency.Value or 0.75
    highlight.OutlineColor = espData.Color
    highlight.OutlineTransparency = Options.ESPOutlineTransparency and Options.ESPOutlineTransparency.Value or 0
    highlight.Enabled = not Toggles.ESPHighlight or Toggles.ESPHighlight.Value
    highlight.Parent = object
    espData.Highlight = highlight
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "AFHub_ESP_Billboard"
    billboard.Adornee = object
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 220, 0, 55)
    billboard.StudsOffset = espData.Offset
    billboard.Parent = object   
    local label = Instance.new("TextLabel")
    label.Name = "TextLabel"
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Font = Enum.Font.Oswald
    label.Text = espData.Text
    label.TextColor3 = espData.Color
    label.TextSize = 20
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.TextStrokeTransparency = 0.5
    label.TextWrapped = true
    label.Parent = billboard    
    espData.Billboard = billboard    
    table.insert(ESP.ESPTable[espType], espData)    
    return espData
end

function ESP.ClearESP(typeName)
    local list = ESP.ESPTable[typeName]
    if not list then
        return
    end    
    for i = #list, 1, -1 do
        local esp = list[i]
        if esp then
            pcall(function()
                esp:Destroy()
            end)
        end
        table.remove(list, i)
    end
end

function ESP.ClearAllESP()
    for typeName, list in pairs(ESP.ESPTable) do
        for i = #list, 1, -1 do
            local esp = list[i]
            if esp then
                pcall(function()
                    esp:Destroy()
                end)
            end
            list[i] = nil
        end
    end
end

ESP.ESPUpdateConnection = RunService.RenderStepped:Connect(function()
    if ESP.Unloaded then
        return
    end    
    local showDistance = Toggles.ESPDistance and Toggles.ESPDistance.Value
    local highlightEnabled = not Toggles.ESPHighlight or Toggles.ESPHighlight.Value    
    for _, espList in pairs(ESP.ESPTable) do
        for i = #espList, 1, -1 do
            local esp = espList[i]            
            if not esp or esp.Destroyed or not esp.Object or not esp.Object:IsDescendantOf(workspace) then
                if esp then
                    pcall(function()
                        esp:Destroy()
                    end)
                end
                table.remove(espList, i)
            else
                if esp.Highlight then
                    esp.Highlight.Enabled = highlightEnabled
                end                
                if esp.Billboard then
                    local label = esp.Billboard:FindFirstChild("TextLabel")
                    if label then
                        if showDistance then
                            local distance = ESP.DistanceFromCharacter(esp.Object)
                            label.Text = string.format("%s\\n[%d]", esp.Text, math.floor(distance))
                        else
                            label.Text = esp.Text
                        end
                    end
                end
            end
        end
    end
end)
table.insert(ESP.Connections, ESP.ESPUpdateConnection)

ESPLeftGroup:AddToggle("PlayerESP", {
    Text = "玩家透视",
    Default = false,
    Tooltip = "显示其他玩家",
    Callback = function(Value)
        if Value then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    ESP.CreateESP({
                        Object = player.Character,
                        Text = player.Name,
                        Color = Options.PlayerESPColor.Value,
                        Type = "Player",
                    })
                end
            end
            ESP.Alert("玩家透视已开启", 3)
        else
            ESP.ClearESP("Player")
            ESP.Alert("玩家透视已关闭", 3)
        end
    end,
}):AddColorPicker("PlayerESPColor", {
    Default = Color3.fromRGB(255, 255, 255),
    Title = "玩家颜色",
    Transparency = 0,
    Callback = function(Value)
        for _, esp in ipairs(ESP.ESPTable.Player) do
            if esp then
                esp:SetColor(Value)
            end
        end
    end,
})
ESPLeftGroup:AddToggle("SeekerESP", {
    Text = "搜寻者透视",
    Default = false,
    Tooltip = "显示 IsHunter 玩家",
    Callback = function(Value)
        if Value then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer 
                    and player:GetAttribute("IsHunter")
                    and player.Character then
                    ESP.CreateESP({
                        Object = player.Character,
                        Text = player.Name .. " (搜寻者)",
                        Color = Options.SeekerESPColor.Value,
                        Type = "Seeker",
                    })
                end
            end
            ESP.Alert("搜寻者透视已开启", 3)
        else
            ESP.ClearESP("Seeker")
            ESP.Alert("搜寻者透视已关闭", 3)
        end
    end,
}):AddColorPicker("SeekerESPColor", {
    Default = Color3.fromRGB(255, 0, 0),
    Title = "搜寻者颜色",
    Transparency = 0,
    Callback = function(Value)
        for _, esp in ipairs(ESP.ESPTable.Seeker) do
            if esp then
                esp:SetColor(Value)
            end
        end
    end,
})
ESPLeftGroup:AddToggle("HiderESP", {
    Text = "躲藏者透视",
    Default = false,
    Tooltip = "显示 IsHider 玩家",
    Callback = function(Value)
        if Value then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer 
                    and player:GetAttribute("IsHider")
                    and player.Character then
                    ESP.CreateESP({
                        Object = player.Character,
                        Text = player.Name .. " (躲藏者)",
                        Color = Options.HiderESPColor.Value,
                        Type = "Hider",
                    })
                end
            end
            ESP.Alert("躲藏者透视已开启", 3)
        else
            ESP.ClearESP("Hider")
            ESP.Alert("躲藏者透视已关闭", 3)
        end
    end,
}):AddColorPicker("HiderESPColor", {
    Default = Color3.fromRGB(0, 255, 0),
    Title = "躲藏者颜色",
    Transparency = 0,
    Callback = function(Value)
        for _, esp in ipairs(ESP.ESPTable.Hider) do
            if esp then
                esp:SetColor(Value)
            end
        end
    end,
})
ESPLeftGroup:AddToggle("GuardESP", {
    Text = "守卫透视",
    Default = false,
    Tooltip = "显示 Live 中的 Guard",
    Callback = function(Value)
        if Value then
            local live = workspace:FindFirstChild("Live")
            if live then
                for _, model in ipairs(live:GetChildren()) do
                    if model:IsA("Model") and string.find(model.Name, "Guard") then
                        ESP.CreateESP({
                            Object = model,
                            Text = "守卫",
                            Color = Options.GuardESPColor.Value,
                            Type = "Guard",
                        })
                    end
                end
            end
            ESP.Alert("守卫透视已开启", 3)
        else
            ESP.ClearESP("Guard")
            ESP.Alert("守卫透视已关闭", 3)
        end
    end,
}):AddColorPicker("GuardESPColor", {
    Default = Color3.fromRGB(200, 100, 200),
    Title = "守卫颜色",
    Transparency = 0,
    Callback = function(Value)
        for _, esp in ipairs(ESP.ESPTable.Guard) do
            if esp then
                esp:SetColor(Value)
            end
        end
    end,
})
ESPLeftGroup:AddToggle("KeyESP", {
    Text = "钥匙透视",
    Default = false,
    Tooltip = "显示地图钥匙",
    Callback = function(Value)
        if Value then
            local map = workspace:FindFirstChild("HideAndSeekMap")
            if map then
                local keys = map:FindFirstChild("KEYS")
                if keys then
                    for _, key in ipairs(keys:GetChildren()) do
                        ESP.CreateESP({
                            Object = key,
                            Text = "钥匙",
                            Color = Options.KeyESPColor.Value,
                            Type = "Key",
                        })
                    end
                end
            end
            ESP.Alert("钥匙透视已开启", 3)
        else
            ESP.ClearESP("Key")
            ESP.Alert("钥匙透视已关闭", 3)
        end
    end,
}):AddColorPicker("KeyESPColor", {
    Default = Color3.fromRGB(255, 255, 0),
    Title = "钥匙颜色",
    Transparency = 0,
    Callback = function(Value)
        for _, esp in ipairs(ESP.ESPTable.Key) do
            if esp then
                esp:SetColor(Value)
            end
        end
    end,
})
ESPLeftGroup:AddToggle("DoorESP", {
    Text = "门透视",
    Default = false,
    Tooltip = "显示门和所需钥匙",
    Callback = function(Value)
        if Value then
            local map = workspace:FindFirstChild("HideAndSeekMap")
            if map then
                local doors = map:FindFirstChild("NEWFIXEDDOORS")
                if doors then
                    for _, floor in ipairs(doors:GetChildren()) do
                        for _, door in ipairs(floor:GetChildren()) do
                            if door.Name == "FullDoorAnimated" then
                                local keyNeeded = door:GetAttribute("KeyNeeded")
                                if keyNeeded == nil then
                                    keyNeeded = "无"
                                end
                                ESP.CreateESP({
                                    Object = door,
                                    Text = "门 (钥匙: " .. tostring(keyNeeded) .. ")",
                                    Color = Options.DoorESPColor.Value,
                                    Type = "Door",
                                })
                            end
                        end
                    end
                end
            end
            ESP.Alert("门透视已开启", 3)
        else
            ESP.ClearESP("Door")
            ESP.Alert("门透视已关闭", 3)
        end
    end,
}):AddColorPicker("DoorESPColor", {
    Default = Color3.fromRGB(0, 128, 255),
    Title = "门颜色",
    Transparency = 0,
    Callback = function(Value)
        for _, esp in ipairs(ESP.ESPTable.Door) do
            if esp then
                esp:SetColor(Value)
            end
        end
    end,
})
ESPLeftGroup:AddToggle("ESPHighlight", {
    Text = "启用高亮效果",
    Default = true,
    Tooltip = "开启或关闭 Highlight",
    Callback = function(Value)
        for _, list in pairs(ESP.ESPTable) do
            for _, esp in pairs(list) do
                if esp.Highlight then
                    esp.Highlight.Enabled = Value
                end
            end
        end
    end,
})
ESPLeftGroup:AddToggle("ESPDistance", {
    Text = "显示距离数值",
    Default = true,
    Tooltip = "显示目标距离",
})

ESPLeftGroup:AddSlider("ESPFillTransparency", {
    Text = "填充透明度",
    Default = 0.75,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Suffix = "",
    Tooltip = "调整 Highlight 填充透明度",
    Callback = function(Value)
        for _, list in pairs(ESP.ESPTable) do
            for _, esp in pairs(list) do
                if esp.Highlight then
                    esp.Highlight.FillTransparency = Value
                end
            end
        end
    end,
})
ESPLeftGroup:AddSlider("ESPOutlineTransparency", {
    Text = "边框透明度",
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Suffix = "",
    Tooltip = "调整 Highlight 边框透明度",
    Callback = function(Value)
        for _, list in pairs(ESP.ESPTable) do
            for _, esp in pairs(list) do
                if esp.Highlight then
                    esp.Highlight.OutlineTransparency = Value
                end
            end
        end
    end,
})
ESPLeftGroup:AddButton({
    Text = "重置透视设置",
    Func = function()
        if Options.PlayerESPColor then
            Options.PlayerESPColor:SetValue(Color3.fromRGB(255, 255, 255))
        end
        if Options.SeekerESPColor then
            Options.SeekerESPColor:SetValue(Color3.fromRGB(255, 0, 0))
        end
        if Options.HiderESPColor then
            Options.HiderESPColor:SetValue(Color3.fromRGB(0, 255, 0))
        end
        if Options.GuardESPColor then
            Options.GuardESPColor:SetValue(Color3.fromRGB(200, 100, 200))
        end
        if Options.KeyESPColor then
            Options.KeyESPColor:SetValue(Color3.fromRGB(255, 255, 0))
        end
        if Options.DoorESPColor then
            Options.DoorESPColor:SetValue(Color3.fromRGB(0, 128, 255))
        end
        if Options.ESPFillTransparency then
            Options.ESPFillTransparency:SetValue(0.75)
        end
        if Options.ESPOutlineTransparency then
            Options.ESPOutlineTransparency:SetValue(0)
        end
        ESP.Alert("透视设置已重置", 3)
    end,
})
ESPLeftGroup:AddButton({
    Text = "开关所有透视",
    Func = function()
        local toggleList = {
            Toggles.PlayerESP,
            Toggles.SeekerESP,
            Toggles.HiderESP,
            Toggles.GuardESP,
            Toggles.KeyESP,
            Toggles.DoorESP,
        }        
        local allOn = true
        for _, toggle in ipairs(toggleList) do
            if toggle and not toggle.Value then
                allOn = false
                break
            end
        end        
        local newState = not allOn
        for _, toggle in ipairs(toggleList) do
            if toggle then
                toggle:SetValue(newState)
            end
        end        
        ESP.Alert(newState and "已开启所有透视" or "已关闭所有透视", 3)
    end,
})

local function SetupPlayer(player)
    if player == LocalPlayer then return end
    local connection = player.CharacterAdded:Connect(function(character)
        if ESP.Unloaded then return end
        task.wait(0.5)
        if ESP.Unloaded then return end
        if Toggles.PlayerESP and Toggles.PlayerESP.Value then
            ESP.CreateESP({
                Object = character,
                Text = player.Name,
                Color = Options.PlayerESPColor.Value,
                Type = "Player",
            })
        end
        if Toggles.SeekerESP and Toggles.SeekerESP.Value and player:GetAttribute("IsHunter") then
            ESP.CreateESP({
                Object = character,
                Text = player.Name .. " (搜寻者)",
                Color = Options.SeekerESPColor.Value,
                Type = "Seeker",
            })
        end
        if Toggles.HiderESP and Toggles.HiderESP.Value and player:GetAttribute("IsHider") then
            ESP.CreateESP({
                Object = character,
                Text = player.Name .. " (躲藏者)",
                Color = Options.HiderESPColor.Value,
                Type = "Hider",
            })
        end
    end)
    table.insert(ESP.Connections, connection)
end

local function SetupAttributeWatcher(player)
    if player == LocalPlayer then return end
    local connection = player.AttributeChanged:Connect(function(attribute)
        if ESP.Unloaded then return end
        if attribute ~= "IsHunter" and attribute ~= "IsHider" then return end
        if not player.Character then return end
        if attribute == "IsHunter" then
            ESP.ClearESP("Seeker")
            if Toggles.SeekerESP and Toggles.SeekerESP.Value then
                for _, target in ipairs(Players:GetPlayers()) do
                    if target ~= LocalPlayer and target:GetAttribute("IsHunter") and target.Character then
                        ESP.CreateESP({
                            Object = target.Character,
                            Text = target.Name .. " (搜寻者)",
                            Color = Options.SeekerESPColor.Value,
                            Type = "Seeker",
                        })
                    end
                end
            end
        end
        if attribute == "IsHider" then
            ESP.ClearESP("Hider")
            if Toggles.HiderESP and Toggles.HiderESP.Value then
                for _, target in ipairs(Players:GetPlayers()) do
                    if target ~= LocalPlayer and target:GetAttribute("IsHider") and target.Character then
                        ESP.CreateESP({
                            Object = target.Character,
                            Text = target.Name .. " (躲藏者)",
                            Color = Options.HiderESPColor.Value,
                            Type = "Hider",
                        })
                    end
                end
            end
        end
    end)
    table.insert(ESP.Connections, connection)
end

for _, player in ipairs(Players:GetPlayers()) do
    SetupPlayer(player)
    SetupAttributeWatcher(player)
end

table.insert(ESP.Connections, Players.PlayerAdded:Connect(function(player)
    if ESP.Unloaded then return end
    SetupPlayer(player)
    SetupAttributeWatcher(player)
end))

function ESP.Unload()
    if ESP.Unloaded then return end
    ESP.Unloaded = true
    ESP.ClearAllESP()
    if ESP.ESPUpdateConnection then
        SafeDisconnect(ESP.ESPUpdateConnection)
        ESP.ESPUpdateConnection = nil
    end
    for i = #ESP.Connections, 1, -1 do
        local connection = ESP.Connections[i]
        SafeDisconnect(connection)
        ESP.Connections[i] = nil
    end
    getgenv().AFHub_InkGame_Loaded = false
    getgenv().AFHub_InkGame_Unload = nil
    pcall(function()
        Library:Unload()
    end)
end

getgenv().AFHub_InkGame_Unload = ESP.Unload

meun:AddDropdown('QTEMode', {
    Text = 'QTE模式',
    Default = '正常',
    Values = {'正常', '狂暴'},
    Callback = function(value)
        autoQTEMode = value
    end
})

meun:AddToggle('AutoQTE', {
    Text = '自动QTE(无视觉效果)',
    Default = false,
    Callback = function(state)
        autoQTEActive = state
        if state then
            startAutoQTE()
        else
            if autoQTEConnection then
                autoQTEConnection:Disconnect()
                autoQTEConnection = nil
            end
        end
    end
})

meun:AddToggle("EnableFOV", {
    Text = "超广角",
    Default = false,
    Callback = function(state)
        if not state then
            pcall(function()
                workspace.CurrentCamera.FieldOfView = 70
            end)
        end
    end
})
local FOVSettings = meun:AddDependencyBox()

FOVSettings:AddSlider('UltraWideSlider', {
    Text = "视角距离",
    Default = 70,
    Min = 0,
    Max = 120,
    Rounding = 0,
    Suffix = "°",
    Callback = function(Value)
        if Toggles.EnableFOV and Toggles.EnableFOV.Value then
            pcall(function()
                workspace.CurrentCamera.FieldOfView = Value
            end)
        end
    end
})

FOVSettings:SetupDependencies({
    { Toggles.EnableFOV, true },
})

task.spawn(function()
    while task.wait(0.05) do
        if Toggles.EnableFOV and Toggles.EnableFOV.Value then
            pcall(function()
                workspace.CurrentCamera.FieldOfView = Options.UltraWideSlider.Value
            end)
        end
    end
end)
meun:AddToggle('NoCooldownToggle', {
    Text = '无后摇',
    Default = false,
    Tooltip = '开启后移除武器后摇动作',
    Callback = function(Value)
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Remotes = ReplicatedStorage:WaitForChild("Remotes")
        local rootCFrameRemote = Remotes:WaitForChild("rootCFrame")
        local UsedToolRemote = Remotes:WaitForChild("UsedTool")
        
        if Value then
            local noCooldownActive = true
            print('[无后摇] 已开启')
            
            local connection1 = UsedToolRemote.OnClientEvent:Connect(function()
                if not noCooldownActive then return end
                
                local args1 = {
                    buffer.fromstring("\171?\248d\182\127\209\0055\215\225\205\002p\198>\128\226B/\238")
                }
                rootCFrameRemote:FireServer(unpack(args1))
                
                local args2 = {
                    buffer.fromstring("oijijjjjjj\154Unejjj?\025\003\004\r'\005\028\015)\031\025\030\005\aijjjjjjj*lkjijjjjjjz*ohjnmjjj)\006\003\t\001\015\014kncjjj#\0258\031\004\004\003\004\rk"),
                    {
                        LocalPlayer.Character:WaitForChild("Fork")
                    }
                }
                UsedToolRemote:FireServer(unpack(args2))
                
                local args3 = {
                    buffer.fromstring("!W\132\240B\140\196\248(TZT{\005\162:|\238N\130\176")
                }
                rootCFrameRemote:FireServer(unpack(args3))
                
                local args4 = {
                    buffer.fromstring("\aq\162\014`\238&Z\138\178\248\182\025\167\000X\154\200(\023\144")
                }
                rootCFrameRemote:FireServer(unpack(args4))
                
                local args5 = {
                    buffer.fromstring("onjijjjjjj\154Unejjj?\025\003\004\r'\005\028\015)\031\025\030\005\aijjjjjjj*lkjijjjjjjb*kijjjjjjz*okjnmjjj)\006\003\t\001\015\014k"),
                    {
                        LocalPlayer.Character:WaitForChild("Fork")
                    }
                }
                UsedToolRemote:FireServer(unpack(args5))
            end)
            
            local connection2 = rootCFrameRemote.OnClientEvent:Connect(function()
                if not noCooldownActive then return end
                
                local args = {
                    buffer.fromstring("\171?\248d\182\127\209\0055\215\225\205\002p\198>\128\226B/\238")
                }
                rootCFrameRemote:FireServer(unpack(args))
            end)
            _G.NoCooldownConnections = {
                connection1 = connection1,
                connection2 = connection2,
                active = noCooldownActive
            }
        else
            if _G.NoCooldownConnections then
                if _G.NoCooldownConnections.connection1 then
                    _G.NoCooldownConnections.connection1:Disconnect()
                end
                if _G.NoCooldownConnections.connection2 then
                    _G.NoCooldownConnections.connection2:Disconnect()
                end
                _G.NoCooldownConnections = nil
            end
            
            print('[无后摇] 已关闭')
        end
    end
})
local FlyingEnabled = false
local SpinningEnabled = false
local FlightSpeed = 50
local SpinSpeed = 5
local CurrentAO, CurrentLV, CurrentMoverAttachment
local FlightConnection
local Control = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local function getControlModule()
    local PlayerModule = LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")
    return require(PlayerModule:WaitForChild("ControlModule"))
end
local function setupBodyMovers(character)
    local hrp = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    local moverParent = workspace:FindFirstChildOfClass("Terrain") or workspace
    local moverAttachment = Instance.new("Attachment", hrp)
    moverAttachment.Name = "FlightAttachment"
    local alignOrientation = Instance.new("AlignOrientation")
    alignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
    alignOrientation.RigidityEnabled = true
    alignOrientation.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    alignOrientation.CFrame = hrp.CFrame
    alignOrientation.Attachment0 = moverAttachment
    alignOrientation.Parent = moverParent
    local linearVelocity = Instance.new("LinearVelocity")
    linearVelocity.VectorVelocity = Vector3.zero
    linearVelocity.MaxForce = 9e9
    linearVelocity.Attachment0 = moverAttachment
    linearVelocity.Parent = moverParent
    return alignOrientation, linearVelocity, humanoid, moverAttachment
end
local function getFlightVector(controlModule)
    local moveVector = controlModule:GetMoveVector()
    Control.F = -moveVector.Z
    Control.B = moveVector.Z
    Control.L = -moveVector.X
    Control.R = moveVector.X
    Control.Q = moveVector.Y
    Control.E = -moveVector.Y
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then Control.F = 1 end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then Control.B = 1 end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then Control.L = 1 end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then Control.R = 1 end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then Control.Q = 1 end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then Control.E = 1 end
    local flightVector =
        Camera.CFrame.LookVector * (Control.F - Control.B) +
        Camera.CFrame.RightVector * (Control.R - Control.L) +
        Vector3.new(0, 1, 0) * (Control.Q - Control.E)
    return flightVector.Magnitude > 0 and flightVector.Unit or flightVector
end
local function startFlying()
    if FlyingEnabled then return end
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    if not character then return end
    FlyingEnabled = true
    SpinningEnabled = false
    if CurrentAO then CurrentAO:Destroy() end
    if CurrentLV then CurrentLV:Destroy() end
    if CurrentMoverAttachment then CurrentMoverAttachment:Destroy() end
    CurrentAO, CurrentLV, humanoid, CurrentMoverAttachment = setupBodyMovers(character)
    local controlModule = getControlModule()
    FlightConnection = RunService.Heartbeat:Connect(function()
        if not FlyingEnabled or not CurrentLV or not CurrentAO then return end
        local flightVector = getFlightVector(controlModule)
        if flightVector.Magnitude > 0 then
            CurrentLV.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
            CurrentLV.VectorVelocity = flightVector * FlightSpeed
        else
            CurrentLV.VectorVelocity = Vector3.zero
        end
        if SpinningEnabled then
            local targetPart = humanoid.SeatPart or character.HumanoidRootPart
            CurrentAO.CFrame = targetPart.CFrame * CFrame.Angles(0, math.rad(SpinSpeed), 0)
        else
            CurrentAO.CFrame = Camera.CFrame
        end
        humanoid.PlatformStand = true
    end)
    character.AncestryChanged:Connect(function(_, parent)
        if not parent and FlyingEnabled then
            stopFlying()
        end
    end)
end

local function stopFlying()
    if not FlyingEnabled then return end
    FlyingEnabled = false
    SpinningEnabled = false
    if FlightConnection then
        FlightConnection:Disconnect()
        FlightConnection = nil
    end
    if CurrentAO then CurrentAO:Destroy() end
    if CurrentLV then CurrentLV:Destroy() end
    if CurrentMoverAttachment then CurrentMoverAttachment:Destroy() end
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.PlatformStand = false
    end
end
meun:AddToggle('MyToggle', {
    Text = '飞行模式[有概率被反作弊击杀]',
    Default = false,
    Tooltip = '开启 / 关闭飞行功能',
    Callback = function(Value)
        if Value then
            startFlying()
        else
            stopFlying()
        end
    end
})
meun:AddSlider('MyIntSlider', {
    Text = '飞行速度',
    Default = 50,
    Min = 1,
    Max = 200,
    Rounding = 0,
    Suffix = '',
    Compact = false,
    Callback = function(Value)
        FlightSpeed = Value
    end
})
local skipDialogueCoroutine = nil
local keepPlayingCoroutine = nil
local function getRemotes()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Remotes = ReplicatedStorage:WaitForChild("Remotes")
    return Remotes
end
local function startSkipDialogue()
    if skipDialogueCoroutine then
        return
    end    
    skipDialogueCoroutine = coroutine.create(function()
        local Remotes = getRemotes()
        local DialogueRemote = Remotes:WaitForChild("DialogueRemote")       
        while true do
            local args = {
                buffer.fromstring("=98;888888\200\a<?888kSQHH]\\"),
                {}
            }
            DialogueRemote:FireServer(unpack(args))
            task.wait(0)
        end
    end)    
    coroutine.resume(skipDialogueCoroutine)
    print("自动跳过对话已开启")
end
local function stopSkipDialogue()
    if skipDialogueCoroutine then
        skipDialogueCoroutine = nil
        print("自动跳过对话已关闭")
    end
end
local function startKeepPlaying()
    if keepPlayingCoroutine then
        return
    end    
    keepPlayingCoroutine = coroutine.create(function()
        local Remotes = getRemotes()
        local ExtraTemporaryRemote = Remotes:WaitForChild("ExtraTemporaryRemote")       
        while true do
            local args = {
                {
                    Voting = "KeepPlaying"
                }
            }
            ExtraTemporaryRemote:FireServer(unpack(args))
            task.wait(0)
        end
    end)    
    coroutine.resume(keepPlayingCoroutine)
    print("自动选择继续游戏已开启")
end
local function stopKeepPlaying()
    if keepPlayingCoroutine then
        keepPlayingCoroutine = nil
        print("自动选择继续游戏已关闭")
    end
end
meun:AddToggle('SkipDialogueToggle', {
    Text = '自动跳过对话',
    Default = false,
    Tooltip = '开启后自动跳过墨水游戏对话',
    Callback = function(Value)
        print('[回调] 自动跳过对话状态:', Value)
        
        if Value then
            startSkipDialogue()
        else
            stopSkipDialogue()
        end
    end
})
meun:AddToggle('KeepPlayingToggle', {
    Text = '自动继续游戏',
    Default = false,
    Tooltip = '开启后自动选择继续游戏（KeepPlaying）',
    Callback = function(Value)
        print('[回调] 自动继续游戏状态:', Value)        
        if Value then
            startKeepPlaying()
        else
            stopKeepPlaying()
        end
    end
})
local isUsedToolEnabled = false
local usedToolCoroutine = nil
local function getBottle()
    local player = game:GetService("Players").LocalPlayer
    if not player or not player.Character then
        return nil
    end
    return player.Character:FindFirstChild("Bottle")
end
local function sendUsedToolRequest()
    local bottle = getBottle()
    if not bottle then
        warn("未找到Bottle")
        return false
    end    
    local args = {
        buffer.fromstring(")/,/,,,,,,\220\019(#,,,y_EBKaCZIoY_XCA/,,,,,,,l*-,/,,,,,,<l)-,(+,,,o@EOGIH-"),
        {
            bottle
        }
    }    
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Remotes = ReplicatedStorage:WaitForChild("Remotes")
    local UsedTool = Remotes:WaitForChild("UsedTool")
    
    UsedTool:FireServer(unpack(args))
    return true
end
local function startUsedTool()
    if usedToolCoroutine then
        return
    end    
    usedToolCoroutine = coroutine.create(function()
        while true do
            local success = sendUsedToolRequest()
            if success then
                print("UsedTool 请求已发送")
            else
                warn("UsedTool 发送失败")
            end
            task.wait(0.1)
        end
    end)
    
    coroutine.resume(usedToolCoroutine)
    print("UsedTool 自动发送已开启")
end
local function stopUsedTool()
    if usedToolCoroutine then
        usedToolCoroutine = nil
        print("UsedTool 自动发送已关闭")
    end
end
meun:AddToggle('UsedToolToggle', {
    Text = '自动使用工具',
    Default = false,
    Tooltip = '开启后自动发送UsedTool请求（使用瓶子）',
    Callback = function(Value)
        print('[回调] 自动使用工具状态:', Value)        
        if Value then
            local bottle = getBottle()
            if not bottle then
                Library:Notify("未找到Bottle，请先装备瓶子", 3)
                print("未找到Bottle")
                local toggle = LeftGroup:GetToggle('UsedToolToggle')
                if toggle then
                    toggle:SetValue(false)
                end
                return
            end            
            startUsedTool()
            Library:Notify("自动使用工具已开启", 2)
        else
            stopUsedTool()
            Library:Notify("自动使用工具已关闭", 2)
        end
    end
})
meun:AddButton("解锁免费冲刺", function()
    local Boosts = LocalPlayer:FindFirstChild("Boosts")
    if Boosts then
        local FasterSprint = Boosts:FindFirstChild("Faster Sprint")
        if FasterSprint then
            FasterSprint.Value = 5
        end
    end
end)
meun:AddButton("免费装备幻影步能力", function()
    LocalPlayer:SetAttribute("_EquippedPower", "PHANTOM STEP")
end)
meun:AddButton("跑酷艺术家", function()
    LocalPlayer:SetAttribute("_EquippedPower", "PARKOUR ARTIST") 
end)
local PlayerNames = {}
for _, Player in ipairs(Players:GetPlayers()) do
    if Player ~= LocalPlayer then
        table.insert(PlayerNames, Player.Name)
    end
end
local PlayerNames = {}
for _, Player in ipairs(Players:GetPlayers()) do
    if Player ~= LocalPlayer then
        table.insert(PlayerNames, Player.Name)
    end
end

local PlayerDropdown = Csgn:AddDropdown("SelectPlayerDropdown", {
    Multi = false,
    Values = PlayerNames,
    Callback = function(Value) end
})
Csgn:AddButton("传送到选中玩家", function()
    local SelectedName = Library.Options.SelectPlayerDropdown.Value
    local TargetPlayer = Players:FindFirstChild(SelectedName)    
    if TargetPlayer and TargetPlayer.Character then
        local TargetRoot = TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
        local MyRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")        
        if TargetRoot and MyRoot then
            MyRoot.CFrame = TargetRoot.CFrame + Vector3.new(0, 2, 0)
        end
    end
end)
Csgn:AddButton("刷新玩家列表", function()
    local NewNames = {}
    for _, Player in ipairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer then
            table.insert(NewNames, Player.Name)
        end
    end
    PlayerDropdown:Refresh(NewNames)
end)
ControlGroup:AddToggle('RotateToggle', {
    Text = '启用旋转',
    Default = false,
    Tooltip = '开启/关闭人物旋转功能',
    Callback = function(Value)
        toggleRotate(Value)
    end
})
ControlGroup:AddSlider('SpeedSlider', {
    Text = '旋转速度',
    Default = 7200,
    Min = 100,
    Max = 36000,
    Rounding = 0,
    Suffix = " °/秒",
    Tooltip = '设置旋转速度（度/秒）\n建议范围：1000-20000',
    Callback = function(Value)
        Settings.RotationSpeed = Value
        if Settings.Rotating then
            Library:Notify("速度已更新: " .. Value .. "°/s", 1)
        end
    end
})
local Settings = {
    Rotating = false,
    RotationSpeed = 7200,
    RotationDirection = 1,
}

local RotateConnection = nil
local LocalPlayer = game:GetService("Players").LocalPlayer

local function startRotate()
    if Settings.Rotating then return end
    
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then
        Library:Notify("请先进入游戏", 2)
        return
    end
    
    Settings.Rotating = true
    RotateConnection = game:GetService("RunService").RenderStepped:Connect(function(dt)
        local currentRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if currentRoot then
            local speedRad = math.rad(Settings.RotationSpeed) * Settings.RotationDirection
            currentRoot.CFrame = currentRoot.CFrame * CFrame.Angles(0, speedRad * dt, 0)
        end
    end)
    
    Library:Notify("旋转已开启 (速度: " .. Settings.RotationSpeed .. "°/s)", 2)
end

local function stopRotate()
    Settings.Rotating = false
    if RotateConnection then
        RotateConnection:Disconnect()
        RotateConnection = nil
    end
    Library:Notify("旋转已关闭", 1)
end

local function toggleRotate(value)
    if value then
        startRotate()
    else
        stopRotate()
    end
end

local function setDirection(value)
    Settings.RotationDirection = value
    Library:Notify("旋转方向: " .. (value == 1 and "顺时针" or "逆时针"), 1)
end
ControlGroup:AddDropdown('DirectionDropdown', {
    Text = '旋转方向',
    Values = {'顺时针', '逆时针'},
    Default = 1,
    Tooltip = '选择旋转方向',
    Callback = function(Value)
        if Value == '顺时针' then
            setDirection(1)
        else
            setDirection(-1)
        end
    end
})
ControlGroup:AddButton({
    Text = '切换方向',
    Func = function()
        if Settings.RotationDirection == 1 then
            setDirection(-1)
            Options.DirectionDropdown:SetValue('逆时针')
        else
            setDirection(1)
            Options.DirectionDropdown:SetValue('顺时针')
        end
    end
})
Owner:AddToggle("FakeVIP", {
    Text = "VIP",
    Default = false,
    Callback = function(state)
        pcall(function()
            local player = game:GetService("Players").LocalPlayer
            if state then
                player:SetAttribute("__OwnsVIPGamepass", true)
            else
                player:SetAttribute("__OwnsVIPGamepass", false)
            end
        end)
    end
}):AddColorPicker("ClothingColor", {
    Default = Color3.fromRGB(255, 255, 255),
    Title = "衣服颜色",
    Transparency = 0,
    Callback = function(Value)
        -- 只有 VIP 开关开着才生效
        if not Toggles.FakeVIP or not Toggles.FakeVIP.Value then
            Library:Notify("请先开启VIP", 2)
            return
        end
        
        pcall(function()
            local player = game:GetService("Players").LocalPlayer
            
            -- 修改 Attribute 里的衣服颜色
            player:SetAttribute("ClothingColor", Value)
            
            -- 如果游戏用其他属性名，同时设置常见变体
            player:SetAttribute("ClothingColor", Value)
            player:SetAttribute("ClothColor", Value)
            player:SetAttribute("BodyColor", Value)
        end)
    end,
})
Owner:AddToggle("FakePermGuard", {
    Text = "永久守卫",
    Default = false,
    Callback = function(state)
        pcall(function()
            local player = game:GetService("Players").LocalPlayer
            if state then
                player:SetAttribute("__OwnsPermGuard", true)
            else
                player:SetAttribute("__OwnsPermGuard", false)
            end
        end)
    end
})

Owner:AddToggle("Fake2xVote", {
    Text = "两倍投票",
    Default = false,
    Callback = function(state)
        pcall(function()
            local player = game:GetService("Players").LocalPlayer
            if state then
                player:SetAttribute("__Owns2XVoteGamepass", true)
            else
                player:SetAttribute("__Owns2XVoteGamepass", false)
            end
        end)
    end
})

Owner:AddToggle("FakeLighter", {
    Text = "打火机",
    Default = false,
    Callback = function(state)
        pcall(function()
            local player = game:GetService("Players").LocalPlayer
            if state then
                player:SetAttribute("HasLighter", true)
            else
                player:SetAttribute("HasLighter", false)
            end
        end)
    end
})

Owner:AddToggle("FakeCustomTag", {
    Text = "自定义标签",
    Default = false,
    Callback = function(state)
        pcall(function()
            local player = game:GetService("Players").LocalPlayer
            if state then
                player:SetAttribute("__OwnsCustomPlayerTag", true)
            else
                player:SetAttribute("__OwnsCustomPlayerTag", false)
            end
        end)
    end
})

Owner:AddToggle("FakeGlass", {
    Text = "玻璃制造商",
    Default = false,
    Callback = function(state)
        pcall(function()
            local player = game:GetService("Players").LocalPlayer
            if state then
                player:SetAttribute("__OwnsGlassManufacturerVision", true)
            else
                player:SetAttribute("__OwnsGlassManufacturerVision", false)
            end
        end)
    end
})

Owner:AddToggle("FakePSPlus", {
    Text = "私服权限",
    Default = false,
    Callback = function(state)
        pcall(function()
            local player = game:GetService("Players").LocalPlayer
            if state then
                player:SetAttribute("__OwnsPSPlus", true)
            else
                player:SetAttribute("__OwnsPSPlus", false)
            end
        end)
    end
})

Boots:AddInput("SprintInput", {
    Default = "0",
    Numeric = true,
    Finished = true,
    MaxLength = 1,
    Text = "速度等级",
    Placeholder = "0-4",
    Callback = function(value)
        local num = tonumber(value)
        if not num then return end
        num = math.clamp(num, 0, 4)
        pcall(function()
            local player = game:GetService("Players").LocalPlayer
            local boosts = player:FindFirstChild("Boosts")
            if boosts then
                local sprint = boosts:FindFirstChild("Faster Sprint")
                if sprint then
                    sprint.Value = num
                end
            end
        end)
    end
})

Boots:AddInput("DamageInput", {
    Default = "0",
    Numeric = true,
    Finished = true,
    MaxLength = 1,
    Text = "力量等级",
    Placeholder = "0-6",
    Callback = function(value)
        local num = tonumber(value)
        if not num then return end
        num = math.clamp(num, 0, 6)
        pcall(function()
            local player = game:GetService("Players").LocalPlayer
            local boosts = player:FindFirstChild("Boosts")
            if boosts then
                local damage = boosts:FindFirstChild("Damage Boost")
                if damage then
                    damage.Value = num
                end
            end
        end)
    end
})

Boots:AddInput("WonInput", {
    Default = "0",
    Numeric = true,
    Finished = true,
    MaxLength = 1,
    Text = "金钱等级",
    Placeholder = "0-6",
    Callback = function(value)
        local num = tonumber(value)
        if not num then return end
        num = math.clamp(num, 0, 6)
        pcall(function()
            local player = game:GetService("Players").LocalPlayer
            local boosts = player:FindFirstChild("Boosts")
            if boosts then
                local won = boosts:FindFirstChild("Won Boost")
                if won then
                    won.Value = num
                end
            end
        end)
    end
})

Boots:AddInput('WalkSpeedInput', {
    Default = '16',
    Numeric = true,
    Finished = true,
    Text = '移动速度',
    Placeholder = '输入速度',
    Callback = function(value)
        local speed = tonumber(value)
        if not speed or speed <= 0 then return end
        pcall(function()
            local Players = game:GetService("Players")
            local lplr = Players.LocalPlayer
            local function setSpeed()
                local char = lplr.Character
                if not char then return end
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum.WalkSpeed = speed
                end
            end
            setSpeed()
            lplr.CharacterAdded:Connect(setSpeed)
        end)
    end
})

--攻击功能
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local CONFIG = {
    FollowDistance = 3,
    FollowHiders = true,
    FollowPosition = "后面",
}
local followConnection = nil
local currentTarget = nil
local isFollowing = false
local function IsPlayerSeeker(Player)
    if not Player or not Player.Character then return false end
    if Player.Backpack:FindFirstChild("Knife") then return true end
    if Player.Character:FindFirstChild("Knife") then return true end
    return false
end
local function GetHiders()
    local hiders = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if not IsPlayerSeeker(player) then
                table.insert(hiders, player)
            end
        end
    end
    return hiders
end
local function GetSeekers()
    local seekers = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if IsPlayerSeeker(player) then
                table.insert(seekers, player)
            end
        end
    end
    return seekers
end
local function getTarget()
    if CONFIG.FollowHiders then
        local hiders = GetHiders()
        if #hiders > 0 then
            return hiders[math.random(1, #hiders)]
        end
        return nil
    else
        local allPlayers = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                table.insert(allPlayers, player)
            end
        end
        if #allPlayers > 0 then
            return allPlayers[math.random(1, #allPlayers)]
        end
        return nil
    end
end
local function getPositionOffset()
    local distance = CONFIG.FollowDistance
    local position = CONFIG.FollowPosition
    
    if position == "前面" then
        return CFrame.new(0, 0, -distance)
    elseif position == "后面" then
        return CFrame.new(0, 0, distance)
    elseif position == "头顶" then
        return CFrame.new(0, distance, 0) * CFrame.Angles(math.rad(-90), 0, 0)
    elseif position == "下面" then
        return CFrame.new(0, -distance, 0)
    elseif position == "左面" then
        return CFrame.new(-distance, 0, 0)
    elseif position == "右面" then
        return CFrame.new(distance, 0, 0)
    else
        return CFrame.new(0, 0, distance)
    end
end
local function startFollowing()
    if isFollowing then
        stopFollowing()
        task.wait()
    end        
    currentTarget = getTarget()
    if not currentTarget then
        local targetType = CONFIG.FollowHiders and "躲藏者" or "任意玩家"
        warn("未找到可依附的目标（" .. targetType .. "）！")
        return
    end    
    isFollowing = true
    local targetType = CONFIG.FollowHiders and "躲藏者" or (IsPlayerSeeker(currentTarget) and "搜寻者" or "躲藏者")
    print("开始依附: " .. currentTarget.Name .. " (" .. targetType .. ") 位置: " .. CONFIG.FollowPosition)        
    followConnection = RunService.Heartbeat:Connect(function()
        if not currentTarget or not currentTarget.Character then
            return
        end
        local targetChar = currentTarget.Character
        local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
        if not targetHRP then return end        
        local myChar = LocalPlayer.Character
        if not myChar then return end
        local myHRP = myChar:FindFirstChild("HumanoidRootPart")
        if not myHRP then return end        
        local offset = getPositionOffset()
        myHRP.CFrame = targetHRP.CFrame * offset
    end)
end
local function stopFollowing()
    if not isFollowing then return end
    if followConnection then
        followConnection:Disconnect()
        followConnection = nil
    end
    isFollowing = false
    currentTarget = nil
    print("已停止依附")
end
Wjgjgn:AddToggle('AutoFollow', {
    Text = '自动依附',
    Default = false,
    Tooltip = '开启后自动依附目标',
    Callback = function(Value)
        if Value then
            startFollowing()
        else
            stopFollowing()
        end
    end
})

Wjgjgn:AddToggle('FollowHiders', {
    Text = '只依附躲藏者',
    Default = true,
    Tooltip = '开启：只依附躲藏者；关闭：随机依附任意玩家（躲藏者或搜寻者）',
    Callback = function(Value)
        CONFIG.FollowHiders = Value
        if isFollowing then
            stopFollowing()
            task.wait()
            startFollowing()
        end
    end
})

Wjgjgn:AddDropdown('FollowPosition', {
    Values = {'前面', '后面', '头顶', '下面', '左面', '右面'},
    Default = 2,
    Multi = false,
    Text = '依附位置',
    Tooltip = '选择依附在目标的哪个方向',
    Callback = function(Value)
        CONFIG.FollowPosition = Value
        if isFollowing then
            print("依附位置已切换至: " .. Value)
        end
    end
})

Wjgjgn:AddSlider('FollowDistance', {
    Text = '依附距离',
    Default = 3,
    Min = 1,
    Max = 10,
    Increment = 0.5,
    Tooltip = '与目标的距离（越近越贴身）',
    Callback = function(Value)
        CONFIG.FollowDistance = Value
    end
})
--朝向
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local facePlayerEnabled = false
local currentTarget = nil
local selectedPlayer = nil
local targetMode = "最近玩家"

local function facePlayer()
    if not facePlayerEnabled then return end
    if not currentTarget then return end    
    local targetCharacter = currentTarget.Character
    if not targetCharacter then return end    
    local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
    if not targetRoot then return end    
    local targetPosition = targetRoot.Position    
    local currentPosition = rootPart.Position
    local direction = (targetPosition - currentPosition)
    if direction.Magnitude < 0.001 then
        return
    end
    direction = direction.Unit
    local newCFrame = CFrame.lookAt(currentPosition, currentPosition + direction)
    rootPart.CFrame = newCFrame
end
local function getNearestPlayer()
    local nearest = nil
    local shortestDist = math.huge
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= player then
            local otherChar = otherPlayer.Character
            if otherChar then
                local otherRoot = otherChar:FindFirstChild("HumanoidRootPart")
                if otherRoot then
                    local dist = (otherRoot.Position - rootPart.Position).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        nearest = otherPlayer
                    end
                end
            end
        end
    end
    return nearest
end
local function updateTarget()
    if targetMode == "最近玩家" then
        currentTarget = getNearestPlayer()
    elseif targetMode == "指定玩家" then
        if selectedPlayer and selectedPlayer ~= player then
            currentTarget = selectedPlayer
        else
            currentTarget = nil
        end
    end
end
local function onPlayerRemoving(playerLeaving)
    if currentTarget == playerLeaving then
        currentTarget = nil
        if facePlayerEnabled then
            updateTarget()
        end
    end
    if selectedPlayer == playerLeaving then
        selectedPlayer = nil
    end
end
RunService.Heartbeat:Connect(facePlayer)
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    rootPart = character:WaitForChild("HumanoidRootPart")
    humanoid = character:WaitForChild("Humanoid")
    updateTarget()
end)
Players.PlayerRemoving:Connect(onPlayerRemoving)
Cxwjgn:AddDropdown('PlayerList', {
    SpecialType = 'Player',
    Text = '选择目标玩家',
    Tooltip = '从服务器玩家列表中选择要面朝的目标',
    Callback = function(Value)
        print('[回调] 选中玩家:', Value)
        selectedPlayer = Value
        if targetMode == "指定玩家" and facePlayerEnabled then
            updateTarget()
        end
    end
})
Cxwjgn:AddDropdown('TargetSelector', {
    Values = { '最近玩家', '指定玩家' },
    Default = 1,
    Multi = false,
    Text = '目标选择模式',
    Tooltip = '选择使用最近玩家还是手动指定的玩家',
    Callback = function(Value)
        print('[回调] 选择目标模式:', Value)
        targetMode = Value
        if facePlayerEnabled then
            updateTarget()
        end
    end
})
Cxwjgn:AddToggle('FacePlayerToggle', {
    Text = '始终面朝玩家',
    Default = false,
    Tooltip = '开启后角色将始终面朝选定的玩家（仅旋转朝向，不移动位置）',
    Callback = function(Value)
        facePlayerEnabled = Value
        print('[回调] 面朝玩家状态:', Value)
        if Value then
            updateTarget()
        end
    end
})

updateTarget()

updateTarget()

local Players1 = Tabs.Players:AddLeftGroupbox("玩家信息", "info")
local Players2 = Tabs.Players:AddRightGroupbox("玩家", "user")

local LabelA = Players1:AddLabel("名字: 等待选择...", false)
local LabelDisplayName = Players1:AddLabel("用户名: 等待选择...", false)
local LabelWim = Players1:AddLabel("金钱: 等待选择...", false)
local LabelLevel = Players1:AddLabel("等级: 等待选择...", false)
local LabelWins = Players1:AddLabel("胜场: 等待选择...", false)
local LabelSprint = Players1:AddLabel("速度等级: 等待选择...", false)
local LabelDamage = Players1:AddLabel("力量等级: 等待选择...", false)
local LabelWonBoost = Players1:AddLabel("金钱等级: 等待选择...", false)
local LabelAFK = Players1:AddLabel("挂机世界币: 等待选择...", false)
local LabelVIP = Players1:AddLabel("VIP: 等待选择...", false)
local LabelRobux = Players1:AddLabel("捐赠Robux: 等待选择...", false)
local Label2xVote = Players1:AddLabel("2倍投票: 等待选择...", false)
local LabelPSPlus = Players1:AddLabel("私服通行证: 等待选择...", false)
local LabelGlass = Players1:AddLabel("玻璃厂商: 等待选择...", false)
local LabelEmotePages = Players1:AddLabel("动作页: 等待选择...", false)
local LabelCustomTag = Players1:AddLabel("自定义标签: 等待选择...", false)
local LabelLighter = Players1:AddLabel("打火机: 等待选择...", false)

Players2:AddDropdown("MyDropdownPlayers1", {
    Values = {},
    Default = nil,
    Multi = false,
    Text = "选择玩家",
    Searchable = true,
    SpecialType = "Player",
    ExcludeLocalPlayer = false,
})

local function refreshPlayerList()
    local playerNames = {}
    for _, player in pairs(Players:GetPlayers()) do
        table.insert(playerNames, player.Name)
    end
    pcall(function()
        Library.Options.MyDropdownPlayers1:SetValues(playerNames)
    end)
end

refreshPlayerList()
Players.PlayerAdded:Connect(refreshPlayerList)
Players.PlayerRemoving:Connect(function()
    task.wait(0.1)
    refreshPlayerList()
end)
task.spawn(function()
    while true do
        task.wait(1)
        refreshPlayerList()
    end
end)

Players2:AddButton({
    Text = "确定",
    Func = function()
        pcall(function()
            local selectedName = Library.Options.MyDropdownPlayers1.Value
            local targetPlayer = Players:FindFirstChild(selectedName)

            if targetPlayer then
                LabelA:SetText("名字: " .. selectedName)
                LabelDisplayName:SetText("用户名: " .. targetPlayer.DisplayName)
                LabelWim:SetText("金钱: " .. tostring(targetPlayer:GetAttribute("_Won")))
                LabelLevel:SetText("等级: " .. tostring(targetPlayer:GetAttribute("_CurrentLevel")))
                LabelWins:SetText("胜场: " .. tostring(targetPlayer:GetAttribute("_GameWins")))
                LabelRobux:SetText("捐赠Robux: " .. tostring(targetPlayer:GetAttribute("_TotalRobuxDonated")))
                LabelAFK:SetText("挂机世界币: " .. tostring(targetPlayer:GetAttribute("_AFKCoins")))

                local vipData = targetPlayer:GetAttribute("_VIPSettingData")
                if vipData == "[]" or vipData == "" or not vipData then
                    LabelVIP:SetText("VIP: X")
                else
                    LabelVIP:SetText("VIP: √")
                end

                local has2xVote = targetPlayer:GetAttribute("__Owns2XVoteGamepass")
                Label2xVote:SetText("2倍投票: " .. (has2xVote and "√" or "X"))

                local hasPSPlus = targetPlayer:GetAttribute("__OwnsPSPlus")
                LabelPSPlus:SetText("私服: " .. (hasPSPlus and "√" or "X"))

                local hasGlass = targetPlayer:GetAttribute("__OwnsGlassManufacturerVision")
                LabelGlass:SetText("玻璃透视: " .. (hasGlass and "√" or "X"))

                local hasEmotePages = targetPlayer:GetAttribute("__OwnsEmotePages")
                LabelEmotePages:SetText("动作页: " .. (hasEmotePages and "√" or "X"))

                local hasCustomTag = targetPlayer:GetAttribute("__OwnsCustomPlayerTag")
                LabelCustomTag:SetText("自定义标签: " .. (hasCustomTag and "√" or "X"))

                local hasLighter = targetPlayer:GetAttribute("HasLighter")
                LabelLighter:SetText("打火机: " .. (hasLighter and "√" or "X"))

                local boostData = targetPlayer:GetAttribute("_BoostData")
                if boostData then
                    if type(boostData) == "string" then
                        boostData = HttpService:JSONDecode(boostData)
                    end
                    LabelSprint:SetText("速度等级: " .. tostring(boostData["Faster Sprint"]))
                    LabelDamage:SetText("力量等级: " .. tostring(boostData["Damage Boost"]))
                    LabelWonBoost:SetText("金钱等级: " .. tostring(boostData["Won Boost"]))
                else
                    LabelSprint:SetText("速度等级: …")
                    LabelDamage:SetText("力量等级: …")
                    LabelWonBoost:SetText("金钱等级: …")
                end
            else
                LabelA:SetText("名字: 未选择")
                LabelDisplayName:SetText("用户名: 未选择")
                LabelWim:SetText("金钱: 未选择")
                LabelLevel:SetText("等级: 未选择")
                LabelWins:SetText("胜场: 未选择")
                LabelSprint:SetText("速度等级: 未选择")
                LabelDamage:SetText("力量等级: 未选择")
                LabelWonBoost:SetText("金钱等级: 未选择")
                LabelAFK:SetText("挂机世界币: 未选择")
                LabelVIP:SetText("VIP: 未选择")
                Label2xVote:SetText("2倍投票: 未选择")
                LabelPSPlus:SetText("私服: 未选择")
                LabelGlass:SetText("玻璃透视: 未选择")
                LabelEmotePages:SetText("动作页: 未选择")
                LabelCustomTag:SetText("自定义标签: 未选择")
                LabelLighter:SetText("打火机: 未选择")
                LabelRobux:SetText("捐赠Robux: 未选择")
            end
        end)
    end
})

local Zdxg = Tabs.guard:AddLeftGroupbox("枪械修改", "crosshair")
Zdxg:AddInput('BulletInput', {
    Default = '999',
    Numeric = true,
    Finished = true,
    Text = '子弹数量',
    Placeholder = '输入子弹数量',
    Callback = function(Value)
        _G.BulletAmount = tonumber(Value) or 999
    end
})

Zdxg:AddButton('修改子弹', function()
    local Player = game:GetService("Players").LocalPlayer
    local Backpack = Player:FindFirstChild("Backpack")
    if not Backpack then return end
    local Amount = _G.BulletAmount or 999
    
    for _, Gun in pairs(Backpack:GetChildren()) do
        if Gun:IsA("Tool") and Gun:FindFirstChild("InfoClient") then
            local Bullets = Gun.InfoClient:FindFirstChild("Bullets")
            if Bullets then
                Bullets.Value = Amount
                print('[成功] ' .. Gun.Name .. ' 子弹已改为 ' .. Amount)
            end
        end
    end
end)

local MenuGroup = Tabs.Settings:AddLeftGroupbox("菜单")
MenuGroup:AddToggle("KeybindMenuOpen", {
    Text = "显示按键绑定菜单",
    Default = Library.KeybindFrame.Visible,
    Callback = function(State)
        Library.KeybindFrame.Visible = State
    end
})
MenuGroup:AddToggle("ShowCustomCursor", {
    Text = "自定义光标",
    Default = false,
    Callback = function(State)
        Library.ShowCustomCursor = State
    end
})
MenuGroup:AddDropdown("NotificationSide", {
    Text = "通知位置",
    Default = "右侧",
    Values = { "左侧", "右侧" },
    Callback = function(Value)
        Library:SetNotifySide(Value)
    end
})
MenuGroup:AddDropdown("DPIDropdown", {
    Text = "界面缩放 (DPI)",
    Default = "100%",
    Values = {
        "50%", "75%", "100%", "125%", "150%", "175%", "200%"
    },
    Callback = function(Value)
        local Scale = tonumber(Value:gsub("%%", ""))
        Library:SetDPIScale(Scale / 100)
    end
})
MenuGroup:AddDivider()
MenuGroup:AddLabel("菜单快捷键")
    :AddKeyPicker("MenuKeybind", {
        Default = "RightShift",
        NoUI = true,
        Text = "菜单快捷键"
    })

MenuGroup:AddButton("卸载脚本", function()
    Library:Unload()
end)
Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
ThemeManager:SetFolder("MyScriptTheme")
SaveManager:SetFolder("MyScriptConfig")
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)
Library:Notify("AY Hub丨墨水游戏 已加载", 3)
