local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local repo = "https://raw.githubusercontent.com/YirdeX-Dev/obsidian_UI/refs/heads/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "SaveManager.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "ThemeManager.lua"))()

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
    Title = "YX-脚本中心",
    Footer = "脚本中心",
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
    Main = Window:AddTab("通用功能", "code-xml"),
    ScriptCenter = Window:AddTab("脚本中心", "bug"),
    YX = Window:AddTab("YX加载", "menu"),
    ["UI Settings"] = Window:AddTab("设置", "settings"),
}
----------
local ScriptCenterLeftGroup = Tabs.ScriptCenter:AddLeftGroupbox("脚本中心1");
local ScriptCenterRightGroup = Tabs.ScriptCenter:AddRightGroupbox("脚本中心2");
local leftIndex = 0;
local rightIndex = 0;

local ScriptCenter = {
    {
        GroupName = "各大脚本",
        List = {
            {Name = "秋容脚本复刻版", Url = "https://raw.githubusercontent.com/fningna51-stack/-/main/%E7%A7%8B%E5%AE%B9%E8%84%9A%E6%9C%AC%E5%A4%8D%E5%88%BB%E7%89%88"},
            {Name = "叶脚本", Url = "https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/ROBLOX-CNVIP-XIAOYE.lua"},
            {Name = "xk脚本", Url = "https://github.com/devslopo/DVES/raw/main/XK%20Hub"},
            {Name = "新版XA脚本", Url = "https://github.com/YunLua/Lua/raw/main/XA_Hub.lua"},
            {Name = "皮脚本", Url = "https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"},
            {Name = "落叶脚本", Url = "https://raw.githubusercontent.com/krlpl/Deciduous-center-LS/main/%E8%90%BD%E5%8F%B6%E4%B8%AD%E5%BF%83%E6%B7%B7%E6%B7%86.txt"},
            {Name = "Rb脚本中心＿汉化中心", Url = "https://api.luarmor.net/files/v3/loaders/4fe525637e43a1be8cb0cdf902d107c2.lua"},
            {Name = "sky Hub", Url = "https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/Skyhub.lua"},
            {Name = "NOL免费版", Url = "https://raw.githubusercontent.com/Syndromehsh/BETA2/refs/heads/main/NOL"},
            {Name = "BS中心", Url = "https://gitee.com/BS_script/script/raw/master/黑洞中心(BS).txt"},
            {Name = "Rb脚本中心", Url = "https://raw.githubusercontent.com/Yungengxin/roblox/refs/heads/main/Rb-Hub"},
            {Name = "sa脚本", Url = "https://raw.githubusercontent.com/Bebo-Mods/BeboScripts/main/StandAwekening.lua"},
            {Name = "霖溺通用", Url = "https://raw.githubusercontent.com/ShenJiaoBen/Partial-Server-Ribbon/refs/heads/main/Linni_Universal.txt"},
        }
    },
    {
        GroupName = "FE",
        List = {
            {Name = "放置我的世界方块", Url = "https://raw.githubusercontent.com/asdfgh160/Chinese-localization/refs/heads/main/MozCraft"},
            {Name = "可让尾巴饰品动起来()", Url = "https://rawscripts.net/raw/Universal-Script-physics-based-tail-animator-86591"},
            {Name = "可做动作脚本", Url = "https://raw.githubusercontent.com/sypcerr/scripts/refs/heads/main/c15.lua"},
            {Name = "valout动作脚本", Url = "https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/valout%E8%A1%A8%E6%83%85"},
        }
    },
    {
        GroupName = "99夜",
        List = {
            {Name = "虚空99夜脚本汉化", Url = "https://raw.githubusercontent.com/fningna51-stack/-/main/99%E5%A4%9C%E6%B1%89%E5%8C%96"},
            {Name = "Foxname99夜汉化脚本", Url = "https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/Foxname99"},
            {Name = "99夜脚本可杀队友", Url = "https://raw.githubusercontent.com/358545698555/roblox-/refs/heads/main/%E5%8F%AF%E6%9D%80%E9%98%9F%E5%8F%8B99%E5%A4%9C"},
            {Name = "RINGTA汉化脚本", Url = "https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/99Nights"},
            {Name = "99夜汉化脚本(无敌有效果)", Url = "https://raw.githubusercontent.com/fningna51-stack/-/main/%E7%A7%8B%E8%BE%9E99%E5%A4%9C%E6%B1%89%E5%8C%96"},
            {Name = "AF Hub 99夜", Url = "https://raw.githubusercontent.com/fningna51-stack/-/main/99%E5%A4%9C%E8%84%9A%E6%9C%AC"},
        }
    },
            GroupName = "动物医院",
        List = {
            {Name = "Cyraa汉化脚本", Url = "https://raw.githubusercontent.com/YirdeX-Dev/China/refs/heads/main/Cyraa"},
        }
    },
    {
        GroupName = "亡命速递",
        List = {
            {Name = "亡命速递脚本无法使用", Url = "https://raw.githubusercontent.com/JanseJYC/Script/refs/heads/main/Deadly-Deliver.lua"},
            {Name = "亡命速递英文脚本", Url = "https://raw.githubusercontent.com/xxdaysheus01/RuneX/refs/heads/main/DeadlyDeliveryScript.lua"},
            {Name = "亡命速递", Url = "https://pandadevelopment.net/virtual/file/c96973c95ae3aaec"},
            {Name = "亡命速递汉化脚本", Url = "https://raw.githubusercontent.com/JanseJYC/Script/refs/heads/main/Deadly-Deliver.lua"},
        }
    },
    {
        GroupName = "死铁轨",
        List = {
            {Name = "仿红叶脚本汉化", Url = "https://raw.githubusercontent.com/fningna51-stack/-/main/%E4%BB%BF%E7%BA%A2%E5%8F%B6%E8%84%9A%E6%9C%AC%E6%B1%89%E5%8C%96"},
            {Name = "红叶脚本", Url = "https://getnative.cc/script/loader"},
            {Name = "速通脚本汉化", Url = "https://raw.githubusercontent.com/fningna51-stack/-/main/%E6%AD%BB%E9%93%81%E8%BD%A8%E6%B1%89%E5%8C%96%E8%84%9A%E6%9C%AC"},
            {Name = "死铁轨脚本", Url = "https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/DeadRails"},
            {Name = "死铁轨脚本(好用)", Url = "https://raw.githubusercontent.com/kiciahook/kiciahook/refs/heads/main/loader.lua"},
        }
    },
    {
        GroupName = "墨水游戏",
        List = {
            {Name = "AX-有芙同享汉化", Url = "https://raw.githubusercontent.com/fningna51-stack/-/main/ax%E8%84%9A%E6%9C%AC%E7%A7%8B%E8%BE%9E%E6%B1%89%E5%8C%96"},
            {Name = "AX-YirdeX汉化脚本", Url = "https://raw.githubusercontent.com/YirdeX-Dev/China/refs/heads/main/Ax%E6%B1%89%E5%8C%96%E8%84%9A%E6%9C%AC"},   
             {Name = "HSX汉化脚本", Url = "https://raw.githubusercontent.com/YirdeX-Dev/China/refs/heads/main/HSX%E5%A2%A8%E6%B0%B4%E6%B8%B8%E6%88%8F"},   
            {Name = "墨水Ringta汉化", Url = "https://raw.githubusercontent.com/YirdeX-Dev/China/refs/heads/main/RINGTA/ink%20Game.lua"},
            {Name = "Unm汉化，卡密ink50", Url = "https://raw.githubusercontent.com/Youfutongxiang1/unm-CN/refs/heads/main/README.md"},
        }
    },
    {
        GroupName = "doors",
        List = {
            {Name = "Doors脚本", Url = "https://raw.githubusercontent.com/atnew2025/Chinese-scripts/refs/heads/main/mshax(prohax).txt"},
            {Name = "doors最新脚本", Url = "https://raw.githubusercontent.com/TheHunterSolo1/Scripts/refs/heads/main/Protected_2809220311826785.lua.txt"},
            {Name = "doorsDP汉化脚本", Url = "https://raw.githubusercontent.com/Clover781/m/refs/heads/main/doors-DP-robot"},
            {Name = "doors abysall汉化脚本", Url = "https://raw.githubusercontent.com/atnew2025/Chinese-scripts/refs/heads/main/Abysallcn-hub"},
        }
    },
    {
        GroupName = "监狱生活",
        List = {
            {Name = "监狱生活汉化", Url = "https://raw.githubusercontent.com/fningna51-stack/-/main/%E7%9B%91%E7%8B%B1%E7%94%9F%E6%B4%BB%E8%84%9A%E6%9C%AC"},
        }
    },
    {
        GroupName = "战争大亨",
        List = {
            {Name = "战争大亨最强脚本", Url = "https://raw.githubusercontent.com/MaxPikaa/PureLove/refs/heads/main/520"},
            {Name = "战争大亨无卡密高级脚本", Url = "https://raw.githubusercontent.com/Macintosh1983/ChillHubMain/main/ChillHubOilWarfareTycoon.lua"},
        }
    },
    {
        GroupName = "被遗弃",
        List = {
            {Name = "RINGTA汉化脚本", Url = "https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/RINGTA/forsaken"},
            {Name = "Fart汉化脚本", Url = "https://raw.githubusercontent.com/YirdeX-Dev/China/refs/heads/main/fartsakena"},
            {Name = "访客中心汉化脚本", Url = "https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/fartsaken"},
        }
    },
    {
        GroupName = "俄亥俄州",
        List = {
            {Name = "俄亥俄州自动捡彩蛋脚本", Url = "https://pastebin.com/raw/TrPbSbkm"},
            {Name = "Rb脚本俄亥俄州", Url = "https://raw.githubusercontent.com/Yungengxin/roblox/refs/heads/main/RbHub-OHIO"},
        }
    },
    {
        GroupName = "画我",
        List = {
            {Name = "无卡密画我脚本", Url = "https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/KENNY画我.lua"},
        }
    },
    {
        GroupName = "通缉脚本",
        List = {
            {Name = "SX HUB", Url = "https://api.luarmor.net/files/v3/loaders/87a8a4f4c2d2ef535ccd1bdb949218fe.lua"},
            {Name = "KENNY", Url = "https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/KENNY通缉换服.lua"},
            {Name = "通缉", Url = "https://raw.githubusercontent.com/combatlegnd/combatlegnd/refs/heads/main/NH-Loader"},
        }
    },
    {
        GroupName = "闪光",
        List = {
            {Name = "闪光脚本", Url = "https://apigetunx.vercel.app/UNX.lua"},
            {Name = "闪光脚本(英文)", Url = "https://raw.githubusercontent.com/Jager-Hub/Scripts/refs/heads/main/loader.lua"},
        }
    },
    {
        GroupName = "最坚强的战场",
        List = {
            {Name = "最强战场Phantasm汉化脚本", Url = "https://raw.githubusercontent.com/Clover781/m/refs/heads/main/thestongestbattlegrounds-Phantasm-robot"},
            {Name = "最坚强的战场脚本2", Url = "https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/phantasm.lua"},
            {Name = "最坚强的战场脚本(好用)", Url = "https://eltonshub-loader.netlify.app/UBG1.lua"},
            {Name = "角色扮演搜sans汉化脚本", Url = "https://raw.githubusercontent.com/asdfgh160/Chinese-localization/refs/heads/main/Merebennie"},
            {Name = "Phantasm汉化脚本", Url = "https://raw.githubusercontent.com/asdfgh160/Chinese-localization/refs/heads/main/Phantasm"},
            {Name = "AlanbeikersFF汉化脚本", Url = "https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/AlanbeikersFF"},
            {Name = "Combat汉化脚本", Url = "https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/Combat"},
            {Name = "最坚强的战场open脚本", Url = "https://api.luarmor.net/files/v3/loaders/6f502e252308fb97855295005faa73a0.lua"},
        }
    },
    {
        GroupName = "偷走脑红",
        List = {
            {Name = "偷走脑红脚本", Url = "https://raw.githubusercontent.com/DynaFetchy/Scripts/refs/heads/main/Loader.lua"},
            {Name = "偷走脑红脚本2", Url = "https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/偷走脑红"},
            {Name = "偷走脑红KURD汉化脚本", Url = "https://raw.githubusercontent.com/Clover781/m/refs/heads/main/Brainrot-KURD-robot"},
        }
    },
    {
        GroupName = "竞争对手",
        List = {
            {Name = "竞争对手脚本汉化", Url = "https://raw.githubusercontent.com/fningna51-stack/-/main/竞争对手汉化脚本"},
        }
    },
    {
        GroupName = "chain脚本",
        List = {
            {Name = "chain英文脚本", Url = "https://api.getpolsec.com/scripts/hosted/79fcede2ce14619990c741986e6123ddbc41cd9e4a25c4dc4da13c5f63a25f2b.lua"},
        }
    },
    {
        GroupName = "跳跃对决",
        List = {
            {Name = "跳跃对决脚本", Url = "https://raw.githubusercontent.com/solarastuff/sorryjimpee/refs/heads/main/Jumper.lua"},
        }
    },
    {
        GroupName = "死亡球",
        List = {
            {Name = "死亡球Fluxin汉化脚本(要卡密)", Url = "https://raw.githubusercontent.com/Clover781/m/refs/heads/main/deathball-Fluxin-robot"},
            {Name = "死亡球stark汉化脚本(要卡密)", Url = "https://raw.githubusercontent.com/Clover781/m/refs/heads/main/Deathballs-stark-robot"},
            {Name = "NodeX死亡球", Url = "https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/NodeX%E5%88%80%E5%88%83%E5%89%91.lua"},
            {Name = "Achaotic死亡球", Url = "https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/Achaotic%E5%88%80%E5%88%83%E7%90%83"},
        }
    },
    {
        GroupName = "监狱人生",
        List = {
            {Name = "监狱人生人机汉化脚本", Url = "https://raw.githubusercontent.com/Clover781/m/refs/heads/main/PrisonLife-Serk4rx-robot"},
        }
    },
    {
        GroupName = "逃脱海啸",
        List = {
            {Name = "逃脱海啸并带走红Merqur汉化脚本(要卡密)", Url = "https://raw.githubusercontent.com/Clover781/m/refs/heads/main/EscapeTsunamiForBrinrots-Merqury-robot"},
            {Name = "逃脱海啸并拿走脑红Solix汉化脚本(要卡密)", Url = "https://raw.githubusercontent.com/Clover781/m/refs/heads/main/EscapeTsunamiForBrinrots-Solix-robot"},
        }
    },
    {
        GroupName = "盲射",
        List = {
            {Name = "盲射ToraIsMe汉化脚本", Url = "https://raw.githubusercontent.com/Clover781/m/refs/heads/main/blindshot-ToraIsMe-robot"},
        }
    },
    {
        GroupName = "彩虹朋友",
        List = {
            {Name = "彩虹朋友二UB汉化脚本(要卡密)", Url = "https://raw.githubusercontent.com/Clover781/m/refs/heads/main/RainbowFriends-UB-robot"},
        }
    },
    {
        GroupName = "撕咬之夜",
        List = {
            {Name = "撕咬之夜", Url = "https://raw.githubusercontent.com/Youfutongxiang1/Msploit-v2-CN/refs/heads/main/Msploit-v2-CN"},
            {Name = "殺脚本撕咬之夜", Url = "https://raw.githubusercontent.com/FengYu-X/Max/refs/heads/X/BBN.lua"},
            {Name = "Ringta撕咬之夜(汉化)", Url = "https://raw.githubusercontent.com/Youfutongxiang1/RINGTA-BitebyNight-CN/refs/heads/main/RINGTA/Bite%20by%20Night-CN"},
            {Name = "撕咬之夜", Url = "https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/Cerberus"},
        }
    },
    {
        GroupName = "死刑",
        List = {
            {Name = "死刑脚本(无卡密)", Url = "https://api.luarmor.net/files/v3/loaders/8c08b8f2252eec7dbb77d253d269bb65.lua"},
        }
    },
    {
        GroupName = "活了7天",
        List = {
            {Name = "活了7天刷废料", Url = "https://raw.githubusercontent.com/rndmq/Serverlist/refs/heads/main/Server87"},
            {Name = "活了7天汉化", Url = "https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E4%B8%83%E6%97%A5%E7%94%9F%E6%88%90kkk.txt"},
        }
    },
    {
        GroupName = "终极战场",
        List = {
            {Name = "终极战场脚本", Url = "https://raw.githubusercontent.com/YQANTGV3/YQANTGV3/refs/heads/main/antitamper.txt"},
        }
    },
    {
        GroupName = "餐厅大亨",
        List = {
            {Name = "餐厅大亨脚本(自动解卡无卡密)", Url = "https://rawscripts.net/raw/Universal-Script-Samuraa1-Hub-Best-Keyless-Script-For-EA-ByB-RT3-etc-88197"},
        }
    },
    {
        GroupName = "恐鬼症",
        List = {
            {Name = "恐鬼症脚本", Url = "https://raw.githubusercontent.com/longchneg/GAl/refs/heads/Dragon/%E6%81%90%E9%AC%BC%E7%97%87%20%E5%85%8D%E8%B4%B9%E7%89%88"},
            {Name = "恐鬼症付费脚本(免费用)", Url = "https://raw.githubusercontent.com/fningna51-stack/-/main/%E6%81%90%E9%AC%BC%E7%97%87"},
        }
    },
    {
        GroupName = "力量传奇",
        List = {
            {Name = "Yttrium力量传奇付费脚本(免费用)", Url = "https://raw.githubusercontent.com/fningna51-stack/-/main/%E5%8A%9B%E9%87%8F%E4%BC%A0%E5%A5%87%E8%84%9A%E6%9C%AC"},
        }
    },
    {
        GroupName = "通缉",
        List = {
            {Name = "Yttrium通缉付费脚本(免费用)", Url = "https://raw.githubusercontent.com/fningna51-stack/-/main/%E9%80%9A%E7%BC%89%E8%84%9A%E6%9C%AC%E5%85%8D%E8%B4%B9%E7%89%88"},
        }
    },
    {
        GroupName = "GB内脏与黑火药",
        List = {
            {Name = "GB汉化脚本(需要解卡和AX一样)", Url = "https://raw.githubusercontent.com/fningna51-stack/-/main/AF%20%E7%A7%8B%E5%AE%B9GB"},
        }
    },
    {
        GroupName = "攻击泰坦革命",
        List = {
            {Name = "攻击泰坦革命脚本(英文版)", Url = "https://api.luarmor.net/files/v4/loaders/705e7fe7aa288f0fe86900cedb1119b1.lua"},
        }
    },
    {
        GroupName = "犯罪",
        List = {
            {Name = "犯罪脚本付费版(免费用)", Url = "https://raw.githubusercontent.com/fningna51-stack/-/main/%E7%8A%AF%E7%BD%AA"},
        }
    },
    {
        GroupName = "破坏者谜团",
        List = {
            {Name = "破坏者谜团脚本", Url = "https://pastebin.com/raw/VRwdkSG3"},
            {Name = "Foxname MM2", Url = "https://raw.githubusercontent.com/YIRDEX/China/refs/heads/main/Foxnamemm2.lua"},
        }
    }
}

