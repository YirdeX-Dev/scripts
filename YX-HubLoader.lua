--🤓你们搬吧，你们能坚持下来算你们可以

local function ShowErrorPrompt(title, message, shouldKick)
    local promptCode = [[
        local title, message, shouldKick = ...
        
        spawn(function()
            while true do
                pcall(function()
                    local CoreGui = game:GetService("CoreGui")
                    local prompt = CoreGui:FindFirstChild("RobloxPromptGui")
                    if prompt and prompt:FindFirstChild("promptOverlay") then
                        local overlay = prompt.promptOverlay
                        local errorPrompt = overlay:FindFirstChild("ErrorPrompt")
                        if errorPrompt then
                            local titleFrame = errorPrompt:FindFirstChild("TitleFrame")
                            if titleFrame and titleFrame:FindFirstChild("ErrorTitle") then
                                titleFrame.ErrorTitle.Text = title
                            end
                            local messageArea = errorPrompt:FindFirstChild("MessageArea")
                            if messageArea and messageArea:FindFirstChild("ErrorFrame") then
                                local errorFrame = messageArea.ErrorFrame
                                if errorFrame:FindFirstChild("ErrorMessage") then
                                    errorFrame.ErrorMessage.Text = message
                                end
                            end
                        end
                    end
                end)
                wait()
            end
        end)
        
        if shouldKick then
            game:GetService("Players").LocalPlayer:Kick(message)
        end
        
        while wait() do end
    ]]
    
    loadstring(promptCode)(title, message, shouldKick)
end

local TARGET_PLACE_IDS = {
    114234929420007,
}

local currentPlaceId = game.PlaceId

local isBlocked = false
for _, id in ipairs(TARGET_PLACE_IDS) do
    if currentPlaceId == id then
        isBlocked = true
        break
    end
end

if isBlocked then

    ShowErrorPrompt("YX-脚本中心警告🚫", "该服务器已被禁止使用\n现以踢出防止封禁", true)
else

end

game:GetService("StarterGui"):SetCore("SendNotification", {
  Title = "YX-脚本中心",
  Text = "欢迎使用YX-脚本中心",
  Icon = "rbxassetid://127276339495788",
  Duration = 1,
  Callback = bindable,
  Button1 = "欢迎使用",
  Button2 = "持续更新",
})

local GlobalEnv = getgenv()
local FunctionEnv = getfenv()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/DevSloPo/obsidian_UI/main/Library.lua"))() 
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/obsidian_UI/refs/heads/main/ThemeManager.lua"))() 
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/DevSloPo/obsidian_UI/main/addons/SaveManager.lua"))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local Humanoid = Character:WaitForChild("Humanoid")

local function LoadScript(scriptName, url)
    local startTime = tick()
    loadstring(game:HttpGet(url))()
    ShowScriptLoadedNotification(scriptName, tick() - startTime)
end
local A1 = game:GetService("Players")
local A2 = A1.LocalPlayer
local A3 = game:GetService("RunService")
local A4 = game:GetService("Lighting")
local A5 = game:GetService("CoreGui")
local A6 = game:GetService("UserInputService")
local A7 = game:GetService("TeleportService")
local A8 = workspace
local A9 = game:GetService("HttpService")

