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

local GlobalEnv = getgenv()
local FunctionEnv = getfenv()

local repo = 'https://raw.githubusercontent.com/DevSloPo/obsidian_UI/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local Humanoid = Character:WaitForChild("Humanoid")

local Win = Library:CreateWindow({
	Title = "YX-脚本中心",
    Footer = "汉化中心",
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
        Name = "通用功能(维修)",
        Description = "6",
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
}

local AB = Tabs.D:AddRightGroupbox("信息")
local AA = Tabs.D:AddLeftGroupbox("人员名单","handshake")

    Tabs.D:UpdateWarningBox({
        Title = '脚本信息',
        Text = '请不要在bloxstrike服务器执行脚本，路被封禁，若执意执行，[<font color=\"rgb(255, 0, 0)\">后果自负，我们概不负责</font>]',
        IsNormal = true,
        Visible = true,
        LockSize = true,
    })
AA:AddLabel("[<font color=\"rgb(0, 255, 0)\">YirdeX</font>]制作者 | 所有者")
AA:AddLabel("[<font color=\"rgb(0, 255, 0)\">秋词</font>]制作者 | 开发者")
AA:AddLabel("[<font color=\"rgb(0, 255, 0)\">白枫</font>]测试者")


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
    Text = "YI_Hub",
    Func = function()
    getgenv().YI_HUB="YI_HUB群979312897"loadstring(game:HttpGet('https://raw.githubusercontent.com/YI-HUB-TEAM/YIscript/refs/heads/main/YI_HUB'))("")
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

AGA:AddLabel("--------撕咬之夜--------")
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
    Text = "访客中心汉化脚本",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/YirdeX-Dev/China/refs/heads/main/%E8%AE%BF%E5%AE%A2%E4%B8%AD%E5%BF%83"))()
    end
})
AGA:AddButton({
    Text = "fart汉化脚本",
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
   loadstring(game:HttpGet("https://raw.githubusercontent.com/YirdeX-Dev/China/refs/heads/main/Ax%E6%B1%89%E5%8C%96%E8%84%9A%E6%9C%AC"))()
    end
})
AGA:AddButton({
    Text = "博伦汉化脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/Youfutongxiang1/unm-CN/refs/heads/main/README.md"))()
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
AGA:AddLabel("------竞争对手--------")
AGA:AddButton({
    Text = "竞争对手汉化脚本",
    Func = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/fningna51-stack/-/main/竞争对手汉化脚本"))()
    end
})
-------------分开-------------
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




-------------分开-------------
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