for _, category in ipairs(ScriptCenter) do
    local targetGroup = ((leftIndex <= rightIndex) and ScriptCenterLeftGroup) or ScriptCenterRightGroup;
    if (((targetGroup == ScriptCenterLeftGroup) and (leftIndex > 0)) or ((targetGroup == ScriptCenterRightGroup) and (rightIndex > 0))) then
        targetGroup:AddLabel("--------------------------------------------------------------------------------");
    end
    targetGroup:AddLabel(category.GroupName);
    for _, btn in ipairs(category.List) do
        targetGroup:AddButton({Text=btn.Name,Func=function()
            local success, err = pcall(function()
                local scriptContent = game:HttpGet(btn.Url);
                local func = loadstring(scriptContent);
                if func then
                    func();
                end
            end);
        end});
    end
    if (targetGroup == ScriptCenterLeftGroup) then
        leftIndex = leftIndex + 1;
    else
        rightIndex = rightIndex + 1;
    end
end

Tabs.ScriptCenter:UpdateWarningBox({
    Title = '脚本信息及<font color=\"rgb(255, 0, 0)\">警告!</font>',
    Text = '可能有些没有完全汉化，\n在一些反作弊系统强的服务器建议执行后立即删除脚本UI',
    IsNormal = true,
    Visible = true,
    LockSize = true,
})