local Win = Library:CreateWindow({
	Title = "YX-脚本中心",
    Footer = "制作人：YirdeX，此脚本为脚本中心",
	Icon = 127276339495788,
	  Size = UDim2.fromOffset(750, 650),
    AutoShow = true,
    NotifySide = "Right",
    ShowCustomCursor = true,
    IconSize = UDim2.fromOffset(40, 40),
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
    D = Win:AddTab({
        Name = "首页",
        Description = "[主要群聊:2152069753]",
        Icon = "house"
    }),
    Universal = Win:AddTab({
        Name = "通用功能",
        Description = "汇聚优秀脚本",
        Icon = "code-xml"
    }),
    B = Win:AddTab({
        Name = "脚本中心",
        Description = "汇聚很多服务器优秀脚本",
        Icon = "bug"
    }),
    ["UI Settings"] = Win:AddTab({
        Name = "设置",
        Description = "界面设置与部分功能",
        Icon = "settings"
    }),
    C = Win:AddTab({
        Name = "外部插件",
        Description = "额外功能加入此脚本",
        Icon = "boxes"
    })
}


local AB = Tabs.D:AddRightGroupbox("信息")
local AA = Tabs.D:AddLeftGroupbox("人员名单","handshake")
local Addons = Tabs.C:AddLeftGroupbox("插件管理")

    Tabs.D:UpdateWarningBox({
        Title = '脚本信息',
        Text = '该脚本是由<font color=\"rgb(0, 255, 255)\">YirdeX</font>制作出来的<font color=\"rgb(0, 255, 255)\">Hub</font>脚本，为各位脚本玩家提供最为优质的脚本中心，同时搜寻网上所有的汉化脚本，让各位不用再为看不懂<font color=\"rgb(0, 255, 255)\">英文</font>而烦恼',
        IsNormal = true,
        Visible = true,
        LockSize = true,
    })
AA:AddLabel("[<font color=\"rgb(0, 255, 0)\">YirdeX</font>]制作者 | 所有者")
AA:AddLabel("[<font color=\"rgb(0, 255, 0)\">秋词</font>]制作者 | 开发者")


AB:AddButton({
    Text = "复制YirdeXQQ主群",
    Func = function()
    setclipboard("2152069753")
    Tooltip = "复制主群号",
    Library:Notify({
    Title = "YirdeX-提示",
    Description = "复制成功",
    Time = 2,
})
    end
})
AB:AddButton({
    Text = "复制YirdeX快手号",
    Func = function()
    setclipboard("3839425043")
       Tooltip = "复制快手号",
       Library:Notify({
    Title = "YirdeX-提示",
    Description = "复制成功",
    Time = 2,
})
    end
})
AB:AddButton({
    Text = "复制YirdeXB站lD",
    Func = function()
    setclipboard("UID:3493111925836628")
       Tooltip = "复制B站lD",
    Library:Notify({
    Title = "YirdeX-提示",
    Description = "复制成功",
    Time = 2,
})
    end
})
AB:AddLabel("--------------------")
AB:AddButton({
    Text = "复制AF主群",
    Func = function()
    setclipboard("https://qun.qq.com/universal-share/share?ac=1&authKey=bEmFYn95LgJAyVYjM00CBWVn8i23mWAyj5Z%2Ba3rithMWPxzDwKlZ9wKtaB7q2s6n&busi_data=eyJncm91cENvZGUiOiI5Mzg3MTQ0MjciLCJ0b2tlbiI6IkFGL2Z6QTE5WUNRU2UrOGF6SzRQRVJDdmc5YzJjZVVmQXdEbmhObHNnRUhQZDUzL3djamJUdm5SRThDSjFrQmYiLCJ1aW4iOiIzNDM1Mjg2MTc3In0%3D&data=ahUTHr2un-Gf0AHE1oBjxdt0-y4VEoLSnZ1D6Ve-6KdsYM4R_Rw-hJ-amg0HfFokPb9CyhFVCDesPER_Ave_8A&svctype=4&tempid=h5_group_info")
       Tooltip = "复制AF主群",
    Library:Notify({
    Title = "YirdeX-提示",
    Description = "复制成功",
    Time = 2,
})
    end
})
AB:AddButton({
    Text = "复制秋词快手号",
    Func = function()
    setclipboard("XQWANYYDS")
       Tooltip = "复制秋词快手号",
    Library:Notify({
    Title = "YirdeX-提示",
    Description = "复制成功",
    Time = 2,
})
    end
})
----------


local UniversalLeftGroup = Tabs.Universal:AddLeftGroupbox("各种功能");
local UniversalRightGroup = Tabs.Universal:AddRightGroupbox("信息与翻译");
local A17 = nil;
local A18 = false;
local A19 = false;
local A20 = false;
local A21 = false;
local A22 = nil;
local A23 = nil;
local A24 = nil;
local A25 = nil;
local A26 = nil;
local A27 = {};
local A28 = false;
local A29 = true;
local PL = {};
local CP = nil;
local bulletTrackingHook = nil;
local function safeNotify(title, message, duration)
        warn(title .. ": " .. message);
end
UniversalLeftGroup:AddSlider("WalkSpeedSlider", {Text="移动速度(可在墨水使用)",Default=16,Min=16,Max=200,Rounding=0,Compact=false,Callback=function(Value)
        if (A2 and A2.Character) then
                local Humanoid = A2.Character:FindFirstChild("Humanoid");
                if Humanoid then
                        Humanoid.WalkSpeed = Value;
                end
        end
end});
UniversalLeftGroup:AddInput("WalkSpeedInput", {Text="移动速度设置",Default="",Placeholder="输入移动速度值",Numeric=true,Finished=false,Callback=function(Value)
        local numValue = tonumber(Value);
        if (numValue and A2 and A2.Character) then
                local Humanoid = A2.Character:FindFirstChild("Humanoid");
                if Humanoid then
                        Humanoid.WalkSpeed = numValue;
                end
        end
end});

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

UniversalLeftGroup:AddToggle('MyToggle', {
    Text = '飞行模式(能在墨水使用可能会被反作弊击杀)',
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

UniversalLeftGroup:AddSlider('MyIntSlider', {
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

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local lp = Players.LocalPlayer
local camera = workspace.CurrentCamera

local isWarpFlying = false
local flySpeed = 50

local MICRO_STEP_INTERVAL = 0.001
local MAX_STEP_SIZE = 10

local hrp, hum
local ControlModule = require(
    lp.PlayerScripts:WaitForChild("PlayerModule")
):GetControls()

local microStepConn, healthLockConn, diedConn
local originalCanCollide = {}
local descendantConnection

local function clearFlyRes()
    pcall(function()
        for part, state in pairs(originalCanCollide) do
            if part and part.Parent then
                part.CanCollide = state
            end
        end
        table.clear(originalCanCollide)

        if descendantConnection then descendantConnection:Disconnect() end
        if microStepConn then microStepConn:Cancel() end
        if healthLockConn then healthLockConn:Disconnect() end
        if diedConn then diedConn:Disconnect() end

        if hrp and hum then
            hum:ChangeState(Enum.HumanoidStateType.Running)
        end
    end)
end

local function microStepLoop()
    local targetPos = hrp.Position
    local lastTime = tick()

    while isWarpFlying do
        local now = tick()
        local dt = now - lastTime
        lastTime = now

        local mv = ControlModule:GetMoveVector()
        local cf = camera.CFrame

        local moveDir =
            (cf.LookVector * -mv.Z) +
            (cf.RightVector * mv.X)

        local vertical = 0
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            vertical = 1
        elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            vertical = -1
        end

        local totalDelta =
            (moveDir + Vector3.new(0, vertical, 0)) *
            flySpeed * dt

        targetPos += totalDelta

        local currentPos = hrp.Position
        local remaining = targetPos - currentPos
        local distance = remaining.Magnitude

        if distance > 0 then
            local steps = math.ceil(distance / MAX_STEP_SIZE)
            local stepVec = remaining / steps

            for i = 1, steps do
                if not isWarpFlying then break end
                currentPos += stepVec
                hrp.CFrame =
                    CFrame.new(currentPos) * hrp.CFrame.Rotation
                hrp.Velocity = Vector3.zero
            end
        else
            hrp.CFrame =
                CFrame.new(targetPos) * hrp.CFrame.Rotation
            hrp.Velocity = Vector3.zero
        end

        hum:ChangeState(Enum.HumanoidStateType.Climbing)
        task.wait(MICRO_STEP_INTERVAL)
    end
end

local function healthLockLoop()
    while isWarpFlying do
        if hum and hum.Health < hum.MaxHealth then
            hum.Health = hum.MaxHealth
        end
        RunService.Heartbeat:Wait()
    end
end

local function onDied()
    if hum and isWarpFlying then
        hum.Health = hum.MaxHealth
        hum:ChangeState(Enum.HumanoidStateType.Running)
    end
end

local function startWarpFly()
    if isWarpFlying then return end

    local char = lp.Character
    if not char then return end

    hrp = char:FindFirstChild("HumanoidRootPart")
    hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end

    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            originalCanCollide[part] = part.CanCollide
            part.CanCollide = false
        end
    end

    descendantConnection = char.DescendantAdded:Connect(function(desc)
        if desc:IsA("BasePart") then
            originalCanCollide[desc] = desc.CanCollide
            desc.CanCollide = false
        end
    end)

    isWarpFlying = true
    hum:ChangeState(Enum.HumanoidStateType.Climbing)

    microStepConn = task.spawn(microStepLoop)
    healthLockConn = task.spawn(healthLockLoop)
    diedConn = hum.Died:Connect(onDied)
end

local function stopWarpFly()
    isWarpFlying = false
    clearFlyRes()
end

UniversalLeftGroup:AddToggle('FlyToggle', {
    Text = '平滑飞行(无视墙体，不会死亡，不能在墨水使用)',
    Default = false,
    Tooltip = '开启 / 关闭硬核不死飞行',
    Callback = function(Value)
        if Value then
            startWarpFly()
        else
            stopWarpFly()
        end
    end
})

UniversalLeftGroup:AddSlider('FlySpeedSlider', {
    Text = '飞行速度',
    Default = 50,
    Min = 10,
    Max = 200,
    Rounding = 0,
    Suffix = '',
    Callback = function(Value)
        flySpeed = Value
    end
})

local function bindCharacter()
    local char = lp.Character or lp.CharacterAdded:Wait()
    hrp = char:WaitForChild("HumanoidRootPart")
    hum = char:WaitForChild("Humanoid")

    char.AncestryChanged:Connect(function(_, parent)
        if not parent then
            stopWarpFly()
            bindCharacter()
        end
    end)
end

bindCharacter()

print("✅ 战旗飞行（硬核不死版）已加载")

local CurrentCamera = workspace.CurrentCamera
if not CurrentCamera then
    warn("未找到 CurrentCamera")
    return
end

UniversalLeftGroup:AddSlider('UltraWideSlider', {
    Text = "超广角设置(可在墨水使用)",
    Default = 70,
    Min = 20,
    Max = 120,
    Rounding = 0,
    Suffix = "°",
    Compact = false,

    Callback = function(Value)
        local fov = tonumber(Value)
        if fov then
            CurrentCamera.FieldOfView = fov
        end
    end
})
UniversalLeftGroup:AddToggle('MyToggle', {
    Text = '极速旋转(不要在墨水游戏里使用)',
    Default = false,
    Tooltip = '开启将会快速旋转',
    Callback = function(Value)
    local Character = LocalPlayer.Character
        local Humanoid = Character:FindFirstChild("Humanoid")
        
        spawn(function()
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://507776043"
            local track = Humanoid:LoadAnimation(anim)
            track:Play()
            track:AdjustSpeed(0)
            
            if Character:FindFirstChild("Animate") then
                Character.Animate.Disabled = true
            end
            
            local sound = Instance.new("Sound")
            sound.Name = "Sound"
            sound.SoundId = "http://www.roblox.com/asset/?id=8114290584"
            sound.Volume = 0
            sound.Looped = false
            sound.Parent = Workspace
            sound:Play()
            
            wait()
            
            local bav = Instance.new("BodyAngularVelocity")
            bav.Name = "Spinning"
            bav.Parent = Character.HumanoidRootPart
            bav.MaxTorque = Vector3.new(0, math.huge, 0)
            bav.AngularVelocity = Vector3.new(0, 30, 0)
            
            wait(3.5)
        end)
    end
})
UniversalLeftGroup:AddToggle('TeleportToolToggle', {
    Text = '启用传送工具',
    Default = false,
    Tooltip = '开启后可使用传送工具',
    Callback = function(Value)
        if Value then
            print("[传送工具] 已启用，请在背包中使用")
        else
            local tool = LocalPlayer.Backpack:FindFirstChild("[bs中心]传送工具")
            if tool then tool:Destroy() end
        end
    end
})
UniversalLeftGroup:AddButton({
    Text = '获取传送工具',
    Tooltip = '点击后获得一个点击传送工具',
    Callback = function()
        if not Toggles.TeleportToolToggle.Value then
            warn("[传送工具] 请先开启开关")
            return
        end

        local Mouse = LocalPlayer:GetMouse()

        local Tool = Instance.new("Tool")
        Tool.RequiresHandle = false
        Tool.Name = "[bs中心]传送工具"

        Tool.Activated:Connect(function()
            local pos = Mouse.Hit.Position + Vector3.new(0, 2.5, 0)
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(pos)
            end
        end)

        Tool.Parent = LocalPlayer.Backpack
    end
})
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

local Enabled = false
local targetPlayer = nil

local function findPlayer(text)
    text = text:lower()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Name:lower():find(text) or plr.DisplayName:lower():find(text) then
            return plr
        end
    end
end

lp.Chatted:Connect(function(msg)
    if not Enabled then return end

    if msg:sub(1,6):lower() == ";kill " then
        local name = msg:sub(7)
        targetPlayer = findPlayer(name)
    end
end)

task.spawn(function()
    while task.wait(0.01) do
        if not Enabled or not targetPlayer then continue end

        local char = targetPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then
            targetPlayer = nil
            continue
        end

        local hum = char.Humanoid
        if hum.Health <= 0 then
            targetPlayer = nil
            continue
        end

        local myChar = lp.Character
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local targetHRP = char.HumanoidRootPart

        if myHRP and targetHRP then
            local offset = targetHRP.Velocity.Magnitude < 0.1 and 0 or 7
            local goal =
                targetHRP.CFrame
                * CFrame.new(0, 0, -offset)
                * CFrame.Angles(0, math.rad(-3), 0)

            myHRP.CFrame = myHRP.CFrame:Lerp(goal, 0.4)
            myHRP.Velocity = Vector3.zero
            myHRP.RotVelocity = Vector3.zero
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if not Enabled then continue end
        local hum = lp.Character and lp.Character:FindFirstChild("Humanoid")
        if hum then
            hum:Move(Vector3.one * 1e31)
        end
    end
end)

UniversalLeftGroup:AddToggle("TouchKillToggle", {
    Text = "碰飞(可在墨水使用)",
    Default = false,
    Callback = function(Value)
        Enabled = Value
        targetPlayer = nil

        if Value then
            warn("碰飞已开启")
        else
            warn("碰飞已关闭")
        end
    end
})
UniversalLeftGroup:AddToggle('AntiFlingToggle', {
    Text = '防甩飞(可在墨水使用)',
    Default = false,
    Tooltip = '开启后防止玩家被甩飞',

    Callback = function(state)
        if state then
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local LocalPlayer = Players.LocalPlayer

            local ANTI_FLING_FORCE = 1e6
            local UPDATE_RATE = 0.01

            _G.ActiveHandles = {
                Connections = {},
                Constraints = {},
                Alignments = {}
            }

            local function CreateSuperConstraint(part)
                local bodyPos = Instance.new("BodyPosition")
                bodyPos.P = ANTI_FLING_FORCE
                bodyPos.D = ANTI_FLING_FORCE / 10
                bodyPos.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bodyPos.Position = part.Position
                bodyPos.Parent = part

                local bodyGyro = Instance.new("BodyGyro")
                bodyGyro.P = ANTI_FLING_FORCE
                bodyGyro.D = ANTI_FLING_FORCE / 10
                bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                bodyGyro.CFrame = part.CFrame
                bodyGyro.Parent = part

                local alignPos = Instance.new("AlignPosition")
                alignPos.RigidityEnabled = true
                alignPos.MaxForce = ANTI_FLING_FORCE
                alignPos.Responsiveness = ANTI_FLING_FORCE
                alignPos.Parent = part

                local alignOri = Instance.new("AlignOrientation")
                alignOri.RigidityEnabled = true
                alignOri.MaxTorque = ANTI_FLING_FORCE
                alignOri.Responsiveness = ANTI_FLING_FORCE
                alignOri.Parent = part

                table.insert(_G.ActiveHandles.Constraints, bodyPos)
                table.insert(_G.ActiveHandles.Constraints, bodyGyro)
                table.insert(_G.ActiveHandles.Alignments, alignPos)
                table.insert(_G.ActiveHandles.Alignments, alignOri)

                return bodyPos, bodyGyro, alignPos, alignOri
            end

            local function ApplyUltimateProtection(character)
                if not character then return end

                local rootPart = character:FindFirstChild("HumanoidRootPart")
                    or character:FindFirstChild("Torso")

                if not rootPart then return end

                local bodyPos, bodyGyro, alignPos, alignOri =
                    CreateSuperConstraint(rootPart)

                local updateConn = RunService.Heartbeat:Connect(function()
                    if not character:IsDescendantOf(workspace) then return end

                    bodyPos.Position = rootPart.Position
                    bodyGyro.CFrame = rootPart.CFrame

                    for _, part in ipairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                            part.CustomPhysicalProperties =
                                PhysicalProperties.new(0, 0, 0)
                            part.AssemblyAngularVelocity = Vector3.new()
                            part.AssemblyLinearVelocity = Vector3.new()
                            part.Velocity = Vector3.new()
                            part.RotVelocity = Vector3.new()
                            part:SetAttribute("LastPosition", part.Position)
                        end
                    end
                end)

                table.insert(_G.ActiveHandles.Connections, updateConn)

                local velConn =
                    rootPart:GetPropertyChangedSignal("AssemblyLinearVelocity")
                        :Connect(function()
                            rootPart.AssemblyLinearVelocity = Vector3.new()
                            rootPart.Velocity = Vector3.new()
                        end)

                table.insert(_G.ActiveHandles.Connections, velConn)

                local rotConn =
                    rootPart:GetPropertyChangedSignal("AssemblyAngularVelocity")
                        :Connect(function()
                            rootPart.AssemblyAngularVelocity = Vector3.new()
                            rootPart.RotVelocity = Vector3.new()
                        end)

                table.insert(_G.ActiveHandles.Connections, rotConn)

                local posCheck = RunService.Heartbeat:Connect(function()
                    if not character:IsDescendantOf(workspace) then return end

                    local lastPos = rootPart:GetAttribute("LastPosition")
                    if lastPos then
                        local dist =
                            (rootPart.Position - lastPos).Magnitude
                        if dist > 5 then
                            rootPart.CFrame = CFrame.new(lastPos)
                        end
                    end
                    rootPart:SetAttribute("LastPosition", rootPart.Position)
                end)

                table.insert(_G.ActiveHandles.Connections, posCheck)
            end

            local function MonitorPlayer(player)
                if player == LocalPlayer then return end

                local function HandleCharacter(character)
                    if not character then return end
                    repeat task.wait() until
                        character:FindFirstChild("HumanoidRootPart")
                        or character:FindFirstChild("Torso")

                    ApplyUltimateProtection(character)
                end

                if player.Character then
                    HandleCharacter(player.Character)
                end

                local charConn =
                    player.CharacterAdded:Connect(HandleCharacter)
                table.insert(_G.ActiveHandles.Connections, charConn)
            end

            for _, player in ipairs(Players:GetPlayers()) do
                MonitorPlayer(player)
            end

            local playerConn =
                Players.PlayerAdded:Connect(MonitorPlayer)
            table.insert(_G.ActiveHandles.Connections, playerConn)

        else
            -- 关闭防甩飞
            for _, conn in ipairs(_G.ActiveHandles.Connections or {}) do
                if conn.Connected then
                    conn:Disconnect()
                end
            end

            for _, constraint in ipairs(
                _G.ActiveHandles.Constraints or {}
            ) do
                if constraint and constraint.Parent then
                    constraint:Destroy()
                end
            end

            for _, align in ipairs(
                _G.ActiveHandles.Alignments or {}
            ) do
                if align and align.Parent then
                    align:Destroy()
                end
            end

            for _, player in ipairs(
                game:GetService("Players"):GetPlayers()
            ) do
                if player ~= LocalPlayer and player.Character then
                    for _, part in ipairs(
                        player.Character:GetDescendants()
                    ) do
                        if part:IsA("BasePart") then
                            part.CanCollide = true
                            part.CustomPhysicalProperties = nil
                            part.AssemblyAngularVelocity = Vector3.new()
                            part.AssemblyLinearVelocity = Vector3.new()
                            part:SetAttribute("LastPosition", nil)
                        end
                    end
                end
            end

            _G.ActiveHandles = {
                Connections = {},
                Constraints = {},
                Alignments = {}
            }
        end
    end
})
 UniversalLeftGroup:AddCheckbox("ESP", {
    Text = "透视[墨水可用]",
    Default = false,
    Callback = function(enabled)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")

        local highlights = {}
        local connections = {}

        local function clearHighlights()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local hl = plr.Character.HumanoidRootPart:FindFirstChild("Highlight")
                    if hl then
                        hl:Destroy()
                    end
                end
            end
            for _, conn in pairs(connections) do
                if typeof(conn) == "RBXScriptConnection" then
                    conn:Disconnect()
                end
            end
            table.clear(highlights)
            table.clear(connections)
        end

        if enabled then
            for _, plr in pairs(Players:GetPlayers()) do
                task.spawn(function()
                    repeat task.wait() until plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                    if not plr.Character.HumanoidRootPart:FindFirstChild("Highlight") then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "Highlight"
                        highlight.Adornee = plr.Character
                        highlight.Parent = plr.Character.HumanoidRootPart
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlights[plr] = highlight
                    end
                end)
            end

            connections["PlayerAdded"] = Players.PlayerAdded:Connect(function(plr)
                task.spawn(function()
                    repeat task.wait() until plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                    if not plr.Character.HumanoidRootPart:FindFirstChild("Highlight") then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "Highlight"
                        highlight.Adornee = plr.Character
                        highlight.Parent = plr.Character.HumanoidRootPart
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlights[plr] = highlight
                    end
                end)
            end)

            connections["PlayerRemoving"] = Players.PlayerRemoving:Connect(function(plr)
                if highlights[plr] then
                    highlights[plr]:Destroy()
                    highlights[plr] = nil
                end
            end)

        else
            clearHighlights()
        end
    end
})
UniversalLeftGroup:AddCheckbox("No Shadows", {
    Text = "无阴影",
    Default = false,
    Callback = function(v)
        _env.GlobalShadows = v
    end
})

UniversalLeftGroup:AddCheckbox("Demisting", {
    Text = "去雾",
    Default = false,
    Callback = function(v)
        _env.NoFog = v
    end
})

UniversalLeftGroup:AddToggle("RainbowFPS", {
    Text = "彩虹FPS",
    Default = false,
    Callback = function(v)
        _G.RainbowFPS_Enabled = v
    end
})

local AimbotFOV = 150

UniversalLeftGroup:AddSlider('AimbotFOVSlider', {
    Text = "自瞄范围 FOV",
    Default = 150,
    Min = 50,
    Max = 400,
    Rounding = 0,
    Suffix = "px",
    Compact = false,

    Callback = function(Value)
        AimbotFOV = tonumber(Value)
    end
})

UniversalLeftGroup:AddToggle('AimbotToggle', {
    Text = '强制自瞄[无法关闭，带墙壁检测]',
    Default = false,
    Tooltip = 'FOV模式 + 墙壁检测',
    Callback = function(Value)
        local Cam = workspace.CurrentCamera
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")

        local MAX_DISTANCE = 800
        local connection
        local fovCircle

        if Value then
            fovCircle = Drawing.new("Circle")
            fovCircle.Color = Color3.fromRGB(255, 0, 0)
            fovCircle.Thickness = 1.5
            fovCircle.Filled = false
            fovCircle.Visible = true

            connection = RunService.RenderStepped:Connect(function()
                fovCircle.Position = Vector2.new(
                    Cam.ViewportSize.X / 2,
                    Cam.ViewportSize.Y / 2
                )
                fovCircle.Radius = AimbotFOV

                local nearest = nil
                local last = math.huge

                for _, v in pairs(Players:GetPlayers()) do
                    if v ~= Players.LocalPlayer
                        and v.Character
                        and v.Character:FindFirstChild("Head") then

                        local head = v.Character.Head
                        local pos, visible =
                            Cam:WorldToViewportPoint(head.Position)

                        if visible then
                            local accPos = Vector2.new(pos.X, pos.Y)
                            local center = Vector2.new(
                                Cam.ViewportSize.X / 2,
                                Cam.ViewportSize.Y / 2
                            )

                            local dist = (accPos - center).Magnitude

                            if dist < last and dist <= AimbotFOV then
                                local rayParams = RaycastParams.new()
                                rayParams.FilterDescendantsInstances = {
                                    Players.LocalPlayer.Character
                                }
                                rayParams.FilterType = Enum.RaycastFilterType.Blacklist

                                local origin = Cam.CFrame.Position
                                local direction =
                                    (head.Position - origin).Unit * MAX_DISTANCE

                                local result =
                                    workspace:Raycast(origin, direction, rayParams)

                                if not result or result.Instance:IsDescendantOf(v.Character) then
                                    last = dist
                                    nearest = v
                                end
                            end
                        end
                    end
                end

                if nearest and nearest.Character and nearest.Character:FindFirstChild("Head") then
                    Cam.CFrame = CFrame.new(
                        Cam.CFrame.Position,
                        nearest.Character.Head.Position
                    )
                end
            end)

        else
            if connection then
                connection:Disconnect()
                connection = nil
            end
            if fovCircle then
                fovCircle:Remove()
                fovCircle = nil
            end
        end
    end
})
UniversalLeftGroup:AddToggle('CircleESPToggle', {
    Text = '透视 ESP',
    Default = false,
    Tooltip = '显示玩家圆圈 + 名字',
    Callback = function(Value)
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                if Value then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = player.Character
                    highlight.Adornee = player.Character
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    local billboard = Instance.new("BillboardGui")
                    billboard.Parent = player.Character
                    billboard.Adornee = player.Character
                    billboard.Size = UDim2.new(0, 100, 0, 100)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true

                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Parent = billboard
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = player.Name
                    nameLabel.TextColor3 = Color3.new(1, 1, 1)
                    nameLabel.TextStrokeTransparency = 0.5
                    nameLabel.TextScaled = true

                    local circle = Instance.new("ImageLabel")
                    circle.Parent = billboard
                    circle.Size = UDim2.new(0, 50, 0, 50)
                    circle.Position = UDim2.new(0.5, 0, 0.5, 0)
                    circle.AnchorPoint = Vector2.new(0.5, 0.5)
                    circle.BackgroundTransparency = 1
                    circle.Image = "rbxassetid://2200552246"
                else
                    if player.Character then
                        local highlight = player.Character:FindFirstChildOfClass("Highlight")
                        local billboard = player.Character:FindFirstChildOfClass("BillboardGui")

                        if highlight then highlight:Destroy() end
                        if billboard then billboard:Destroy() end
                    end
                end
            end
        end
    end
})
UniversalLeftGroup:AddToggle('BoxESPToggle', {
    Text = '3D 方框 + 追踪线[无法关闭]',
    Default = false,
    Tooltip = '显示玩家3D方框与追踪线',

    Callback = function(Value)
        local Enabled = Value
        local Connections = {}

        local function NewLine(color)
            local line = Drawing.new("Line")
            line.Thickness = 1.4
            line.Color = color or Color3.fromRGB(0, 255, 50)
            line.Visible = false
            return line
        end

        if Enabled then
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer then
                    Connections[player] = {}

                    local lines = {}
                    for i = 1, 12 do
                        local line = NewLine()
                        table.insert(lines, line)
                        table.insert(Connections[player], line)
                    end

                    local tracer = NewLine()
                    table.insert(Connections[player], tracer)

                    local conn = game:GetService("RunService").RenderStepped:Connect(function()
                        if not Enabled or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
                            for _, line in pairs(lines) do line.Visible = false end
                            tracer.Visible = false
                            return
                        end

                        local char = player.Character
                        local hrp = char.HumanoidRootPart
                        local cam = workspace.CurrentCamera

                        local scale = char.Head.Size.Y / 2
                        local size = Vector3.new(2, 3, 1.5) * (scale * 2)

                        local function wp(cf)
                            local v, on = cam:WorldToViewportPoint(cf.p)
                            return Vector2.new(v.X, v.Y), on
                        end

                        local top1, v1 = wp(hrp.CFrame * CFrame.new(-size.X, size.Y, -size.Z))
                        local top2, v2 = wp(hrp.CFrame * CFrame.new(-size.X, size.Y, size.Z))
                        local top3, v3 = wp(hrp.CFrame * CFrame.new(size.X, size.Y, size.Z))
                        local top4, v4 = wp(hrp.CFrame * CFrame.new(size.X, size.Y, -size.Z))

                        local bot1, v5 = wp(hrp.CFrame * CFrame.new(-size.X, -size.Y, -size.Z))
                        local bot2, v6 = wp(hrp.CFrame * CFrame.new(-size.X, -size.Y, size.Z))
                        local bot3, v7 = wp(hrp.CFrame * CFrame.new(size.X, -size.Y, size.Z))
                        local bot4, v8 = wp(hrp.CFrame * CFrame.new(size.X, -size.Y, -size.Z))

                        local visible = v1 and v2 and v3 and v4 and v5 and v6 and v7 and v8

                        lines[1].From, lines[1].To = top1, top2
                        lines[2].From, lines[2].To = top2, top3
                        lines[3].From, lines[3].To = top3, top4
                        lines[4].From, lines[4].To = top4, top1

                        lines[5].From, lines[5].To = bot1, bot2
                        lines[6].From, lines[6].To = bot2, bot3
                        lines[7].From, lines[7].To = bot3, bot4
                        lines[8].From, lines[8].To = bot4, bot1

                        lines[9].From, lines[9].To = bot1, top1
                        lines[10].From, lines[10].To = bot2, top2
                        lines[11].From, lines[11].To = bot3, top3
                        lines[12].From, lines[12].To = bot4, top4

                        for _, line in pairs(lines) do
                            line.Visible = visible
                        end

                        if visible then
                            local tracePos = cam:WorldToViewportPoint((hrp.CFrame * CFrame.new(0, -size.Y, 0)).p)
                            tracer.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                            tracer.To = Vector2.new(tracePos.X, tracePos.Y)
                            tracer.Visible = true
                        else
                            tracer.Visible = false
                        end
                    end)

                    table.insert(Connections[player], conn)

                    player.CharacterAdded:Connect(function(char)
                        -- 重新绑定逻辑可在这里扩展
                    end)
                end
            end
        else
            for player, objects in pairs(Connections) do
                for _, obj in pairs(objects) do
                    if typeof(obj) == "RBXScriptConnection" then
                        obj:Disconnect()
                    else
                        obj:Remove()
                    end
                end
            end
            Connections = {}
        end
    end
})
UniversalLeftGroup:AddToggle('SkeletonESPToggle', {
    Text = '骨骼 ESP[无法关闭]',
    Default = false,
    Tooltip = '显示玩家骨架线条',

    Callback = function(Value)
        local Enabled = Value
        local Connections = {}

        local function NewLine(color)
            local line = Drawing.new("Line")
            line.Thickness = 2
            line.Color = color or Color3.fromRGB(0, 255, 0)
            line.Visible = false
            return line
        end

        if Enabled then
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer then
                    Connections[player] = {}

                    local lines = {
                        Head = NewLine(),
                        Torso = NewLine(),
                        LeftArm = NewLine(),
                        RightArm = NewLine(),
                        LeftLeg = NewLine(),
                        RightLeg = NewLine(),
                    }

                    for _, line in pairs(lines) do
                        table.insert(Connections[player], line)
                    end

                    local function Draw(character)
                        local conn = game:GetService("RunService").RenderStepped:Connect(function()
                            if not Enabled or not character or not character:FindFirstChild("HumanoidRootPart") then
                                for _, line in pairs(lines) do
                                    line.Visible = false
                                end
                                return
                            end

                            local hum = character:FindFirstChild("Humanoid")
                            if not hum or hum.Health <= 0 then
                                for _, line in pairs(lines) do
                                    line.Visible = false
                                end
                                return
                            end

                            local cam = workspace.CurrentCamera

                            local function wp(pos)
                                local v, on = cam:WorldToViewportPoint(pos)
                                return Vector2.new(v.X, v.Y), on
                            end

                            local head, torsoU, torsoL, larm, rarm, lleg, rleg

                            if hum.RigType == Enum.HumanoidRigType.R6 then
                                head = character.Head
                                torsoU = character.Torso
                                torsoL = torsoU
                                larm = character["Left Arm"]
                                rarm = character["Right Arm"]
                                lleg = character["Left Leg"]
                                rleg = character["Right Leg"]
                            else
                                head = character.Head
                                torsoU = character.UpperTorso
                                torsoL = character.LowerTorso
                                larm = character.LeftUpperArm
                                rarm = character.RightUpperArm
                                lleg = character.LeftUpperLeg
                                rleg = character.RightUpperLeg
                            end

                            if head and torsoU and torsoL and larm and rarm and lleg and rleg then
                                local h2d, hvis = wp(head.Position)
                                local tU2d, tUvis = wp(torsoU.Position + Vector3.new(0, 1.1, 0))
                                local tL2d, tLvis = wp(torsoL.Position + Vector3.new(0, -1.1, 0))
                                local la2d, lavis = wp(larm.Position + Vector3.new(0, -1.1, 0))
                                local ra2d, ravis = wp(rarm.Position + Vector3.new(0, -1.1, 0))
                                local ll2d, llvis = wp(lleg.Position + Vector3.new(0, -1.3, 0))
                                local rl2d, rlvis = wp(rleg.Position + Vector3.new(0, -1.3, 0))

                                local visible =
                                    hvis and tUvis and tLvis and lavis and ravis and llvis and rlvis

                                lines.Head.From, lines.Head.To = h2d, tU2d
                                lines.Torso.From, lines.Torso.To = tU2d, tL2d
                                lines.LeftArm.From, lines.LeftArm.To = tU2d, la2d
                                lines.RightArm.From, lines.RightArm.To = tU2d, ra2d
                                lines.LeftLeg.From, lines.LeftLeg.To = tL2d, ll2d
                                lines.RightLeg.From, lines.RightLeg.To = tL2d, rl2d

                                for _, line in pairs(lines) do
                                    line.Visible = visible
                                end
                            end
                        end)

                        table.insert(Connections[player], conn)
                    end

                    if player.Character then
                        Draw(player.Character)
                    end

                    player.CharacterAdded:Connect(function(char)
                        Draw(char)
                    end)
                end
            end
        else
            for player, objects in pairs(Connections) do
                for _, obj in pairs(objects) do
                    if typeof(obj) == "RBXScriptConnection" then
                        obj:Disconnect()
                    else
                        obj:Remove()
                    end
                end
            end
            Connections = {}
        end
    end
})
UniversalLeftGroup:AddToggle('FastInteractToggle', {
    Text = '快速交互',
    Default = false,
    Tooltip = '开启后所有 ProximityPrompt 无需长按',
    Callback = function(Value)
        if Value then
            game.ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
                prompt.HoldDuration = 0
            end)
        else
            game.ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
                prompt.HoldDuration = 3
            end)
        end

        print('[回调] 快速交互状态:', Value)
    end
})
UniversalLeftGroup:AddToggle("MotionBlurToggle", {
	Text = "动态模糊",
	Default = false,
	Callback = function(Value)
		if Value then
			local camera = workspace.CurrentCamera
			local blurAmount = 10
			local blurAmplifier = 5
			local lastVector = camera.CFrame.LookVector

			local motionBlur = Instance.new("BlurEffect")
			motionBlur.Size = 0
			motionBlur.Parent = camera

			local runService = game:GetService("RunService")

			workspace.Changed:Connect(function(property)
				if property == "CurrentCamera" then
					if motionBlur and motionBlur.Parent then
						motionBlur.Parent = workspace.CurrentCamera
					else
						motionBlur = Instance.new("BlurEffect", workspace.CurrentCamera)
					end
				end
			end)

			runService.Heartbeat:Connect(function()
				if not motionBlur or motionBlur.Parent == nil then
					motionBlur = Instance.new("BlurEffect", camera)
				end

				local magnitude = (camera.CFrame.LookVector - lastVector).Magnitude
				motionBlur.Size = math.abs(magnitude) * blurAmount * blurAmplifier / 2
				lastVector = camera.CFrame.LookVector
			end)
		else
			for _, v in pairs(workspace.CurrentCamera:GetDescendants()) do
				if v:IsA("BlurEffect") then
					v:Destroy()
				end
			end
		end
	end
})
UniversalLeftGroup:AddToggle("AntiVoidToggle", {
    Text = "防虚空掉落",
    Default = false,
    Callback = function(Value)
        if Value then
            if antivoidloop then antivoidloop:Disconnect() end
            local OrgDestroyHeight = Workspace.FallenPartsDestroyHeight
            antivoidloop = RunService.Stepped:Connect(function()
                local char = LocalPlayer.Character
                if char then
                    local root = getRoot(char)
                    if root and root.Position.Y <= OrgDestroyHeight + 25 then
                        root.Velocity = root.Velocity + Vector3.new(0, 250, 0)
                    end
                end
            end)
        else
            if antivoidloop then
                antivoidloop:Disconnect()
                antivoidloop = nil
            end
        end
    end
})
UniversalLeftGroup:AddToggle("AntiAfkToggle", {
    Text = "防止掉线（反挂机）",
    Default = false,
    Callback = function(Value)
        _G.AntiAfkEnabled = Value

        if Value then
            local vu = game:GetService("VirtualUser")
            _G.AntiAfkConnection = game:GetService("Players").LocalPlayer.Idled:Connect(function()
                vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                wait(1)
                vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
            print("Anti Afk On")
        else
            if _G.AntiAfkConnection then
                _G.AntiAfkConnection:Disconnect()
                _G.AntiAfkConnection = nil
            end
            print("Anti Afk Off")
        end
    end
});
UniversalLeftGroup:AddToggle("NightVisionToggle", {Text="夜视(可在墨水使用)",Default=false,Callback=function(Value)
        A28 = Value;
        if Value then
                A4.Ambient = Color3.new(1, 1, 1);
                A4.Brightness = 1;
                A4.OutdoorAmbient = Color3.new(1, 1, 1);
                A4.FogEnd = 100000;
                A4.FogStart = 0;
                A4.GlobalShadows = false;
        else
                A4.Ambient = Color3.new(0, 0, 0);
                A4.Brightness = 1;
                A4.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5);
                A4.FogEnd = 100000;
                A4.FogStart = 0;
                A4.GlobalShadows = true;
        end
end});
UniversalLeftGroup:AddToggle("BulletTrackingToggle", {Text="通用子弹追踪",Default=false,Callback=function(Enabled)
        if Enabled then
                if not bulletTrackingHook then
                        local Workspace = game:GetService("Workspace");
                        local Camera = Workspace.CurrentCamera;
                        local function getClosestHead()
                                if not A2.Character then
                                        return nil;
                                end
                                if not A2.Character:FindFirstChild("HumanoidRootPart") then
                                        return nil;
                                end
                                local closestHead = nil;
                                local closestDistance = math.huge;
                                for _, player in ipairs(A1:GetPlayers()) do
                                        if ((player ~= A2) and player.Character) then
                                                local character = player.Character;
                                                local root = character:FindFirstChild("HumanoidRootPart");
                                                local head = character:FindFirstChild("Head");
                                                local humanoid = character:FindFirstChildOfClass("Humanoid");
                                                local forcefield = character:FindFirstChild("ForceField");
                                                if (root and head and humanoid and not forcefield and (humanoid.Health > 0)) then
                                                        local distance = (root.Position - A2.Character.HumanoidRootPart.Position).Magnitude;
                                                        if (distance < closestDistance) then
                                                                closestHead = head;
                                                                closestDistance = distance;
                                                        end
                                                end
                                        end
                                end
                                return closestHead;
                        end
                        bulletTrackingHook = hookmetamethod(game, "__namecall", function(self, ...)
                                local method = getnamecallmethod();
                                local args = {...};
                                if ((method == "Raycast") and not checkcaller()) then
                                        local origin = args[1] or Camera.CFrame.Position;
                                        local closestHead = getClosestHead();
                                        if closestHead then
                                                return {Instance=closestHead,Position=closestHead.Position,Normal=(origin - closestHead.Position).Unit,Material=Enum.Material.Plastic,Distance=(closestHead.Position - origin).Magnitude};
                                        end
                                end
                                return bulletTrackingHook(self, ...);
                        end);
                end
        elseif bulletTrackingHook then
                hookmetamethod(game, "__namecall", bulletTrackingHook);
                bulletTrackingHook = nil;
        end
end});
local RotationControlGroup = Tabs.Universal:AddRightGroupbox("旋转控制");
RotationControlGroup:AddButton({Text="旋转 10",Func=function()
        if (A2 and A2.Character) then
                local HRP = A2.Character:FindFirstChild("HumanoidRootPart");
                if HRP then
                        if A17 then
                                A17:Destroy();
                        end
                        A17 = Instance.new("BodyAngularVelocity");
                        A17.Parent = HRP;
                        A17.Name = "CustomSpin";
                        A17.MaxTorque = Vector3.new(0, 400000, 0);
                        A17.AngularVelocity = Vector3.new(0, 10, 0);
                end
        end
end});
RotationControlGroup:AddButton({Text="旋转 20",Func=function()
        if (A2 and A2.Character) then
                local HRP = A2.Character:FindFirstChild("HumanoidRootPart");
                if HRP then
                        if A17 then
                                A17:Destroy();
                        end
                        A17 = Instance.new("BodyAngularVelocity");
                        A17.Parent = HRP;
                        A17.Name = "CustomSpin";
                        A17.MaxTorque = Vector3.new(0, 400000, 0);
                        A17.AngularVelocity = Vector3.new(0, 20, 0);
                end
        end
end});
RotationControlGroup:AddButton({Text="旋转 30",Func=function()
        if (A2 and A2.Character) then
                local HRP = A2.Character:FindFirstChild("HumanoidRootPart");
                if HRP then
                        if A17 then
                                A17:Destroy();
                        end
                        A17 = Instance.new("BodyAngularVelocity");
                        A17.Parent = HRP;
                        A17.Name = "CustomSpin";
                        A17.MaxTorque = Vector3.new(0, 400000, 0);
                        A17.AngularVelocity = Vector3.new(0, 30, 0);
                end
        end
end});
RotationControlGroup:AddButton({Text="旋转 50",Func=function()
        if (A2 and A2.Character) then
                local HRP = A2.Character:FindFirstChild("HumanoidRootPart");
                if HRP then
                        if A17 then
                                A17:Destroy();
                        end
                        A17 = Instance.new("BodyAngularVelocity");
                        A17.Parent = HRP;
                        A17.Name = "CustomSpin";
                        A17.MaxTorque = Vector3.new(0, 400000, 0);
                        A17.AngularVelocity = Vector3.new(0, 50, 0);
                end
        end
end});
RotationControlGroup:AddButton({Text="旋转 100",Func=function()
        if (A2 and A2.Character) then
                local HRP = A2.Character:FindFirstChild("HumanoidRootPart");
                if HRP then
                        if A17 then
                                A17:Destroy();
                        end
                        A17 = Instance.new("BodyAngularVelocity");
                        A17.Parent = HRP;
                        A17.Name = "CustomSpin";
                        A17.MaxTorque = Vector3.new(0, 400000, 0);
                        A17.AngularVelocity = Vector3.new(0, 100, 0);
                end
        end
end});
RotationControlGroup:AddButton({Text="旋转 200",Func=function()
        if (A2 and A2.Character) then
                local HRP = A2.Character:FindFirstChild("HumanoidRootPart");
                if HRP then
                        if A17 then
                                A17:Destroy();
                        end
                        A17 = Instance.new("BodyAngularVelocity");
                        A17.Parent = HRP;
                        A17.Name = "CustomSpin";
                        A17.MaxTorque = Vector3.new(0, 400000, 0);
                        A17.AngularVelocity = Vector3.new(0, 200, 0);
                end
        end
end});
RotationControlGroup:AddButton({Text="旋转 500",Func=function()
        if (A2 and A2.Character) then
                local HRP = A2.Character:FindFirstChild("HumanoidRootPart");
                if HRP then
                        if A17 then
                                A17:Destroy();
                        end
                        A17 = Instance.new("BodyAngularVelocity");
                        A17.Parent = HRP;
                        A17.Name = "CustomSpin";
                        A17.MaxTorque = Vector3.new(0, 400000, 0);
                        A17.AngularVelocity = Vector3.new(0, 500, 0);
                end
        end
end});
RotationControlGroup:AddButton({Text="停止旋转",Func=function()
        if A17 then
                A17:Destroy();
                A17 = nil;
        end
end});
UniversalLeftGroup:AddSlider("SpinSpeedSlider", {Text="旋转速度",Default=0,Min=0,Max=500,Rounding=0,Compact=false,Callback=function(Value)
        if (A2 and A2.Character) then
                local HRP = A2.Character:FindFirstChild("HumanoidRootPart");
                if HRP then
                        if (Value > 0) then
                                if A17 then
                                        A17:Destroy();
                                end
                                A17 = Instance.new("BodyAngularVelocity");
                                A17.Parent = HRP;
                                A17.Name = "CustomSpin";
                                A17.MaxTorque = Vector3.new(0, 400000, 0);
                                A17.AngularVelocity = Vector3.new(0, Value, 0);
                        elseif A17 then
                                A17:Destroy();
                                A17 = nil;
                        end
                end
        end
end});
UniversalLeftGroup:AddButton({Text="墨水飞行",Func=function()
        local FlyModule = {};
        FlyModule.Config = {MoveSpeed=10,FreezeEnabled=false,FreezeY=nil};
        FlyModule.State = {UI=nil,Connections={},Initialized=false};
        FlyModule.Init = function()
                if FlyModule.State.Initialized then
                        return;
                end
                FlyModule.Services = {Players=game:GetService("Players"),UserInputService=game:GetService("UserInputService"),RunService=game:GetService("RunService"),CoreGui=game:GetService("CoreGui")};
                FlyModule.Player = FlyModule.Services.Players.LocalPlayer;
                FlyModule.State.Initialized = true;
        end;
        FlyModule.CreateUI = function()
                if FlyModule.State.UI then
                        FlyModule.State.UI:Destroy();
                        FlyModule.State.UI = nil;
                end
                local ScreenGui = Instance.new("ScreenGui");
                ScreenGui.Name = "QC_FlyUI";
                ScreenGui.Parent = FlyModule.Services.CoreGui;
                ScreenGui.DisplayOrder = 2000;
                ScreenGui.ResetOnSpawn = false;
                local SpeedInput = Instance.new("TextBox");
                SpeedInput.Name = "SpeedInput";
                SpeedInput.Parent = ScreenGui;
                SpeedInput.Size = UDim2.new(0, 120, 0, 30);
                SpeedInput.Position = UDim2.new(0.95, -120, 0.05, 38);
                SpeedInput.Text = tostring(FlyModule.Config.MoveSpeed);
                SpeedInput.TextSize = 18;
                SpeedInput.PlaceholderText = "移动速度";
                SpeedInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                SpeedInput.BackgroundTransparency = 0.2;
                SpeedInput.TextColor3 = Color3.fromRGB(0, 0, 0);
                Instance.new("UICorner").Parent = SpeedInput;
                SpeedInput.FocusLost:Connect(function()
                        local num = tonumber(SpeedInput.Text);
                        if (num and (num > 0)) then
                                FlyModule.Config.MoveSpeed = num;
                        else
                                SpeedInput.Text = tostring(FlyModule.Config.MoveSpeed);
                        end
                end);
                local FreezeBtn = Instance.new("TextButton");
                FreezeBtn.Name = "FreezeBtn";
                FreezeBtn.Parent = ScreenGui;
                FreezeBtn.Size = UDim2.new(0, 120, 0, 38);
                FreezeBtn.Position = UDim2.new(0.95, -120, 0.05, 0);
                FreezeBtn.Text = "开启空中悬挂";
                FreezeBtn.TextSize = 20;
                FreezeBtn.BackgroundColor3 = Color3.fromRGB(210, 240, 255);
                FreezeBtn.BackgroundTransparency = 0.2;
                FreezeBtn.TextColor3 = Color3.fromRGB(0, 0, 0);
                Instance.new("UICorner").Parent = FreezeBtn;
                FreezeBtn.MouseButton1Click:Connect(function()
                        FlyModule.Config.FreezeEnabled = not FlyModule.Config.FreezeEnabled;
                        FreezeBtn.Text = (FlyModule.Config.FreezeEnabled and "悬挂√") or "开启空中悬挂";
                        FreezeBtn.BackgroundColor3 = (FlyModule.Config.FreezeEnabled and Color3.fromRGB(255, 200, 200)) or Color3.fromRGB(210, 240, 255);
                        if not FlyModule.Config.FreezeEnabled then
                                FlyModule.Config.FreezeY = nil;
                        end
                end);
                FlyModule.State.UI = ScreenGui;
                return ScreenGui;
        end;
        FlyModule.SetupCharacter = function(Character)
                FlyModule.Character = Character;
                FlyModule.Humanoid = Character:WaitForChild("Humanoid", 10);
                FlyModule.HRP = Character:WaitForChild("HumanoidRootPart", 10);
                FlyModule.Humanoid.Died:Connect(function()
                        FlyModule.Config.FreezeEnabled = false;
                        FlyModule.Config.FreezeY = nil;
                        if FlyModule.State.UI then
                                local FreezeBtn = FlyModule.State.UI:FindFirstChild("FreezeBtn");
                                if FreezeBtn then
                                        FreezeBtn.Text = "开启空中悬挂";
                                        FreezeBtn.BackgroundColor3 = Color3.fromRGB(210, 240, 255);
                                end
                        end
                end);
        end;
        FlyModule.SetupInfiniteJump = function()
                table.insert(FlyModule.State.Connections, FlyModule.Services.UserInputService.JumpRequest:Connect(function()
                        if (FlyModule.Humanoid and (FlyModule.Humanoid:GetState() ~= Enum.HumanoidStateType.Dead)) then
                                FlyModule.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
                        end
                end));
        end;
        FlyModule.SetupMainLoop = function()
                table.insert(FlyModule.State.Connections, FlyModule.Services.RunService.Heartbeat:Connect(function(dt)
                        if (FlyModule.Humanoid and FlyModule.HRP and (FlyModule.Humanoid:GetState() ~= Enum.HumanoidStateType.Dead)) then
                                local MoveDirection = FlyModule.Humanoid.MoveDirection;
                                if FlyModule.Config.FreezeEnabled then
                                        local State = FlyModule.Humanoid:GetState();
                                        if ((State == Enum.HumanoidStateType.Freefall) and (FlyModule.Humanoid:GetState() ~= Enum.HumanoidStateType.Jumping)) then
                                                if (MoveDirection.Magnitude > 0) then
                                                        if not FlyModule.Config.FreezeY then
                                                                FlyModule.Config.FreezeY = FlyModule.HRP.Position.Y;
                                                        end
                                                        local Move = Vector3.new(MoveDirection.X, 0, MoveDirection.Z) * FlyModule.Config.MoveSpeed * dt;
                                                        local CurrentPos = FlyModule.HRP.Position;
                                                        local NewPos = Vector3.new(CurrentPos.X, FlyModule.Config.FreezeY, CurrentPos.Z) + Move;
                                                        FlyModule.HRP.CFrame = CFrame.new(NewPos, NewPos + FlyModule.HRP.CFrame.LookVector);
                                                        FlyModule.HRP.Velocity = Vector3.new(0, 0, 0);
                                                else
                                                        FlyModule.Config.FreezeY = nil;
                                                end
                                                return;
                                        else
                                                FlyModule.Config.FreezeY = nil;
                                        end
                                end
                                if (MoveDirection.Magnitude > 0) then
                                        FlyModule.HRP.CFrame = FlyModule.HRP.CFrame + (MoveDirection.Unit * FlyModule.Config.MoveSpeed * dt);
                                end
                        end
                end));
        end;
        FlyModule.SetupCharacterListeners = function()
                if FlyModule.Player.Character then
                        FlyModule.SetupCharacter(FlyModule.Player.Character);
                end
                table.insert(FlyModule.State.Connections, FlyModule.Player.CharacterAdded:Connect(function(Character)
                        FlyModule.SetupCharacter(Character);
                end));
                table.insert(FlyModule.State.Connections, FlyModule.Player.CharacterRemoving:Connect(function()
                        FlyModule.Character = nil;
                        FlyModule.Humanoid = nil;
                        FlyModule.HRP = nil;
                        FlyModule.Config.FreezeEnabled = false;
                        FlyModule.Config.FreezeY = nil;
                end));
        end;
        FlyModule.Start = function()
                FlyModule.Init();
                FlyModule.CreateUI();
                FlyModule.SetupInfiniteJump();
                FlyModule.SetupMainLoop();
                FlyModule.SetupCharacterListeners();
        end;
        FlyModule.Start();
end});
UniversalLeftGroup:AddButton({Text="无限跳",Func=function()
        A20 = not A20;
        if A25 then
                A25:Disconnect();
                A25 = nil;
        end
        if A20 then
                A25 = A6.JumpRequest:Connect(function()
                        if A2.Character then
                                local Humanoid = A2.Character:FindFirstChildOfClass("Humanoid");
                                if Humanoid then
                                        Humanoid:ChangeState("Jumping");
                                end
                        end
                end);
        end
end});
UniversalLeftGroup:AddButton({Text="爬墙",Func=function()
        A18 = not A18;
        if A24 then
                A24:Disconnect();
                A24 = nil;
        end
        if A18 then
                A24 = A3.Heartbeat:Connect(function()
                        if A2.Character then
                                local Humanoid = A2.Character:FindFirstChildOfClass("Humanoid");
                                local HRP = A2.Character:FindFirstChild("HumanoidRootPart");
                                if (Humanoid and HRP) then
                                        local Ray = Ray.new(HRP.Position, HRP.CFrame.LookVector * 5);
                                        local Hit, Position = A8:FindPartOnRay(Ray, A2.Character);
                                        if Hit then
                                                Humanoid:ChangeState(Enum.HumanoidStateType.Climbing);
                                                HRP.CFrame = CFrame.new(Position) * CFrame.new(0, 3, 0);
                                        end
                                end
                        end
                end);
        end
end});
UniversalLeftGroup:AddButton({Text="飞行",Func=function()
        A21 = not A21;
        if A21 then
                local ScreenGui = Instance.new("ScreenGui");
                local Frame = Instance.new("Frame");
                local UpBtn = Instance.new("TextButton");
                local DownBtn = Instance.new("TextButton");
                local ToggleBtn = Instance.new("TextButton");
                local TitleLabel = Instance.new("TextLabel");
                local PlusBtn = Instance.new("TextButton");
                local SpeedLabel = Instance.new("TextLabel");
                local MinusBtn = Instance.new("TextButton");
                local CloseBtn = Instance.new("TextButton");
                local MinimizeBtn = Instance.new("TextButton");
                local MaximizeBtn = Instance.new("TextButton");
                ScreenGui.Name = "main";
                ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui");
                ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
                ScreenGui.ResetOnSpawn = false;
                Frame.Parent = ScreenGui;
                Frame.BackgroundColor3 = Color3.fromRGB(163, 255, 137);
                Frame.BorderColor3 = Color3.fromRGB(103, 221, 213);
                Frame.Position = UDim2.new(0.100320168, 0, 0.379746825, 0);
                Frame.Size = UDim2.new(0, 190, 0, 57);
                Frame.Active = true;
                Frame.Draggable = true;
                UpBtn.Name = "up";
                UpBtn.Parent = Frame;
                UpBtn.BackgroundColor3 = Color3.fromRGB(79, 255, 152);
                UpBtn.Size = UDim2.new(0, 44, 0, 28);
                UpBtn.Font = Enum.Font.SourceSans;
                UpBtn.Text = "上升";
                UpBtn.TextColor3 = Color3.fromRGB(0, 0, 0);
                UpBtn.TextSize = 14;
                DownBtn.Name = "down";
                DownBtn.Parent = Frame;
                DownBtn.BackgroundColor3 = Color3.fromRGB(215, 255, 121);
                DownBtn.Position = UDim2.new(0, 0, 0.491228074, 0);
                DownBtn.Size = UDim2.new(0, 44, 0, 28);
                DownBtn.Font = Enum.Font.SourceSans;
                DownBtn.Text = "下降";
                DownBtn.TextColor3 = Color3.fromRGB(0, 0, 0);
                DownBtn.TextSize = 14;
                ToggleBtn.Name = "onof";
                ToggleBtn.Parent = Frame;
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 249, 74);
                ToggleBtn.Position = UDim2.new(0.702823281, 0, 0.491228074, 0);
                ToggleBtn.Size = UDim2.new(0, 56, 0, 28);
                ToggleBtn.Font = Enum.Font.SourceSans;
                ToggleBtn.Text = "起飞";
                ToggleBtn.TextColor3 = Color3.fromRGB(0, 0, 0);
                ToggleBtn.TextSize = 14;
                TitleLabel.Parent = Frame;
                TitleLabel.BackgroundColor3 = Color3.fromRGB(242, 60, 255);
                TitleLabel.Position = UDim2.new(0.469327301, 0, 0, 0);
                TitleLabel.Size = UDim2.new(0, 100, 0, 28);
                TitleLabel.Font = Enum.Font.SourceSans;
                TitleLabel.Text = " 秋辞飞行";
                TitleLabel.TextColor3 = Color3.fromRGB(0, 0, 0);
                TitleLabel.TextScaled = true;
                TitleLabel.TextSize = 14;
                TitleLabel.TextWrapped = true;
                PlusBtn.Name = "plus";
                PlusBtn.Parent = Frame;
                PlusBtn.BackgroundColor3 = Color3.fromRGB(133, 145, 255);
                PlusBtn.Position = UDim2.new(0.231578946, 0, 0, 0);
                PlusBtn.Size = UDim2.new(0, 45, 0, 28);
                PlusBtn.Font = Enum.Font.SourceSans;
                PlusBtn.Text = "+";
                PlusBtn.TextColor3 = Color3.fromRGB(0, 0, 0);
                PlusBtn.TextScaled = true;
                PlusBtn.TextSize = 14;
                PlusBtn.TextWrapped = true;
                SpeedLabel.Name = "speed";
                SpeedLabel.Parent = Frame;
                SpeedLabel.BackgroundColor3 = Color3.fromRGB(255, 85, 0);
                SpeedLabel.Position = UDim2.new(0.468421042, 0, 0.491228074, 0);
                SpeedLabel.Size = UDim2.new(0, 44, 0, 28);
                SpeedLabel.Font = Enum.Font.SourceSans;
                SpeedLabel.Text = "1";
                SpeedLabel.TextColor3 = Color3.fromRGB(0, 0, 0);
                SpeedLabel.TextScaled = true;
                SpeedLabel.TextSize = 14;
                SpeedLabel.TextWrapped = true;
                MinusBtn.Name = "mine";
                MinusBtn.Parent = Frame;
                MinusBtn.BackgroundColor3 = Color3.fromRGB(123, 255, 247);
                MinusBtn.Position = UDim2.new(0.231578946, 0, 0.491228074, 0);
                MinusBtn.Size = UDim2.new(0, 45, 0, 29);
                MinusBtn.Font = Enum.Font.SourceSans;
                MinusBtn.Text = "-";
                MinusBtn.TextColor3 = Color3.fromRGB(0, 0, 0);
                MinusBtn.TextScaled = true;
                MinusBtn.TextSize = 14;
                MinusBtn.TextWrapped = true;
                CloseBtn.Name = "Close";
                CloseBtn.Parent = ScreenGui.Frame;
                CloseBtn.BackgroundColor3 = Color3.fromRGB(225, 25, 0);
                CloseBtn.Font = "SourceSans";
                CloseBtn.Size = UDim2.new(0, 45, 0, 28);
                CloseBtn.Text = "X";
                CloseBtn.TextSize = 30;
                CloseBtn.Position = UDim2.new(0, 0, -1, 27);
                MinimizeBtn.Name = "minimize";
                MinimizeBtn.Parent = ScreenGui.Frame;
                MinimizeBtn.BackgroundColor3 = Color3.fromRGB(192, 150, 230);
                MinimizeBtn.Font = "SourceSans";
                MinimizeBtn.Size = UDim2.new(0, 45, 0, 28);
                MinimizeBtn.Text = "-";
                MinimizeBtn.TextSize = 40;
                MinimizeBtn.Position = UDim2.new(0, 44, -1, 27);
                MaximizeBtn.Name = "minimize2";
                MaximizeBtn.Parent = ScreenGui.Frame;
                MaximizeBtn.BackgroundColor3 = Color3.fromRGB(192, 150, 230);
                MaximizeBtn.Font = "SourceSans";
                MaximizeBtn.Size = UDim2.new(0, 45, 0, 28);
                MaximizeBtn.Text = "+";
                MaximizeBtn.TextSize = 40;
                MaximizeBtn.Position = UDim2.new(0, 44, -1, 57);
                MaximizeBtn.Visible = false;
                local speeds = 1;
                local LocalPlayer = game:GetService("Players").LocalPlayer;
                local Character = game.Players.LocalPlayer.Character;
                local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid");
                local nowe = false;
                ToggleBtn.MouseButton1Down:connect(function()
                        if (nowe == true) then
                                nowe = false;
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, true);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, true);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, true);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, true);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, true);
                                LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics);
                        else
                                nowe = true;
                                for i = 1, speeds do
                                        spawn(function()
                                                local Heartbeat = game:GetService("RunService").Heartbeat;
                                                local tpwalking = true;
                                                local Char = game.Players.LocalPlayer.Character;
                                                local Hum = Char and Char:FindFirstChildWhichIsA("Humanoid");
                                                while tpwalking and Heartbeat:Wait() and Char and Hum and Hum.Parent do
                                                        if (Hum.MoveDirection.Magnitude > 0) then
                                                                Char:TranslateBy(Hum.MoveDirection);
                                                        end
                                                end
                                        end);
                                end
                                game.Players.LocalPlayer.Character.Animate.Disabled = true;
                                local Char = game.Players.LocalPlayer.Character;
                                local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController");
                                for i, v in next, Hum:GetPlayingAnimationTracks() do
                                        v:AdjustSpeed(0);
                                end
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, false);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, false);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, false);
                                LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false);
                                LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming);
                        end
                        if (game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6) then
                                local Player = game.Players.LocalPlayer;
                                local Torso = Player.Character.Torso;
                                local keys = {f=0,b=0,l=0,r=0};
                                local previous = {f=0,b=0,l=0,r=0};
                                local maxSpeed = 50;
                                local speed = 0;
                                local gyro = Instance.new("BodyGyro", Torso);
                                gyro.P = 90000;
                                gyro.maxTorque = Vector3.new(8999999488, 8999999488, 8999999488);
                                gyro.cframe = Torso.CFrame;
                                local velocity = Instance.new("BodyVelocity", Torso);
                                velocity.velocity = Vector3.new(0, 0.1, 0);
                                velocity.maxForce = Vector3.new(8999999488, 8999999488, 8999999488);
                                if (nowe == true) then
                                        Player.Character.Humanoid.PlatformStand = true;
                                end
                                while (nowe == true) or (game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0) do
                                        game:GetService("RunService").RenderStepped:Wait();
                                        if (((keys.l + keys.r) ~= 0) or ((keys.f + keys.b) ~= 0)) then
                                                speed = speed + 0.5 + (speed / maxSpeed);
                                                if (speed > maxSpeed) then
                                                        speed = maxSpeed;
                                                end
                                        elseif (not (((keys.l + keys.r) ~= 0) or ((keys.f + keys.b) ~= 0)) and (speed ~= 0)) then
                                                speed = speed - 1;
                                                if (speed < 0) then
                                                        speed = 0;
                                                end
                                        end
                                        if (((keys.l + keys.r) ~= 0) or ((keys.f + keys.b) ~= 0)) then
                                                velocity.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (keys.f + keys.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(keys.l + keys.r, (keys.f + keys.b) * 0.2, 0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * speed;
                                                previous = {f=keys.f,b=keys.b,l=keys.l,r=keys.r};
                                        elseif (((keys.l + keys.r) == 0) and ((keys.f + keys.b) == 0) and (speed ~= 0)) then
                                                velocity.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (previous.f + previous.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(previous.l + previous.r, (previous.f + previous.b) * 0.2, 0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * speed;
                                        else
                                                velocity.velocity = Vector3.new(0, 0, 0);
                                        end
                                        gyro.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad(((keys.f + keys.b) * 50 * speed) / maxSpeed), 0, 0);
                                end
                                keys = {f=0,b=0,l=0,r=0};
                                previous = {f=0,b=0,l=0,r=0};
                                speed = 0;
                                gyro:Destroy();
                                velocity:Destroy();
                                Player.Character.Humanoid.PlatformStand = false;
                                game.Players.LocalPlayer.Character.Animate.Disabled = false;
                        else
                                local Player = game.Players.LocalPlayer;
                                local UpperTorso = Player.Character.UpperTorso;
                                local keys = {f=0,b=0,l=0,r=0};
                                local previous = {f=0,b=0,l=0,r=0};
                                local maxSpeed = 50;
                                local speed = 0;
                                local gyro = Instance.new("BodyGyro", UpperTorso);
                                gyro.P = 90000;
                                gyro.maxTorque = Vector3.new(8999999488, 8999999488, 8999999488);
                                gyro.cframe = UpperTorso.CFrame;
                                local velocity = Instance.new("BodyVelocity", UpperTorso);
                                velocity.velocity = Vector3.new(0, 0.1, 0);
                                velocity.maxForce = Vector3.new(8999999488, 8999999488, 8999999488);
                                if (nowe == true) then
                                        Player.Character.Humanoid.PlatformStand = true;
                                end
                                while (nowe == true) or (game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0) do
                                        wait();
                                        if (((keys.l + keys.r) ~= 0) or ((keys.f + keys.b) ~= 0)) then
                                                speed = speed + 0.5 + (speed / maxSpeed);
                                                if (speed > maxSpeed) then
                                                        speed = maxSpeed;
                                                end
                                        elseif (not (((keys.l + keys.r) ~= 0) or ((keys.f + keys.b) ~= 0)) and (speed ~= 0)) then
                                                speed = speed - 1;
                                                if (speed < 0) then
                                                        speed = 0;
                                                end
                                        end
                                        if (((keys.l + keys.r) ~= 0) or ((keys.f + keys.b) ~= 0)) then
                                                velocity.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (keys.f + keys.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(keys.l + keys.r, (keys.f + keys.b) * 0.2, 0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * speed;
                                                previous = {f=keys.f,b=keys.b,l=keys.l,r=keys.r};
                                        elseif (((keys.l + keys.r) == 0) and ((keys.f + keys.b) == 0) and (speed ~= 0)) then
                                                velocity.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (previous.f + previous.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(previous.l + previous.r, (previous.f + previous.b) * 0.2, 0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * speed;
                                        else
                                                velocity.velocity = Vector3.new(0, 0, 0);
                                        end
                                        gyro.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad(((keys.f + keys.b) * 50 * speed) / maxSpeed), 0, 0);
                                end
                                keys = {f=0,b=0,l=0,r=0};
                                previous = {f=0,b=0,l=0,r=0};
                                speed = 0;
                                gyro:Destroy();
                                velocity:Destroy();
                                Player.Character.Humanoid.PlatformStand = false;
                                game.Players.LocalPlayer.Character.Animate.Disabled = false;
                        end
                end);
                local upConnection;
                UpBtn.MouseButton1Down:connect(function()
                        upConnection = UpBtn.MouseEnter:connect(function()
                                while upConnection do
                                        wait();
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 0);
                                end
                        end);
                end);
                UpBtn.MouseLeave:connect(function()
                        if upConnection then
                                upConnection:Disconnect();
                                upConnection = nil;
                        end
                end);
                local downConnection;
                DownBtn.MouseButton1Down:connect(function()
                        downConnection = DownBtn.MouseEnter:connect(function()
                                while downConnection do
                                        wait();
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -1, 0);
                                end
                        end);
                end);
                DownBtn.MouseLeave:connect(function()
                        if downConnection then
                                downConnection:Disconnect();
                                downConnection = nil;
                        end
                end);
                game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(Character)
                        wait(0.7);
                        game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false;
                        game.Players.LocalPlayer.Character.Animate.Disabled = false;
                end);
                PlusBtn.MouseButton1Down:connect(function()
                        speeds = speeds + 1;
                        SpeedLabel.Text = speeds;
                        if (nowe == true) then
                                for i = 1, speeds do
                                        spawn(function()
                                                local Heartbeat = game:GetService("RunService").Heartbeat;
                                                local tpwalking = true;
                                                local Char = game.Players.LocalPlayer.Character;
                                                local Hum = Char and Char:FindFirstChildWhichIsA("Humanoid");
                                                while tpwalking and Heartbeat:Wait() and Char and Hum and Hum.Parent do
                                                        if (Hum.MoveDirection.Magnitude > 0) then
                                                                Char:TranslateBy(Hum.MoveDirection);
                                                        end
                                                end
                                        end);
                                end
                        end
                end);
                MinusBtn.MouseButton1Down:connect(function()
                        if (speeds == 1) then
                                SpeedLabel.Text = "cannot be less than 1";
                                wait(1);
                                SpeedLabel.Text = speeds;
                        else
                                speeds = speeds - 1;
                                SpeedLabel.Text = speeds;
                                if (nowe == true) then
                                        for i = 1, speeds do
                                                spawn(function()
                                                        local Heartbeat = game:GetService("RunService").Heartbeat;
                                                        local tpwalking = true;
                                                        local Char = game.Players.LocalPlayer.Character;
                                                        local Hum = Char and Char:FindFirstChildWhichIsA("Humanoid");
                                                        while tpwalking and Heartbeat:Wait() and Char and Hum and Hum.Parent do
                                                                if (Hum.MoveDirection.Magnitude > 0) then
                                                                        Char:TranslateBy(Hum.MoveDirection);
                                                                end
                                                        end
                                                end);
                                        end
                                end
                        end
                end);
                CloseBtn.MouseButton1Click:Connect(function()
                        ScreenGui:Destroy();
                        A21 = false;
                end);
                MinimizeBtn.MouseButton1Click:Connect(function()
                        UpBtn.Visible = false;
                        DownBtn.Visible = false;
                        ToggleBtn.Visible = false;
                        PlusBtn.Visible = false;
                        SpeedLabel.Visible = false;
                        MinusBtn.Visible = false;
                        MinimizeBtn.Visible = false;
                        MaximizeBtn.Visible = true;
                        ScreenGui.Frame.BackgroundTransparency = 1;
                        CloseBtn.Position = UDim2.new(0, 0, -1, 57);
                end);
                MaximizeBtn.MouseButton1Click:Connect(function()
                        UpBtn.Visible = true;
                        DownBtn.Visible = true;
                        ToggleBtn.Visible = true;
                        PlusBtn.Visible = true;
                        SpeedLabel.Visible = true;
                        MinusBtn.Visible = true;
                        MinimizeBtn.Visible = true;
                        MaximizeBtn.Visible = false;
                        ScreenGui.Frame.BackgroundTransparency = 0;
                        CloseBtn.Position = UDim2.new(0, 0, -1, 27);
                end);
        end
end});
UniversalLeftGroup:AddButton({Text="重新加载角色",Func=function()
        if A2.Character then
                A2.Character:BreakJoints();
        end
end});
UniversalLeftGroup:AddButton({Text="通用甩飞[不能在墨水使用，秒封]",Func=function()
        local ScriptContent = game:HttpGet("https://pastebin.com/raw/zqyDSUWX");
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
UniversalLeftGroup:AddButton({
    Text = "无敌",
    Func = function()
        local lp = game:GetService("Players").LocalPlayer
        if lp.Character:FindFirstChild("Head") then
            local char = lp.Character
            char.Archivable = true
            local new = char:Clone()
            new.Parent = workspace
            lp.Character = new
            wait(2)
            local oldhum = char:FindFirstChildWhichIsA("Humanoid")
            local newhum = oldhum:Clone()
            newhum.Parent = char
            newhum.RequiresNeck = false
            oldhum.Parent = nil
            wait(2)
            lp.Character = char
            new:Destroy()
            wait(1)
            newhum:GetPropertyChangedSignal("Health"):Connect(
                function()
                    if newhum.Health <= 0 then
                        oldhum.Parent = lp.Character
                        wait(1)
                        oldhum:Destroy()
                    end
                end
            )
            workspace.CurrentCamera.CameraSubject = char
            if char:FindFirstChild("Animate") then
                char.Animate.Disabled = true
                wait(.1)
                char.Animate.Disabled = false
            end
            lp.Character:FindFirstChild("Head"):Destroy()
        end
    end
})
UniversalLeftGroup:AddButton({Text="取消坠落伤害",Func=function()
        if A2.Character then
                local HRP = A2.Character:FindFirstChild("HumanoidRootPart");
                if HRP then
                        local ScriptContent = game:HttpGet("http://rawscripts.net/raw/Universal-Script-Touch-fling-script-22447");
                        local Func = loadstring(ScriptContent);
                        if Func then
                                Func();
                        end
                end
        end
end});
UniversalLeftGroup:AddButton({Text="走路创人",Func=function()
        if A2.Character then
                local HRP = A2.Character:FindFirstChild("HumanoidRootPart");
                if HRP then
                        local ScriptContent = game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe./main/Fling%20GUI");
                        local Func = loadstring(ScriptContent);
                        if Func then
                                Func();
                        end
                end
        end
end});
UniversalLeftGroup:AddButton({Text="穿墙模式",Func=function()
        A19 = not A19;
        if A22 then
                A22:Disconnect();
                A22 = nil;
        end
        if A19 then
                A22 = A3.Stepped:Connect(function()
                        if A2.Character then
                                for _, Part in pairs(A2.Character:GetDescendants()) do
                                        if Part:IsA("BasePart") then
                                                Part.CanCollide = false;
                                        end
                                end
                        end
                end);
        end
end});
UniversalLeftGroup:AddButton({Text="刷新游戏",Func=function()
        A7:Teleport(game.PlaceId, A2);
end});
UniversalRightGroup:AddLabel("复制区");

UniversalRightGroup:AddButton({Text="点击复制墨水脚本天使之翼卡密",Func=function()
        setclipboard("8J2X1A2-Skan");
end});
UniversalRightGroup:AddLabel("光影");
UniversalRightGroup:AddButton({Text="光影",Func=function()
        loadstring(game:HttpGet("https://pastebin.com/raw/arzRCgwS"))()
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
UniversalRightGroup:AddLabel("TX全自动翻译");
UniversalRightGroup:AddButton({Text="TX全自动翻译",Func=function()
        TX = "TX Script"
Script = "全自动翻译"
loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/Item/refs/heads/main/Auto-language"))()
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
UniversalRightGroup:AddButton({Text="TX死铁轨全自动刷债券",Func=function()
        TX = "TX Script"
Script = "TX自动刷债券V4"
loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/Item/refs/heads/main/Auto-Bond-V4"))()
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
UniversalRightGroup:AddButton({Text="SX翻译",Func=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SQ182/y/refs/heads/main/翻译.lua"))()
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
UniversalRightGroup:AddLabel("音乐播放器");
UniversalRightGroup:AddButton({Text="音乐播放器脚本",Func=function()
        loadstring(game:HttpGet("http://music.567099.xyz/music.php"))()
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
UniversalRightGroup:AddButton({Text="秋辞音乐播放器(正在开发)",Func=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fningna51-stack/-/main/%E7%A7%8B%E8%BE%9E%E7%BA%AF%E6%9C%8D%E5%8A%A1%E5%99%A8%E8%84%9A%E6%9C%AC"))()
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
local UniversalPIAY = Tabs.Universal:AddLeftGroupbox("选择玩家传送功能")

local selectedPlayer = nil

UniversalPIAY:AddDropdown('PlayerList', {
    SpecialType = 'Player',
    Text = '玩家列表',
    Tooltip = '自动获取当前服务器玩家',
    Callback = function(Value)
        selectedPlayer = Value
        if Value then
            print('[回调] 选中玩家:', Value.Name)
        else
            print('[回调] 未选中任何玩家')
        end
    end
})

UniversalPIAY:AddButton({
    Text = "选择玩家传送",
    Func = function()
        if not selectedPlayer then
            Library:Notify("请先在下拉列表中选择一个玩家！", 3)
            return
        end

        local Players = game:GetService("Players")
        local localPlayer = Players.LocalPlayer

        if not selectedPlayer.Parent then
            Library:Notify("目标玩家已退出游戏！", 3)
            selectedPlayer = nil
            return
        end

        if selectedPlayer == localPlayer then
            Library:Notify("不能传送到自己！", 3)
            return
        end

        local targetChar = selectedPlayer.Character
        if not targetChar or not targetChar.Parent then
            Library:Notify("目标玩家尚未加载角色！", 3)
            return
        end

        local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
        if not targetHRP then
            targetHRP = targetChar:WaitForChild("HumanoidRootPart", 2)
            if not targetHRP then
                Library:Notify("无法获取目标玩家位置！", 3)
                return
            end
        end

        local myChar = localPlayer.Character
        if not myChar or not myChar.Parent then
            local charAdded = localPlayer.CharacterAdded:Wait(3)
            if not charAdded then
                Library:Notify("等待角色加载超时！", 3)
                return
            end
            myChar = charAdded
        end
        
        local myHRP = myChar:FindFirstChild("HumanoidRootPart")
        if not myHRP then
            myHRP = myChar:WaitForChild("HumanoidRootPart", 2)
            if not myHRP then
                Library:Notify("无法获取你的位置！", 3)
                return
            end
        end

        local offset = Vector3.new(0, 0, 3)
        myHRP.CFrame = targetHRP.CFrame + targetHRP.CFrame:VectorToWorldSpace(offset)
        
        Library:Notify("已传送到玩家：" .. selectedPlayer.Name, 3)
    end,
    DoubleClick = false
})
----------
local AGA = Tabs.B:AddLeftGroupbox("脚本中心1")
local A22 = Tabs.B:AddRightGroupbox("脚本中心2")



Tabs.B:UpdateWarningBox({
        Title = '脚本信息及<font color=\"rgb(255, 0, 0)\">警告!</font>',
        Text = '可能有些没有完全汉化，\n在一些反作弊系统强的服务器建议执行后立即删除脚本UI',
        IsNormal = true,
        Visible = true,
        LockSize = true,
    })
AGA:AddLabel("--------各大脚本--------")
AGA:AddButton({
    Text = "XK脚本",
    Func = function()
    loadstring(game:HttpGet(('https://github.com/devslopo/DVES/raw/main/XK%20Hub')))()
    end
})
AGA:AddButton({
    Text = "皮脚本",
    Func = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
    end
})
AGA:AddButton({
    Text = "Rb脚本中心",
    Func = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Yungengxin/roblox/refs/heads/main/Rb-Hub"))()
    end
})
AGA:AddButton({
    Text = "Sky Hub",
    Func = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/Skyhub.lua"))()
    end
})
AGA:AddButton({
    Text = "BS黑洞中心",
    Func = function()
    loadstring(game:HttpGet("https://gitee.com/BS_script/script/raw/master/BS_Script.Luau"))()
    end
})
AGA:AddButton({
    Text = "Rb汉化中心",
    Func = function()
    loadstring(game:HttpGet("https://gitee.com/BS_script/script/raw/master/BS_Script.Luau"))()
    end
})
AGA:AddButton({
    Text = "AF Hub",
    Func = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/fningna51-stack/-/main/%E7%A7%8B%E8%BE%9E%E7%BC%9D%E5%90%88%E8%84%9A%E6%9C%AC%E6%9C%80%E6%96%B0%E7%89%88%E6%96%B0ui"))()
    end
})
AGA:AddButton({
    Text = "霖溺脚本",
    Func = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ShenJiaoBen/ScriptLoader/refs/heads/main/Linni_FreeLoader.lua"))()
    end
})
AGA:AddButton({
    Text = "Msploit汉化脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/Msploit"))()
    end
})
AGA:AddButton("Msploit里面内置通用脚本")

AGA:AddButton({
    Text = "通用汉化脚本",
    Func = function()
   loadstring(game:HttpGet(" https://raw.githubusercontent.com/fningna51-stack/-/main/%E7%9B%91%E7%8B%B1%E7%94%9F%E6%B4%BB%E8%84%9A%E6%9C%AC"))()
    end
})

AGA:AddButton({
    Text = "mobileaimbot汉化脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/%E9%80%9A%E7%94%A8%E8%84%9A%E6%9C%ACmobileaimbot"))()
    end
})
AGA:AddLabel("------FE--------")
AGA:AddButton({
    Text = "MozCraft放方块汉化脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/asdfgh160/Chinese-localization/refs/heads/main/MozCraft"))()
    end
})
AGA:AddButton({
    Text = "摇尾巴动作脚本",
    Func = function()
   loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-physics-based-tail-animator-86591"))()
    end
})
AGA:AddLabel("这边推荐带有尾巴的饰品虚拟形象的人使用")

AGA:AddButton({
    Text = "免费动作脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/sypcerr/scripts/refs/heads/main/c15.lua",true))()
    end
})
AGA:AddButton({
    Text = "valout动作脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/valout%E8%A1%A8%E6%83%85"))()
    end
})
AGA:AddButton({Text="柳叶碰飞(墨水可以使用)",Func=function()
        local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

local Enabled = false
local targetPlayer = nil
local originalCFrame = nil

local function findPlayer(text)
    text = text:lower()
    for _, plr in pairs(Players:GetPlayers()) do
        if string.find(plr.Name:lower(), text) or string.find(plr.DisplayName:lower(), text) then
            return plr
        end
    end
end

lp.Chatted:Connect(function(msg)
    if not Enabled then return end
    if msg:sub(1,6):lower() == ";kill " then
        local name = msg:sub(7)
        local plr = findPlayer(name)
        if plr and plr.Character and plr.Character:FindFirstChild("Humanoid") then
            targetPlayer = plr
            if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                originalCFrame = lp.Character.HumanoidRootPart.CFrame
            end
            if statusLabel then
                statusLabel.Text = "已锁定 " .. plr.Name
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.01) do
        if not Enabled then continue end
        if not targetPlayer then continue end

        local char = targetPlayer.Character
        if not char or not char:FindFirstChild("Humanoid") then
            targetPlayer = nil
            if statusLabel then statusLabel.Text = "开启 (未锁定)" end
            continue
        end

        local hum = char.Humanoid
        if hum.Health <= 0 then
            targetPlayer = nil
            if statusLabel then statusLabel.Text = "开启 (未锁定)" end
            continue
        end

        local myChar = lp.Character
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local targetHRP = char:FindFirstChild("HumanoidRootPart")

        if myHRP and targetHRP then
            local offset = targetHRP.Velocity.Magnitude < 0.1 and 0 or 7
            local goal = targetHRP.CFrame * CFrame.new(0,0,-offset) * CFrame.Angles(0, math.rad(-3), 0)
            myHRP.CFrame = myHRP.CFrame:Lerp(goal, 0.4)
            myHRP.Velocity = Vector3.new(0,0,0)
            myHRP.RotVelocity = Vector3.new(0,0,0)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if not Enabled then continue end
        local hum = lp.Character and lp.Character:FindFirstChild("Humanoid")
        if hum then
            hum:Move(Vector3.one * 1e31)
        end
    end
end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlyOffGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = lp:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 130)
mainFrame.Position = UDim2.new(0.5, -110, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BackgroundTransparency = 0.25
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 1
stroke.Transparency = 0.8
stroke.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 28)
title.BackgroundTransparency = 1
title.Text = "碰飞(碰到人就让对面甩飞)"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 160, 0, 32)
toggleBtn.Position = UDim2.new(0.5, -80, 0, 38)
toggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
toggleBtn.Text = "开启碰飞"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.GothamSemibold
toggleBtn.TextSize = 12
toggleBtn.Parent = mainFrame
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = toggleBtn

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 0, 78)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "状态: 关闭"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextSize = 11
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = mainFrame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 80, 0, 24)
closeBtn.Position = UDim2.new(0.5, -40, 0, 102)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Text = "关闭甩飞脚本(关了需要重新加载)"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamSemibold
closeBtn.TextSize = 10
closeBtn.Parent = mainFrame
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

toggleBtn.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    if Enabled then
        toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        toggleBtn.Text = "关闭碰飞"
        statusLabel.Text = "开启"
        targetPlayer = nil
    else
        toggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        toggleBtn.Text = "开启碰飞"
        statusLabel.Text = "状态: 关闭"
        targetPlayer = nil
        originalCFrame = nil
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    Enabled = false
    targetPlayer = nil
    originalCFrame = nil
    screenGui:Destroy()
end)

Enabled = false
targetPlayer = nil

print("😝😝😝")
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
AGA:AddButton({Text="有福同享超飞",Func=function()
        local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

local FLING_OFFSET = 0
local LERP_ALPHA = 1
local VELOCITY_BOOST = 200

local flingEnabled = false
local manualEnabled = false
local autoCycleActive = false
local previousFlingEnabled = false
local targetPlayer = nil
local originalCFrame = nil

local function findPlayer(text)
    text = text:lower()
    for _, plr in pairs(Players:GetPlayers()) do
        if string.find(plr.Name:lower(), text) or string.find(plr.DisplayName:lower(), text) then
            return plr
        end
    end
end

lp.Chatted:Connect(function(msg)
    if not manualEnabled then return end
    if msg:sub(1,6):lower() == ";kill " then
        local name = msg:sub(7)
        local plr = findPlayer(name)
        if plr and plr.Character and plr.Character:FindFirstChild("Humanoid") then
            targetPlayer = plr
            if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                originalCFrame = lp.Character.HumanoidRootPart.CFrame
            end
            if statusLabel then
                statusLabel.Text = "已锁定 " .. plr.Name
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.01) do
        if not flingEnabled then continue end
        if not targetPlayer then continue end

        local char = targetPlayer.Character
        if not char or not char:FindFirstChild("Humanoid") then
            targetPlayer = nil
            if statusLabel then statusLabel.Text = "开启 (未锁定)" end
            continue
        end

        local hum = char.Humanoid
        if hum.Health <= 0 then
            targetPlayer = nil
            if statusLabel then statusLabel.Text = "开启" end
            continue
        end

        local myChar = lp.Character
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local targetHRP = char:FindFirstChild("HumanoidRootPart")

        if myHRP and targetHRP then
            local offset = FLING_OFFSET
            local goal = targetHRP.CFrame * CFrame.new(0,0,-offset) * CFrame.Angles(0, math.rad(-3), 0)

            if LERP_ALPHA >= 1 then
                myHRP.CFrame = goal
            else
                myHRP.CFrame = myHRP.CFrame:Lerp(goal, LERP_ALPHA)
            end

            local dist = (targetHRP.Position - myHRP.Position).Magnitude
            if dist < 5 then
                local dir = (targetHRP.Position - myHRP.Position).Unit
                myHRP.Velocity = dir * VELOCITY_BOOST
            else
                myHRP.Velocity = Vector3.zero
            end
            myHRP.RotVelocity = Vector3.zero
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if not flingEnabled then continue end
        local hum = lp.Character and lp.Character:FindFirstChild("Humanoid")
        if hum then
            hum:Move(Vector3.one * 1e31)
        end
    end
end)

local function startAutoCycle()
    previousFlingEnabled = flingEnabled
    flingEnabled = true
    autoCycleActive = true

    task.spawn(function()
        while autoCycleActive do
            local players = Players:GetPlayers()
            for _, plr in ipairs(players) do
                if plr == lp then continue end
                if not autoCycleActive then break end

                targetPlayer = plr
                if statusLabel then
                    statusLabel.Text = "自动: " .. plr.Name
                end

                local cam = workspace.CurrentCamera
                local hum = plr.Character and plr.Character:FindFirstChild("Humanoid")
                if hum then
                    cam.CameraSubject = hum
                    cam.CameraType = Enum.CameraType.Custom
                end

                local waited = 0
                while waited < 2 and autoCycleActive do
                    task.wait(0.1)
                    waited = waited + 0.1
                    if not plr.Character or not plr.Character:FindFirstChild("Humanoid") or plr.Character.Humanoid.Health <= 0 then
                        break
                    end
                end
            end
        end
        local cam = workspace.CurrentCamera
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            cam.CameraSubject = lp.Character.Humanoid
            cam.CameraType = Enum.CameraType.Custom
        end
        targetPlayer = nil
        if statusLabel then statusLabel.Text = "开启" end
    end)
end

local function stopAutoCycle()
    autoCycleActive = false
    flingEnabled = previousFlingEnabled
    if not flingEnabled then
        targetPlayer = nil
        if statusLabel then statusLabel.Text = "状态: 关闭" end
    end
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlyOffGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = lp:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 180)
mainFrame.Position = UDim2.new(0.5, -110, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
mainFrame.BackgroundTransparency = 0
mainFrame.BorderSizePixel = 1
mainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -30, 0, 28)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "超飞"
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 28)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 1
closeBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
closeBtn.Parent = mainFrame

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 160, 0, 32)
toggleBtn.Position = UDim2.new(0.5, -80, 0, 38)
toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
toggleBtn.Text = "开启触碰甩飞"
toggleBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
toggleBtn.Font = Enum.Font.GothamSemibold
toggleBtn.TextSize = 12
toggleBtn.BorderSizePixel = 1
toggleBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
toggleBtn.Parent = mainFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 0, 78)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "状态: 关闭"
statusLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
statusLabel.TextSize = 11
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = mainFrame

