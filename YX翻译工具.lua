local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local UserInputService  = game:GetService("UserInputService")
local Lighting          = game:GetService("Lighting")
local CoreGui           = game:GetService("CoreGui")
local TeleportService   = game:GetService("TeleportService")
local HttpService       = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
 local repo = 'https://raw.githubusercontent.com/KingScriptAE/No-sirve-nada./refs/heads/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Options = Library.Options
local Toggles = Library.Toggles

local Window = Library:CreateWindow({
    Title = "YX Hub丨自动翻译",
    Footer = "By Linni",
    Icon = 122936242690381,
    NotifySide = "Right",
    ShowCustomCursor = true,
})

local Tabs = {
    Translate = Window:AddTab("自动翻译", "languages"),
    Settings = Window:AddTab("设置", "settings"),
}

local TranslateGroup = Tabs.Translate:AddLeftGroupbox("翻译设置")

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Chat = game:GetService("Chat")
local LocalPlayer = Players.LocalPlayer

local targetLang = "zh-CN"
local maxTextLength = 500
local baseScanInterval = 1.5
local speedMultiplier = 2
local translationMode = "智能翻译"
local translateNumbers = false
local translateSymbolsOnly = false
local skipPlayerNames = false
local autoTranslateEnabled = false
local heartbeatConnection = nil
local lastScanTime = 0

local translationCache = {}
local translatedInstances = {}

local emoteKeywords = {
    "neon", "shine", "ghost", "gold", "spin",
    "bighead", "smallhead", "giant", "squash",
}

local function detectLanguage(text)
    if not text or #text == 0 then
        return "en"
    end

    local counts = {
        cjk = 0,
        zht = 0,
        ko = 0,
        ja = 0,
        en = 0,
    }

    for _, code in utf8.codes(text) do
        local char = utf8.char(code)
        if char:match("[\228-\233][\128-\191][\128-\191]") then
            counts.cjk += 1
        elseif char:match("[\227][\128-\191][\128-\191]") then
            counts.zht += 1
        elseif char:match("[\234-\237][\128-\191]") then
            counts.ko += 1
        elseif char:match("[\227-\227][\128-\191][\128-\191]*") or char:match("[\227-\233][\128-\191]") then
            counts.ja += 1
        elseif char:match("[%a]") then
            counts.en += 1
        end
    end

    if counts.cjk > 3 then
        return counts.zht > 3 and "zh-TW" or "zh-CN"
    end
    if counts.ko > 2 then
        return "ko"
    end
    if counts.ja > 2 then
        return "ja"
    end
    if counts.en > 5 then
        return "en"
    end
    return "en"
end

local function shouldSkipText(text)
    if not text or text == "" or translationCache[text] then
        return true
    end
    if text:match("^%s*$") then
        return true
    end
    if not translateNumbers and text:match("^[%d%.%%,%s:/]+$") then
        return true
    end
    if not translateSymbolsOnly and text:match("^[^%w%s]+$") then
        return true
    end
    if #text > maxTextLength then
        return true
    end
    if not skipPlayerNames then
        if Players:FindFirstChild(text) then
            return true
        end
    end
    local lower = string.lower(text)
    for _, keyword in ipairs(emoteKeywords) do
        if string.find(lower, keyword) then
            return true
        end
    end
    return false
end

local function shouldTranslateByMode(text, detectedLang)
    if translationMode == "仅翻译英文" and detectedLang ~= "en" then
        return false
    end
    if translationMode == "仅翻译日文" and detectedLang ~= "ja" then
        return false
    end
    if translationMode == "仅翻译韩文" and detectedLang ~= "ko" then
        return false
    end
    if translationMode == "快速翻译" and #text > 50 then
        return false
    end
    return true
end

local function translateGoogle(text, fromLang, toLang)
    local url = string.format(
        "https://translate.googleapis.com/translate_a/single?client=gtx&sl=%s&tl=%s&dt=t&q=%s",
        fromLang,
        toLang,
        HttpService:UrlEncode(text)
    )

    local ok, body = pcall(function()
        return game:HttpGet(url, false, {
            ["User-Agent"] = "Mozilla/5.0",
        })
    end)
    if not ok or not body then
        return nil
    end

    local decodeOk, data = pcall(HttpService.JSONDecode, HttpService, body)
    if not decodeOk or not data or not data[1] then
        return nil
    end

    local result = ""
    for _, part in ipairs(data[1]) do
        if part[1] then
            result ..= part[1]
        end
    end
    return result ~= "" and result or nil
end

local function translateMyMemory(text, fromLang, toLang)
    local url = string.format(
        "https://api.mymemory.translated.net/get?q=%s&langpair=%s|%s",
        HttpService:UrlEncode(text),
        fromLang,
        toLang
    )

    local ok, body = pcall(function()
        return game:HttpGet(url, false, {
            ["User-Agent"] = "Roblox",
        })
    end)
    if not ok or not body then
        return nil
    end

    local decodeOk, data = pcall(HttpService.JSONDecode, HttpService, body)
    if not decodeOk or not data or not data.responseData then
        return nil
    end
    return data.responseData.translatedText
end

