local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local repo = "https://raw.githubusercontent.com/YirdeX-Dev/obsidian_UI/refs/heads/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "SaveManager.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "ThemeManager.lua"))()


local success, Library = pcall(function()
    return loadstring(game:HttpGet(repo .. 'Library.lua'))()
end)

if not success or not Library then
    warn("无法加载Library.lua")
    return
end

local success, ThemeManager = pcall(function()
    return loadstring(game:HttpGet(repo .. 'ThemeManager.lua'))()
end)

if not success or not ThemeManager then
    warn("无法加载ThemeManager.lua")
    return
end

local success, SaveManager = pcall(function()
    return loadstring(game:HttpGet(repo .. 'SaveManager.lua'))()
end)

if not success or not SaveManager then
    warn("无法加载SaveManager.lua")
    return
end

local Options = Library.Options
local Toggles = Library.Toggles

local isKeyValid = false
local HttpService = game:GetService("HttpService")

local WHITELIST_FILE = "Qiuci_Whitelist.json"
local VALIDATED_USERS_FILE = "Qiuci_Validated_Users.json"

local Players = game:GetService("Players")

local function getLocalPlayer()
    local lp = Players.LocalPlayer
    if lp then return lp end
    
    for i = 1, 30 do
        lp = Players.LocalPlayer
        if lp then return lp end
        task.wait(0.2)
    end
    return nil
end

local LocalPlayer = getLocalPlayer()
if not LocalPlayer then
    warn("无法获取 LocalPlayer，脚本终止")
    return
end

local function saveValidatedUser()
    local data = {
        UserId = LocalPlayer.UserId,
        UserName = LocalPlayer.Name,
        Validated = true,
        Time = os.time(),
        Date = os.date("%Y-%m-%d %H:%M:%S")
    }
    
    local allUsers = {}
    if isfile(VALIDATED_USERS_FILE) then
        local success, existing = pcall(function()
            return HttpService:JSONDecode(readfile(VALIDATED_USERS_FILE))
        end)
        if success and type(existing) == "table" then
            allUsers = existing
        end
    end
    
    allUsers[tostring(LocalPlayer.UserId)] = data
    
    pcall(function()
        writefile(VALIDATED_USERS_FILE, HttpService:JSONEncode(allUsers))
    end)
end

local function loadValidatedUsers()
    if isfile(VALIDATED_USERS_FILE) then
        local success, data = pcall(function()
            return HttpService:JSONDecode(readfile(VALIDATED_USERS_FILE))
        end)
        if success and type(data) == "table" then
            return data
        end
    end
    return {}
end

local function isUserValidated()
    local validatedUsers = loadValidatedUsers()
    local userId = tostring(LocalPlayer.UserId)
    local userData = validatedUsers[userId]
    
    if userData and userData.Validated then
        if (os.time() - userData.Time) < 5184000 then -- 30天有效期
            return true
        else
            validatedUsers[userId] = nil
            pcall(function()
                writefile(VALIDATED_USERS_FILE, HttpService:JSONEncode(validatedUsers))
            end)
        end
    end
    return false
end

local function saveWhitelist()
    pcall(function()
        writefile(WHITELIST_FILE, HttpService:JSONEncode({
            UserId = LocalPlayer.UserId,
            Verified = true,
            Time = os.time()
        }))
    end)
end

local function loadWhitelist()
    if isfile(WHITELIST_FILE) then
        local success, data = pcall(function()
            return HttpService:JSONDecode(readfile(WHITELIST_FILE))
        end)
        if success and type(data) == "table" and data.UserId == LocalPlayer.UserId then
            return data
        end
    end
    return nil
end

if loadWhitelist() or isUserValidated() then
    isKeyValid = true
    print("✅ 已验证用户，自动通过")
end

local Options = Library.Options
local Toggles = Library.Toggles
local A1 = game:GetService("Players")
local A2 = A1.LocalPlayer
local A3 = game:GetService("RunService")
local A4 = game:GetService("Lighting")
local A5 = game:GetService("CoreGui")
local A6 = game:GetService("UserInputService")
local A7 = game:GetService("TeleportService")
local A8 = workspace
local A9 = game:GetService("HttpService")

local Window = Library:CreateWindow({
    Title = "YX-加载器",
    Footer = "加载器(卡密验证代码由秋辞提供)",
    Icon = "rbxassetid://71400987113958", 
    Size = UDim2.fromOffset(750, 650),
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
    Main = Window:AddTab("卡密验证", "house"),
    ["UI Settings"] = Window:AddTab("设置", "settings"),
}
local RightGroupBox1 = Tabs.Main:AddRightGroupbox("信息", "info")

if not Window then
    warn("无法创建窗口")
    return
end

if Window.TitleLabel then
    Window.TitleLabel.RichText = true
end

local LeftGroup = Tabs.Main:AddLeftGroupbox("卡密验证", "key")

LeftGroup:AddLabel("请输入您的卡密进行验证", true)

local KeyInput = LeftGroup:AddInput("KeyInput", {
    Text = "卡密",
    Placeholder = "例如: LIYXI-2025-VIP",
    Numeric = false,
    Finished = false,
})

local resultLabel = LeftGroup:AddLabel("等待输入卡密...")

if isKeyValid then
    resultLabel:SetText("✅ 检测到已验证用户，可直接执行脚本")
    Library:Notify("欢迎回来！您已验证过，可直接执行脚本", 3)
end

local VALID_KEYS = {
    ["YX-6324-5431-IMKFART"] = { 
        name = "VIP会员",
        expires = "永久"
    },
}

local function executeMainScript()
    Library:Notify("✅ 验证通过，正在加载脚本...", 3)
    resultLabel:SetText("✅ 验证通过，正在加载脚本...")
    task.wait(0.5)

    local success, err = pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/YirdeX-Dev/scripts/refs/heads/main/Id.lua"))()---该服务器脚本
    end)

    if success then
        Library:Notify("✅ 脚本已成功执行", 3)
    else
        Library:Notify("❌ 脚本执行失败：" .. tostring(err), 5)
    end

    task.wait(1)
    Library:Unload()
    return true