local autoCycleBtn = Instance.new("TextButton")
autoCycleBtn.Size = UDim2.new(0, 160, 0, 32)
autoCycleBtn.Position = UDim2.new(0.5, -80, 0, 105)
autoCycleBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
autoCycleBtn.Text = "自动超飞别人"
autoCycleBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
autoCycleBtn.Font = Enum.Font.GothamSemibold
autoCycleBtn.TextSize = 12
autoCycleBtn.BorderSizePixel = 1
autoCycleBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
autoCycleBtn.Parent = mainFrame

local surpriseBtn = Instance.new("TextButton")
surpriseBtn.Size = UDim2.new(0, 80, 0, 24)
surpriseBtn.Position = UDim2.new(0.5, -40, 0, 145)
surpriseBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
surpriseBtn.Text = "点我有惊喜"
surpriseBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
surpriseBtn.Font = Enum.Font.GothamSemibold
surpriseBtn.TextSize = 10
surpriseBtn.BorderSizePixel = 1
surpriseBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
surpriseBtn.Parent = mainFrame

toggleBtn.MouseButton1Click:Connect(function()
    if autoCycleActive then
        stopAutoCycle()
        autoCycleBtn.Text = "循环超飞"
        autoCycleBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        flingEnabled = false
        manualEnabled = false
        toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        toggleBtn.Text = "开启触碰甩飞"
        statusLabel.Text = "状态: 关闭"
        targetPlayer = nil
        local cam = workspace.CurrentCamera
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            cam.CameraSubject = lp.Character.Humanoid
            cam.CameraType = Enum.CameraType.Custom
        end
        return
    end

    manualEnabled = not manualEnabled
    flingEnabled = manualEnabled
    if manualEnabled then
        toggleBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
        toggleBtn.Text = "关闭触碰甩飞"
        statusLabel.Text = "开启"
        targetPlayer = nil
    else
        toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        toggleBtn.Text = "开启触碰甩飞"
        statusLabel.Text = "状态: 关闭"
        targetPlayer = nil
        originalCFrame = nil
    end
end)

