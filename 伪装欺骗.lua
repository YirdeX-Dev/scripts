local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local localPlayer = Players.LocalPlayer

local repo = "https://raw.githubusercontent.com/YirdeX-Dev/obsidian_UI/refs/heads/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "SaveManager.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "ThemeManager.lua"))()
local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

local function notify(title, text, duration)
    if Library and Library.Notify then
        Library:Notify({
            Title = tostring(title),
            Description = tostring(text or ""),
            Time = tonumber(duration) or 0.9,
        })
    else
        print("[Notify]", title, text)
    end
end

local Window = Library:CreateWindow({
    Title = "YX-伪装欺骗",
    Footer = "基于NOL的诬陷进行修改 | YirdeX | 墨水可用",
    Size = UDim2.fromOffset(750, 650),
    Icon = "rbxassetid://71400987113958",
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
    into = Window:AddTab("信息", "info"),
    Main = Window:AddTab("主功能", "cpu"),
    ["UI Settings"] = Window:AddTab("UI设置", "settings"),
}

local RightGroupBox1 = Tabs.into:AddRightGroupbox("开发者名单", "circle-star")
RightGroupBox1:AddLabel("[<font color=\"rgb(73, 230, 133)\">YirdeX</font>] 主开发者")
RightGroupBox1:AddLabel("[<font color=\"rgb(73, 230, 133)\">秋辞</font>] 优化脚本")

local LeftGroupBox2 = Tabs.into:AddLeftGroupbox("注意事项", "triangle-alert")
LeftGroupBox2:AddLabel("使用了该脚本，出事后的任何后果\n那我们概不负责")

Tabs.Main:UpdateWarningBox({
    Title = '脚本注意事项',
    Text = '在墨水游戏里面，应用伪装完后，需要点击右边玩家列表中的自己，如果看到自身的名字和用户名和头像变了，那就说明成功了',
    IsNormal = true,
    Visible = true,
    LockSize = true,
})

local function getUserIdByUsername(username)
    local success, result = pcall(function()
        return game:HttpGet("https://users.roblox.com/v1/users/search?keyword=" .. username, true)
    end)
    if not success then return nil, nil, nil end
    local data = HttpService:JSONDecode(result)
    if data and data.data and #data.data > 0 then
        return data.data[1].id, data.data[1].name, data.data[1].displayName
    end
    return nil, nil, nil
end

local function applyCharacterAppearance(character, userId)
    local appearance = Players:GetCharacterAppearanceAsync(userId)

    for _, v in pairs(character:GetChildren()) do
        if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") then
            v:Destroy()
        end
    end

    for _, v in pairs(appearance:GetChildren()) do
        if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") then
            v.Parent = character
        elseif v:IsA("Accessory") then
            character.Humanoid:AddAccessory(v)
        end
    end

    if appearance:FindFirstChild("face") then
        if character:WaitForChild("Head"):FindFirstChild("face") then
            character.Head.face:Destroy()
        end
        appearance.face.Parent = character.Head
    end

    local parent = character.Parent
    character.Parent = nil
    character.Parent = parent
end

local LeftGroupBox = Tabs.Main:AddLeftGroupbox("角色伪装", "hat-glasses")

LeftGroupBox:AddInput("VictimInput", {
    Default = "cmwk222",
    Text = "目标玩家名字",
    Placeholder = "输入目标名字...",
    Callback = function() end,
})

local function applyDisguise(victimName)
    if victimName == "" then
        notify("错误", "请输入一个目标玩家的名字", 3)
        return false
    end

    local success = pcall(function()
        local userId, userName, displayName = getUserIdByUsername(victimName)
        if not userId then
            notify("错误", "找不到该玩家", 3)
            return
        end

        local lp = Players.LocalPlayer
        lp.Name = userName
        lp.UserId = userId
        lp.CharacterAppearanceId = userId
        lp.DisplayName = displayName

        local char = lp.Character or lp.CharacterAdded:Wait()
        char.Name = userName

        applyCharacterAppearance(char, userId)

        notify("成功", "伪装为: " .. displayName, 3)
    end)

    return success
end

LeftGroupBox:AddButton({
    Text = "应用伪装",
    Func = function()
        applyDisguise(Options.VictimInput.Value)
    end,
})

local LeftGroupBox1 = Tabs.Main:AddRightGroupbox("他人伪装", "hat-glasses")

LeftGroupBox1:AddDropdown('TargetPlayerList', {
    SpecialType = 'Player',
    Text = '选择要修改的玩家',
})

LeftGroupBox1:AddInput("AppearanceSourceInput", {
    Text = "输入伪装玩家名字",
    Placeholder = "输入外观来源玩家名字...",
})

local function getSelectedTargetPlayer()
    local v = Options.TargetPlayerList.Value
    return (v and typeof(v) == "Instance" and v:IsA("Player")) and v or nil
end

local function applyAppearanceToTarget(appearanceName)
    local target = getSelectedTargetPlayer()
    if not target then
        notify("错误", "请选择一个目标玩家", 3)
        return false
    end

    local userId, userName, displayName = getUserIdByUsername(appearanceName)
    if not userId then
        notify("错误", "找不到外观来源玩家", 3)
        return false
    end

    local char = target.Character or target.CharacterAdded:Wait()

    target.Name = userName
    target.UserId = userId
    target.CharacterAppearanceId = userId
    target.DisplayName = displayName

    char.Name = userName

    applyCharacterAppearance(char, userId)

    notify("成功", string.format("已将 %s 伪装为 %s", target.Name, displayName), 3)
end

LeftGroupBox1:AddButton({
    Text = "应用伪装",
    Func = function()
        applyAppearanceToTarget(Options.AppearanceSourceInput.Value)
    end,
})

local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("菜单设置", "wrench")

MenuGroup:AddToggle("KeybindMenuOpen", {
    Default = Library.KeybindFrame.Visible,
    Text = "打开按键绑定菜单",
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end,
})

MenuGroup:AddToggle("ShowCustomCursor", {
    Text = "自定义鼠标指针",
    Default = true,
    Callback = function(Value)
        Library.ShowCustomCursor = Value
    end,
})

MenuGroup:AddDropdown("NotificationSide", {
    Values = { "左侧", "右侧" },
    Default = "右侧",
    Text = "通知弹窗位置",
    Callback = function(Value)
        Library:SetNotifySide(Value)
    end,
})

MenuGroup:AddDropdown("DPIDropdown", {
    Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
    Default = "100%",
    Text = "DPI 缩放比例",
    Callback = function(Value)
        Value = Value:gsub("%%", "")
        local DPI = tonumber(Value)
        Library:SetDPIScale(DPI)
    end,
})

MenuGroup:AddSlider("UICornerSlider", {
    Text = "界面圆角大小",
    Default = Library.CornerRadius,
    Min = 0,
    Max = 20,
    Rounding = 0,
    Callback = function(value)
        Window:SetCornerRadius(value)
    end,
})

MenuGroup:AddDivider()
MenuGroup:AddLabel("菜单快捷键")
    :AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "菜单快捷键" })

MenuGroup:AddButton("卸载脚本", function()
    Library:Unload()
end)

Library.ToggleKeybind = Options.MenuKeybind
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