end

LeftGroup:AddButton({
    Text = "验 证 卡 密",
    Func = function()
        local inputKey = nil
        local success, err = pcall(function()
            inputKey = KeyInput:GetValue()
        end)
        
        if not success or inputKey == nil or inputKey == "" then
            if Options.KeyInput and Options.KeyInput.Value then
                inputKey = Options.KeyInput.Value
            else
                pcall(function()
                    resultLabel:SetText("❌ 请输入卡密！")
                end)
                Library:Notify("请输入卡密后再验证", 3)
                return
            end
        end
        
        if inputKey then
            inputKey = string.gsub(inputKey, "^%s*(.-)%s*$", "%1")
        end
        
        if inputKey == nil or inputKey == "" then
            pcall(function()
                resultLabel:SetText("❌ 请输入卡密！")
            end)
            Library:Notify("请输入卡密后再验证", 3)
            return
        end
        
        if VALID_KEYS[inputKey] then
            isKeyValid = true
            local keyInfo = VALID_KEYS[inputKey]
            pcall(function()
                resultLabel:SetText(string.format("✅ 验证成功！欢迎 %s 用户（有效期：%s）", keyInfo.name, keyInfo.expires))
            end)
            Library:Notify(string.format("✅ 卡密验证成功！欢迎 %s", keyInfo.name), 5)
            
            saveValidatedUser()
            saveWhitelist()
        else
            isKeyValid = false
            pcall(function()
                resultLabel:SetText("❌ 卡密无效！请检查后重新输入")
            end)
            Library:Notify("❌ 卡密验证失败，请检查是否正确", 4)
        end
    end
})

LeftGroup:AddLabel("━━━━━━━━━━━━━━━━━━━━")

LeftGroup:AddButton({
    Text = "执 行 脚 本",
    Func = function()
        if not isKeyValid then
            Library:Notify("❌ 请先验证卡密后再执行脚本！", 4)
            resultLabel:SetText("⚠️ 请先验证卡密！")
            return
        end
        
        executeMainScript()
    end
})

LeftGroup:AddLabel("━━━━━━━━━━━━━━━━━━━━")
LeftGroup:AddLabel("获取卡密方式：", true)

LeftGroup:AddButton({
    Text = "复制QQ群号",
    Func = function()
        local demoKey = "2152069753"
        if setclipboard then
            setclipboard(demoKey)
            Library:Notify("✅ 已复制QQ群号: " .. demoKey, 3)
            resultLabel:SetText("💡 QQ群号已复制")
        else
            Library:Notify("❌ 当前环境不支持复制功能", 3)
        end
    end
})

LeftGroup:AddButton({
    Text = "重 置 验 证",
    Func = function()
        isKeyValid = false
        KeyInput:SetValue("")
        resultLabel:SetText("🔄 验证状态已重置，请重新输入卡密")
        Library:Notify("验证状态已重置", 3)
    end
})

LeftGroup:AddButton({
    Text = "清 除 验 证 记 录",
    Func = function()
        if isfile(VALIDATED_USERS_FILE) then
            local userId = tostring(LocalPlayer.UserId)
            local validatedUsers = loadValidatedUsers()
            validatedUsers[userId] = nil
            pcall(function()
                writefile(VALIDATED_USERS_FILE, HttpService:JSONEncode(validatedUsers))
            end)
            isKeyValid = false
            resultLabel:SetText("🗑️ 已验证记录已清除，请重新验证")
            Library:Notify("已验证记录已清除", 3)
        end
    end
})

Tabs.Main:UpdateWarningBox({
        Title = '脚本信息',
        Text = '请不要在bloxstrike服务器执行脚本，不然会被封禁，若执意执行，[<font color=\"rgb(255, 0, 0)\">后果自负，我们概不负责</font>]',
        IsNormal = true,
        Visible = true,
        LockSize = true,
    })
    
RightGroupBox1:AddDivider("贡献者")
RightGroupBox1:AddLabel("[<font color=\"rgb(73, 230, 133)\">YirdeX</font>] 所有者")
RightGroupBox1:AddLabel("[<font color=\"rgb(73, 230, 133)\">秋辞</font>] 开发者")
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

if isKeyValid then
    Library:Notify("✅ 检测到已验证用户，正在自动加载脚本...", 3)
    task.wait(1.5)
    executeMainScript()
else
    Library:Notify("欢迎使用卡密验证系统！请先验证卡密", 5)
end