autoCycleBtn.MouseButton1Click:Connect(function()
    if autoCycleActive then
        stopAutoCycle()
        autoCycleBtn.Text = "自动超飞"
        autoCycleBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        local cam = workspace.CurrentCamera
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            cam.CameraSubject = lp.Character.Humanoid
            cam.CameraType = Enum.CameraType.Custom
        end
    else
        autoCycleBtn.Text = "停止超飞"
        autoCycleBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        startAutoCycle()
    end
end)

surpriseBtn.MouseButton1Click:Connect(function()
    lp:Kick("嘿嘿")
end)

closeBtn.MouseButton1Click:Connect(function()
    flingEnabled = false
    manualEnabled = false
    autoCycleActive = false
    targetPlayer = nil
    originalCFrame = nil
    local cam = workspace.CurrentCamera
    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
        cam.CameraSubject = lp.Character.Humanoid
        cam.CameraType = Enum.CameraType.Custom
    end
    screenGui:Destroy()
end)

flingEnabled = false
manualEnabled = false
autoCycleActive = false
targetPlayer = nil

print(" Hi pig god I am dream")
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});

AGA:AddLabel("--------撕咬之夜--------")

AGA:AddButton({
    Text = "Msploit汉化脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/Msploit"))()
    end
})
AGA:AddButton({
    Text = "撕咬之夜殺脚本",
    Func = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-X/Max/refs/heads/X/BBN.lua"))()
    end
})
AGA:AddButton({
    Text = "撕咬之夜RINGTA脚本",
    Func = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/RINGTA/bitesbynight"))()
    end
})
AGA:AddButton({
    Text = "撕咬之夜Cerberus汉化脚本",
    Func = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/Cerberus"))()
    end
})