local function translateText(text)
    if shouldSkipText(text) then
        return translationCache[text] or text
    end

    local detected = detectLanguage(text)
    if detected == "zh-CN" then
        return text
    end
    if not shouldTranslateByMode(text, detected) then
        return text
    end

    local translated = translateGoogle(text, detected, targetLang)
    if translated then
        translationCache[text] = translated
        return translated
    end

    translated = translateMyMemory(text, detected, targetLang)
    if translated then
        translationCache[text] = translated
        return translated
    end

    return text
end

local function isTextInstance(obj)
    return obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")
end

local function shouldSkipInstance(obj)
    if not obj then
        return true
    end
    if obj == Chat or obj.Parent == Chat then
        return true
    end
    local ancestor = obj:FindFirstAncestorWhichIsA("TextChannel")
    if ancestor then
        return true
    end
    return false
end

local function getText(instance)
    if not isTextInstance(instance) then
        return nil
    end
    if not instance.Text or instance.Text == "" or shouldSkipInstance(instance) then
        return nil
    end
    return instance.Text
end

local function setText(instance, text)
    if isTextInstance(instance) and not shouldSkipInstance(instance) then
        instance.Text = text
    end
end

local function translateInstance(instance)
    if not isTextInstance(instance) or translatedInstances[instance] then
        return false
    end

    local original = getText(instance)
    if not original then
        return false
    end

    translatedInstances[instance] = true
    if getText(instance) == original then
        setText(instance, translateText(original))
        return true
    end
    return false
end

local function scanAndTranslate(root)
    local now = tick()
    if now - lastScanTime < baseScanInterval / speedMultiplier then
        return 0
    end
    lastScanTime = now

    local count = 0
    for _, descendant in ipairs(root:GetDescendants()) do
        if isTextInstance(descendant) and not translatedInstances[descendant] and not shouldSkipInstance(descendant) then
            if translateInstance(descendant) then
                count += 1
            end
        end
    end
    return count
end

local function onDescendantAdded(obj)
    if not autoTranslateEnabled or not isTextInstance(obj) then
        return
    end
    task.delay(0.1, function()
        if obj.Parent and not shouldSkipInstance(obj) then
            translateInstance(obj)
        end
    end)
end

TranslateGroup:AddLabel("注意：请先加载此脚本开启翻译，再加载你需要翻译的脚本", false)
TranslateGroup:AddLabel("小部分特殊UI无法翻译", false)

TranslateGroup:AddDropdown("TranslationMode", {
    Values = { "智能翻译", "仅翻译英文", "仅翻译日文", "仅翻译韩文", "快速翻译" },
    Default = 1,
    Multi = false,
    Text = "翻译模式",
    Callback = function(Value)
        translationMode = Value
    end
})

TranslateGroup:AddToggle("AutoTranslate", {
    Text = "启用自动翻译",
    Default = false,
    Callback = function(Value)
        autoTranslateEnabled = Value
        if Value then
            if heartbeatConnection then
                heartbeatConnection:Disconnect()
            end
            scanAndTranslate(LocalPlayer:WaitForChild("PlayerGui"))
            heartbeatConnection = RunService.Heartbeat:Connect(function()
                if autoTranslateEnabled then
                    scanAndTranslate(LocalPlayer.PlayerGui)
                end
            end)
        else
            if heartbeatConnection then
                heartbeatConnection:Disconnect()
                heartbeatConnection = nil
            end
        end
    end
})

TranslateGroup:AddSlider("TranslationSpeed", {
    Text = "翻译速度",
    Default = 2,
    Min = 1,
    Max = 5,
    Rounding = 0,
    Suffix = "x",
    Callback = function(Value)
        speedMultiplier = Value
    end
})

TranslateGroup:AddToggle("TranslateNumbers", {
    Text = "翻译数字",
    Default = false,
    Callback = function(Value)
        translateNumbers = Value
    end
})
TranslateGroup:AddToggle("TranslateSymbolsOnly", {
    Text = "翻译纯符号",
    Default = false,
    Callback = function(Value)
        translateSymbolsOnly = Value
    end
})
TranslateGroup:AddToggle("SkipPlayerNames", {
    Text = "跳过玩家名称",
    Default = false,
    Callback = function(Value)
        skipPlayerNames = Value
    end
})
TranslateGroup:AddButton({
    Text = "官方群聊",
    Desc = "点击复制群号",
    Func = function()
        if setclipboard then
            setclipboard("766691084")
            Library:Notify("已复制群号: 766691084", 3)
        end
    end,
    DoubleClick = false,
})

local MenuGroup = Tabs.Settings:AddLeftGroupbox('菜单')
MenuGroup:AddButton('卸载脚本', function() Library:Unload() end)
MenuGroup:AddLabel('菜单快捷键'):AddKeyPicker('MenuKeybind', { Default = 'RightShift', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
ThemeManager:SetFolder("MyScriptTheme")
SaveManager:SetFolder("MyScriptConfig")
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

LocalPlayer:WaitForChild("PlayerGui").DescendantAdded:Connect(onDescendantAdded)
game:GetService("CoreGui").DescendantAdded:Connect(onDescendantAdded)