-------------分开-------------
Tabs.Main:UpdateWarningBox({
    Title = '<font color=\"rgb(255, 0, 0)\">警告!</font>',
    Text = '部分功能无法在墨水游戏或者高反作弊系统的游戏下使用,请慎重考虑功能',
    IsNormal = true,
    Visible = true,
    LockSize = true,
})

local LeftGroup = Tabs.Main:AddLeftGroupbox("主要功能（全部可在墨水使用）")
local Cnmb = Tabs.Main:AddLeftGroupbox("通用功能1")
local Tong = Tabs.Main:AddLeftGroupbox("通用功能2")
local Nbcoos = Tabs.Main:AddLeftGroupbox("传送")
local RightGroup = Tabs.Main:AddRightGroupbox("杂项")
local Ksqcnbcos = Tabs.Main:AddRightGroupbox("透视（全部可在墨水使用）")
local Bofang = Tabs.Main:AddRightGroupbox("播放功能")
local Yule = Tabs.Main:AddRightGroupbox("娱乐脚本功能")
local RotationControlGroup = Tabs.Main:AddRightGroupbox("旋转控制")
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
LeftGroup:AddSlider("WalkSpeedSlider", {Text="移动速度(可在墨水使用)",Default=16,Min=16,Max=200,Rounding=0,Compact=false,Callback=function(Value)
        if (A2 and A2.Character) then
                local Humanoid = A2.Character:FindFirstChild("Humanoid");
                if Humanoid then
                        Humanoid.WalkSpeed = Value;
                end
        end
end});
LeftGroup:AddInput("WalkSpeedInput", {Text="移动速度设置",Default="",Placeholder="输入移动速度值",Numeric=true,Finished=false,Callback=function(Value)
        local numValue = tonumber(Value);
        if (numValue and A2 and A2.Character) then
                local Humanoid = A2.Character:FindFirstChild("Humanoid");
                if Humanoid then
                        Humanoid.WalkSpeed = numValue;
                end
        end
end});
LeftGroup:AddButton({Text="无限跳",Func=function()
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

LeftGroup:AddToggle('MyToggle', {
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
LeftGroup:AddSlider('MyIntSlider', {
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
LeftGroup:AddSlider('UltraWideSlider', {
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

LeftGroup:AddToggle("TouchKillToggle", {
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
LeftGroup:AddToggle('AntiFlingToggle', {
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
LeftGroup:AddCheckbox("ESP", {
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
LeftGroup:AddButton({Text="墨水飞行",Func=function()
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

RightGroup:AddButton({
    Text = "HSX卡密",
    Func = function()
        local demoKey = "HSX-7562-3194-0835-4981-2470-1488-1029-6967"
        if setclipboard then
            setclipboard(demoKey)
        end
    end
})
RightGroup:AddButton({Text="柳叶碰飞(墨水可以使用)",Func=function()
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
RightGroup:AddButton({Text="TX全自动翻译",Func=function()
        TX = "TX Script"
Script = "全自动翻译"
loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/Item/refs/heads/main/Auto-language"))()
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
RightGroup:AddButton({Text="TX死铁轨全自动刷债券",Func=function()
        TX = "TX Script"
Script = "TX自动刷债券V4"
loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/Item/refs/heads/main/Auto-Bond-V4"))()
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
RightGroup:AddButton({Text="SX翻译",Func=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SQ182/y/refs/heads/main/翻译.lua"))()
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
RightGroup:AddButton({Text="音乐播放器脚本",Func=function()
        loadstring(game:HttpGet("http://music.567099.xyz/music.php"))()
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
RightGroup:AddButton({Text="秋辞音乐播放器(正在开发)",Func=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fningna51-stack/-/main/%E7%A7%8B%E8%BE%9E%E7%BA%AF%E6%9C%8D%E5%8A%A1%E5%99%A8%E8%84%9A%E6%9C%AC"))()
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
Ksqcnbcos:AddToggle('ESPToggle', {
    Text = '方框透视',
    Default = false,
    Tooltip = '显示玩家方框 ESP',
    Callback = function(Value)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local Camera = workspace.CurrentCamera
        local LocalPlayer = Players.LocalPlayer

        if Value then
            if getgenv().cyberline_esp_boxes then
                for _, v in pairs(getgenv().cyberline_esp_boxes) do
                    pcall(function() v.box:Remove() end)
                    pcall(function() v.outline:Remove() end)
                end
            end
            getgenv().cyberline_esp_boxes = {}

            local function create_box()
                local outline = Drawing.new("Square")
                outline.Color = Color3.new(0, 0, 0)
                outline.Thickness = 1
                outline.Filled = false
                outline.Visible = false

                local box = Drawing.new("Square")
                box.Color = Color3.fromRGB(255, 255, 255)
                box.Thickness = 1
                box.Filled = false
                box.Visible = false

                return { box = box, outline = outline }
            end

            local function get_bounds(char)
                local min = Vector3.new(1e9, 1e9, 1e9)
                local max = Vector3.new(-1e9, -1e9, -1e9)
                for _, p in char:GetDescendants() do
                    if p:IsA("BasePart") then
                        local pos = p.Position
                        min = Vector3.new(
                            math.min(min.X, pos.X),
                            math.min(min.Y, pos.Y),
                            math.min(min.Z, pos.Z)
                        )
                        max = Vector3.new(
                            math.max(max.X, pos.X),
                            math.max(max.Y, pos.Y),
                            math.max(max.Z, pos.Z)
                        )
                    end
                end
                return min, max
            end

            getgenv().cyberline_esp_conn = RunService.RenderStepped:Connect(function()
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer
                        and plr.Character
                        and plr.Character:FindFirstChild("HumanoidRootPart") then

                        local min, max = get_bounds(plr.Character)
                        local points = {
                            Vector3.new(min.X, min.Y, min.Z),
                            Vector3.new(min.X, max.Y, min.Z),
                            Vector3.new(max.X, min.Y, min.Z),
                            Vector3.new(max.X, max.Y, min.Z),
                            Vector3.new(min.X, min.Y, max.Z),
                            Vector3.new(min.X, max.Y, max.Z),
                            Vector3.new(max.X, min.Y, max.Z),
                            Vector3.new(max.X, max.Y, max.Z),
                        }

                        local min2d = Vector2.new(1e9, 1e9)
                        local max2d = Vector2.new(-1e9, -1e9)
                        local visible = false

                        for _, pt in ipairs(points) do
                            local screen, onScreen = Camera:WorldToViewportPoint(pt)
                            if onScreen then
                                visible = true
                                min2d = Vector2.new(
                                    math.min(min2d.X, screen.X),
                                    math.min(min2d.Y, screen.Y)
                                )
                                max2d = Vector2.new(
                                    math.max(max2d.X, screen.X),
                                    math.max(max2d.Y, screen.Y)
                                )
                            end
                        end

                        if not getgenv().cyberline_esp_boxes[plr] then
                            getgenv().cyberline_esp_boxes[plr] = create_box()
                        end

                        local b = getgenv().cyberline_esp_boxes[plr]
                        if visible then
                            local size = max2d - min2d
                            b.box.Position = min2d
                            b.box.Size = size
                            b.box.Visible = true

                            b.outline.Position = min2d - Vector2.new(1, 1)
                            b.outline.Size = size + Vector2.new(2, 2)
                            b.outline.Visible = true
                        else
                            b.box.Visible = false
                            b.outline.Visible = false
                        end
                    end
                end
            end)

            Library:Notify("方框透视 已开启", 2)
        else
            if getgenv().cyberline_esp_conn then
                getgenv().cyberline_esp_conn:Disconnect()
            end
            if getgenv().cyberline_esp_boxes then
                for _, v in pairs(getgenv().cyberline_esp_boxes) do
                    pcall(function() v.box:Remove() end)
                    pcall(function() v.outline:Remove() end)
                end
            end
            getgenv().cyberline_esp_boxes = nil
            Library:Notify("方框透视 已关闭", 2)
        end
    end
})
getgenv().cyberline_chams = {}
getgenv().cyberline_chams_conn = nil
getgenv().cyberline_chams_color = Color3.fromRGB(255, 255, 255)

Ksqcnbcos:AddToggle('ChamsToggle', {
    Text = '人物透视',
    Default = false,
    Tooltip = '显示玩家模型高亮透视',
    Callback = function(Value)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local LocalPlayer = Players.LocalPlayer

        if Value then
            if getgenv().cyberline_chams then
                for _, hl in pairs(getgenv().cyberline_chams) do
                    pcall(function() hl:Destroy() end)
                end
            end
            getgenv().cyberline_chams = {}

            getgenv().cyberline_chams_conn = RunService.RenderStepped:Connect(function()
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer
                        and plr.Character
                        and not getgenv().cyberline_chams[plr] then

                        local highlight = Instance.new("Highlight")
                        highlight.Name = "CyberlineChams"
                        highlight.FillColor = getgenv().cyberline_chams_color
                        highlight.OutlineColor = Color3.new(0, 0, 0)
                        highlight.FillTransparency = 0.8
                        highlight.OutlineTransparency = 1
                        highlight.Adornee = plr.Character
                        highlight.Parent = game.CoreGui

                        getgenv().cyberline_chams[plr] = highlight
                    end
                end
            end)

            Library:Notify("人物透视 已开启", 2)
        else
            if getgenv().cyberline_chams_conn then
                getgenv().cyberline_chams_conn:Disconnect()
            end
            if getgenv().cyberline_chams then
                for _, hl in pairs(getgenv().cyberline_chams) do
                    pcall(function() hl:Destroy() end)
                end
            end
            getgenv().cyberline_chams = nil
            Library:Notify("人物透视 已关闭", 2)
        end
    end
}):AddColorPicker('ChamsColorPicker', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = '透视颜色',
    Transparency = 0,
    Callback = function(Value)
        getgenv().cyberline_chams_color = Value

        if getgenv().cyberline_chams then
            for _, hl in pairs(getgenv().cyberline_chams) do
                if hl and hl:IsA("Highlight") then
                    hl.FillColor = Value
                end
            end
        end
    end
})
Ksqcnbcos:AddToggle('NameESPToggle', {
    Text = '名字透视',
    Default = false,
    Tooltip = '显示玩家头顶名字',
    Callback = function(Value)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local Camera = workspace.CurrentCamera
        local LocalPlayer = Players.LocalPlayer

        if Value then
            if getgenv().cyberline_name_esp then
                for _, txt in pairs(getgenv().cyberline_name_esp) do
                    pcall(function() txt:Remove() end)
                end
            end
            getgenv().cyberline_name_esp = {}

            local function create_name_label()
                local text = Drawing.new("Text")
                text.Size = 12
                text.Center = true
                text.Outline = true
                text.Font = 2 -- Inconsolata
                text.Color = Color3.fromRGB(255, 255, 255)
                text.Visible = false
                return text
            end

            getgenv().cyberline_name_esp_conn = RunService.RenderStepped:Connect(function()
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer
                        and plr.Character
                        and plr.Character:FindFirstChild("Head") then

                        local head = plr.Character.Head
                        local screenPos, onScreen =
                            Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1.8, 0))

                        if not getgenv().cyberline_name_esp[plr] then
                            getgenv().cyberline_name_esp[plr] = create_name_label()
                        end

                        local text = getgenv().cyberline_name_esp[plr]

                        if onScreen then
                            text.Position = Vector2.new(screenPos.X, screenPos.Y)
                            text.Text = plr.Name
                            text.Visible = true
                        else
                            text.Visible = false
                        end
                    elseif getgenv().cyberline_name_esp[plr] then
                        getgenv().cyberline_name_esp[plr].Visible = false
                    end
                end
            end)

            Library:Notify("名字透视 已开启", 2)
        else
            if getgenv().cyberline_name_esp_conn then
                getgenv().cyberline_name_esp_conn:Disconnect()
            end
            if getgenv().cyberline_name_esp then
                for _, txt in pairs(getgenv().cyberline_name_esp) do
                    pcall(function() txt:Remove() end)
                end
            end
            getgenv().cyberline_name_esp = nil
            Library:Notify("名字透视 已关闭", 2)
        end
    end
})
Ksqcnbcos:AddToggle('HealthBarToggle', {
    Text = '血量条透视',
    Default = false,
    Tooltip = '显示玩家血量条',
    Callback = function(Value)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local Camera = workspace.CurrentCamera
        local LocalPlayer = Players.LocalPlayer

        if Value then
            if getgenv().cyberline_health_bars then
                for _, v in pairs(getgenv().cyberline_health_bars) do
                    pcall(function() v.bar:Remove() end)
                    pcall(function() v.outline:Remove() end)
                end
            end
            getgenv().cyberline_health_bars = {}

            local function create_bar()
                local outline = Drawing.new("Square")
                outline.Color = Color3.new(0, 0, 0)
                outline.Filled = true
                outline.Transparency = 1
                outline.Visible = false

                local bar = Drawing.new("Square")
                bar.Color = Color3.fromRGB(0, 255, 0)
                bar.Filled = true
                bar.Transparency = 1
                bar.Visible = false

                return { bar = bar, outline = outline }
            end

            local function get_bounds(char)
                local min = Vector3.new(1e9, 1e9, 1e9)
                local max = Vector3.new(-1e9, -1e9, -1e9)
                for _, p in char:GetDescendants() do
                    if p:IsA("BasePart") then
                        local pos = p.Position
                        min = Vector3.new(
                            math.min(min.X, pos.X),
                            math.min(min.Y, pos.Y),
                            math.min(min.Z, pos.Z)
                        )
                        max = Vector3.new(
                            math.max(max.X, pos.X),
                            math.max(max.Y, pos.Y),
                            math.max(max.Z, pos.Z)
                        )
                    end
                end
                return min, max
            end

            getgenv().cyberline_health_bar_conn = RunService.RenderStepped:Connect(function()
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer
                        and plr.Character
                        and plr.Character:FindFirstChild("HumanoidRootPart") then

                        local humanoid = plr.Character:FindFirstChildWhichIsA("Humanoid")
                        if humanoid then
                            local min, max = get_bounds(plr.Character)
                            local points = {
                                Vector3.new(min.X, min.Y, min.Z),
                                Vector3.new(min.X, max.Y, min.Z),
                                Vector3.new(max.X, min.Y, min.Z),
                                Vector3.new(max.X, max.Y, min.Z),
                                Vector3.new(min.X, min.Y, max.Z),
                                Vector3.new(min.X, max.Y, max.Z),
                                Vector3.new(max.X, min.Y, max.Z),
                                Vector3.new(max.X, max.Y, max.Z),
                            }

                            local min2d = Vector2.new(1e9, 1e9)
                            local max2d = Vector2.new(-1e9, -1e9)
                            local visible = false

                            for _, pt in ipairs(points) do
                                local screen, onScreen = Camera:WorldToViewportPoint(pt)
                                if onScreen then
                                    visible = true
                                    min2d = Vector2.new(
                                        math.min(min2d.X, screen.X),
                                        math.min(min2d.Y, screen.Y)
                                    )
                                    max2d = Vector2.new(
                                        math.max(max2d.X, screen.X),
                                        math.max(max2d.Y, screen.Y)
                                    )
                                end
                            end

                            if not getgenv().cyberline_health_bars[plr] then
                                getgenv().cyberline_health_bars[plr] = create_bar()
                            end

                            local bar = getgenv().cyberline_health_bars[plr].bar
                            local outline = getgenv().cyberline_health_bars[plr].outline

                            if visible then
                                local height = max2d.Y - min2d.Y
                                local ratio = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                                local barHeight = height * ratio

                                bar.Size = Vector2.new(2, barHeight)
                                bar.Position = Vector2.new(min2d.X - 5, max2d.Y - barHeight)
                                bar.Visible = true

                                outline.Size = Vector2.new(4, height + 2)
                                outline.Position = Vector2.new(min2d.X - 6, min2d.Y - 1)
                                outline.Visible = true
                            else
                                bar.Visible = false
                                outline.Visible = false
                            end
                        end
                    elseif getgenv().cyberline_health_bars[plr] then
                        getgenv().cyberline_health_bars[plr].bar.Visible = false
                        getgenv().cyberline_health_bars[plr].outline.Visible = false
                    end
                end
            end)

            Library:Notify("血量条透视 已开启", 2)
        else
            if getgenv().cyberline_health_bar_conn then
                getgenv().cyberline_health_bar_conn:Disconnect()
            end
            if getgenv().cyberline_health_bars then
                for _, v in pairs(getgenv().cyberline_health_bars) do
                    pcall(function() v.bar:Remove() end)
                    pcall(function() v.outline:Remove() end)
                end
            end
            getgenv().cyberline_health_bars = nil
            Library:Notify("血量条透视 已关闭", 2)
        end
    end
})
Ksqcnbcos:AddToggle('SkeletonToggle', {
    Text = '骨骼透视',
    Default = false,
    Tooltip = '显示玩家骨骼线条',
    Callback = function(Value)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local Camera = workspace.CurrentCamera
        local LocalPlayer = Players.LocalPlayer

        if Value then
            if getgenv().cyberline_skeleton then
                for _, skel in pairs(getgenv().cyberline_skeleton) do
                    for _, line in pairs(skel) do
                        pcall(function() line:Remove() end)
                    end
                end
            end
            getgenv().cyberline_skeleton = {}

            local function create_line()
                local line = Drawing.new("Line")
                line.Color = Color3.new(1, 1, 1)
                line.Thickness = 1
                line.Transparency = 1
                line.Visible = false
                return line
            end

            local function create_skeleton()
                return {
                    head = create_line(),
                    torso = create_line(),
                    left_arm = create_line(),
                    right_arm = create_line(),
                    left_leg = create_line(),
                    right_leg = create_line()
                }
            end

            getgenv().cyberline_skeleton_conn = RunService.RenderStepped:Connect(function()
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character then
                        local char = plr.Character

                        local parts = {
                            head = char:FindFirstChild("Head"),
                            upper = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso"),
                            lower = char:FindFirstChild("LowerTorso") or char:FindFirstChild("HumanoidRootPart"),
                            left_arm = char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm"),
                            right_arm = char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm"),
                            left_leg = char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg"),
                            right_leg = char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg"),
                        }

                        if not getgenv().cyberline_skeleton[plr] then
                            getgenv().cyberline_skeleton[plr] = create_skeleton()
                        end

                        local skel = getgenv().cyberline_skeleton[plr]

                        local function to_screen(part)
                            local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                            return Vector2.new(pos.X, pos.Y), onScreen
                        end

                        local allVisible = true
                        for _, part in pairs(parts) do
                            if not part then
                                allVisible = false
                                break
                            end
                        end

                        if allVisible then
                            local head_pos = to_screen(parts.head)
                            local upper_pos = to_screen(parts.upper)
                            local lower_pos = to_screen(parts.lower)
                            local larm_pos = to_screen(parts.left_arm)
                            local rarm_pos = to_screen(parts.right_arm)
                            local lleg_pos = to_screen(parts.left_leg)
                            local rleg_pos = to_screen(parts.right_leg)

                            skel.head.From = head_pos
                            skel.head.To = upper_pos

                            skel.torso.From = upper_pos
                            skel.torso.To = lower_pos

                            skel.left_arm.From = upper_pos
                            skel.left_arm.To = larm_pos

                            skel.right_arm.From = upper_pos
                            skel.right_arm.To = rarm_pos

                            skel.left_leg.From = lower_pos
                            skel.left_leg.To = lleg_pos

                            skel.right_leg.From = lower_pos
                            skel.right_leg.To = rleg_pos

                            for _, line in pairs(skel) do
                                line.Visible = true
                            end
                        else
                            for _, line in pairs(skel) do
                                line.Visible = false
                            end
                        end
                    elseif getgenv().cyberline_skeleton[plr] then
                        for _, line in pairs(getgenv().cyberline_skeleton[plr]) do
                            line.Visible = false
                        end
                    end
                end
            end)

            Library:Notify("骨骼透视 已开启", 2)
        else
            if getgenv().cyberline_skeleton_conn then
                getgenv().cyberline_skeleton_conn:Disconnect()
            end
            if getgenv().cyberline_skeleton then
                for _, skel in pairs(getgenv().cyberline_skeleton) do
                    for _, line in pairs(skel) do
                        pcall(function() line:Remove() end)
                    end
                end
            end
            getgenv().cyberline_skeleton = nil
            Library:Notify("骨骼透视 已关闭", 2)
        end
    end
})
Ksqcnbcos:AddToggle('TracerToggle', {
    Text = '射线透视',
    Default = false,
    Tooltip = '从屏幕顶部指向玩家',
    Callback = function(Value)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local Camera = workspace.CurrentCamera
        local LocalPlayer = Players.LocalPlayer

        if Value then
            -- 清理旧 Tracers
            if getgenv().cyberline_tracers then
                for _, line in pairs(getgenv().cyberline_tracers) do
                    pcall(function() line:Remove() end)
                end
            end
            getgenv().cyberline_tracers = {}

            local function create_tracer()
                local line = Drawing.new("Line")
                line.Color = Color3.fromRGB(255, 255, 255)
                line.Thickness = 1
                line.Transparency = 1
                line.Visible = false
                return line
            end

            getgenv().cyberline_tracer_conn = RunService.RenderStepped:Connect(function()
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer
                        and plr.Character
                        and plr.Character:FindFirstChild("HumanoidRootPart") then

                        local root = plr.Character.HumanoidRootPart
                        local screenPos, onScreen =
                            Camera:WorldToViewportPoint(root.Position)

                        if not getgenv().cyberline_tracers[plr] then
                            getgenv().cyberline_tracers[plr] = create_tracer()
                        end

                        local tracer = getgenv().cyberline_tracers[plr]

                        if onScreen then
                            tracer.From = Vector2.new(
                                Camera.ViewportSize.X / 2,
                                0
                            )
                            tracer.To = Vector2.new(screenPos.X, screenPos.Y)
                            tracer.Visible = true
                        else
                            tracer.Visible = false
                        end
                    elseif getgenv().cyberline_tracers[plr] then
                        getgenv().cyberline_tracers[plr].Visible = false
                    end
                end
            end)

            Library:Notify("射线透视 已开启", 2)
        else
            if getgenv().cyberline_tracer_conn then
                getgenv().cyberline_tracer_conn:Disconnect()
            end
            if getgenv().cyberline_tracers then
                for _, line in pairs(getgenv().cyberline_tracers) do
                    pcall(function() line:Remove() end)
                end
            end
            getgenv().cyberline_tracers = nil
            Library:Notify("射线透视 已关闭", 2)
        end
    end
})
Bofang:AddButton({
	Text = "点击播放雨爱",
	Func = function()
		local soundId = "rbxassetid://79277371759525"
		local Workspace = game:GetService("Workspace")

		local sound = Instance.new("Sound")
		sound.SoundId = soundId
		sound.Looped = false
		sound.Volume = 0.5
		sound.Parent = Workspace
		sound:Play()

		sound.Ended:Connect(function()
			sound:Destroy()
			warn("音效已播放完毕并销毁")
		end)

		task.delay(10, function()
			if sound and sound.Parent and not sound.IsPlaying then
				sound:Destroy()
				warn("音效加载超时/未播放，已自动销毁")
			end
		end)

		Library:Notify("正在播放音效...", 2)
	end,
	DoubleClick = false
})
Bofang:AddButton({
	Text = "停止播放雨爱",
	Func = function()
		local Workspace = game:GetService("Workspace")

		local targetSoundId = "rbxassetid://79277371759525"
		local found = false

		for _, sound in ipairs(Workspace:GetDescendants()) do
			if sound:IsA("Sound") and sound.SoundId == targetSoundId then
				sound:Stop()
				sound:Destroy()
				found = true
			end
		end

		if found then
			Library:Notify("已停止播放青衣", 2)
			warn("青衣音效已停止并销毁")
		else
			Library:Notify("没有找到正在播放的青衣音效", 2)
			warn("未找到对应 SoundId 的音效")
		end
	end,
	DoubleClick = false
})
Bofang:AddButton({
	Text = "点击播放将军😭😭",
	Func = function()
		local soundId = "rbxassetid://117061993775129"
		local Workspace = game:GetService("Workspace")

		local sound = Instance.new("Sound")
		sound.SoundId = soundId
		sound.Looped = false
		sound.Volume = 0.5
		sound.Parent = Workspace
		sound:Play()

		sound.Ended:Connect(function()
			sound:Destroy()
			warn("音效已播放完毕并销毁")
		end)

		task.delay(10, function()
			if sound and sound.Parent and not sound.IsPlaying then
				sound:Destroy()
				warn("音效加载超时/未播放，已自动销毁")
			end
		end)

		Library:Notify("正在播放音效...", 2)
	end,
	DoubleClick = false
})
Bofang:AddButton({
	Text = "停止播放将军😭😭",
	Func = function()
		local Workspace = game:GetService("Workspace")

		local targetSoundId = "rbxassetid://117061993775129"
		local found = false

		for _, sound in ipairs(Workspace:GetDescendants()) do
			if sound:IsA("Sound") and sound.SoundId == targetSoundId then
				sound:Stop()
				sound:Destroy()
				found = true
			end
		end

		if found then
			Library:Notify("已停止播放青衣", 2)
			warn("青衣音效已停止并销毁")
		else
			Library:Notify("没有找到正在播放的青衣音效", 2)
			warn("未找到对应 SoundId 的音效")
		end
	end,
	DoubleClick = false
})
Bofang:AddButton({
	Text = "lQOO进行曲",
	Func = function()
		local soundId = "rbxassetid://109693244185458"
		local Workspace = game:GetService("Workspace")

		local sound = Instance.new("Sound")
		sound.SoundId = soundId
		sound.Looped = false
		sound.Volume = 0.5
		sound.Parent = Workspace
		sound:Play()

		sound.Ended:Connect(function()
			sound:Destroy()
			warn("音效已播放完毕并销毁")
		end)

		task.delay(10, function()
			if sound and sound.Parent and not sound.IsPlaying then
				sound:Destroy()
				warn("音效加载超时/未播放，已自动销毁")
			end
		end)

		Library:Notify("正在播放音效...", 2)
	end,
	DoubleClick = false
})
Bofang:AddButton({
	Text = "停止播放lQOO进行曲",
	Func = function()
		local Workspace = game:GetService("Workspace")

		local targetSoundId = "rbxassetid://109693244185458"
		local found = false

		for _, sound in ipairs(Workspace:GetDescendants()) do
			if sound:IsA("Sound") and sound.SoundId == targetSoundId then
				sound:Stop()
				sound:Destroy()
				found = true
			end
		end

		if found then
			Library:Notify("已停止播放青衣", 2)
			warn("青衣音效已停止并销毁")
		else
			Library:Notify("没有找到正在播放的青衣音效", 2)
			warn("未找到对应 SoundId 的音效")
		end
	end,
	DoubleClick = false
})
Bofang:AddButton({
	Text = "不值得",
	Func = function()
		local soundId = "rbxassetid://131649148795563"
		local Workspace = game:GetService("Workspace")

		local sound = Instance.new("Sound")
		sound.SoundId = soundId
		sound.Looped = false
		sound.Volume = 0.5
		sound.Parent = Workspace
		sound:Play()

		sound.Ended:Connect(function()
			sound:Destroy()
			warn("音效已播放完毕并销毁")
		end)

		task.delay(10, function()
			if sound and sound.Parent and not sound.IsPlaying then
				sound:Destroy()
				warn("音效加载超时/未播放，已自动销毁")
			end
		end)

		Library:Notify("正在播放音效...", 2)
	end,
	DoubleClick = false
})
Bofang:AddButton({
	Text = "停止播放不值得",
	Func = function()
		local Workspace = game:GetService("Workspace")

		local targetSoundId = "rbxassetid://131649148795563"
		local found = false

		for _, sound in ipairs(Workspace:GetDescendants()) do
			if sound:IsA("Sound") and sound.SoundId == targetSoundId then
				sound:Stop()
				sound:Destroy()
				found = true
			end
		end

		if found then
			Library:Notify("已停止播放青衣", 2)
			warn("青衣音效已停止并销毁")
		else
			Library:Notify("没有找到正在播放的青衣音效", 2)
			warn("未找到对应 SoundId 的音效")
		end
	end,
	DoubleClick = false
})
Bofang:AddButton({
	Text = "山楂树之恋",
	Func = function()
		local soundId = "rbxassetid://114372452919028"
		local Workspace = game:GetService("Workspace")

		local sound = Instance.new("Sound")
		sound.SoundId = soundId
		sound.Looped = false
		sound.Volume = 0.5
		sound.Parent = Workspace
		sound:Play()

		sound.Ended:Connect(function()
			sound:Destroy()
			warn("音效已播放完毕并销毁")
		end)

		task.delay(10, function()
			if sound and sound.Parent and not sound.IsPlaying then
				sound:Destroy()
				warn("音效加载超时/未播放，已自动销毁")
			end
		end)

		Library:Notify("正在播放音效...", 2)
	end,
	DoubleClick = false
})
Bofang:AddButton({
	Text = "停止播放山楂树之恋",
	Func = function()
		local Workspace = game:GetService("Workspace")

		local targetSoundId = "rbxassetid://114372452919028"
		local found = false

		for _, sound in ipairs(Workspace:GetDescendants()) do
			if sound:IsA("Sound") and sound.SoundId == targetSoundId then
				sound:Stop()
				sound:Destroy()
				found = true
			end
		end

		if found then
			Library:Notify("已停止播放青衣", 2)
			warn("青衣音效已停止并销毁")
		else
			Library:Notify("没有找到正在播放的青衣音效", 2)
			warn("未找到对应 SoundId 的音效")
		end
	end,
	DoubleClick = false
})
Bofang:AddButton({
	Text = "银河奥特曼主题曲",
	Func = function()
		local soundId = "rbxassetid://91550314012338"
		local Workspace = game:GetService("Workspace")

		local sound = Instance.new("Sound")
		sound.SoundId = soundId
		sound.Looped = false
		sound.Volume = 0.5
		sound.Parent = Workspace
		sound:Play()

		sound.Ended:Connect(function()
			sound:Destroy()
			warn("音效已播放完毕并销毁")
		end)

		task.delay(10, function()
			if sound and sound.Parent and not sound.IsPlaying then
				sound:Destroy()
				warn("音效加载超时/未播放，已自动销毁")
			end
		end)

		Library:Notify("正在播放音效...", 2)
	end,
	DoubleClick = false
})
Bofang:AddButton({
	Text = "停止播放银河奥特曼主题曲",
	Func = function()
		local Workspace = game:GetService("Workspace")

		local targetSoundId = "rbxassetid://91550314012338"
		local found = false

		for _, sound in ipairs(Workspace:GetDescendants()) do
			if sound:IsA("Sound") and sound.SoundId == targetSoundId then
				sound:Stop()
				sound:Destroy()
				found = true
			end
		end

		if found then
			Library:Notify("已停止播放青衣", 2)
			warn("青衣音效已停止并销毁")
		else
			Library:Notify("没有找到正在播放的青衣音效", 2)
			warn("未找到对应 SoundId 的音效")
		end
	end,
	DoubleClick = false
})
Bofang:AddButton({
	Text = "纯DJ",
	Func = function()
		local soundId = "rbxassetid://99498025749186"
		local Workspace = game:GetService("Workspace")

		local sound = Instance.new("Sound")
		sound.SoundId = soundId
		sound.Looped = false
		sound.Volume = 0.5
		sound.Parent = Workspace
		sound:Play()

		sound.Ended:Connect(function()
			sound:Destroy()
			warn("音效已播放完毕并销毁")
		end)

		task.delay(10, function()
			if sound and sound.Parent and not sound.IsPlaying then
				sound:Destroy()
				warn("音效加载超时/未播放，已自动销毁")
			end
		end)

		Library:Notify("正在播放音效...", 2)
	end,
	DoubleClick = false
})
Bofang:AddButton({
	Text = "停止播放银纯DJ",
	Func = function()
		local Workspace = game:GetService("Workspace")

		local targetSoundId = "rbxassetid://99498025749186"
		local found = false

		for _, sound in ipairs(Workspace:GetDescendants()) do
			if sound:IsA("Sound") and sound.SoundId == targetSoundId then
				sound:Stop()
				sound:Destroy()
				found = true
			end
		end

		if found then
			Library:Notify("已停止播放青衣", 2)
			warn("青衣音效已停止并销毁")
		else
			Library:Notify("没有找到正在播放的青衣音效", 2)
			warn("未找到对应 SoundId 的音效")
		end
	end,
	DoubleClick = false
})
Yule:AddLabel("柳宗权同款撸屌脚本(不能在墨水使用)");
Yule:AddButton({Text="撸屌R6",Func=function()
        loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
Yule:AddButton({Text="撸屌R15",Func=function()
        loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
Yule:AddLabel("动作类");
Yule:AddButton({Text="飞踢脚本",Func=function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fe-DropKick-Script-165813"))()
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
Yule:AddButton({Text="VR脚本",Func=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/Qwerty/refs/heads/main/qwerty45.lua"))()
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
Yule:AddButton({Text="4000种动作脚本",Func=function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-7yd7-I-Emote-Script-48024"))()
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
Yule:AddLabel("飞行类");
Yule:AddButton({Text="无敌少侠飞行脚本",Func=function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))()
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
Yule:AddButton({Text="联邦GUI飞行脚本",Func=function()
        local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local old = LocalPlayer.PlayerGui:FindFirstChild("ClimateV11_Fixed")
if old then old:Destroy() end

local sg = Instance.new("ScreenGui")
sg.Name = "ClimateV11_Fixed"
sg.Parent = LocalPlayer:WaitForChild("PlayerGui")
sg.ZIndexBehavior = Enum.ZIndexBehavior.Global
sg.ResetOnSpawn = false

local isFlying = false
local flySpeed = 1
local walkSpeedMult = 1
local bg, bv

local Logo = Instance.new("TextButton")
Logo.Parent = sg
Logo.Size = UDim2.new(0, 45, 0, 45)
Logo.Position = UDim2.new(0.05, 0, 0.4, 0)
Logo.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
Logo.Text = "Fly"
Logo.TextColor3 = Color3.new(0,0,0)
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 20
Logo.Visible = false
Logo.ZIndex = 50
Instance.new("UICorner", Logo).CornerRadius = UDim.new(1, 0)
Logo.Draggable = true
Logo.Active = true
Logo.Selectable = true

local MainFrame = Instance.new("Frame")
MainFrame.Parent = sg
MainFrame.Size = UDim2.new(0, 190, 0, 260)
MainFrame.Position = UDim2.new(0.5, -95, 0.4, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 127)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Selectable = true
MainFrame.ZIndex = 5
MainFrame.ClipsDescendants = true

local TopBar = Instance.new("Frame")
TopBar.Parent = MainFrame
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TopBar.BorderSizePixel = 0
TopBar.ZIndex = 15
TopBar.Active = true
TopBar.Selectable = true

local function makeDraggable(dragBar, targetFrame)
    local dragging = false
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        targetFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    dragBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = targetFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    RunService.RenderStepped:Connect(function()
        if dragging and dragInput then
            update(dragInput)
        end
    end)
end

makeDraggable(TopBar, MainFrame)
makeDraggable(Logo, Logo)

local Watermark = Instance.new("TextLabel")
Watermark.Parent = MainFrame
Watermark.Size = UDim2.new(1, 0, 0, 20)
Watermark.Position = UDim2.new(0, 0, 0, 35)
Watermark.BackgroundTransparency = 1
Watermark.Text = "FLY GUI by Trash"
Watermark.TextColor3 = Color3.fromRGB(0, 255, 127)
Watermark.TextSize = 14
Watermark.Font = Enum.Font.GothamBold
Watermark.ZIndex = 10

local QQGroup = Instance.new("TextLabel")
QQGroup.Parent = MainFrame
QQGroup.Size = UDim2.new(1, 0, 0, 16)
QQGroup.Position = UDim2.new(0, 0, 0, 52)
QQGroup.BackgroundTransparency = 1
QQGroup.Text = "QQ群: 1082973754"
QQGroup.TextColor3 = Color3.fromRGB(255, 255, 255)
QQGroup.TextSize = 10
QQGroup.Font = Enum.Font.Gotham
QQGroup.ZIndex = 10

local function createTab(name, pos, txt)
    local t = Instance.new("TextButton")
    t.Size = UDim2.new(0.4, 0, 0, 35)
    t.Position = pos
    t.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    t.Text = txt
    t.TextColor3 = Color3.new(1,1,1)
    t.Font = Enum.Font.GothamBold
    t.Parent = MainFrame
    t.ZIndex = 20 
    t.Active = true
    t.Selectable = true
    return t
end

local TabFly = createTab("T1", UDim2.new(0,0,0,0), "飞行")
local TabPlayer = createTab("T2", UDim2.new(0.4,0,0,0), "玩家")
local Mini = Instance.new("TextButton", MainFrame)
Mini.Size = UDim2.new(0, 38, 0, 35)
Mini.Position = UDim2.new(0.8, 0, 0, 0)
Mini.BackgroundTransparency = 1
Mini.Text = "_"
Mini.TextColor3 = Color3.new(1,1,1)
Mini.TextSize = 20
Mini.ZIndex = 20
Mini.Active = true
Mini.Selectable = true

local function createScrollPage(name)
    local s = Instance.new("ScrollingFrame")
    s.Name = name
    s.Size = UDim2.new(1, 0, 1, -75)
    s.Position = UDim2.new(0, 0, 0, 75)
    s.BackgroundTransparency = 1
    s.BorderSizePixel = 0
    s.ScrollBarThickness = 2
    s.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 127)
    s.CanvasSize = UDim2.new(0, 0, 0, 280)
    s.ZIndex = 6
    s.Visible = false
    s.Parent = MainFrame
    s.Active = true
    s.Selectable = true
    return s
end

local PageFly = createScrollPage("PageFly")
PageFly.Visible = true
local PagePlayer = createScrollPage("PagePlayer")

local function addBtn(parent, txt, y, color)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.9, 0, 0, 35)
    b.Position = UDim2.new(0.05, 0, 0, y)
    b.BackgroundColor3 = color or Color3.fromRGB(45, 45, 45)
    b.Text = txt
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.Parent = parent
    b.ZIndex = 8
    b.Active = true
    b.Selectable = true
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
    return b
end

local FlyBtn = addBtn(PageFly, "开启飞行", 10, Color3.fromRGB(0, 100, 50))
local SpeedLab = Instance.new("TextLabel", PageFly)
SpeedLab.Size = UDim2.new(1, 0, 0, 20)
SpeedLab.Position = UDim2.new(0, 0, 0, 50)
SpeedLab.Text = "飞行速度: 1"
SpeedLab.TextColor3 = Color3.new(1,1,0)
SpeedLab.BackgroundTransparency = 1
SpeedLab.ZIndex = 8
SpeedLab.Active = false

local FlyPlus = addBtn(PageFly, "增加速度 (+)", 75)
local FlyMinus = addBtn(PageFly, "减少速度 (-)", 115)

local SpeedLab2 = Instance.new("TextLabel", PagePlayer)
SpeedLab2.Size = UDim2.new(1, 0, 0, 25)
SpeedLab2.Position = UDim2.new(0, 0, 0, 10)
SpeedLab2.Text = "跑步加速倍率: 1"
SpeedLab2.TextColor3 = Color3.new(1,1,0)
SpeedLab2.BackgroundTransparency = 1
SpeedLab2.ZIndex = 8
SpeedLab2.Active = false

local WSPlus = addBtn(PagePlayer, "增加跑步速度", 40)
local WSMinus = addBtn(PagePlayer, "减少跑步速度", 80)
local ResetWS = addBtn(PagePlayer, "重置人物速度", 120, Color3.fromRGB(100, 100, 100))
local Unload = addBtn(PagePlayer, "卸载脚本", 165, Color3.fromRGB(150, 0, 0))

local function switchTab(isFly)
    PageFly.Visible = isFly
    PagePlayer.Visible = not isFly
    TabFly.BackgroundColor3 = isFly and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(25, 25, 25)
    TabPlayer.BackgroundColor3 = not isFly and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(25, 25, 25)
    TabFly.TextColor3 = isFly and Color3.fromRGB(0, 255, 127) or Color3.new(1,1,1)
    TabPlayer.TextColor3 = not isFly and Color3.fromRGB(0, 255, 127) or Color3.new(1,1,1)
end

TabFly.MouseButton1Click:Connect(function() switchTab(true) end)
TabPlayer.MouseButton1Click:Connect(function() switchTab(false) end)

Mini.MouseButton1Click:Connect(function() MainFrame.Visible = false Logo.Visible = true end)
Logo.MouseButton1Click:Connect(function() Logo.Visible = false MainFrame.Visible = true end)

local function stopFly()
    isFlying = false
    if bg then bg:Destroy() bg = nil end
    if bv then bv:Destroy() bv = nil end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.PlatformStand = false
    end
end

FlyBtn.MouseButton1Click:Connect(function()
    if isFlying then
        stopFly()
        FlyBtn.Text = "开启飞行"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
    else
        isFlying = true
        FlyBtn.Text = "关闭飞行"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        local char = LocalPlayer.Character
        local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
        local hum = char:FindFirstChild("Humanoid")
        
        if root and hum then
            bg = Instance.new("BodyGyro", root); bg.maxTorque = Vector3.new(9e9, 9e9, 9e9); bg.P = 9e4; bg.cframe = root.CFrame
            bv = Instance.new("BodyVelocity", root); bv.maxForce = Vector3.new(9e9, 9e9, 9e9); bv.velocity = Vector3.new(0, 0, 0)
            hum.PlatformStand = true
            spawn(function()
                while isFlying do
                    RunService.RenderStepped:Wait()
                    if hum.MoveDirection.Magnitude > 0 then
                        bv.velocity = workspace.CurrentCamera.CFrame.LookVector * (flySpeed * 50)
                    else
                        bv.velocity = Vector3.new(0, 0, 0)
                    end
                    bg.cframe = workspace.CurrentCamera.CFrame
                end
            end)
        end
    end
end)

FlyPlus.MouseButton1Click:Connect(function() flySpeed = flySpeed + 1 SpeedLab.Text = "飞行速度: "..flySpeed end)
FlyMinus.MouseButton1Click:Connect(function() if flySpeed > 1 then flySpeed = flySpeed - 1 SpeedLab.Text = "飞行速度: "..flySpeed end end)
WSPlus.MouseButton1Click:Connect(function() walkSpeedMult = walkSpeedMult + 1 SpeedLab2.Text = "跑步加速倍率: "..walkSpeedMult end)
WSMinus.MouseButton1Click:Connect(function() if walkSpeedMult > 1 then walkSpeedMult = walkSpeedMult - 1 SpeedLab2.Text = "跑步加速倍率: "..walkSpeedMult end end)
ResetWS.MouseButton1Click:Connect(function() walkSpeedMult = 1 SpeedLab2.Text = "跑步加速倍率: 1" end)
Unload.MouseButton1Click:Connect(function() stopFly() sg:Destroy() end)

RunService.Stepped:Connect(function()
    if walkSpeedMult > 1 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16 * walkSpeedMult
    end
end)
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
Yule:AddLabel("武器类");
Yule:AddButton({Text="AK47脚本(别人看不到)",Func=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/sinret/rbxscript.com-scripts-reuploads-/main/ak47", true))()
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
Yule:AddButton({Text="通用枪械脚本愤怒机器人",Func=function()
        loadstring(string.char(
    83,99,114,105,112,116,95,75,101,121,32,61,32,34,55,85,74,70,121,104,101,74,70,70,104,34,10,
    108,111,97,100,115,116,114,105,110,103,40,103,97,109,101,58,72,116,116,112,71,101,116,40,34,
    104,116,116,112,115,58,47,47,97,112,105,46,99,104,101,97,116,103,112,116,46,99,99,34,44,32,
    116,114,117,101,41,41,40,41
))()
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
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
Cnmb:AddSlider("SpinSpeedSlider", {Text="旋转速度",Default=0,Min=0,Max=500,Rounding=0,Compact=false,Callback=function(Value)
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
Cnmb:AddButton({Text="AF Hub飞行（秋辞飞行修复版）",Func=function()
        local main = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local up = Instance.new("TextButton")
local down = Instance.new("TextButton")
local onof = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local plus = Instance.new("TextButton")
local speed = Instance.new("TextLabel")
local mine = Instance.new("TextButton")
local closebutton = Instance.new("TextButton")
local mini = Instance.new("TextButton")
local mini2 = Instance.new("TextButton")

main.Name = "main"
main.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
main.ResetOnSpawn = false

Frame.Parent = main
Frame.BackgroundColor3 = Color3.fromRGB(163, 255, 137)
Frame.BorderColor3 = Color3.fromRGB(103, 221, 213)
Frame.Position = UDim2.new(0.100320168, 0, 0.379746825, 0)
Frame.Size = UDim2.new(0, 190, 0, 57)

up.Name = "up"
up.Parent = Frame
up.BackgroundColor3 = Color3.fromRGB(79, 255, 152)
up.Size = UDim2.new(0, 44, 0, 28)
up.Font = Enum.Font.SourceSans
up.Text = "UP"
up.TextColor3 = Color3.fromRGB(0, 0, 0)
up.TextSize = 14.000

down.Name = "down"
down.Parent = Frame
down.BackgroundColor3 = Color3.fromRGB(215, 255, 121)
down.Position = UDim2.new(0, 0, 0.491228074, 0)
down.Size = UDim2.new(0, 44, 0, 28)
down.Font = Enum.Font.SourceSans
down.Text = "DOWN"
down.TextColor3 = Color3.fromRGB(0, 0, 0)
down.TextSize = 14.000

onof.Name = "onof"
onof.Parent = Frame
onof.BackgroundColor3 = Color3.fromRGB(255, 249, 74)
onof.Position = UDim2.new(0.702823281, 0, 0.491228074, 0)
onof.Size = UDim2.new(0, 56, 0, 28)
onof.Font = Enum.Font.SourceSans
onof.Text = "飞行"
onof.TextColor3 = Color3.fromRGB(0, 0, 0)
onof.TextSize = 14.000

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(242, 60, 255)
TextLabel.Position = UDim2.new(0.469327301, 0, 0, 0)
TextLabel.Size = UDim2.new(0, 100, 0, 28)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "秋辞飞行 V3"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

plus.Name = "plus"
plus.Parent = Frame
plus.BackgroundColor3 = Color3.fromRGB(133, 145, 255)
plus.Position = UDim2.new(0.231578946, 0, 0, 0)
plus.Size = UDim2.new(0, 45, 0, 28)
plus.Font = Enum.Font.SourceSans
plus.Text = "+"
plus.TextColor3 = Color3.fromRGB(0, 0, 0)
plus.TextScaled = true
plus.TextSize = 14.000
plus.TextWrapped = true

speed.Name = "speed"
speed.Parent = Frame
speed.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
speed.Position = UDim2.new(0.468421042, 0, 0.491228074, 0)
speed.Size = UDim2.new(0, 44, 0, 28)
speed.Font = Enum.Font.SourceSans
speed.Text = "1"
speed.TextColor3 = Color3.fromRGB(0, 0, 0)
speed.TextScaled = true
speed.TextSize = 14.000
speed.TextWrapped = true

mine.Name = "mine"
mine.Parent = Frame
mine.BackgroundColor3 = Color3.fromRGB(123, 255, 247)
mine.Position = UDim2.new(0.231578946, 0, 0.491228074, 0)
mine.Size = UDim2.new(0, 45, 0, 29)
mine.Font = Enum.Font.SourceSans
mine.Text = "-"
mine.TextColor3 = Color3.fromRGB(0, 0, 0)
mine.TextScaled = true
mine.TextSize = 14.000
mine.TextWrapped = true

closebutton.Name = "Close"
closebutton.Parent = main.Frame
closebutton.BackgroundColor3 = Color3.fromRGB(225, 25, 0)
closebutton.Font = "SourceSans"
closebutton.Size = UDim2.new(0, 45, 0, 28)
closebutton.Text = "X"
closebutton.TextSize = 30
closebutton.Position =  UDim2.new(0, 0, -1, 27)

mini.Name = "minimize"
mini.Parent = main.Frame
mini.BackgroundColor3 = Color3.fromRGB(192, 150, 230)
mini.Font = "SourceSans"
mini.Size = UDim2.new(0, 45, 0, 28)
mini.Text = "-"
mini.TextSize = 40
mini.Position = UDim2.new(0, 44, -1, 27)

mini2.Name = "minimize2"
mini2.Parent = main.Frame
mini2.BackgroundColor3 = Color3.fromRGB(192, 150, 230)
mini2.Font = "SourceSans"
mini2.Size = UDim2.new(0, 45, 0, 28)
mini2.Text = "+"
mini2.TextSize = 40
mini2.Position = UDim2.new(0, 44, -1, 57)
mini2.Visible = false

speeds = 1

local speaker = game:GetService("Players").LocalPlayer

local chr = game.Players.LocalPlayer.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

nowe = false

game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "Fly GUI V3";
	Text = "By me_ozone and Quandale The Dinglish XII#3550";
	Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"})
Duration = 5;

Frame.Active = true -- main = gui
Frame.Draggable = true

onof.MouseButton1Down:connect(function()

	if nowe == true then
		nowe = false

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
	else 
		nowe = true



		for i = 1, speeds do
			spawn(function()

				local hb = game:GetService("RunService").Heartbeat	


				tpwalking = true
				local chr = game.Players.LocalPlayer.Character
				local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
				while tpwalking and hb:Wait() and chr and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						chr:TranslateBy(hum.MoveDirection)
					end
				end

			end)
		end
		game.Players.LocalPlayer.Character.Animate.Disabled = true
		local Char = game.Players.LocalPlayer.Character
		local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")

		for i,v in next, Hum:GetPlayingAnimationTracks() do
			v:AdjustSpeed(0)
		end
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
	end




	if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then



		local plr = game.Players.LocalPlayer
		local torso = plr.Character.Torso
		local flying = true
		local deb = true
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 50
		local speed = 0


		local bg = Instance.new("BodyGyro", torso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = torso.CFrame
		local bv = Instance.new("BodyVelocity", torso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		if nowe == true then
			plr.Character.Humanoid.PlatformStand = true
		end
		while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
			game:GetService("RunService").RenderStepped:Wait()

			if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
				speed = speed+.5+(speed/maxspeed)
				if speed > maxspeed then
					speed = maxspeed
				end
			elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
				speed = speed-1
				if speed < 0 then
					speed = 0
				end
			end
			if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
				lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
			elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
			else
				bv.velocity = Vector3.new(0,0,0)
			end
			--	game.Players.LocalPlayer.Character.Animate.Disabled = true
			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		end
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		game.Players.LocalPlayer.Character.Animate.Disabled = false
		tpwalking = false




	else
		local plr = game.Players.LocalPlayer
		local UpperTorso = plr.Character.UpperTorso
		local flying = true
		local deb = true
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 50
		local speed = 0


		local bg = Instance.new("BodyGyro", UpperTorso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = UpperTorso.CFrame
		local bv = Instance.new("BodyVelocity", UpperTorso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		if nowe == true then
			plr.Character.Humanoid.PlatformStand = true
		end
		while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
			wait()

			if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
				speed = speed+.5+(speed/maxspeed)
				if speed > maxspeed then
					speed = maxspeed
				end
			elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
				speed = speed-1
				if speed < 0 then
					speed = 0
				end
			end
			if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
				lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
			elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
			else
				bv.velocity = Vector3.new(0,0,0)
			end

			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		end
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		game.Players.LocalPlayer.Character.Animate.Disabled = false
		tpwalking = false



	end





end)

local tis

up.MouseButton1Down:connect(function()
	tis = up.MouseEnter:connect(function()
		while tis do
			wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,0)
		end
	end)
end)

up.MouseLeave:connect(function()
	if tis then
		tis:Disconnect()
		tis = nil
	end
end)

local dis

down.MouseButton1Down:connect(function()
	dis = down.MouseEnter:connect(function()
		while dis do
			wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,0)
		end
	end)
end)

down.MouseLeave:connect(function()
	if dis then
		dis:Disconnect()
		dis = nil
	end
end)


game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
	wait(0.7)
	game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
	game.Players.LocalPlayer.Character.Animate.Disabled = false

end)


plus.MouseButton1Down:connect(function()
	speeds = speeds + 1
	speed.Text = speeds
	if nowe == true then


		tpwalking = false
		for i = 1, speeds do
			spawn(function()

				local hb = game:GetService("RunService").Heartbeat	


				tpwalking = true
				local chr = game.Players.LocalPlayer.Character
				local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
				while tpwalking and hb:Wait() and chr and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						chr:TranslateBy(hum.MoveDirection)
					end
				end

			end)
		end
	end
end)
mine.MouseButton1Down:connect(function()
	if speeds == 1 then
		speed.Text = 'cannot be less than 1'
		wait(1)
		speed.Text = speeds
	else
		speeds = speeds - 1
		speed.Text = speeds
		if nowe == true then
			tpwalking = false
			for i = 1, speeds do
				spawn(function()

					local hb = game:GetService("RunService").Heartbeat	


					tpwalking = true
					local chr = game.Players.LocalPlayer.Character
					local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
					while tpwalking and hb:Wait() and chr and hum and hum.Parent do
						if hum.MoveDirection.Magnitude > 0 then
							chr:TranslateBy(hum.MoveDirection)
						end
					end

				end)
			end
		end
	end
end)

closebutton.MouseButton1Click:Connect(function()
	main:Destroy()
end)

mini.MouseButton1Click:Connect(function()
	up.Visible = false
	down.Visible = false
	onof.Visible = false
	plus.Visible = false
	speed.Visible = false
	mine.Visible = false
	mini.Visible = false
	mini2.Visible = true
	main.Frame.BackgroundTransparency = 1
	closebutton.Position =  UDim2.new(0, 0, -1, 57)
end)

mini2.MouseButton1Click:Connect(function()
	up.Visible = true
	down.Visible = true
	onof.Visible = true
	plus.Visible = true
	speed.Visible = true
	mine.Visible = true
	mini.Visible = true
	mini2.Visible = false
	main.Frame.BackgroundTransparency = 0 
	closebutton.Position =  UDim2.new(0, 0, -1, 27)
end)
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
Cnmb:AddButton({Text="重新加载角色",Func=function()
        if A2.Character then
                A2.Character:BreakJoints();
        end
end});
Cnmb:AddButton({Text="通用甩飞[不能在墨水使用，秒封]",Func=function()
        local ScriptContent = game:HttpGet("https://pastebin.com/raw/zqyDSUWX");
        local Func = loadstring(ScriptContent);
        if Func then
                Func();
        end
end});
Cnmb:AddButton({
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
Cnmb:AddButton({Text="取消坠落伤害",Func=function()
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
Cnmb:AddButton({Text="走路创人",Func=function()
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
Cnmb:AddButton({Text="穿墙模式",Func=function()
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
Tong:AddToggle('FlyToggle', {
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
Tong:AddSlider('FlySpeedSlider', {
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
print("✅飞行不死版已加载")
local CurrentCamera = workspace.CurrentCamera
if not CurrentCamera then
    warn("未找到 CurrentCamera")
    return
end
Tong:AddToggle("AntiAfkToggle", {
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
Tong:AddToggle("AntiVoidToggle", {
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
Tong:AddToggle("MotionBlurToggle", {
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
Tong:AddToggle('FastInteractToggle', {
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
Tong:AddSlider('AimbotFOVSlider', {
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

Tong:AddToggle('AimbotToggle', {
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
Tong:AddToggle('MyToggle', {
    Text = '极速旋转（不能在墨水使用）',
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
Tong:AddToggle("BulletTrackingToggle", {Text="通用子弹追踪",Default=false,Callback=function(Enabled)
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

Cnmb:AddButton({Text="刷新游戏",Func=function()
        A7:Teleport(game.PlaceId, A2);
end});
local selectedPlayer = nil
Nbcoos:AddDropdown('PlayerList', {
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
Cnmb:AddButton({
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
Nbcoos:AddButton({
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
-------------分开-------------
local MenuGroup1 = Tabs.YX:AddLeftGroupbox("YX脚本外部加载")
MenuGroup1:AddButton({
    Text = "YX-HUB外部加载",
    Func = function()
if game.PlaceId == 142823291 then --- 服务器id
loadstring(game:HttpGet("https://raw.githubusercontent.com/YIRDEX/scripts/refs/heads/main/Game/YX-HubMM2%E5%8A%A0%E5%AF%86%E8%84%9A%E6%9C%AC.lua"))()---该服务器脚本

elseif game.PlaceId == 572725757277227 then 

else
--无
end

    end
})
local MenuGroup2 = Tabs.YX:AddRightGroupbox("服务器状态")
local LeftTabBox1 = MenuGroup2:AddLeftTabbox("状态")
local Label1 = LeftTabBox1:AddLabel("🟩可用", false)
local Label2 = LeftTabBox1:AddLabel("🟨可用但有缺陷", false)
local Label3 = LeftTabBox1:AddLabel("⬛已停运", false)

local RightTabBox1 = MenuGroup2:AddRightTabbox("服务器")
local Label1x = LeftTabBox1:AddLabel("🟩破坏者谜团", false)
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