AGA:AddLabel("----------被遗弃--------")
AGA:AddButton({
    Text = "Msploit汉化脚本",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/Msploit"))()
    end
})

AGA:AddButton({
    Text = "fartsaken汉化脚本",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/fartsaken"))()
    end
})

AGA:AddButton({
    Text = "RINGTA被遗弃汉化脚本",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/RINGTA/forsaken"))()
    end
})


AGA:AddLabel("-------99夜生存--------")
AGA:AddButton({
    Text = "Foxname99汉化脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/Foxname99"))()
    end
})
AGA:AddButton({
    Text = "RINGTA汉化脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/99Nights"))()
    end
})
AGA:AddButton({
    Text = "NOT汉化脚本",
    Func = function()
   loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/asdfgh160/Chinese-localization/refs/heads/main/99nights"))()
    end
})
AGA:AddButton({
    Text = "void汉化脚本",
    Func = function()
   loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/asdfgh160/Chinese-localization/refs/heads/main/VapeVoidware"))()
    end
})
AGA:AddButton({
    Text = "霖溺99夜脚本",
    Func = function()
   loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ShenJiaoBen/Partial-Server-Ribbon/refs/heads/main/LinniTeam_99NightsInTheForest.lua"))()
    end
})


AGA:AddLabel("-------最强的战场-------")

AGA:AddButton({
    Text = "角色扮演搜sans汉化脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/asdfgh160/Chinese-localization/refs/heads/main/Merebennie"))()
    end
})
AGA:AddButton({
    Text = "Phantasm汉化脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/asdfgh160/Chinese-localization/refs/heads/main/Phantasm"))()
    end
})
AGA:AddButton({
    Text = "AlanbeikersFF汉化脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/AlanbeikersFF"))()
    end
})
AGA:AddButton({
    Text = "Combat汉化脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/Combat"))()
    end
})








AGA:AddLabel("-------死亡之死-------")

AGA:AddButton({
    Text = "Msploit汉化脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/Msploit"))()
    end
})













AGA:AddLabel("-------MM2--------")
AGA:AddButton({
    Text = "king汉化脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/MM2King"))()
    end
})
AGA:AddButton({
    Text = "Foxname汉化脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/Foxnamemm2.lua"))()
    end
})

AGA:AddLabel("-------墨水游戏--------")

AGA:AddButton({
    Text = "AX有芙同享汉化脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/fningna51-stack/-/refs/heads/main/%E6%96%B0AX%E6%B1%89%E5%8C%96%E5%BA%93"))()
    end
})
AGA:AddButton({
    Text = "AXYirdeX汉化脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/Ax%E6%B1%89%E5%8C%96%E8%84%9A%E6%9C%AC"))()
    end
})
AGA:AddButton({
    Text = "博伦汉化脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/Youfutongxiang1/unm-CN/refs/heads/main/README.md"))()
    end
})

AGA:AddButton({
    Text = "天使之翼汉化脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/%E5%A4%A9%E4%BD%BF%E4%B9%8B%E7%BF%BC%E5%A2%A8%E6%B0%B4%E6%B8%B8%E6%88%8F%E6%B1%89%E5%8C%96"))()
    end
})


AGA:AddLabel("------竞争对手--------")
AGA:AddButton({
    Text = "竞争对手汉化脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/fningna51-stack/-/main/竞争对手汉化脚本"))()
    end
})
-------------分开-------------
A22:AddLabel("-------偷走脑红-------")

A22:AddLabel("-------锻造-------")

A22:AddLabel("-------亡命速递-------")

A22:AddLabel("-------死铁轨-------")

A22:AddLabel("-------刀刃球-------")
A22:AddButton({
    Text = "NodeX刀刃剑",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/NodeX%E5%88%80%E5%88%83%E5%89%91.lua"))()
    end
})
A22:AddButton({
    Text = "Achaotic混沌刀刃剑",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/Achaotic%E5%88%80%E5%88%83%E7%90%83"))()
    end
})
























-------------分开-------------

Tabs.C:UpdateWarningBox({
    Title = "警告！",
    Text = "小心！您放入YX-Hub-插件/Addons目录的任何脚本都会被执行器执行，我们建议您仅使用来自可信来源或开源的插件。对于插件造成的任何损害，我们概不负责，特此警告！",
    IsNormal = false,
    Visible = true,
    LockSize = true,
})
local HubFolder = "YX-Hub-插件"
local addonFolder = HubFolder.."/Addons"

if not isfolder(HubFolder) then
    makefolder(HubFolder)
end

if not isfolder(addonFolder) then
    makefolder(addonFolder)
end

AddonsFolder = AddonsFolder or {}
AddonsFolder.Addons = {}

for _, file in ipairs(listfiles(addonFolder)) do
    if file:sub(-4) == ".lua" or file:sub(-4) == ".txt" then
        local success, addon = pcall(function()
            return loadstring(readfile(file))()
        end)
        if success and type(addon) == "table" then
            table.insert(AddonsFolder.Addons, addon)
            
            if addon.Text then
                if addon.Callback then
                    Addons:AddToggle(addon.Text, {
                        Text = addon.Text,
                        Default = addon.Default or false,
                        Tooltip = addon.Tooltip or "",
                        Callback = addon.Callback
                    })
                elseif addon.Func then
                    Addons:AddButton({
                        Text = addon.Text,
                        Tooltip = addon.Tooltip or "",
                        Func = addon.Func
                    })
                elseif addon.Default and addon.Min and addon.Max and addon.Rounding then
                    Addons:AddSlider(addon.Text, {
                        Text = addon.Text,
                        Default = addon.Default,
                        Min = addon.Min,
                        Max = addon.Max,
                        Rounding = addon.Rounding,
                        Tooltip = addon.Tooltip or "",
                        Callback = addon.Callback
                    })
                elseif addon.Values then
                    Addons:AddDropdown(addon.Text, {
                        Values = addon.Values,
                        Default = addon.Default or 1,
                        Multi = addon.Multi or false,
                        Text = addon.Text,
                        Tooltip = addon.Tooltip or "",
                        Searchable = addon.Searchable or false,
                        Callback = addon.Callback
                    })
                elseif addon.Numeric ~= nil then
                    Addons:AddInput(addon.Text, {
                        Default = addon.Default or "",
                        Numeric = addon.Numeric,
                        Finished = addon.Finished or false,
                        ClearTextOnFocus = addon.ClearTextOnFocus or false,
                        Text = addon.Text,
                        Tooltip = addon.Tooltip or "",
                        Placeholder = addon.Placeholder or "",
                        Callback = addon.Callback
                    })
                else
                    Addons:AddLabel(addon.Text)
                end
            end
        end
    end
end
local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("界面设置")

MenuGroup:AddCheckbox("ShowCustomCursor", {
    Text = "自定义光标",
    Default = true,
    Callback = function(Value)
        Library.ShowCustomCursor = Value
    end,
})
MenuGroup:AddDropdown("NotificationSide", {
    Values = { "左侧", "右侧" },
    Default = "右侧",
    Text = "通知位置",
    Callback = function(Value)
        Library:SetNotifySide(Value)
    end,
})
MenuGroup:AddDropdown("DPIDropdown", {
    Values = { "25%", "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
    Default = "100%",
    Text = "界面大小",
    Callback = function(Value)
        Value = Value:gsub("%%", "")
        local DPI = tonumber(Value)
        Library:SetDPIScale(DPI)
    end,
})
MenuGroup:AddDivider()  
MenuGroup:AddLabel("菜单")  
    :AddKeyPicker("MenuKeybind", { 
        Default = "RightShift",  
        NoUI = true,            
        Text = "快捷键"    
    })

MenuGroup:AddButton("卸载界面", function()
    Library:Unload()  
end)

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)   
SaveManager:IgnoreThemeSettings() 
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })  
ThemeManager:SetFolder("MyScriptHub")            
SaveManager:SetFolder("MyScriptHub/specific-game")  
SaveManager:SetSubFolder("specific-place")       
SaveManager:BuildConfigSection(Tabs["UI Settings"])  
ThemeManager:ApplyToTab(Tabs["UI Settings"])
SaveManager:LoadAutoloadConfig()
