local YXOpt = {}
do
	local ZH = {
		['Small'] = '小',
		['Medium'] = '中',
		['Large'] = '大',
		['Square'] = '方形',
		['Rectangle'] = '矩形',
		['Low'] = '低',
		['High'] = '高',
		['None'] = '无',
		['(No synced items)'] = '（暂无同步项目）',
		['(No other players)'] = '（没有其他玩家）',
		['Server (FE)'] = '服务器 (FE)',
		['Local'] = '本地',
		['Filled'] = '填充',
		['Outline'] = '描边',
		['Default'] = '默认',
		['Purple Nebula'] = '紫色星云',
		['Dreamy Sunset'] = '梦幻日落',
		['Redshift'] = '红移',
		['Cinematic'] = '电影风格',
		['Deep Shader'] = '深度着色',
		['Realistic Shader'] = '写实着色',
		['RTX Reflection & Shaders'] = 'RTX 反射与着色',
		['Soft Shader'] = '柔和着色',
		['star'] = '星形',
		['heart'] = '心形',
		['circle-plus'] = '圆形加号',
		['crosshair'] = '准星',
		['Shiftlock / First Person'] = '锁定视角 / 第一人称',
		['Always'] = '始终',
		['Aimlock'] = '锁定瞄准',
		['Silent Aim'] = '静默瞄准',
		['Head'] = '头部',
		['HumanoidRootPart'] = '人物根部件',
		['Torso'] = '躯干',
		['UpperTorso'] = '上躯干',
		['Normal'] = '普通',
		['Behind Walls'] = '穿墙',
		['CFrame'] = '坐标瞬移',
		['Tween'] = '补间移动',
		['Under'] = '地图下方',
		['Board 1'] = '投票板 1',
		['Board 2'] = '投票板 2',
		['Board 3'] = '投票板 3',
		['Fake Dead 1'] = '假死 1',
		['Fake Dead 2'] = '假死 2',
		['Wall Glitch (GLITCH)'] = '穿墙卡位（异常）',
	}
	local EN = {}
	for k, v in pairs(ZH) do EN[v] = k end
	function YXOpt.zh(v)
		if type(v) ~= "string" then return v end
		return ZH[v] or v
	end
	function YXOpt.en(v)
		if type(v) ~= "string" then return v end
		return EN[v] or v
	end
	function YXOpt.list(t)
		if type(t) ~= "table" then return t end
		local out = {}
		for k, v in pairs(t) do out[k] = YXOpt.zh(v) end
		return out
	end
end


task.defer(function()
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "YX-SCRPIT",
			Text = "根据FoxnameMM2开源代码，二改",
			Icon = "rbxassetid://133245078123989",
			Duration = 5,
		})
	end)
end)

local genv
genv = getgenv and getgenv() or _G

FoxnameCopyToClipboard = function(bootstrap_param_0001)
	local bootstrap_callResult_0002 = tostring(bootstrap_param_0001 or "")
	local bootstrap_localValue_0003

	if typeof(setclipboard) == "function" then
		bootstrap_localValue_0003 = setclipboard
	elseif typeof(setrbxclipboard) == "function" then
		bootstrap_localValue_0003 = setrbxclipboard
	else
		bootstrap_localValue_0003 = nil
	end

	if bootstrap_localValue_0003 then
		return (pcall(bootstrap_localValue_0003, bootstrap_callResult_0002))
	end
	return false
end

FoxnameKickPlayer = function(bootstrap_param_0004, bootstrap_param_0005)
	if not bootstrap_param_0004 then
		return false
	end

	return (pcall(function()
		local bootstrap_localValue_0006 = bootstrap_param_0004
		local kick = bootstrap_localValue_0006.Kick
		local bootstrap_localValue_0007 = tostring
		local bootstrap_localValue_0008 = bootstrap_param_0005
		local bootstrap_textValue_0009

		if bootstrap_param_0005 then
			bootstrap_textValue_0009 = bootstrap_localValue_0008
		else
			bootstrap_textValue_0009 = ""
		end

		kick(bootstrap_localValue_0006, bootstrap_localValue_0007(bootstrap_textValue_0009))
	end))
end

local hookSupported, silentAimSupported, foxnameMM2Runtime, sessionId, isTerminated, WindUI, Window, isOwner
local Tabs, UI_BUILD_DELAY = nil, 0.08
local info

do
	local runtime_fieldTable_0010 = { Name = "未知执行器", IsXeno = false, IsDelta = false }

	pcall(function()
		if type(identifyexecutor) == "function" then
			runtime_fieldTable_0010.Name = tostring(select(1, identifyexecutor()) or runtime_fieldTable_0010.Name)
		end
	end)

	local runtime_localValue_0011 = string.lower(runtime_fieldTable_0010.Name)
	runtime_fieldTable_0010.IsXeno = runtime_localValue_0011:find("xeno", 1, true) ~= nil
	runtime_fieldTable_0010.IsDelta = runtime_localValue_0011:find("delta", 1, true) ~= nil

	local function runtime_helperFunc_0012()
		if runtime_fieldTable_0010.IsXeno then
			return false
		end
		return type(hookmetamethod) == "function" and type(getnamecallmethod) == "function" and type(checkcaller) == "function" and type(newcclosure) == "function"
	end

	local runtime_callResult_0013 = runtime_helperFunc_0012()
	hookSupported = runtime_callResult_0013
	silentAimSupported = runtime_callResult_0013
	genv.__FoxnameMM2Runtime = genv.__FoxnameMM2Runtime or { running = false, windui = nil, window = nil, alive = false, sessionId = nil }
	foxnameMM2Runtime = genv.__FoxnameMM2Runtime
	local random = math.random
	sessionId = string.format("%.6f_%d", os.clock(), random(100000, 999999))
	isTerminated = false

	if foxnameMM2Runtime.running and foxnameMM2Runtime.alive then
		local windui = foxnameMM2Runtime.windui

		if windui and type(windui.Notify) == "function" then
			pcall(function()
				windui:Notify({ Title = "失败", Content = "脚本已在运行中！", Icon = "ban", Duration = 2.5 })
			end)
		end

		return
	end

	foxnameMM2Runtime.running = true
	foxnameMM2Runtime.alive = true
	foxnameMM2Runtime.sessionId = sessionId
	local HttpService = game:GetService("HttpService")

	if syn and type(syn.request) == "function" then
		request_ = syn.request
	elseif type(http_request) == "function" then
		request_ = http_request
	elseif type(request) == "function" then
		request_ = request
	end

	local function compat_helperFunc_0014()
		local compat_textValue_0015 = "未知执行器"

		pcall(function()
			if type(identifyexecutor) == "function" then
				local compat_callResult_0016, compat_callResult_0017 = identifyexecutor()
				compat_textValue_0015 = tostring(compat_callResult_0016 or compat_textValue_0015)

				if compat_callResult_0017 and tostring(compat_callResult_0017) ~= "" then
					compat_textValue_0015 ..= " " .. tostring(compat_callResult_0017)
				end
			end
		end)

		local compat_callResult_0018 = type(request) == "function" or type(http_request) == "function" or type(syn) == "table" and type(syn.request) == "function"
		local websocket_ = type(WebSocket) == "table" and WebSocket
		local compat_callResult_0019 = type(websocket_) == "table"

		if compat_callResult_0019 then
			compat_callResult_0019 = type(websocket_.connect or websocket_.Connect) == "function"
		end

		local compat_callResult_0020 = type(queue_on_teleport) == "function"

		if not compat_callResult_0020 then
			compat_callResult_0020 = type(syn) == "table"

			if compat_callResult_0020 then
				compat_callResult_0020 = type(syn.queue_on_teleport or syn.queueonteleport) == "function"
			end
		end

		local compat_callResult_0021 = type(readfile) == "function" and type(writefile) == "function" and type(makefolder) == "function" and type(isfile) == "function" and type(isfolder) == "function" and type(delfile) == "function"
		local compat_localValue_0022 = runtime_callResult_0013
		local compat_configTable_0023 = {}

		local compat_configTable_0024 = {
			name = "HTTP 请求",
			ok = compat_callResult_0018,
			features = { "Discord 实时信息", "兼容性报告发送" },
		}

		local compat_configTable_0025 = {
			name = "WebSocket",
			ok = compat_callResult_0019,
			features = { "消息", "所有者 / 同脚本用户检测", "所有者面板指令" },
		}

		local compat_configTable_0026 = {
			name = "文件存储",
			ok = compat_callResult_0021,
			features = { "本地库缓存", "刷币进度恢复", "Webhook / 图标缓存" },
		}

		local compat_fieldTable_0027 = { name = "传送队列", ok = compat_callResult_0020, features = { "自动重连服务器并重新执行脚本" } }

		local compat_configTable_0028 = {
			name = "触摸模拟",
			ok = type(firetouchinterest) == "function",
			features = { "金币触摸回退", "拿枪 / 瞬间拿枪" },
		}

		local compat_configTable_0029 = {
			name = "连接检测",
			ok = type(getconnections) == "function",
			features = { "已验证的游戏 UI 按钮触发" },
		}

		local compat_configTable_0030 = {
			name = "元方法钩子",
			ok = compat_localValue_0022,
			features = { "完整同步游戏内动作选择器" },
		}

		local compat_configTable_0031 = {
			name = "剪贴板",
			ok = type(setclipboard) == "function",
			features = { "复制 Discord 邀请与报告" },
		}

		local compat_configTable_0032 = {
			name = "动态代码加载",
			ok = type(loadstring) == "function",
			features = { "远程库与防甩飞加载" },
		}

		compat_configTable_0023[1] = compat_configTable_0024
		compat_configTable_0023[2] = compat_configTable_0025
		compat_configTable_0023[3] = compat_configTable_0026
		compat_configTable_0023[4] = compat_fieldTable_0027
		compat_configTable_0023[5] = compat_configTable_0028
		compat_configTable_0023[6] = compat_configTable_0029
		compat_configTable_0023[7] = compat_configTable_0030
		compat_configTable_0023[8] = compat_configTable_0031
		compat_configTable_0023[9] = compat_configTable_0032

		compat_configTable_0023[10] = {
			name = "执行器识别",
			ok = compat_textValue_0015 ~= "未知执行器",
			features = { "执行器名称检测" },
		}

		local compat_configTable_0033 = {}
		local compat_configTable_0034 = {}
		local compat_configTable_0035 = {}
		local compat_numericVar_0036 = 0

		for _, compat_loopVar_0037 in ipairs(compat_configTable_0023) do
			if compat_loopVar_0037.ok then
				compat_numericVar_0036 += 1
			else
				table.insert(compat_configTable_0034, compat_loopVar_0037.name)

				for _, feature in ipairs(compat_loopVar_0037.features) do
					if not compat_configTable_0035[feature] then
						compat_configTable_0035[feature] = true
						table.insert(compat_configTable_0033, feature)
					end
				end
			end
		end

		return {
			executor = compat_textValue_0015,
			score = math.floor(compat_numericVar_0036 / #compat_configTable_0023 * 100 + 0.5),
			checks = compat_configTable_0023,
			missing = compat_configTable_0034,
			unsupported = compat_configTable_0033,
		}
	end

	local compat_callResult_0038 = compat_helperFunc_0014()

	task.spawn(function()
		local Players = game:GetService("Players")
		local UserInputService = game:GetService("UserInputService")
		local GuiService = game:GetService("GuiService")
		local localPlayer = Players.LocalPlayer
		local playerGui = localPlayer and localPlayer:FindFirstChildOfClass("PlayerGui")

		if not playerGui and localPlayer then
			playerGui = localPlayer:WaitForChild("PlayerGui", 2)
		end

		if playerGui then
			local function background_helperFunc_0039(background_param_0040)
				while background_param_0040 and background_param_0040 ~= playerGui do
					if background_param_0040:IsA("GuiObject") and not background_param_0040.Visible then
						return false
					end

					if background_param_0040:IsA("LayerCollector") and not background_param_0040.Enabled then
						return false
					end
					background_param_0040 = background_param_0040.Parent
				end

				return background_param_0040 == playerGui
			end

			local function background_helperFunc_0041(background_param_0042)
				if not background_param_0042 or not background_param_0042:IsA("GuiButton") or not background_helperFunc_0039(background_param_0042) then
					return false
				end
				local background_numericVar_0043 = background_param_0042.AbsolutePosition + background_param_0042.AbsoluteSize / 2

				if type(mousemoveabs) == "function" and type(mouse1click) == "function" then
					if pcall(function()
						mousemoveabs(background_numericVar_0043.X, background_numericVar_0043.Y)
						mouse1click()
					end) then
						return true
					end
				end

				local ok, result = pcall(game.GetService, game, "VirtualInputManager")

				if ok and result then
					return pcall(function()
						result:SendMouseButtonEvent(background_numericVar_0043.X, background_numericVar_0043.Y, 0, true, game, 0)
						result:SendMouseButtonEvent(background_numericVar_0043.X, background_numericVar_0043.Y, 0, false, game, 0)
					end)
				end

				return false
			end

			local function background_helperFunc_0044(background_param_0045)
				if not background_param_0045 or not background_param_0045:IsA("GuiButton") or not background_helperFunc_0039(background_param_0045) then
					return false
				end

				if type(getconnections) ~= "function" then
					return background_helperFunc_0041(background_param_0045)
				end
				local ok, result = pcall(getconnections, background_param_0045.MouseButton1Click)
				if not ok or type(result) ~= "table" then
					return background_helperFunc_0041(background_param_0045)
				end

				for _, background_loopVar_0046 in ipairs(result) do
					if background_loopVar_0046.Enabled ~= false and type(background_loopVar_0046.Function) == "function" then
						local function_ = background_loopVar_0046.Function

						task.spawn(function()
							local background_localValue_0047 = getthreadidentity or getidentity
							local background_localValue_0048 = setthreadidentity or setidentity
							local background_optionalValue_0049 = nil

							if type(background_localValue_0047) == "function" then
								pcall(function()
									background_optionalValue_0049 = background_localValue_0047()
								end)
							end

							if type(background_localValue_0048) == "function" then
								pcall(background_localValue_0048, 2)
							end

							pcall(function_)

							if background_optionalValue_0049 and type(background_localValue_0048) == "function" then
								pcall(background_localValue_0048, background_optionalValue_0049)
							end
						end)

						return true
					end
				end

				return background_helperFunc_0041(background_param_0045)
			end

			local function background_helperFunc_0050()
				local currentCamera = workspace.CurrentCamera
				currentCamera = currentCamera and currentCamera.ViewportSize

				if not currentCamera or currentCamera.X <= 0 or currentCamera.Y <= 0 then
					local ok, result = pcall(function()
						return GuiService:GetScreenResolution()
					end)

					if ok then
						currentCamera = result
					end
				end

				if not currentCamera or currentCamera.X <= 0 or currentCamera.Y <= 0 then
					return "Phone"
				end
				local background_numericVar_0051 = math.min(currentCamera.X, currentCamera.Y)
				return math.max(currentCamera.X, currentCamera.Y) / math.max(background_numericVar_0051, 1) <= 1.7 and "Tablet" or "Phone"
			end

			local now = os.clock()
			local background_numericVar_0052 = now + 5
			local background_numericVar_0053 = now + 12
			local background_numericVar_0054 = 0
			local now2 = nil
			local background_numericVar_0055 = 0

			while os.clock() < background_numericVar_0053 do
				local deviceSelect = playerGui:FindFirstChild("DeviceSelect")
				local background_boolFlag_0056 = deviceSelect and UserInputService.TouchEnabled and background_numericVar_0054 < 8
				local background_boolFlag_0057 = false

				if background_boolFlag_0056 then
					local container = deviceSelect:FindFirstChild("Container")
					local button

					if container then
						local background_localValue_0058 = container
						local findFirstChild = background_localValue_0058.FindFirstChild
						local background_callResult_0059 = background_helperFunc_0050()
						button = findFirstChild(background_localValue_0058, background_callResult_0059)
					else
						button = container
					end

					button = button and button:FindFirstChild("Button")

					if background_helperFunc_0044(button) then
						background_numericVar_0054 += 1
						now2 = os.clock()
						background_boolFlag_0057 = true
					end
				end

				local join = playerGui:FindFirstChild("Join") or playerGui:FindFirstChild("JoinPhone")
				join = join and join:FindFirstChild("Friends")
				local play = join and join:FindFirstChild("Play")

				if play and background_helperFunc_0039(play) and background_numericVar_0055 < 6 then
					if background_helperFunc_0044(play) then
						background_numericVar_0055 += 1
						now2 = os.clock()
						background_boolFlag_0057 = true
					end
				end

				local wait

				if now2 then
					if not (not playerGui:FindFirstChild("DeviceSelect") and not playerGui:FindFirstChild("Join") and not playerGui:FindFirstChild("JoinPhone") and os.clock() - now2 >= 0.6) then
						wait = task.wait
						background_boolFlag_0057 = background_boolFlag_0057 and 0.35 or 0.15
						wait(background_boolFlag_0057)
						continue
					end
				elseif not (os.clock() >= background_numericVar_0052) then
					wait = task.wait
					wait(background_boolFlag_0057 and 0.35 or 0.15)
					continue
				end

				break
			end

			local background_numericVar_0060 = 0

			while foxnameMM2Runtime.alive do
				local deviceSelect = playerGui:FindFirstChild("DeviceSelect")
				deviceSelect = deviceSelect and deviceSelect:FindFirstChild("Container")

				if deviceSelect then
					local findFirstChild = deviceSelect.FindFirstChild
					local background_callResult_0061 = background_helperFunc_0050()
					deviceSelect = findFirstChild(deviceSelect, background_callResult_0061)
				end

				deviceSelect = deviceSelect and deviceSelect:FindFirstChild("Button")
				local join = playerGui:FindFirstChild("Join") or playerGui:FindFirstChild("JoinPhone")
				join = join and join:FindFirstChild("Friends")
				join = join and join:FindFirstChild("Play")
				local isGuiButton = deviceSelect and deviceSelect:IsA("GuiButton") and background_helperFunc_0039(deviceSelect)
				local isGuiButton2 = join and join:IsA("GuiButton") and background_helperFunc_0039(join)

				if not (not isGuiButton and not isGuiButton2) then
					if os.clock() - background_numericVar_0060 >= 1 then
						background_numericVar_0060 = os.clock()

						if isGuiButton and UserInputService.TouchEnabled then
							background_helperFunc_0044(deviceSelect)
						elseif isGuiButton2 then
							background_helperFunc_0044(join)
						end
					end

					task.wait(0.2)
					continue
				end

				break
			end
		end
	end)

	local function winduiLoad_helperFunc_0062()
		pcall(function()
			local ReplicatedStorage = game:GetService("ReplicatedStorage")

			if not ReplicatedStorage:FindFirstChild("GetIcons") then
				local remoteFunction = Instance.new("RemoteFunction")
				remoteFunction.Name = "GetIcons"

				remoteFunction.OnClientInvoke = function()
					return { Icons = {} }
				end

				remoteFunction.Parent = ReplicatedStorage
			end
		end)

		local request_2

		if typeof(http_request) == "function" then
			request_2 = http_request
		elseif typeof(request) == "function" then
			request_2 = request
		elseif typeof(syn) == "table" and typeof(syn.request) == "function" then
			request_2 = syn.request
		else
			request_2 = nil
		end

		local urls = {
			"https://raw.githubusercontent.com/YirdeX-Dev/Miscs/refs/heads/main/YX-WindUI.lua",
		}

		local cachePath = "Foxname/WindUI_cache.lua"
		local function tryReadCache()
			if typeof(isfile) == "function" and typeof(readfile) == "function" then
				local ok, content = pcall(readfile, cachePath)
				if ok and typeof(content) == "string" and #content > 400 then
					return content
				end
				local ok2, content2 = pcall(readfile, "WindUI.lua")
				if ok2 and typeof(content2) == "string" and #content2 > 400 then
					return content2
				end
			end
			return nil
		end

		local function tryWriteCache(src)
			if typeof(writefile) == "function" and typeof(src) == "string" and #src > 400 then
				pcall(function()
					if typeof(isfolder) == "function" and typeof(makefolder) == "function" and not isfolder("Foxname") then
						makefolder("Foxname")
					end
					writefile(cachePath, src)
				end)
			end
		end

		local function compileSource(src)
			if typeof(src) ~= "string" or #src < 400 then
				return nil
			end
			local winduiLoad_textValue_0063 = src:gsub("WaitForChild%(\"GetIcons\",%s*%d+%)", "FindFirstChild(\"GetIcons\")"):gsub("local d=b%(game:GetService\"ReplicatedStorage\":WaitForChild%(\"GetIcons\",99999%):InvokeServer%(%)%)", "local d={Icons={}}")
			winduiLoad_textValue_0063 = winduiLoad_textValue_0063:gsub("d=ak%.AddSignal%(ar%.UIElements%.ContainerFrame%.ChildAdded,%s*function%(%)%s*b%.Visible=false%s*d:Disconnect%(%)%s*end%)", "d=ak.AddSignal(ar.UIElements.ContainerFrame.ChildAdded,function(c) if c~=b and c.ClassName~='UIListLayout' and c.ClassName~='UIPadding' then b.Visible=false b.Size=UDim2.new(1,0,0,0) if d then d:Disconnect() end end end)\nif #ar.Elements>0 or #ar.UIElements.ContainerFrame:GetChildren()>3 then b.Visible=false b.Size=UDim2.new(1,0,0,0) end")
			local chunk, err = loadstring(winduiLoad_textValue_0063)
			if chunk then
				return chunk
			end
			return nil
		end

		local chunk = nil

		for _, url in ipairs(urls) do
			for attempt = 1, 2 do
				local body = nil
				if request_2 then
					local ok, res = pcall(request_2, {
						Url = url,
						Method = "GET",
						Headers = { ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" },
					})
					if ok and typeof(res) == "table" and (res.Body or res.body) then
						local b = res.Body or res.body
						if typeof(b) == "string" and #b > 400 then
							body = b
						end
					end
				end

				if not body then
					local ok, res = pcall(function()
						return game:HttpGet(url)
					end)
					if ok and typeof(res) == "string" and #res > 400 then
						body = res
					end
				end

				if body then
					chunk = compileSource(body)
					if chunk then
						tryWriteCache(body)
						break
					end
				end

				if attempt < 2 then
					task.wait(0.15)
				end
			end
			if chunk then
				break
			end
		end

		if not chunk then
			local cached = tryReadCache()
			if cached then
				chunk = compileSource(cached)
			end
		end

		if not chunk then
			error("WindUI source could not be downloaded")
		end

		return chunk()
	end

	WindUI = winduiLoad_helperFunc_0062()
	foxnameMM2Runtime.windui = WindUI
	_G.WindUI = WindUI

loadstring(game:HttpGet("https://raw.githubusercontent.com/YirdeX-Dev/Miscs/refs/heads/main/YX-Theme.lua"))()

local savedTheme        = _G.savedTheme
local ALLOWED_THEMES    = _G.ALLOWED_THEMES
local isAllowedTheme    = _G.isAllowedTheme
local ThemeMemory       = _G.ThemeMemory
local THEME_BACKGROUNDS = _G.THEME_BACKGROUNDS
local wallpaperFor      = _G.wallpaperFor
local onEnterTheme      = _G.onEnterTheme
local YXTheme           = _G.YXTheme
local addGradientBorder = _G.addGradientBorder
Window = WindUI:CreateWindow({
    Title = "YX-破坏者谜团2",
    Icon = "rbxassetid://71400987113958",
    Author = "by YirdeX",
    Folder = "YX-HUB",
    IconSize = 27,
    Size = UDim2.fromOffset(600, 400),
    MinSize = Vector2.new(460, 340),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = savedTheme,
    Resizable = true,
    AutoScale = false,
    SideBarWidth = 170,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    BackgroundImageTransparency = 0.42,
    Background = wallpaperFor(savedTheme) or THEME_BACKGROUNDS["YX-Wind"],
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            onUserCardClick()
        end,
    },
})

pcall(function()
    if Window.SetUIScale then Window:SetUIScale(1) end
end)

Window:Tag({
    Title = "YX-SCRPIT",
    Icon = "star",
})

local isAnonymous = false
onUserCardClick = function()
    isAnonymous = not isAnonymous
    Window.User:SetAnonymous(isAnonymous)
    WindUI:Notify({
        Title = "用户信息",
        Content = isAnonymous and "已切换为匿名用户" or "已显示真实用户信息",
        Icon = isAnonymous and "eye-off" or "eye",
        Duration = 2,
    })
end

Window:EditOpenButton({
    Title = "YX-破坏者谜团2",
    Icon = "rbxassetid://71400987113958",
    OnlyIcon = false,
    CornerRadius = UDim.new(1, 0),
    StrokeThickness = 2.5,
    Color = ColorSequence.new(
        Color3.fromHex("#FFFFFF"),
        Color3.fromHex("#EA788C")
    ),
    OnlyMobile = false,
    Draggable = true,
})

	foxnameMM2Runtime.window = Window
	isOwner = false

	local function tabSkeleton_helperFunc_0072()
		local dummyTab = setmetatable({}, {
			__index = function(self, k)
				return function()
					return self
				end
			end,
		})
		local tabSkeleton_localValue_0073 = dummyTab
		local tabSkeleton_localValue_0074 = dummyTab
	info = Window:Tab({
		Title = "信息",
		Desc = "脚本信息",
		Icon = "house",
		IconThemed = true,
		ShowTabTitle = false,
		Border = true,
	})
	local YX_SCRPITinfo = info:Section({
		Title = "脚本信息",
		Desc = "脚本及作者相关信息",
		Icon = "handshake",
		TextSize = 20,
		TextXAlignment = "Left",
		Box = true,
		BoxBorder = true,
		Opened = true,
		TextTransparency = 0,
		DescTextTransparency = 0,
	})
	YX_SCRPITinfo:Paragraph({
		Title = '<font color="rgb(0, 255, 255)">Y</font><font color="rgb(50, 255, 255)">i</font><font color="rgb(100, 255, 255)">r</font><font color="rgb(150, 255, 255)">d</font><font color="rgb(200, 255, 255)">e</font><font color="rgb(255, 255, 255)">X</font>',
		Desc = "主创开发者",
		Image = "https://raw.githubusercontent.com/YirdeX-Dev/Miscs/refs/heads/main/IMG_20261031_224741.jpg",
		ImageSize = 50,
	})
		local visualsTab = Window:Tab({ Title = "绘制", Icon = "eye" })
		task.wait(UI_BUILD_DELAY)
		local crosshairTab = Window:Tab({ Title = "准星", Icon = "crosshair" })
		task.wait(UI_BUILD_DELAY)
		local combatTab = Window:Tab({ Title = "战斗", Icon = "crosshair" })
		task.wait(UI_BUILD_DELAY)
		local miscTab = Window:Tab({ Title = "杂项", Icon = "wrench" })
		task.wait(UI_BUILD_DELAY)
		local movementTab = Window:Tab({ Title = "玩家", Icon = "user" })
		task.wait(UI_BUILD_DELAY)
		local farmTab = Window:Tab({ Title = "刷币", Icon = "coins" })
		task.wait(UI_BUILD_DELAY)
		local animsTab = Window:Tab({ Title = "动作", Icon = "play" })
		task.wait(UI_BUILD_DELAY)
		local radioTab = Window:Tab({ Title = "收音机", Icon = "radio" })
		task.wait(UI_BUILD_DELAY)
		local teleportsTab = Window:Tab({ Title = "传送", Icon = "navigation" })
		task.wait(UI_BUILD_DELAY)
		local settingsTab = Window:Tab({ Title = "设置", Icon = "settings" })
		task.wait(UI_BUILD_DELAY)

		local tabSkeleton_configTable_0076 = {
			Messages = tabSkeleton_localValue_0073,
			Panel = tabSkeleton_localValue_0074,
			Donate = donateTab,
			Visuals = visualsTab,
			Crosshair = crosshairTab,
			Combat = combatTab,
			Misc = miscTab,
			Movement = movementTab,
			Farm = farmTab,
			Anims = animsTab,
			Radio = radioTab,
			Teleports = teleportsTab,
			Settings = settingsTab,
		}

		tabSkeleton_configTable_0076.ESP = tabSkeleton_configTable_0076.Visuals
		tabSkeleton_configTable_0076.LocalPlayer = tabSkeleton_configTable_0076.Movement
		tabSkeleton_configTable_0076.Aim = tabSkeleton_configTable_0076.Combat
		tabSkeleton_configTable_0076.Player = tabSkeleton_configTable_0076.Movement

		local function fixEmptyTab(tab)
			if not tab or typeof(tab) ~= "table" or typeof(tab.UIElements) ~= "table" then
				return
			end
			local container = tab.UIElements.ContainerFrame
			if not container or typeof(container) ~= "Instance" or not container:IsA("ScrollingFrame") then
				return
			end

			local function checkAndHide()
				local hasElements = (tab.Elements and #tab.Elements > 0)
				for _, child in ipairs(container:GetChildren()) do
					if child:IsA("GuiObject") and child.ClassName ~= "UIListLayout" and child.ClassName ~= "UIPadding" then
						local tl = child:FindFirstChildWhichIsA("TextLabel", true)
						local isPlaceholder = tl and string.find(string.lower(tl.Text), "empty")
						if not isPlaceholder then
							hasElements = true
							break
						end
					end
				end

				if hasElements then
					for _, child in ipairs(container:GetChildren()) do
						if child:IsA("Frame") then
							local tl = child:FindFirstChildWhichIsA("TextLabel", true)
							if tl and string.find(string.lower(tl.Text), "empty") then
								child.Visible = false
								child.Size = UDim2.new(1, 0, 0, 0)
							end
						end
					end
				end
			end

			checkAndHide()
			container.ChildAdded:Connect(function()
				task.defer(checkAndHide)
			end)
		end

		for _, tab in pairs(tabSkeleton_configTable_0076) do
			fixEmptyTab(tab)
		end

		task.defer(function()
			local mainBar = Window and typeof(Window.UIElements) == "table" and Window.UIElements.MainBar
			if mainBar and typeof(mainBar) == "Instance" then
				mainBar.DescendantAdded:Connect(function(descendant)
					if descendant:IsA("TextLabel") and string.find(string.lower(descendant.Text), "empty") then
						local parentFrame = descendant.Parent
						if parentFrame and parentFrame:IsA("Frame") and parentFrame.Parent and parentFrame.Parent:IsA("ScrollingFrame") then
							local scroller = parentFrame.Parent
							local hasContent = false
							for _, c in ipairs(scroller:GetChildren()) do
								if c ~= parentFrame and c:IsA("GuiObject") and c.ClassName ~= "UIListLayout" and c.ClassName ~= "UIPadding" then
									hasContent = true
									break
								end
							end
							if hasContent then
								parentFrame.Visible = false
								parentFrame.Size = UDim2.new(1, 0, 0, 0)
							end
						end
					end
				end)
			end
		end)

		return tabSkeleton_configTable_0076
	end

	Tabs = tabSkeleton_helperFunc_0072()
	game:GetService("RunService").Heartbeat:Wait()


end

local services_dataTable_0104
services_dataTable_0104 = { General = Tabs.Misc, Murderer = Tabs.Combat, Sheriff = Tabs.Combat, Farm = Tabs.Farm }

pcall(function()
	Tabs.ESP:Select()
end)

local Players
Players = game:GetService("Players")
local RunService
RunService = game:GetService("RunService")
local TweenService
TweenService = game:GetService("TweenService")
local ReplicatedStorage
ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting
Lighting = game:GetService("Lighting")
local StarterGui
StarterGui = game:GetService("StarterGui")
local currentCamera
currentCamera = workspace.CurrentCamera
local UserInputService
UserInputService = game:GetService("UserInputService")
local TeleportService
TeleportService = game:GetService("TeleportService")
local GuiService
GuiService = game:GetService("GuiService")
local HttpService
HttpService = game:GetService("HttpService")
local localPlayer
localPlayer = Players.LocalPlayer
local services_boolFlag_0105
services_boolFlag_0105 = false


local services_helperFunc_0106

services_helperFunc_0106 = function(services_param_0107)
	return false
end

local services_helperFunc_0108

services_helperFunc_0108 = function(services_param_0109)
end

local services_helperFunc_0110

services_helperFunc_0110 = function(services_param_0111)
end

local services_helperFunc_0112

services_helperFunc_0112 = function(services_param_0113)
	return false
end

local localChar
localChar = { character = localPlayer.Character }
localChar.humanoid = localChar.character and localChar.character:FindFirstChildOfClass("Humanoid")
localChar.rootPart = localChar.character and localChar.character:FindFirstChild("HumanoidRootPart")
local cleanupDeadConns, trackConn
local trackedConnections = {}

cleanupDeadConns = function()
	for i = #trackedConnections, 1, -1 do
		local services_localValue_0114 = trackedConnections[i]

		if not services_localValue_0114 or services_localValue_0114.Connected == false then
			table.remove(trackedConnections, i)
		end
	end
end

trackConn = function(services_param_0115)
	if services_param_0115 then
		if #trackedConnections >= 64 then
			cleanupDeadConns()
		end

		table.insert(trackedConnections, services_param_0115)
	end

	return services_param_0115
end

local Hub

Hub = {
	PlayerESP = false,
	PlayerESPStyle = "Filled",
	LineESP = false,
	NametagESP = false,
	GunESP = false,
	CoinESP = false,
	BulletTracer = {
		enabled = false,
		color = Color3.fromRGB(255, 55, 75),
		thickness = 0.35,
		duration = 1,
		folder = nil,
		shotCooldown = 3,
		lastDrawAt = 0,
	},
	ESP360 = false,
	DroppedGunNotify = false,
	ESPTable = {},
	ESPPlayerConnections = {},
	GunESPTable = {},
	CoinESPTable = {},
	CoinESPAddedConnection = nil,
	CoinESPRemovingConnection = nil,
	CoinESPMap = nil,
	CoinESPContainer = nil,
	CoinESPGeneration = 0,
	AimEnabled = false,
	AimlockPart = "Head",
	AimPrediction = true,
	AimPredictionStrength = 5,
	PredictionStrength = 5,
	AimStyle = "Aimlock",
	AimSticky = true,
	OnlyAimWhileSheriff = false,
	IgnoreWalls = false,
	HideFOV = false,
	FOV = 150,
	FlyEnabled = false,
	FlySpeed = 50,
	WalkSpeed = 16,
}

local cameraFov = workspace.CurrentCamera and workspace.CurrentCamera.FieldOfView
Hub.PlayerFOV = math.clamp(type(cameraFov) == "number" and cameraFov or 70, 40, 120)
Hub.NoclipEnabled = false
Hub.JumpPower = 50
Hub.InfiniteJumpEnabled = false
Hub.SpeedGlitchEnabled = false
Hub.SpeedGlitchPower = 2
Hub.JumpConnection = nil
Hub.StartFly = nil
Hub.StopFly = nil
Hub.ToggleInfiniteJump = nil
Hub.SetupInfiniteJump = nil
Hub.CleanupSelector = nil
Hub.CleanupRadio = nil
Hub.ToggleAutoShoot = nil
Hub.ToggleThrowKnifeButton = nil
Hub.UpdateAutoShoot = nil
Hub.TriggerAutoShootInput = nil
Hub.TriggerThrowKnifeInput = nil
Hub.UpdateAimBinding = nil
Hub.AutoShootTouchGui = nil
Hub.AutoShootTouchButton = nil

Hub.AutoShootState = {
	enabled = false,
	mode = "Normal",
	part = "Head",
	cooldown = 0.5,
	tapWindow = 2.25,
	retryInterval = 0.1,
	inputCooldown = 0.18,
	inputBusy = false,
	inputGeneration = 0,
	nextInputAt = 0,
	offset = 2.8,
	lastShotAt = 0,
}

Hub.AutoShootDragState = {
	enabled = false,
	size = "Medium",
	shape = "Square",
	backgroundColor = Color3.fromRGB(18, 18, 18),
	outlineColor = Color3.fromRGB(0, 255, 255),
	textColor = Color3.fromRGB(240, 236, 247),
	position = UDim2.new(0.84, 0, 0.62, 0),
	draggable = false,
	gui = nil,
	button = nil,
	beginConn = nil,
	inputConn = nil,
	globalConn = nil,
	endConn = nil,
	input = nil,
	start = nil,
	startPos = nil,
	dragging = false,
}

Hub.AutoGunTouchEnabled = false
Hub.AutoGunTouchSources = { misc = false }
Hub.AutoGunTouchPending = {}
Hub.SetAutoGunTouchSource = nil
Hub.AutoGunTouchControl = nil
Hub.AutoGunTouchBeforeCoinFarm = false
Hub.AutoGunTouchForcedByCoinFarm = false
Hub.SetCoinFarmAutoGunTouch = nil
Hub.TakeDroppedGunOnce = nil

Hub.GetGunButtonState = {
	enabled = false,
	size = "Medium",
	shape = "Square",
	position = UDim2.new(0.84, 0, 0.71, 0),
	draggable = false,
	gui = nil,
	button = nil,
	beginConn = nil,
	inputConn = nil,
	globalConn = nil,
	endConn = nil,
	input = nil,
	start = nil,
	startPos = nil,
	dragging = false,
}

Hub.BombJump = { busy = false, nextReadyAt = 0, cooldown = 22 }

Hub.BombJumpButtonState = {
	enabled = false,
	size = "Medium",
	shape = "Square",
	position = UDim2.new(0.84, 0, 0.8, 0),
	draggable = false,
	gui = nil,
	button = nil,
	beginConn = nil,
	inputConn = nil,
	globalConn = nil,
	endConn = nil,
	input = nil,
	start = nil,
	startPos = nil,
	dragging = false,
}

Hub.QuickMenuState = {
	enabled = false,
	open = false,
	position = UDim2.new(0.91, 0, 0.5, 0),
	gui = nil,
	button = nil,
	actions = {},
	connections = {},
	dragging = false,
	dragInput = nil,
	dragStart = nil,
	dragStartPosition = nil,
	dragMoved = false,
}

Hub.RunBombJump = nil
Hub.AntiFlingEnabled = false
Hub.AntiFlingSources = { manual = false }
Hub.SetAntiFlingSource = nil
Hub.SetCoinFarmAntiFling = nil

Hub.ThrowKnifeButtonState = {
	enabled = false,
	mode = "Normal",
	size = "Medium",
	shape = "Square",
	backgroundColor = Color3.fromRGB(112, 35, 185),
	outlineColor = Color3.fromRGB(0, 255, 255),
	textColor = Color3.fromRGB(255, 255, 255),
	position = UDim2.new(0.84, 0, 0.53, 0),
	draggable = false,
	gui = nil,
	button = nil,
	beginConn = nil,
	inputConn = nil,
	globalConn = nil,
	endConn = nil,
	inputCooldown = 0.4,
	inputBusy = false,
	nextInputAt = 0,
	input = nil,
	start = nil,
	startPos = nil,
	dragging = false,
}

Hub.RoleState = { cache = {}, lastGunDropPicker = nil, lastGunDropAt = 0, gunDropPickerTtl = 2.5 }

Hub.RoundState = {
	active = false,
	coinsReady = false,
	initialized = false,
	startedAt = 0,
	currentMapName = nil,
	currentMapInstance = nil,
	mapReceivedAt = 0,
}

Hub.Crosshair = {
	enabled = false,
	style = "star",
	mode = "Shiftlock / First Person",
	size = 30,
	speed = 360,
	frameInterval = UserInputService.TouchEnabled and 0.033333333333333333 or 0.016666666666666666,
	rgb = false,
	color = Color3.fromRGB(255, 255, 255),
	root = nil,
	parts = {},
	connection = nil,
	angle = 0,
	lastUpdate = 0,
	cursorHidden = false,
	suppressCursor = false,
	cursorConnection = nil,
	originalMouseIconEnabled = nil,
	userGameSettings = (typeof(UserSettings) == "function" and pcall(UserSettings)) and UserSettings():GetService("UserGameSettings") or nil,
	iconModule = nil,
	iconLoading = false,
	icons = {
		star = "rbxassetid://136141469398409",
		heart = "rbxassetid://116559368303288",
		["circle-plus"] = "rbxassetid://113157136350384",
		crosshair = "rbxassetid://134242818164054",
	},
}

Hub.Spinbot = { enabled = false, speed = 1, connection = nil, humanoid = nil, originalAutoRotate = nil }

Hub.HitboxExpander = {
	enabled = false,
	size = 6,
	visible = false,
	originals = {},
	playerConnections = {},
	partConnections = {},
	localPlayerConnection = nil,
	localCharacterConnection = nil,
	localToolConnections = {},
	stabGeneration = 0,
	stabActive = false,
}

Hub.NoclipParts = {}
Hub.NoclipConn = nil
Hub.NoclipStepConn = nil
Hub.NoclipNextRefresh = 0
Hub.FlingActive = false
Hub.FlingAllRunning = false
Hub.SelectedFlingName = nil
Hub.FlingOldPos = nil
Hub.SafezonePart = nil
Hub.XRayEnabled = false
Hub.XRayOriginal = {}
Hub.XRayConn = nil
Hub.XRayRemoveConn = nil
Hub.XRayRefreshConn = nil
Hub.XRayScanGeneration = 0
Hub.XRayMap = nil

Hub.XRayButtonState = {
	enabled = false,
	size = "Medium",
	shape = "Square",
	position = UDim2.new(0.84, 0, 0.35, 0),
	draggable = false,
	gui = nil,
	button = nil,
	beginConn = nil,
	inputConn = nil,
	globalConn = nil,
	endConn = nil,
	input = nil,
	start = nil,
	startPos = nil,
	dragging = false,
}

Hub.WallPhaseButtonState = {
	enabled = false,
	size = "Medium",
	shape = "Square",
	backgroundColor = Color3.fromRGB(27, 24, 34),
	outlineColor = Color3.fromRGB(0, 255, 255),
	textColor = Color3.fromRGB(255, 255, 255),
	position = UDim2.new(0.84, 0, 0.26, 0),
	draggable = false,
	gui = nil,
	button = nil,
	beginConn = nil,
	inputConn = nil,
	globalConn = nil,
	endConn = nil,
	input = nil,
	start = nil,
	startPos = nil,
	dragging = false,
}

Hub.FlyButtonState = {
	enabled = false,
	size = "Medium",
	shape = "Square",
	position = UDim2.new(0.66, 0, 0.71, 0),
	draggable = false,
	gui = nil,
	button = nil,
	beginConn = nil,
	inputConn = nil,
	globalConn = nil,
	endConn = nil,
	input = nil,
	start = nil,
	startPos = nil,
	dragging = false,
}

Hub.NoclipButtonState = {
	enabled = false,
	size = "Medium",
	shape = "Square",
	position = UDim2.new(0.66, 0, 0.8, 0),
	draggable = false,
	gui = nil,
	button = nil,
	beginConn = nil,
	inputConn = nil,
	globalConn = nil,
	endConn = nil,
	input = nil,
	start = nil,
	startPos = nil,
	dragging = false,
}

Hub.AimlockButtonState = {
	enabled = false,
	size = "Medium",
	shape = "Square",
	position = UDim2.new(0.84, 0, 0.44, 0),
	draggable = false,
	gui = nil,
	button = nil,
	beginConn = nil,
	inputConn = nil,
	globalConn = nil,
	endConn = nil,
	input = nil,
	start = nil,
	startPos = nil,
	dragging = false,
}

Hub.InvisibilityEnabled = false
Hub.InvisibilityTransparency = 0.75
Hub.InvisibilitySeatName = "invischair"
Hub.InvisibilitySeatTeleportPosition = Vector3.new(-25.95, 400, 3537.55)
Hub.InvisibilityDescAddedConn = nil
Hub.InvisibilityRefreshConn = nil
Hub.WalkSpeedConn = nil

Hub.TouchButtons = {
	XRayToggleControl = nil,
	XRayKeybindControl = nil,
	AimToggleControl = nil,
	FlyToggleControl = nil,
	NoclipToggleControl = nil,
	AutoShootToggleControl = nil,
	ThrowKnifeToggleControl = nil,
	Theme = {
		backgroundColor = Color3.fromRGB(27, 24, 34),
		accentColor = Color3.fromRGB(0, 255, 255),
		textColor = Color3.fromRGB(240, 236, 247),
	},
	iconModule = nil,
	iconLoading = false,
	iconCache = {},
	remoteIconCache = {},
	remoteIconLoading = {},
	remoteIconFailed = {},
	iconFallback = {
		default = "rbxassetid://130359823580534",
		eye = "rbxassetid://100033680381365",
		target = "rbxassetid://87563802520297",
		hand = "rbxassetid://130703864968637",
		bomb = "rbxassetid://139223800924636",
		["brick-wall"] = "rbxassetid://112878522258821",
		slice = "rbxassetid://95810504278179",
		crosshair = "rbxassetid://134242818164054",
		send = "rbxassetid://97136202386756",
		circle = "rbxassetid://130359823580534",
	},
	Icons = {
		XRay = "eye",
		Aimlock = "target",
		["Get Gun"] = "hand",
		["Bomb Jump"] = "bomb",
		["Wall Glitch"] = "brick-wall",
		["Throw Knife"] = "slice",
		Shoot = "crosshair",
		["Auto Shoot"] = "crosshair",
		AutoShoot = "crosshair",
		Fly = "rocket",
		Noclip = "grid-3x3",
	},
	RemoteIcons = {
		XRay = "xray.png",
		Aimlock = "aimlock.png",
		["Get Gun"] = "get-gun.png",
		["Bomb Jump"] = "bomb-jump.png",
		["Wall Glitch"] = "wall-glitch.png",
		["Throw Knife"] = "throw-knife.png",
		Shoot = "shoot.png",
		["Auto Shoot"] = "shoot.png",
		AutoShoot = "shoot.png",
		Fly = "fly.png",
		Noclip = "noclip.png",
	},
	Sizes = {
		Small = { size = UDim2.fromOffset(135, 52), textSize = 21 },
		Medium = { size = UDim2.fromOffset(170, 70), textSize = 28 },
		Large = { size = UDim2.fromOffset(210, 86), textSize = 32 },
	},
}

Hub.AutoPrestige = {
	enabled = false,
	waitingForServer = false,
	requestedPrestige = nil,
	lastRequestAt = 0,
	connection = nil,
	control = nil,
	profile = nil,
	profileRefreshedAt = 0,
	lastKnownPrestige = nil,
	blackScreenPrestige = nil,
	blackScreenPrestigeResetPending = false,
	levelModule = nil,
}

Hub.AutoClaimReward = {
	enabled = true,
	connection = nil,
	control = nil,
}

Hub.CoinFarm = {
	enabled = false,
	mode = "CFrame",
	position = "Normal",
	speed = 28,
	speedControl = nil,
	blackScreenEnabled = false,
	disable3DRendering = false,
	blackScreenGui = nil,
	blackScreenStartedAt = 0,
	sessionStartedAt = 0,
	resumedSessionElapsed = 0,
	antiAfkLastAt = 0,
	blackScreenUpdateGeneration = 0,
	blackScreenLabels = {},
	blackScreenControl = nil,
	renderingControl = nil,
	reduceCoinVisuals = UserInputService.TouchEnabled,
	optimizedCoinVisuals = setmetatable({}, { __mode = "k" }),
	phase = "Disabled",
	generation = 0,
	workerRunning = false,
	coins = {},
	retryUntil = {},
	contactAttempts = {},
	coinVisualParts = setmetatable({}, { __mode = "k" }),
	currentCoin = nil,
	indexedMap = nil,
	indexedCoinContainer = nil,
	mapAddedConnection = nil,
	mapRemovingConnection = nil,
	lastIndexAttemptAt = 0,
	lastBagCount = nil,
	bagMaximum = nil,
	bagFull = false,
	resetRequestedForBag = false,
	xpFarmEnabled = false,
	serverHopLowPlayers = false,
	serverHopPlayerThreshold = 4,
	serverHopRunning = false,
	serverHopCount = 0,
	serverHopTimerMinutes = 15,
	serverHopTimerStartedAt = 0,
	resumedFromServerHop = false,
	webhookUrl = "",
	webhookDraft = "",
	webhookInput = nil,
	webhookGeneration = 0,
	bagWebhookSent = false,
	serverHopControl = nil,
	serverHopThresholdControl = nil,
	serverHopTimerControl = nil,
	antiBotEnabled = false,
	antiBotControl = nil,
	antiBotLastCount = 0,
	StartLowPlayerServerHop = nil,
	StartAntiBotServerHop = nil,
	xpWaitRunning = false,
	xpWaitGeneration = 0,
	xpWaitShotStarted = false,
	xpWaitFlingAttempted = false,
	endRoundEnabled = false,
	endRoundRunning = false,
	endRoundCompleted = false,
	endRoundGeneration = 0,
	endRoundDeathRequested = false,
	endRoundRespawnRetryRunning = false,
	endRoundRespawnRetryGeneration = 0,
	lastLocalDead = false,
	flingMurderer = nil,
	flingSheriff = nil,
	getSheriffFlingTarget = nil,
	sheriffFlingRunning = false,
	sheriffFlingBlocking = false,
	sheriffFlingCompleted = false,
	shootMurderer = nil,
	runKnifeAura = nil,
	totalCollected = 0,
	totalEarnedXP = 0,
	lastObservedXP = nil,
	ownedCoinAmountLabel = nil,
	bagCurrentValue = nil,
	bagCountLabel = nil,
	ranThisRound = false,
	endTeleportDone = false,
	safetyChecked = false,
	safetyStartedAt = 0,
	murdererNearRange = 30,
	nextMurdererCheckAt = 0,
	nextMurdererEscapeAt = 0,
	escapeCoin = nil,
	escapeUnderActive = false,
	activeTween = nil,
	underCharacter = nil,
	underParts = {},
	underToolMassless = {},
	underAddedConnection = nil,
	stabilizer = nil,
	stabilizerRoot = nil,
	nextUnderEnforceAt = 0,
	statsControl = nil,
	toggleControl = nil,
	xpFarmControl = nil,
	UpdateXPFarmLock = nil,
	endRoundControl = nil,
	modeControl = nil,
	positionControl = nil,
	lastStatsText = nil,
}

Hub.ShowRoundTimer = false
Hub.ShowTimerControl = nil
Hub.ShowTimerBeforeXPFarm = false
Hub.ShowTimerForcedByXPFarm = false
Hub.SetXPFarmTimerForced = nil
Hub.UpdateRoundTimer = nil
Hub.MobileRoundTimerGui = nil
Hub.AvoidMurderer = { enabled = false, distance = 35, nextTeleportAt = 0, accumulator = 0, connection = nil }
Hub.AutoMapVote = { enabled = false, board = "Board 1", thread = nil, control = nil, boardControl = nil }
local VirtualUser = nil

pcall(function()
	VirtualUser = game:GetService("VirtualUser")
end)

trackConn(localPlayer.Idled:Connect(function()
	if not Hub.CoinFarm.enabled or not VirtualUser then
		return
	end
	local now = os.clock()
	if now - Hub.CoinFarm.antiAfkLastAt < 30 then
		return
	end
	Hub.CoinFarm.antiAfkLastAt = now
	local currentCamera2 = workspace.CurrentCamera
	local cFrame = currentCamera2 and currentCamera2.CFrame or CFrame.new()

	pcall(function()
		VirtualUser:CaptureController()
		VirtualUser:Button2Down(Vector2.new(0, 0), cFrame)
	end)

	task.delay(0.1, function()
		pcall(function()
			VirtualUser:Button2Up(Vector2.new(0, 0), cFrame)
		end)
	end)
end))

Hub.AutoPrestige.GetData = function(prestige_param_0116)
	local now = os.clock()
	local prestige_profileValue_0117 = prestige_param_0116 or not Hub.AutoPrestige.profile
	local prestige_boolFlag_0118

	if prestige_profileValue_0117 then
		prestige_boolFlag_0118 = prestige_profileValue_0117
	else
		prestige_boolFlag_0118 = now - (Hub.AutoPrestige.profileRefreshedAt or 0) >= 1
	end

	if prestige_boolFlag_0118 then
		local remotes = ReplicatedStorage:FindFirstChild("Remotes")
		remotes = remotes and remotes:FindFirstChild("Inventory")
		local getProfileData = remotes and remotes:FindFirstChild("GetProfileData")

		if getProfileData and getProfileData:IsA("RemoteFunction") then
			local ok, profile = pcall(function()
				return getProfileData:InvokeServer(localPlayer.Name)
			end)

			if ok and type(profile) == "table" then
				Hub.AutoPrestige.profile = profile
				Hub.AutoPrestige.profileRefreshedAt = now
			end
		end
	end

	if not Hub.AutoPrestige.profile then
		local ok, profile = pcall(require, ReplicatedStorage.Modules.ProfileData)

		if ok and type(profile) == "table" then
			Hub.AutoPrestige.profile = profile
			Hub.AutoPrestige.profileRefreshedAt = now
		end
	end

	if not Hub.AutoPrestige.levelModule then
		local ok, levelModule = pcall(require, ReplicatedStorage.Modules.LevelModule)

		if ok and type(levelModule) == "table" then
			Hub.AutoPrestige.levelModule = levelModule
		end
	end

	return Hub.AutoPrestige.profile, Hub.AutoPrestige.levelModule
end

Hub.AutoPrestige.SetControl = function(prestige_param_0119)
	local control = Hub.AutoPrestige.control

	if control and type(control.Set) == "function" then
		pcall(function()
			control:Set(prestige_param_0119)
		end)
	end
end

Hub.AutoPrestige.FireButton = function(prestige_param_0120)
	if not prestige_param_0120 or not prestige_param_0120:IsA("GuiButton") then
		return false
	end

	if type(firesignal) == "function" then
		if pcall(function()
			firesignal(prestige_param_0120.MouseButton1Click)
		end) then
			return true
		end
	end

	if type(getconnections) == "function" then
		local prestige_boolFlag_0121 = false

		for _, prestige_loopVar_0122 in ipairs(getconnections(prestige_param_0120.MouseButton1Click)) do
			local ok = pcall(function()
				if type(prestige_loopVar_0122.Fire) == "function" then
					prestige_loopVar_0122:Fire()
				elseif type(prestige_loopVar_0122.Function) == "function" then
					prestige_loopVar_0122.Function()
				end
			end)

			prestige_boolFlag_0121 = prestige_boolFlag_0121 or ok
		end

		if prestige_boolFlag_0121 then
			return true
		end
	end

	return false
end

Hub.AutoPrestige.Request = function()
	local playerGui = localPlayer:FindFirstChild("PlayerGui")
	playerGui = playerGui and playerGui:FindFirstChild("MainGUI")
	playerGui = playerGui and playerGui:FindFirstChild("Game")
	local level = playerGui and playerGui:FindFirstChild("Level")
	local tabletLevel = playerGui and playerGui:FindFirstChild("TabletLevel")
	level = level and level:FindFirstChild("Prestige")

	if not level or not level.Visible then
		level = tabletLevel and tabletLevel:FindFirstChild("Prestige")
	end

	if level and Hub.AutoPrestige.FireButton(level) then
		task.wait(0.1)
		playerGui = playerGui and playerGui:FindFirstChild("Prestige")
		if Hub.AutoPrestige.FireButton(playerGui and playerGui:FindFirstChild("Accept")) then
			return true
		end
	end

	local remotes = ReplicatedStorage:FindFirstChild("Remotes")
	remotes = remotes and remotes:FindFirstChild("Inventory")
	remotes = remotes and remotes:FindFirstChild("Prestige")
	if remotes and remotes:IsA("RemoteEvent") then
		remotes:FireServer()
		return true
	end
	return false
end

Hub.AutoPrestige.Check = function()
	if not Hub.AutoPrestige.enabled then
		return false
	end
	local prestige_getDataValue_0123, prestige_getDataValue_0124 = Hub.AutoPrestige.GetData(true)
	if not prestige_getDataValue_0123 or not prestige_getDataValue_0124 or type(prestige_getDataValue_0124.GetLevel) ~= "function" then
		return false
	end
	local lastKnownPrestige = tonumber(localPlayer:GetAttribute("Prestige")) or tonumber(prestige_getDataValue_0123.Prestige) or 0
	local prestige_numericVar_0125 = tonumber(prestige_getDataValue_0123.NewXP) or 0
	local prestige_localValue_0126 = tonumber
	local prestige_localValue_0127 = prestige_getDataValue_0124.GetLevel(prestige_numericVar_0125)
	local prestige_callResult_0128 = prestige_localValue_0126(prestige_localValue_0127) or 1
	local prestige_lastKnownPrestigeValue_0129 = tonumber(Hub.AutoPrestige.lastKnownPrestige)
	Hub.AutoPrestige.lastKnownPrestige = lastKnownPrestige

	if prestige_lastKnownPrestigeValue_0129 and lastKnownPrestige > prestige_lastKnownPrestigeValue_0129 then
		Hub.AutoPrestige.waitingForServer = false
		Hub.AutoPrestige.requestedPrestige = nil
	end

	if lastKnownPrestige >= 10 then
		Hub.AutoPrestige.enabled = false
		Hub.AutoPrestige.waitingForServer = false
		Hub.AutoPrestige.requestedPrestige = nil
		Hub.AutoPrestige.SetControl(false)

		WindUI:Notify({
			Title = "自动转生",
			Content = "已达到最高转生等级 (X)",
			Icon = "crown",
			Duration = 3,
		})

		return false
	end

	if Hub.AutoPrestige.waitingForServer then
		if not (lastKnownPrestige > (tonumber(Hub.AutoPrestige.requestedPrestige) or lastKnownPrestige) or prestige_callResult_0128 < 100) then
			return false
		end
		Hub.AutoPrestige.waitingForServer = false
		Hub.AutoPrestige.requestedPrestige = nil
	end

	local prestige_boolFlag_0130 = prestige_callResult_0128 < 100
	local prestige_boolFlag_0131

	if prestige_boolFlag_0130 then
		prestige_boolFlag_0131 = prestige_boolFlag_0130
	else
		local lastRequestAt = Hub.AutoPrestige.lastRequestAt
		prestige_boolFlag_0131 = os.clock() - lastRequestAt < 15
	end

	if prestige_boolFlag_0131 then
		return false
	end
	Hub.AutoPrestige.waitingForServer = true
	Hub.AutoPrestige.requestedPrestige = lastKnownPrestige
	Hub.AutoPrestige.lastRequestAt = os.clock()

	if not Hub.AutoPrestige.Request() then
		Hub.AutoPrestige.waitingForServer = false
		Hub.AutoPrestige.requestedPrestige = nil
		return false
	end

	WindUI:Notify({
		Title = "自动转生",
		Content = "转生 " .. tostring(lastKnownPrestige + 1) .. " requested",
		Icon = "crown",
		Duration = 2.5,
	})

	return true
end

Hub.AutoPrestige.SetEnabled = function(prestige_param_0132)
	Hub.AutoPrestige.enabled = prestige_param_0132 and true or false

	if not Hub.AutoPrestige.enabled then
		Hub.AutoPrestige.waitingForServer = false
		Hub.AutoPrestige.requestedPrestige = nil
		return
	end

	task.defer(Hub.AutoPrestige.Check)
end

Hub.AutoPrestige.Init = function()
	if Hub.AutoPrestige.connection then
		return
	end
	local updateData2 = ReplicatedStorage:FindFirstChild("UpdateData2")

	if updateData2 and updateData2:IsA("RemoteEvent") then
		Hub.AutoPrestige.connection = updateData2.OnClientEvent:Connect(function()
			task.defer(function()
				RunService.Heartbeat:Wait()
				Hub.AutoPrestige.GetData(true)

				if Hub.CoinFarm.enabled and type(Hub.CoinFarm.SyncEarnedXP) == "function" then
					Hub.CoinFarm.SyncEarnedXP()
				end

				if Hub.AutoPrestige.enabled then
					Hub.AutoPrestige.Check()
				end
			end)
		end)
	end
end

Hub.AutoPrestige.Destroy = function()
	Hub.AutoPrestige.enabled = false
	Hub.AutoPrestige.waitingForServer = false
	Hub.AutoPrestige.requestedPrestige = nil

	if Hub.AutoPrestige.connection then
		Hub.AutoPrestige.connection:Disconnect()
		Hub.AutoPrestige.connection = nil
	end
end

Hub.AutoPrestige.Init()

task.spawn(function()
	while foxnameMM2Runtime.alive and not isTerminated do
		if Hub.AutoPrestige.enabled then
			pcall(Hub.AutoPrestige.Check)
		end

		task.wait(2)
	end
end)

Hub.AutoClaimReward.FireButton = function(btn)
	if not btn or not btn:IsA("GuiButton") then
		return false
	end

	local fired = false

	if type(firesignal) == "function" then
		for _, sig in ipairs({ btn.Activated, btn.MouseButton1Click }) do
			if sig and pcall(firesignal, sig) then
				fired = true
			end
		end

		if fired then
			return true
		end
	end

	if type(getconnections) == "function" then
		for _, sig in ipairs({ btn.Activated, btn.MouseButton1Click }) do
			if sig then
				for _, con in ipairs(getconnections(sig)) do
					local ok = pcall(function()
						if type(con.Fire) == "function" then
							con:Fire()
						elseif type(con.Function) == "function" then
							con.Function()
						end
					end)

					fired = fired or ok
				end
			end
		end
	end

	return fired
end

Hub.AutoClaimReward.Check = function()
	if not Hub.AutoClaimReward.enabled then
		return false
	end

	local playerGui = localPlayer:FindFirstChild("PlayerGui")
	if not playerGui then
		return false
	end

	local claimed = false
	local crossPlatform = playerGui:FindFirstChild("CrossPlatform")
	local newItem = crossPlatform and crossPlatform:FindFirstChild("NewItem")
	local medium = newItem and newItem:FindFirstChild("Medium")

	if medium and medium.Visible then
		local container = medium:FindFirstChild("Container")
		local claimBtn = container and container:FindFirstChild("Claim")
		local attempts = 0

		while medium.Visible and claimBtn and attempts < 10 do
			attempts += 1
			if Hub.AutoClaimReward.FireButton(claimBtn) then
				claimed = true
			end
			task.wait(0.1)
		end
	end

	local mainGui = playerGui:FindFirstChild("MainGUI")
	local gameFrame = mainGui and mainGui:FindFirstChild("Game")
	local legacyNewItem = gameFrame and gameFrame:FindFirstChild("NewItem")

	if legacyNewItem and legacyNewItem.Visible then
		local container = legacyNewItem:FindFirstChild("Container")
		local claimBtn = container and container:FindFirstChild("Claim")

		if claimBtn and Hub.AutoClaimReward.FireButton(claimBtn) then
			claimed = true
		end
	end

	return claimed
end

Hub.AutoClaimReward.SetEnabled = function(enabled)
	Hub.AutoClaimReward.enabled = enabled and true or false

	if Hub.AutoClaimReward.enabled then
		task.defer(Hub.AutoClaimReward.Check)
	end
end

Hub.AutoClaimReward.Init = function()
	if Hub.AutoClaimReward.connection then
		return
	end

	local playerGui = localPlayer:FindFirstChild("PlayerGui")
	local crossPlatform = playerGui and playerGui:FindFirstChild("CrossPlatform")
	local newItem = crossPlatform and crossPlatform:FindFirstChild("NewItem")
	local medium = newItem and newItem:FindFirstChild("Medium")

	if medium then
		Hub.AutoClaimReward.connection = medium:GetPropertyChangedSignal("Visible"):Connect(function()
			if medium.Visible and Hub.AutoClaimReward.enabled then
				task.defer(Hub.AutoClaimReward.Check)
			end
		end)
	end
end

Hub.AutoClaimReward.Destroy = function()
	Hub.AutoClaimReward.enabled = false

	if Hub.AutoClaimReward.connection then
		Hub.AutoClaimReward.connection:Disconnect()
		Hub.AutoClaimReward.connection = nil
	end
end

Hub.AutoClaimReward.Init()

task.spawn(function()
	while foxnameMM2Runtime.alive and not isTerminated do
		if Hub.AutoClaimReward.enabled then
			if not Hub.AutoClaimReward.connection then
				pcall(Hub.AutoClaimReward.Init)
			end

			pcall(Hub.AutoClaimReward.Check)
		end

		task.wait(0.5)
	end
end)

Hub.CoinFarm.RefreshStats = function()
	local statsControl = Hub.CoinFarm.statsControl
	local cache = Hub.RoleState.cache
	local prestige_callResult_0133 = type(cache) == "table" and (cache[localPlayer.Name] or cache[tostring(localPlayer.UserId)] or cache[localPlayer.UserId]) or nil
	local role

	if type(Hub.CoinFarm.GetCachedRole) == "function" then
		role = Hub.CoinFarm.GetCachedRole(localPlayer)
	else
		role = type(prestige_callResult_0133) == "table" and prestige_callResult_0133.Role or nil
	end

	if role ~= "Innocent" and role ~= "Sheriff" and role ~= "Murderer" and role ~= "Hero" then
		role = "Unknown"
	end

	local lastStatsText = "状态：" .. tostring(Hub.CoinFarm.phase) .. "\n累计收集金币：" .. tostring(Hub.CoinFarm.totalCollected) .. "\n累计获得经验：" .. tostring(Hub.CoinFarm.totalEarnedXP) .. "\n身份：" .. role

	if Hub.CoinFarm.lastStatsText ~= lastStatsText then
		Hub.CoinFarm.lastStatsText = lastStatsText

		if statsControl and type(statsControl.SetDesc) == "function" then
			pcall(function()
				statsControl:SetDesc(lastStatsText)
			end)
		end
	end

	if type(Hub.CoinFarm.RefreshBlackScreen) == "function" then
		Hub.CoinFarm.RefreshBlackScreen(role)
	end
end

Hub.CoinFarm.GetCurrentXP = function()
	local profile = Hub.AutoPrestige.profile

	if type(profile) ~= "table" then
		local modules = ReplicatedStorage:FindFirstChild("Modules")
		modules = modules and modules:FindFirstChild("ProfileData")

		if modules then
			local ok, profile2 = pcall(require, modules)

			if ok and type(profile2) == "table" then
				Hub.AutoPrestige.profile = profile2
				profile = profile2
			end
		end
	end

	local prestige_numericVar_0134 = type(profile) == "table" and tonumber(profile.NewXP) or nil
	return prestige_numericVar_0134 and math.max(0, math.floor(prestige_numericVar_0134)) or nil
end

Hub.CoinFarm.SyncEarnedXP = function()
	if not Hub.CoinFarm.enabled then
		return false
	end
	local prestige_getCurrentXPValue_0135 = Hub.CoinFarm.GetCurrentXP()
	if prestige_getCurrentXPValue_0135 == nil then
		return false
	end
	local prestige_lastObservedXPValue_0136 = tonumber(Hub.CoinFarm.lastObservedXP)
	Hub.CoinFarm.lastObservedXP = prestige_getCurrentXPValue_0135
	if prestige_lastObservedXPValue_0136 == nil or prestige_getCurrentXPValue_0135 <= prestige_lastObservedXPValue_0136 then
		return false
	end
	local coinFarm = Hub.CoinFarm
	coinFarm.totalEarnedXP = coinFarm.totalEarnedXP + prestige_getCurrentXPValue_0135 - prestige_lastObservedXPValue_0136
	Hub.CoinFarm.RefreshStats()
	return true
end

Hub.CoinFarm.SetPhase = function(phase)
	if Hub.CoinFarm.phase == phase then
		return
	end
	Hub.CoinFarm.phase = phase
	Hub.CoinFarm.RefreshStats()
end

Hub.CoinFarm.GetRoundTimeRemaining = function()
	local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
	playerGui = playerGui and playerGui:FindFirstChild("MainGUI")
	playerGui = playerGui and playerGui:FindFirstChild("Game")
	playerGui = playerGui and playerGui:FindFirstChild("Timer")
	playerGui = playerGui and playerGui:FindFirstChild("XPText")
	local text = playerGui and playerGui:IsA("TextLabel") and playerGui.Text or ""
	local match, prestige_localValue_0137 = text:match("(%d+)%s*m%s*(%d+)%s*s")
	if match and prestige_localValue_0137 then
		return match * 60 + tonumber(prestige_localValue_0137), "GameUI"
	end
	local match2, prestige_localValue_0138 = text:match("(%d+)%s*:%s*(%d+)")
	if match2 and prestige_localValue_0138 then
		return match2 * 60 + prestige_localValue_0138, "GameUI"
	end
	local match3 = text:match("^(%d+)%s*s$")
	if match3 then
		return tonumber(match3), "GameUI"
	end
	local roundTimerPart = workspace:FindFirstChild("RoundTimerPart")

	if roundTimerPart then
		local prestige_numericVar_0139 = tonumber(roundTimerPart:GetAttribute("Time"))
		if prestige_numericVar_0139 and prestige_numericVar_0139 >= 0 then
			return math.max(0, prestige_numericVar_0139), "Attribute"
		end
		local surfaceGui = roundTimerPart:FindFirstChildWhichIsA("SurfaceGui")
		surfaceGui = surfaceGui and surfaceGui:FindFirstChild("Timer", true)
		local text2 = surfaceGui and surfaceGui:IsA("TextLabel") and surfaceGui.Text or ""
		local match4, prestige_localValue_0140 = text2:match("(%d+)%s*m%s*(%d+)%s*s")
		if match4 and prestige_localValue_0140 then
			return match4 * 60 + prestige_localValue_0140, "SurfaceGui"
		end
		local match5, prestige_localValue_0141 = text2:match("(%d+)%s*:%s*(%d+)")
		if match5 and prestige_localValue_0141 then
			return match5 * 60 + prestige_localValue_0141, "SurfaceGui"
		end
		local match6 = text2:match("(%d+)%s*s")
		if match6 then
			return tonumber(match6), "SurfaceGui"
		end
		local prestige_numericVar_0142 = tonumber(roundTimerPart:GetAttribute("RoundLength"))
		if prestige_numericVar_0142 and Hub.RoundState.startedAt > 0 then
			local startedAt = Hub.RoundState.startedAt
			return math.max(0, prestige_numericVar_0142 - os.clock() - startedAt), "Estimated"
		end
	end

	if Hub.RoundState.startedAt > 0 then
		local startedAt = Hub.RoundState.startedAt
		return math.max(0, 180 - os.clock() - startedAt), "Estimated"
	end
	return nil, "Unavailable"
end

Hub.CoinFarm.CancelXPFarmWait = function()
	local coinFarm = Hub.CoinFarm
	coinFarm.xpWaitGeneration = coinFarm.xpWaitGeneration + 1
	Hub.CoinFarm.xpWaitRunning = false
	Hub.CoinFarm.xpWaitShotStarted = false
	Hub.CoinFarm.xpWaitFlingAttempted = false
end

Hub.CoinFarm.CancelEndRoundRespawnRetry = function()
	local coinFarm = Hub.CoinFarm
	coinFarm.endRoundRespawnRetryGeneration = coinFarm.endRoundRespawnRetryGeneration + 1
	Hub.CoinFarm.endRoundRespawnRetryRunning = false
end

Hub.CoinFarm.DisconnectMap = function()
	if Hub.CoinFarm.mapAddedConnection then
		Hub.CoinFarm.mapAddedConnection:Disconnect()
		Hub.CoinFarm.mapAddedConnection = nil
	end

	if Hub.CoinFarm.mapRemovingConnection then
		Hub.CoinFarm.mapRemovingConnection:Disconnect()
		Hub.CoinFarm.mapRemovingConnection = nil
	end

	table.clear(Hub.CoinFarm.coins)
	table.clear(Hub.CoinFarm.retryUntil)
	table.clear(Hub.CoinFarm.contactAttempts)
	table.clear(Hub.CoinFarm.coinVisualParts)
	Hub.CoinFarm.currentCoin = nil
	Hub.CoinFarm.escapeCoin = nil
	Hub.CoinFarm.escapeUnderActive = false
	Hub.CoinFarm.indexedMap = nil
	Hub.CoinFarm.indexedCoinContainer = nil
end

Hub.CoinFarm.CancelTween = function()
	local activeTween = Hub.CoinFarm.activeTween
	Hub.CoinFarm.activeTween = nil
	if not activeTween then
		return
	end

	pcall(function()
		activeTween:Cancel()
	end)

	pcall(function()
		activeTween:Destroy()
	end)
end

Hub.CoinFarm.DisableUnder = function()
	if Hub.CoinFarm.underAddedConnection then
		Hub.CoinFarm.underAddedConnection:Disconnect()
		Hub.CoinFarm.underAddedConnection = nil
	end

	if Hub.CoinFarm.stabilizer then
		pcall(function()
			Hub.CoinFarm.stabilizer:Destroy()
		end)

		Hub.CoinFarm.stabilizer = nil
	end

	Hub.CoinFarm.stabilizerRoot = nil

	for k, underPart in pairs(Hub.CoinFarm.underParts) do
		if k and k.Parent then
			if Hub.NoclipEnabled then
				if Hub.NoclipParts[k] == nil or Hub.NoclipParts[k] == false then
					Hub.NoclipParts[k] = underPart
				end
			else
				k.CanCollide = underPart
			end

			local farmBase_underToolMasslessValue_0143 = Hub.CoinFarm.underToolMassless[k]

			if farmBase_underToolMasslessValue_0143 ~= nil then
				k.Massless = farmBase_underToolMasslessValue_0143
			end
		end
	end

	table.clear(Hub.CoinFarm.underParts)
	table.clear(Hub.CoinFarm.underToolMassless)
	Hub.CoinFarm.underCharacter = nil
	Hub.CoinFarm.nextUnderEnforceAt = 0
end

Hub.CoinFarm.TrackUnderPart = function(farmBase_param_0144)
	if not farmBase_param_0144:IsA("BasePart") then
		return
	end

	if Hub.CoinFarm.underParts[farmBase_param_0144] == nil then
		Hub.CoinFarm.underParts[farmBase_param_0144] = farmBase_param_0144.CanCollide
	end

	farmBase_param_0144.CanCollide = false

	if farmBase_param_0144:FindFirstAncestorWhichIsA("Tool") then
		if Hub.CoinFarm.underToolMassless[farmBase_param_0144] == nil then
			Hub.CoinFarm.underToolMassless[farmBase_param_0144] = farmBase_param_0144.Massless
		end

		farmBase_param_0144.Massless = true
	end
end

Hub.CoinFarm.EnableUnder = function(underCharacter, farmBase_param_0145, farmBase_param_0146)
	if not (farmBase_param_0146 == true or Hub.CoinFarm.position == "Under" or Hub.CoinFarm.mode == "Tween") or not Hub.CoinFarm.enabled or not Hub.RoundState.active then
		Hub.CoinFarm.DisableUnder()
		return
	end

	if Hub.CoinFarm.underCharacter ~= underCharacter then
		Hub.CoinFarm.DisableUnder()
		Hub.CoinFarm.underCharacter = underCharacter

		for _, descendant in ipairs(underCharacter:GetDescendants()) do
			Hub.CoinFarm.TrackUnderPart(descendant)
		end

		Hub.CoinFarm.underAddedConnection = underCharacter.DescendantAdded:Connect(function(descendant)
			if Hub.CoinFarm.enabled and (Hub.CoinFarm.position == "Under" or Hub.CoinFarm.mode == "Tween" or Hub.CoinFarm.escapeUnderActive) then
				Hub.CoinFarm.TrackUnderPart(descendant)
			end
		end)

		Hub.CoinFarm.nextUnderEnforceAt = os.clock() + 0.5
	elseif Hub.CoinFarm.nextUnderEnforceAt <= os.clock() then
		Hub.CoinFarm.nextUnderEnforceAt = os.clock() + 0.5

		for k in pairs(Hub.CoinFarm.underParts) do
			if k and k.Parent then
				k.CanCollide = false

				if Hub.CoinFarm.underToolMassless[k] ~= nil then
					k.Massless = true
				end
			else
				Hub.CoinFarm.underParts[k] = nil
				Hub.CoinFarm.underToolMassless[k] = nil
			end
		end
	end

	local humanoidRootPart = underCharacter:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return
	end

	if Hub.CoinFarm.position ~= "Under" and farmBase_param_0146 ~= true or farmBase_param_0145 == false then
		if Hub.CoinFarm.stabilizer then
			Hub.CoinFarm.stabilizer:Destroy()
			Hub.CoinFarm.stabilizer = nil
		end

		Hub.CoinFarm.stabilizerRoot = nil
		return
	end

	if not Hub.CoinFarm.stabilizer or Hub.CoinFarm.stabilizer.Parent ~= humanoidRootPart or Hub.CoinFarm.stabilizerRoot ~= humanoidRootPart then
		if Hub.CoinFarm.stabilizer then
			Hub.CoinFarm.stabilizer:Destroy()
		end

		local bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.Name = "FoxnameCoinFarmStabilizer"
		bodyVelocity.Velocity = Vector3.zero
		bodyVelocity.MaxForce = Vector3.new(0, 9e9, 0)
		bodyVelocity.P = 90000
		bodyVelocity.Parent = humanoidRootPart
		Hub.CoinFarm.stabilizer = bodyVelocity
		Hub.CoinFarm.stabilizerRoot = humanoidRootPart
	end
end

Hub.CoinFarm.ResolveMap = function()
	local currentMapInstance = Hub.RoundState.currentMapInstance
	if currentMapInstance and currentMapInstance.Parent and currentMapInstance:IsDescendantOf(workspace) then
		return currentMapInstance
	end
	local currentMapName = Hub.RoundState.currentMapName

	if type(currentMapName) == "string" and currentMapName ~= "" then
		local farmBase_localValue_0147 = workspace:FindFirstChild(currentMapName) or workspace:FindFirstChild(currentMapName, true)
		if farmBase_localValue_0147 and (farmBase_localValue_0147:IsA("Model") or farmBase_localValue_0147:IsA("Folder")) then
			Hub.RoundState.currentMapInstance = farmBase_localValue_0147
			return farmBase_localValue_0147
		end
		local farmBase_textValue_0148 = string.lower(currentMapName):gsub("[^%w]", "")

		for _, child in ipairs(workspace:GetChildren()) do
			if (child:IsA("Model") or child:IsA("Folder")) and string.lower(child.Name):gsub("[^%w]", "") == farmBase_textValue_0148 then
				Hub.RoundState.currentMapInstance = child
				return child
			end
		end
	end

	local lobby = workspace:FindFirstChild("Lobby")

	for _, child in ipairs(workspace:GetChildren()) do
		if child ~= lobby and (child:IsA("Model") or child:IsA("Folder")) and (child:FindFirstChild("Coin_Server", true) or child:FindFirstChild("Candy_Server", true) or child:FindFirstChild("CoinContainer", true) or child:FindFirstChild("CandyContainer", true)) then
			Hub.RoundState.currentMapName = child.Name
			Hub.RoundState.currentMapInstance = child
			return child
		end
	end

	return nil
end

Hub.CoinFarm.IsLocalPlayerInRound = function()
	local character_ = localPlayer.Character
	local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
	if not character_ or not character_:IsDescendantOf(workspace) or not humanoid or humanoid.Health <= 0 then
		return false
	end
	local cache = Hub.RoleState.cache
	local farmBase_callResult_0149 = type(cache) == "table" and (cache[localPlayer.Name] or cache[tostring(localPlayer.UserId)] or cache[localPlayer.UserId]) or nil

	if type(farmBase_callResult_0149) == "table" then
		if farmBase_callResult_0149.Role == "Murderer" or farmBase_callResult_0149.Role == "Sheriff" or farmBase_callResult_0149.Role == "Innocent" or farmBase_callResult_0149.Role == "Hero" then
			if farmBase_callResult_0149.Dead ~= true then
				return true
			end
		end
	end

	local backpack = localPlayer:FindFirstChildOfClass("Backpack")

	if character_ then
		character_ = character_:FindFirstChild("Gun") ~= nil or character_:FindFirstChild("Knife") ~= nil
	end

	return character_ or backpack and (backpack:FindFirstChild("Gun") ~= nil or backpack:FindFirstChild("Knife") ~= nil) or false
end

Hub.CoinFarm.GetCachedRole = function(farmBase_param_0150)
	if not farmBase_param_0150 or type(Hub.RoleState.cache) ~= "table" then
		return nil
	end
	local farmBase_cacheValue_0151 = Hub.RoleState.cache[farmBase_param_0150.Name] or Hub.RoleState.cache[tostring(farmBase_param_0150.UserId)] or Hub.RoleState.cache[farmBase_param_0150.UserId]
	local role = type(farmBase_cacheValue_0151) == "table" and farmBase_cacheValue_0151.Role or nil

	if farmBase_param_0150 == localPlayer and Hub.RoundState.active then
		local character_ = localPlayer.Character
		local backpack = localPlayer:FindFirstChildOfClass("Backpack")
		if character_ and character_:FindFirstChild("Knife") or backpack and backpack:FindFirstChild("Knife") then
			return "Murderer"
		end

		if type(Hub.CoinFarm.FindLocalGun) == "function" and Hub.CoinFarm.FindLocalGun() then
			return role == "Sheriff" and "Sheriff" or "Hero"
		end
	end

	return role
end

Hub.CoinFarm.FindLocalGun = function()
	local farmBase_localValue_0152 = workspace:FindFirstChild(localPlayer.Name)
	local gun = farmBase_localValue_0152 and farmBase_localValue_0152:FindFirstChild("Gun")
	if gun and gun:IsA("Tool") then
		return gun
	end
	local backpack = localPlayer:FindFirstChildOfClass("Backpack")
	backpack = backpack and backpack:FindFirstChild("Gun")
	if backpack and backpack:IsA("Tool") then
		return backpack
	end
	return nil
end

Hub.CoinFarm.GetMurdererRoot = function()
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= localPlayer and Hub.CoinFarm.GetCachedRole(player) == "Murderer" then
			local character_ = player.Character
			local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
			character_ = character_ and character_:FindFirstChild("HumanoidRootPart")
			if humanoid and humanoid.Health > 0 and character_ then
				return character_
			end
		end
	end

	return nil
end

Hub.CoinFarm.RunInitialSafety = function(farmBase_param_0153)
	if Hub.CoinFarm.safetyChecked then
		return true
	end

	if Hub.CoinFarm.GetCachedRole(localPlayer) == "Murderer" then
		Hub.CoinFarm.safetyChecked = true
		return true
	end

	if Hub.CoinFarm.safetyStartedAt == 0 then
		Hub.CoinFarm.safetyStartedAt = os.clock()
	end

	local farmBase_getMurdererRootValue_0154 = Hub.CoinFarm.GetMurdererRoot()

	if not farmBase_getMurdererRootValue_0154 then
		local safetyStartedAt = Hub.CoinFarm.safetyStartedAt
		if os.clock() - safetyStartedAt < 3 then
			return false
		end
		Hub.CoinFarm.safetyChecked = true
		return true
	end

	Hub.CoinFarm.safetyChecked = true
	if Hub.CoinFarm.murdererNearRange < (farmBase_getMurdererRootValue_0154.Position - farmBase_param_0153.Position).Magnitude then
		return true
	end
	local indexedMap = Hub.CoinFarm.indexedMap or Hub.CoinFarm.ResolveMap()
	if not indexedMap then
		return true
	end
	local farmBase_numericVar_0155 = -math.huge
	local farmBase_optionalValue_0156 = nil

	for _, descendant in ipairs(indexedMap:GetDescendants()) do
		if descendant:IsA("BasePart") and descendant.Name == "Spawn" then
			local magnitude = (descendant.Position - farmBase_getMurdererRootValue_0154.Position).Magnitude

			if farmBase_numericVar_0155 < magnitude then
				farmBase_numericVar_0155 = magnitude
				farmBase_optionalValue_0156 = descendant
			end
		end
	end

	if not farmBase_optionalValue_0156 then
		return true
	end
	Hub.CoinFarm.CancelTween()
	Hub.CoinFarm.DisableUnder()
	local farmBase_numericVar_0157 = farmBase_optionalValue_0156.Size.Y * 0.5 + farmBase_param_0153.Size.Y * 0.5 + 0.15
	farmBase_param_0153.AssemblyLinearVelocity = Vector3.zero
	farmBase_param_0153.AssemblyAngularVelocity = Vector3.zero
	farmBase_param_0153.CFrame = farmBase_optionalValue_0156.CFrame + Vector3.new(0, farmBase_numericVar_0157, 0)
	Hub.CoinFarm.currentCoin = nil
	return true
end

Hub.CoinFarm.GetNearbyMurderer = function(farmBase_param_0158)
	if not farmBase_param_0158 or Hub.CoinFarm.GetCachedRole(localPlayer) == "Murderer" then
		return nil
	end
	local now = os.clock()
	if now < Hub.CoinFarm.nextMurdererCheckAt then
		return nil
	end
	Hub.CoinFarm.nextMurdererCheckAt = now + 0.2
	local farmBase_getMurdererRootValue_0159 = Hub.CoinFarm.GetMurdererRoot()
	if farmBase_getMurdererRootValue_0159 and (farmBase_getMurdererRootValue_0159.Position - farmBase_param_0158.Position).Magnitude <= Hub.CoinFarm.murdererNearRange then
		return farmBase_getMurdererRootValue_0159
	end
	return nil
end

Hub.CoinFarm.EscapeMurderer = function(farmBase_param_0160, farmBase_param_0161)
	local now = os.clock()
	if not farmBase_param_0160 or not farmBase_param_0161 or now < Hub.CoinFarm.nextMurdererEscapeAt then
		return false
	end
	local now2 = os.clock()
	local farmBase_numericVar_0162 = -math.huge
	local farmBase_optionalValue_0163 = nil

	for k in pairs(Hub.CoinFarm.coins) do
		local farmBase_isCoinAvailableValue_0164 = Hub.CoinFarm.IsCoinAvailable(k)

		if farmBase_isCoinAvailableValue_0164 then
			farmBase_isCoinAvailableValue_0164 = (Hub.CoinFarm.retryUntil[k] or 0) <= now2
		end

		if farmBase_isCoinAvailableValue_0164 then
			local magnitude = (k.Position - farmBase_param_0161.Position).Magnitude

			if farmBase_numericVar_0162 < magnitude then
				farmBase_numericVar_0162 = magnitude
				farmBase_optionalValue_0163 = k
			end
		end
	end

	Hub.CoinFarm.nextMurdererEscapeAt = now + 0.5
	if not farmBase_optionalValue_0163 then
		return false
	end
	Hub.CoinFarm.currentCoin = farmBase_optionalValue_0163
	Hub.CoinFarm.escapeCoin = farmBase_optionalValue_0163
	Hub.CoinFarm.escapeUnderActive = true
	Hub.CoinFarm.SetPhase("正在躲避杀手")
	return true
end

Hub.CoinFarm.TrackCoin = function(farmBase_param_0165)
	if farmBase_param_0165 and farmBase_param_0165:IsA("BasePart") and (farmBase_param_0165.Name == "Coin_Server" or farmBase_param_0165.Name == "Candy_Server") and farmBase_param_0165.Parent then
		Hub.CoinFarm.coins[farmBase_param_0165] = true

		if Hub.CoinFarm.enabled and Hub.CoinFarm.OptimizeCoinVisual then
			Hub.CoinFarm.OptimizeCoinVisual(farmBase_param_0165)

			task.defer(function()
				if Hub.CoinFarm.enabled and farmBase_param_0165.Parent then
					Hub.CoinFarm.OptimizeCoinVisual(farmBase_param_0165)
				end
			end)
		end
	end
end

Hub.CoinFarm.OptimizeCoinVisual = function(farmBase_param_0166)
	if not Hub.CoinFarm.enabled or not Hub.CoinFarm.reduceCoinVisuals or not farmBase_param_0166 or not farmBase_param_0166.Parent then
		return
	end
	local coinVisual = farmBase_param_0166:FindFirstChild("CoinVisual")
	if not coinVisual then
		return
	end
	local optimizedCoinVisuals = Hub.CoinFarm.optimizedCoinVisuals

	local function farmBase_helperFunc_0167(farmBase_param_0168)
		if (farmBase_param_0168:IsA("ParticleEmitter") or farmBase_param_0168:IsA("Trail") or farmBase_param_0168:IsA("Beam")) and optimizedCoinVisuals[farmBase_param_0168] == nil then
			optimizedCoinVisuals[farmBase_param_0168] = farmBase_param_0168.Enabled
			farmBase_param_0168.Enabled = false
		elseif farmBase_param_0168:IsA("Light") and optimizedCoinVisuals[farmBase_param_0168] == nil then
			optimizedCoinVisuals[farmBase_param_0168] = farmBase_param_0168.Enabled
			farmBase_param_0168.Enabled = false
		end
	end

	farmBase_helperFunc_0167(coinVisual)

	for _, descendant in ipairs(coinVisual:GetDescendants()) do
		farmBase_helperFunc_0167(descendant)
	end
end

Hub.CoinFarm.RestoreCoinVisuals = function()
	for k, optimizedCoinVisual in pairs(Hub.CoinFarm.optimizedCoinVisuals) do
		if k and k.Parent then
			pcall(function()
				k.Enabled = optimizedCoinVisual
			end)
		end

		Hub.CoinFarm.optimizedCoinVisuals[k] = nil
	end
end

Hub.CoinFarm.OptimizeIndexedCoins = function()
	if not Hub.CoinFarm.enabled then
		return
	end

	for k in pairs(Hub.CoinFarm.coins) do
		Hub.CoinFarm.OptimizeCoinVisual(k)
	end
end

Hub.CoinFarm.IsCoinVisualPartVisible = function(farmBase_param_0169, farmBase_param_0170)
	return farmBase_param_0169 and farmBase_param_0169:IsA("BasePart") and (farmBase_param_0169 == farmBase_param_0170 or farmBase_param_0169:IsDescendantOf(farmBase_param_0170)) and farmBase_param_0169.Transparency < 0.99 and farmBase_param_0169.LocalTransparencyModifier < 0.99
end

Hub.CoinFarm.IsCoinAvailable = function(farmBase_param_0171)
	if not farmBase_param_0171 or not farmBase_param_0171.Parent or not farmBase_param_0171:IsA("BasePart") or (farmBase_param_0171.Name ~= "Coin_Server" and farmBase_param_0171.Name ~= "Candy_Server") then
		return false
	end
	if farmBase_param_0171:GetAttribute("Collected") == true then
		return false
	end
	local coinVisual = farmBase_param_0171:FindFirstChild("CoinVisual")
	if coinVisual and coinVisual:GetAttribute("Collected") == true then
		return false
	end
	if not coinVisual then
		return true
	end
	local farmBase_coinVisualPartsValue_0172 = Hub.CoinFarm.coinVisualParts[farmBase_param_0171]

	if not Hub.CoinFarm.IsCoinVisualPartVisible(farmBase_coinVisualPartsValue_0172, coinVisual) then
		farmBase_coinVisualPartsValue_0172 = Hub.CoinFarm.IsCoinVisualPartVisible(coinVisual, coinVisual) and coinVisual or nil

		if not farmBase_coinVisualPartsValue_0172 then
			for _, descendant in ipairs(coinVisual:GetDescendants()) do
				if Hub.CoinFarm.IsCoinVisualPartVisible(descendant, coinVisual) then
					farmBase_coinVisualPartsValue_0172 = descendant
					break
				end
			end
		end

		Hub.CoinFarm.coinVisualParts[farmBase_param_0171] = farmBase_coinVisualPartsValue_0172
	end

	return farmBase_coinVisualPartsValue_0172 ~= nil
end

Hub.CoinFarm.IndexMap = function()
	local farmBase_resolveMapValue_0173 = Hub.CoinFarm.ResolveMap()
	if farmBase_resolveMapValue_0173 and Hub.CoinFarm.indexedMap == farmBase_resolveMapValue_0173 then
		return true
	end
	local now = os.clock()
	if now - Hub.CoinFarm.lastIndexAttemptAt < 0.75 then
		return false
	end
	Hub.CoinFarm.lastIndexAttemptAt = now
	local farmBase_resolveMapValue_0174 = farmBase_resolveMapValue_0173 or Hub.CoinFarm.ResolveMap()
	if not farmBase_resolveMapValue_0174 then
		return false
	end
	Hub.CoinFarm.DisconnectMap()
	Hub.CoinFarm.indexedMap = farmBase_resolveMapValue_0174
	local coinContainer = farmBase_resolveMapValue_0174:FindFirstChild("CoinContainer") or farmBase_resolveMapValue_0174:FindFirstChild("CandyContainer") or farmBase_resolveMapValue_0174:FindFirstChild("CoinContainer", true) or farmBase_resolveMapValue_0174:FindFirstChild("CandyContainer", true)
	local farmBase_boolFlag_0175

	if coinContainer then
		farmBase_boolFlag_0175 = not (coinContainer:IsA("Model") or coinContainer:IsA("Folder"))
	else
		farmBase_boolFlag_0175 = coinContainer
	end

	if farmBase_boolFlag_0175 then
		coinContainer = nil
	end

	farmBase_resolveMapValue_0174 = coinContainer or farmBase_resolveMapValue_0174
	Hub.CoinFarm.indexedCoinContainer = coinContainer

	for _, descendant in ipairs(farmBase_resolveMapValue_0174:GetDescendants()) do
		Hub.CoinFarm.TrackCoin(descendant)
	end

	Hub.CoinFarm.mapAddedConnection = farmBase_resolveMapValue_0174.DescendantAdded:Connect(Hub.CoinFarm.TrackCoin)

	Hub.CoinFarm.mapRemovingConnection = farmBase_resolveMapValue_0174.DescendantRemoving:Connect(function(descendant)
		Hub.CoinFarm.coins[descendant] = nil
		Hub.CoinFarm.retryUntil[descendant] = nil
		Hub.CoinFarm.contactAttempts[descendant] = nil
		Hub.CoinFarm.coinVisualParts[descendant] = nil

		if Hub.CoinFarm.currentCoin == descendant then
			Hub.CoinFarm.currentCoin = nil
		end

		if Hub.CoinFarm.escapeCoin == descendant then
			Hub.CoinFarm.escapeCoin = nil
			Hub.CoinFarm.escapeUnderActive = false
		end
	end)

	Hub.CoinFarm.OptimizeIndexedCoins()
	return true
end

Hub.CoinFarm.GetNearestCoin = function(farmBase_param_0176)
	local now = os.clock()
	local huge = math.huge
	local farmBase_optionalValue_0177 = nil

	for k in pairs(Hub.CoinFarm.coins) do
		if not k.Parent then
			Hub.CoinFarm.coins[k] = nil
			Hub.CoinFarm.retryUntil[k] = nil
			Hub.CoinFarm.contactAttempts[k] = nil
		else
			local farmBase_isCoinAvailableValue_0178 = Hub.CoinFarm.IsCoinAvailable(k)

			if farmBase_isCoinAvailableValue_0178 then
				farmBase_isCoinAvailableValue_0178 = (Hub.CoinFarm.retryUntil[k] or 0) <= now
			end

			if farmBase_isCoinAvailableValue_0178 then
				local magnitude = (k.Position - farmBase_param_0176.Position).Magnitude

				if magnitude < huge then
					huge = magnitude
					farmBase_optionalValue_0177 = k
				end
			end
		end
	end

	return farmBase_optionalValue_0177
end

Hub.CoinFarm.MarkCurrentCollected = function()
	local currentCoin = Hub.CoinFarm.currentCoin
	if not currentCoin then
		return
	end
	Hub.CoinFarm.coins[currentCoin] = nil
	Hub.CoinFarm.retryUntil[currentCoin] = nil
	Hub.CoinFarm.contactAttempts[currentCoin] = nil
	Hub.CoinFarm.currentCoin = nil

	if Hub.CoinFarm.escapeCoin == currentCoin then
		Hub.CoinFarm.escapeCoin = nil
		Hub.CoinFarm.escapeUnderActive = false
	end
end

Hub.CoinFarm.FindBagCountLabel = function()
	local playerGui = localPlayer:FindFirstChild("PlayerGui")
	playerGui = playerGui and playerGui:FindFirstChild("MainGUI")
	playerGui = playerGui and playerGui:FindFirstChild("Game")
	playerGui = playerGui and playerGui:FindFirstChild("CoinBags")
	local container = playerGui and playerGui:FindFirstChild("Container")
	if not container then
		return nil
	end
	local bag = (container:FindFirstChild("Candy") and container.Candy.Visible and container.Candy)
		or (container:FindFirstChild("Coin") and container.Coin.Visible and container.Coin)
		or container:FindFirstChild("Candy")
		or container:FindFirstChild("Coin")
	local coin = bag and bag:FindFirstChild("CurrencyFrame")
	coin = coin and coin:FindFirstChild("Icon")
	coin = coin and coin:FindFirstChild("Coins")
	return coin and coin:IsA("TextLabel") and coin or nil
end

Hub.CoinFarm.GetBagCount = function()
	if type(Hub.CoinFarm.bagCurrentValue) == "number" then
		return Hub.CoinFarm.bagCurrentValue
	end
	local bagCountLabel = Hub.CoinFarm.bagCountLabel

	if not bagCountLabel or not bagCountLabel.Parent then
		bagCountLabel = Hub.CoinFarm.FindBagCountLabel()
		Hub.CoinFarm.bagCountLabel = bagCountLabel
	end

	if not bagCountLabel then
		return nil
	end
	local match = tostring(bagCountLabel.Text or ""):match("%d[%d,]*")

	if match then
		local farmBase_localValue_0179 = tonumber
		local farmBase_textValue_0180 = match:gsub(",", "")
		match = farmBase_localValue_0179(farmBase_textValue_0180)
	end

	return match or nil
end

Hub.CoinFarm.SyncTotalCollected = function()
	if not Hub.CoinFarm.enabled then
		return
	end
	local farmBase_getBagCountValue_0181 = Hub.CoinFarm.GetBagCount()
	if type(farmBase_getBagCountValue_0181) ~= "number" then
		return
	end
	local lastBagCount = math.max(0, math.floor(farmBase_getBagCountValue_0181))
	local lastBagCount2 = Hub.CoinFarm.lastBagCount
	if lastBagCount2 == nil then
		Hub.CoinFarm.lastBagCount = lastBagCount
		return
	end

	if lastBagCount >= lastBagCount2 and lastBagCount > lastBagCount2 then
		local coinFarm = Hub.CoinFarm
		coinFarm.totalCollected = coinFarm.totalCollected + lastBagCount - lastBagCount2
		Hub.CoinFarm.RefreshStats()
	end

	Hub.CoinFarm.lastBagCount = lastBagCount
end

Hub.CoinFarm.ResetAfterBagFull = function()
	if not Hub.CoinFarm.enabled then
		return false
	end

	if Hub.CoinFarm.resetRequestedForBag then
		return true
	end
	local character_ = localPlayer.Character
	local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
	if not character_ or not humanoid or humanoid.Health <= 0 then
		return false
	end
	Hub.CoinFarm.resetRequestedForBag = true
	Hub.CoinFarm.SetPhase("钱袋已满：正在重置")
	Hub.CoinFarm.CancelTween()
	Hub.CoinFarm.LeaveUnderSafely(nil, true)

	pcall(function()
		humanoid.Health = 0
	end)

	if humanoid.Health > 0 then
		pcall(function()
			character_:BreakJoints()
		end)
	end

	return true
end

Hub.CoinFarm.ApplyBagCount = function(farmCore_param_0182, farmCore_param_0183)
	if not Hub.CoinFarm.enabled then
		return
	end
	local farmCore_numericVar_0184 = tonumber(farmCore_param_0182)
	if not farmCore_numericVar_0184 then
		return
	end
	local bagCurrentValue = math.max(0, math.floor(farmCore_numericVar_0184))
	Hub.CoinFarm.bagCurrentValue = bagCurrentValue
	local farmCore_numericVar_0185 = tonumber(farmCore_param_0183)

	if farmCore_numericVar_0185 and farmCore_numericVar_0185 > 0 then
		Hub.CoinFarm.bagMaximum = math.floor(farmCore_numericVar_0185)
	end

	Hub.CoinFarm.SyncTotalCollected()

	if Hub.CoinFarm.bagMaximum and bagCurrentValue >= Hub.CoinFarm.bagMaximum then
		Hub.CoinFarm.bagFull = true
		Hub.CoinFarm.ReportBagFull()
		Hub.CoinFarm.currentCoin = nil
		Hub.CoinFarm.CancelTween()
		Hub.CoinFarm.LeaveUnderSafely(nil, true)

		if not (type(Hub.CoinFarm.StartXPFarmWait) == "function" and Hub.CoinFarm.StartXPFarmWait()) then
			if Hub.CoinFarm.endRoundEnabled then
				Hub.CoinFarm.SetPhase("钱袋已满")
				Hub.CoinFarm.StartEndRoundAction()
			else
				Hub.CoinFarm.ResetAfterBagFull()
			end
		end
	end
end

task.spawn(function()
	while foxnameMM2Runtime.alive and not isTerminated do
		if Hub.CoinFarm.enabled then
			Hub.CoinFarm.SyncEarnedXP()

			if Hub.RoundState.active then
				Hub.CoinFarm.SyncTotalCollected()
			end
		end

		task.wait(1)
	end
end)

Hub.CoinFarm.CheckBagFullGui = function()
	if not Hub.CoinFarm.enabled then
		return false
	end
	local playerGui = localPlayer:FindFirstChild("PlayerGui")
	playerGui = playerGui and playerGui:FindFirstChild("MainGUI")
	playerGui = playerGui and playerGui:FindFirstChild("Game")
	playerGui = playerGui and playerGui:FindFirstChild("CoinBags")
	local container = playerGui and playerGui:FindFirstChild("Container")
	if not container then
		return false
	end
	local bag = (container:FindFirstChild("Candy") and container.Candy.Visible and container.Candy)
		or (container:FindFirstChild("Coin") and container.Coin.Visible and container.Coin)
		or container:FindFirstChild("Candy")
		or container:FindFirstChild("Coin")
	local full = bag and bag:FindFirstChild("Full")
	if not full or not full:IsA("GuiObject") or full.Visible ~= true then
		return false
	end
	Hub.CoinFarm.bagFull = true
	Hub.CoinFarm.ReportBagFull()
	Hub.CoinFarm.currentCoin = nil
	Hub.CoinFarm.CancelTween()
	Hub.CoinFarm.LeaveUnderSafely(nil, true)

	if not (type(Hub.CoinFarm.StartXPFarmWait) == "function" and Hub.CoinFarm.StartXPFarmWait()) then
		if Hub.CoinFarm.endRoundEnabled then
			Hub.CoinFarm.SetPhase("钱袋已满")
			Hub.CoinFarm.StartEndRoundAction()
		else
			Hub.CoinFarm.ResetAfterBagFull()
		end
	end

	return true
end

Hub.CoinFarm.StartEndRoundAction = function()
	if not Hub.CoinFarm.endRoundEnabled or not Hub.CoinFarm.enabled or not Hub.CoinFarm.bagFull and not Hub.CoinFarm.endRoundDeathRequested or Hub.CoinFarm.endRoundRunning or Hub.CoinFarm.endRoundCompleted or Hub.CoinFarm.xpWaitRunning or not Hub.RoundState.active then
		return false
	end
	local farmCore_getCachedRoleValue_0186 = Hub.CoinFarm.GetCachedRole(localPlayer)

	if farmCore_getCachedRoleValue_0186 == nil then
		local character_ = localPlayer.Character
		local backpack = localPlayer:FindFirstChildOfClass("Backpack")

		if character_ and character_:FindFirstChild("Knife") or backpack and backpack:FindFirstChild("Knife") then
			farmCore_getCachedRoleValue_0186 = "Murderer"
		end
	end

	local farmCore_endRoundDeathRequestedValue_0187 = not Hub.CoinFarm.endRoundDeathRequested and (farmCore_getCachedRoleValue_0186 == "Sheriff" or farmCore_getCachedRoleValue_0186 == "Hero")
	if not farmCore_endRoundDeathRequestedValue_0187 and farmCore_getCachedRoleValue_0186 ~= "Murderer" and farmCore_getCachedRoleValue_0186 ~= "Sheriff" and farmCore_getCachedRoleValue_0186 ~= "Innocent" and farmCore_getCachedRoleValue_0186 ~= "Hero" then
		return false
	end
	Hub.CoinFarm.endRoundRunning = true
	local coinFarm = Hub.CoinFarm
	coinFarm.endRoundGeneration = coinFarm.endRoundGeneration + 1
	local endRoundGeneration = Hub.CoinFarm.endRoundGeneration
	Hub.CoinFarm.SetPhase(farmCore_endRoundDeathRequestedValue_0187 and "结束回合：自动射击" or farmCore_getCachedRoleValue_0186 == "Murderer" and "结束回合：刀光环" or "结束回合：甩飞")

	task.spawn(function()
		local endRoundCompleted

		if farmCore_getCachedRoleValue_0186 == "Murderer" and not Hub.CoinFarm.endRoundDeathRequested and not farmCore_endRoundDeathRequestedValue_0187 then
			local runKnifeAura = Hub.CoinFarm.runKnifeAura
			local farmCore_numericVar_0188 = 0

			while true do
				local farmCore_enabledValue_0189 = farmCore_numericVar_0188 < 8 and Hub.CoinFarm.enabled and Hub.CoinFarm.endRoundEnabled and Hub.RoundState.active and Hub.CoinFarm.endRoundGeneration == endRoundGeneration
				endRoundCompleted = false

				if farmCore_enabledValue_0189 then
					farmCore_numericVar_0188 += 1

					if type(runKnifeAura) == "function" and runKnifeAura(endRoundGeneration) == true then
						endRoundCompleted = true
						break
					else
						task.wait(0.25)
						continue
					end
				end

				break
			end
		else
			task.wait(0.12)
			local farmCore_numericVar_0190 = 0

			while true do
				local farmCore_enabledValue_0191 = farmCore_numericVar_0190 < 3 and Hub.CoinFarm.enabled and Hub.CoinFarm.endRoundEnabled and Hub.RoundState.active and Hub.CoinFarm.endRoundGeneration == endRoundGeneration
				endRoundCompleted = false

				if farmCore_enabledValue_0191 then
					local character_ = localPlayer.Character
					character_ = character_ and character_:FindFirstChildOfClass("Humanoid")

					if not character_ or character_.Health <= 0 then
						Hub.CoinFarm.endRoundDeathRequested = true
						Hub.CoinFarm.QueueEndRoundAfterRespawn()
						return
					end

					farmCore_numericVar_0190 += 1
					local farmCore_getCachedRoleValue_0192 = Hub.CoinFarm.GetCachedRole(localPlayer)
					local farmCore_endRoundDeathRequestedValue_0193 = not Hub.CoinFarm.endRoundDeathRequested and (farmCore_getCachedRoleValue_0192 == "Sheriff" or farmCore_getCachedRoleValue_0192 == "Hero")
					Hub.CoinFarm.SetPhase(farmCore_endRoundDeathRequestedValue_0193 and "结束回合：自动射击" or "结束回合：甩飞")
					farmCore_endRoundDeathRequestedValue_0193 = farmCore_endRoundDeathRequestedValue_0193 and Hub.CoinFarm.shootMurderer or Hub.CoinFarm.flingMurderer
					if type(farmCore_endRoundDeathRequestedValue_0193) == "function" and farmCore_endRoundDeathRequestedValue_0193() == true then
						endRoundCompleted = true
						break
					end
					task.wait(0.4)
					continue
				end

				break
			end
		end

		if Hub.CoinFarm.endRoundGeneration == endRoundGeneration then
			Hub.CoinFarm.endRoundRunning = false
			Hub.CoinFarm.endRoundCompleted = endRoundCompleted
		end
	end)

	return true
end

Hub.CoinFarm.QueueEndRoundAfterRespawn = function()
	if Hub.CoinFarm.endRoundRespawnRetryRunning or not Hub.CoinFarm.enabled or not Hub.CoinFarm.endRoundEnabled or not Hub.RoundState.active then
		return false
	end
	Hub.CoinFarm.CancelXPFarmWait()
	local coinFarm = Hub.CoinFarm
	coinFarm.endRoundGeneration = coinFarm.endRoundGeneration + 1
	Hub.CoinFarm.endRoundRunning = false
	Hub.CoinFarm.endRoundCompleted = false
	Hub.CoinFarm.endRoundRespawnRetryRunning = true
	local coinFarm2 = Hub.CoinFarm
	coinFarm2.endRoundRespawnRetryGeneration = coinFarm2.endRoundRespawnRetryGeneration + 1
	local endRoundRespawnRetryGeneration = Hub.CoinFarm.endRoundRespawnRetryGeneration
	local character_ = localPlayer.Character
	Hub.CoinFarm.SetPhase("等待重生后甩飞杀手")

	task.spawn(function()
		local exitTo = nil

		while true do
			if foxnameMM2Runtime.alive and not isTerminated and Hub.CoinFarm.enabled and Hub.CoinFarm.endRoundEnabled and Hub.RoundState.active and Hub.CoinFarm.endRoundRespawnRetryGeneration == endRoundRespawnRetryGeneration then
				local character_2 = localPlayer.Character
				local humanoid = character_2 and character_2:FindFirstChildOfClass("Humanoid")
				local humanoidRootPart = character_2 and character_2:FindFirstChild("HumanoidRootPart")
				if not (character_2 and character_2 ~= character_ and character_2:IsDescendantOf(workspace) and humanoid and humanoid.Health > 0 and humanoidRootPart) then
					task.wait(0.1)
					continue
				end
			else
				exitTo = 1
				break
			end

			break
		end

		if exitTo ~= 1 then
			task.wait(0.2)

			if Hub.CoinFarm.endRoundRespawnRetryGeneration == endRoundRespawnRetryGeneration then
				Hub.CoinFarm.endRoundRespawnRetryRunning = false
				Hub.CoinFarm.endRoundCompleted = false
				Hub.CoinFarm.StartEndRoundAction()
				return
			end
		end

		if Hub.CoinFarm.endRoundRespawnRetryGeneration == endRoundRespawnRetryGeneration then
			Hub.CoinFarm.endRoundRespawnRetryRunning = false
		end
	end)

	return true
end

Hub.CoinFarm.OnPlayerDataChanged = function()
	local cache = Hub.RoleState.cache
	local farmCore_callResult_0194 = type(cache) == "table" and (cache[localPlayer.Name] or cache[tostring(localPlayer.UserId)] or cache[localPlayer.UserId]) or nil
	local lastLocalDead = type(farmCore_callResult_0194) == "table" and farmCore_callResult_0194.Dead == true

	if lastLocalDead and not Hub.CoinFarm.lastLocalDead and Hub.CoinFarm.enabled and Hub.CoinFarm.endRoundEnabled and Hub.CoinFarm.ranThisRound and farmCore_callResult_0194.Role ~= "Murderer" then
		Hub.CoinFarm.endRoundDeathRequested = true
		Hub.CoinFarm.QueueEndRoundAfterRespawn()
	end

	Hub.CoinFarm.lastLocalDead = lastLocalDead
	Hub.CoinFarm.StartRoundSheriffFling()
end

Hub.CoinFarm.StartRoundSheriffFling = function()
	local farmCore_getCachedRoleValue_0195 = Hub.CoinFarm.GetCachedRole(localPlayer)
	local sheriffFlingRunning = Hub.CoinFarm.sheriffFlingRunning or Hub.CoinFarm.sheriffFlingCompleted or not Hub.CoinFarm.enabled or not Hub.CoinFarm.endRoundEnabled or not Hub.RoundState.active
	local farmCore_boolFlag_0196

	if sheriffFlingRunning then
		farmCore_boolFlag_0196 = sheriffFlingRunning
	else
		farmCore_boolFlag_0196 = farmCore_getCachedRoleValue_0195 ~= "Murderer" and farmCore_getCachedRoleValue_0195 ~= "Innocent"
	end

	if farmCore_boolFlag_0196 then
		return false
	end
	Hub.CoinFarm.sheriffFlingRunning = true
	Hub.CoinFarm.sheriffFlingBlocking = true
	local endRoundGeneration = Hub.CoinFarm.endRoundGeneration

	task.spawn(function()
		local function farmCore_helperFunc_0197()
			local farmCore_getCachedRoleValue_0198 = Hub.CoinFarm.GetCachedRole(localPlayer)
			return Hub.CoinFarm.enabled and Hub.CoinFarm.endRoundEnabled and Hub.RoundState.active and Hub.CoinFarm.endRoundGeneration == endRoundGeneration and (farmCore_getCachedRoleValue_0198 == "Murderer" or farmCore_getCachedRoleValue_0198 == "Innocent")
		end

		local function farmCore_helperFunc_0199()
			local gunDrop = workspace:FindFirstChild("GunDrop")
			return gunDrop ~= nil and gunDrop:IsA("BasePart")
		end

		local farmCore_timestamp_0200 = os.clock() + 10
		local farmCore_boolFlag_0201, farmCore_boolFlag_0202

		while true do
			local farmCore_timestamp_0203 = farmCore_helperFunc_0197() and os.clock() < farmCore_timestamp_0200
			farmCore_boolFlag_0201 = false
			farmCore_boolFlag_0202 = false

			if farmCore_timestamp_0203 then
				if farmCore_helperFunc_0199() then
					farmCore_boolFlag_0201 = true
					break
				else
					local getSheriffFlingTarget = Hub.CoinFarm.getSheriffFlingTarget
					local farmCore_callResult_0204 = type(getSheriffFlingTarget) == "function" and getSheriffFlingTarget() or nil

					if farmCore_callResult_0204 and farmCore_callResult_0204 ~= localPlayer then
						local character_ = localPlayer.Character
						local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
						character_ = character_ and character_:FindFirstChild("HumanoidRootPart")
						local character_2 = farmCore_callResult_0204.Character
						local humanoid2 = character_2 and character_2:FindFirstChildOfClass("Humanoid")
						local humanoidRootPart = character_2 and character_2:FindFirstChild("HumanoidRootPart")

						if Hub.CoinFarm.IsLocalPlayerInRound() and humanoid and humanoid.Health > 0 and character_ and character_2 and character_2:IsDescendantOf(workspace) and humanoid2 and humanoid2.Health > 0 and humanoidRootPart and farmCore_helperFunc_0197() then
							Hub.CoinFarm.CancelTween()
							Hub.CoinFarm.currentCoin = nil
							Hub.CoinFarm.LeaveUnderSafely(nil, true)
							RunService.Heartbeat:Wait()
							local flingSheriff = Hub.CoinFarm.flingSheriff

							if type(flingSheriff) == "function" then
								local result
								farmCore_boolFlag_0201, result = pcall(flingSheriff, endRoundGeneration, farmCore_callResult_0204)
								farmCore_boolFlag_0202 = true
								farmCore_boolFlag_0201 = farmCore_boolFlag_0201 and result == true
							end

							break
						else
							task.wait(0.1)
							continue
						end
					else
						task.wait(0.1)
						continue
					end
				end
			end

			break
		end

		local character_ = localPlayer.Character
		character_ = character_ and character_:FindFirstChildOfClass("Humanoid")
		local currentCamera2 = workspace.CurrentCamera

		if currentCamera2 and character_ then
			currentCamera2.CameraType = Enum.CameraType.Custom
			currentCamera2.CameraSubject = character_
		end

		if Hub.CoinFarm.endRoundGeneration == endRoundGeneration then
			Hub.CoinFarm.sheriffFlingRunning = false
			Hub.CoinFarm.sheriffFlingBlocking = false
			Hub.CoinFarm.sheriffFlingCompleted = farmCore_boolFlag_0202 or farmCore_boolFlag_0201 or farmCore_helperFunc_0199()
		end
	end)

	return true
end

Hub.CoinFarm.OnRoundStarted = function()
	local coinFarm = Hub.CoinFarm
	coinFarm.generation = coinFarm.generation + 1
	Hub.CoinFarm.CancelXPFarmWait()
	Hub.CoinFarm.CancelEndRoundRespawnRetry()
	Hub.CoinFarm.CancelTween()
	Hub.CoinFarm.DisableUnder()
	Hub.CoinFarm.ranThisRound = false
	Hub.CoinFarm.endTeleportDone = false
	Hub.CoinFarm.safetyChecked = false
	Hub.CoinFarm.safetyStartedAt = 0
	Hub.CoinFarm.nextMurdererCheckAt = 0
	Hub.CoinFarm.nextMurdererEscapeAt = 0
	Hub.CoinFarm.bagCurrentValue = 0
	Hub.CoinFarm.lastBagCount = 0
	Hub.CoinFarm.bagMaximum = nil
	Hub.CoinFarm.bagFull = false
	Hub.CoinFarm.bagWebhookSent = false
	Hub.CoinFarm.resetRequestedForBag = false
	Hub.CoinFarm.endRoundRunning = false
	Hub.CoinFarm.endRoundCompleted = false
	local coinFarm2 = Hub.CoinFarm
	coinFarm2.endRoundGeneration = coinFarm2.endRoundGeneration + 1
	Hub.CoinFarm.sheriffFlingRunning = false
	Hub.CoinFarm.sheriffFlingBlocking = false
	Hub.CoinFarm.sheriffFlingCompleted = false
	Hub.CoinFarm.endRoundDeathRequested = false
	Hub.CoinFarm.lastLocalDead = false
	Hub.RoleState.lastGunDropPicker = nil
	Hub.RoleState.lastGunDropAt = 0
	Hub.CoinFarm.DisconnectMap()

	if type(Hub.RefreshCoinESP) == "function" then
		task.defer(Hub.RefreshCoinESP)
	end

	if Hub.CoinFarm.enabled then
		Hub.CoinFarm.SetPhase("等待金币出现")
		Hub.CoinFarm.StartRoundSheriffFling()

		task.delay(0.75, function()
			if foxnameMM2Runtime.alive and Hub.CoinFarm.enabled and Hub.RoundState.active and Hub.CoinFarm.blackScreenEnabled then
				Hub.CoinFarm.SetBlackScreen(true, true)
			end
		end)
	end

	Hub.CoinFarm.RefreshStats()
end

Hub.CoinFarm.OnCoinsStarted = function(farmCore_param_0205)
	if type(farmCore_param_0205) ~= "table" or (farmCore_param_0205.Coin == nil and farmCore_param_0205.Candy == nil) then
		return
	end
	Hub.CoinFarm.bagCurrentValue = 0
	Hub.CoinFarm.lastBagCount = 0
	local coin = farmCore_param_0205.Candy ~= nil and farmCore_param_0205.Candy or farmCore_param_0205.Coin

	if type(coin) == "number" then
		Hub.CoinFarm.bagMaximum = coin
	elseif type(coin) == "table" then
		Hub.CoinFarm.bagMaximum = tonumber(coin.MaxCoins or coin.Maximum or coin.Max or coin.Capacity)
	end

	Hub.CoinFarm.bagFull = false
	Hub.CoinFarm.bagWebhookSent = false
	Hub.CoinFarm.resetRequestedForBag = false

	if Hub.CoinFarm.enabled then
		Hub.CoinFarm.IndexMap()
	end

	if Hub.CoinESP and type(Hub.RefreshCoinESP) == "function" then
		task.defer(Hub.RefreshCoinESP)
	end
end

Hub.CoinFarm.TeleportToMapSpawn = function(farmCore_param_0206)
	local character_ = localPlayer.Character
	character_ = character_ and character_:FindFirstChild("HumanoidRootPart")
	if not farmCore_param_0206 or not farmCore_param_0206.Parent or not character_ then
		return false
	end
	local huge = math.huge
	local farmCore_optionalValue_0207 = nil

	for _, descendant in ipairs(farmCore_param_0206:GetDescendants()) do
		if descendant:IsA("BasePart") and descendant.Name == "Spawn" then
			local magnitude = (descendant.Position - character_.Position).Magnitude

			if magnitude < huge then
				huge = magnitude
				farmCore_optionalValue_0207 = descendant
			end
		end
	end

	if not farmCore_optionalValue_0207 then
		return false
	end
	local farmCore_numericVar_0208 = farmCore_optionalValue_0207.Size.Y * 0.5 + character_.Size.Y * 0.5 + 0.15
	character_.AssemblyLinearVelocity = Vector3.zero
	character_.AssemblyAngularVelocity = Vector3.zero
	character_.CFrame = farmCore_optionalValue_0207.CFrame + Vector3.new(0, farmCore_numericVar_0208, 0)
	return true
end

Hub.CoinFarm.TeleportToMapSurface = function(farmCore_param_0209)
	local character_ = localPlayer.Character
	local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
	character_ = character_ and character_:FindFirstChild("HumanoidRootPart")
	if not farmCore_param_0209 or not farmCore_param_0209.Parent or not farmCore_param_0209:IsDescendantOf(workspace) or not humanoid or humanoid.Health <= 0 or not character_ then
		return false
	end
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Include
	raycastParams.FilterDescendantsInstances = { farmCore_param_0209 }
	local farmCore_vectorValue_0210 = character_.Position + Vector3.new(0, character_.Size.Y * 0.5 + 0.05, 0)
	local farmCore_numericVar_0211 = 512
	local farmCore_optionalValue_0212 = nil

	for i = 1, 8 do
		local hit = workspace:Raycast(farmCore_vectorValue_0210, Vector3.new(0, farmCore_numericVar_0211, 0), raycastParams)
		farmCore_optionalValue_0212 = nil

		if hit then
			if hit.Instance.Name ~= "Coin_Server" then
				farmCore_optionalValue_0212 = hit
				break
			else
				farmCore_numericVar_0211 -= (hit.Position - farmCore_vectorValue_0210).Magnitude + 0.1
				farmCore_optionalValue_0212 = nil

				if not (farmCore_numericVar_0211 <= 0) then
					farmCore_vectorValue_0210 = hit.Position + Vector3.new(0, 0.1, 0)
					farmCore_optionalValue_0212 = nil
					continue
				end
			end
		end

		break
	end

	if not farmCore_optionalValue_0212 then
		return false
	end
	local farmCore_numericVar_0213 = farmCore_optionalValue_0212.Position.Y + humanoid.HipHeight + character_.Size.Y * 0.5 + 0.15
	character_.AssemblyLinearVelocity = Vector3.zero
	character_.AssemblyAngularVelocity = Vector3.zero
	local rotation = character_.CFrame.Rotation
	character_.CFrame = CFrame.new(character_.Position.X, farmCore_numericVar_0213, character_.Position.Z) * rotation
	return true
end

Hub.CoinFarm.LeaveUnderSafely = function(farmCore_param_0214, farmCore_param_0215)
	local character_ = localPlayer.Character
	local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
	local humanoidRootPart = character_ and character_:FindFirstChild("HumanoidRootPart")
	local farmCore_underCharacterValue_0216 = (Hub.CoinFarm.underCharacter ~= nil or Hub.CoinFarm.stabilizer ~= nil) and humanoidRootPart and humanoid and humanoid.Health > 0
	local farmCore_boolFlag_0217 = false

	if farmCore_underCharacterValue_0216 then
		local indexedMap = farmCore_param_0214 or Hub.CoinFarm.indexedMap or Hub.RoundState.currentMapInstance or Hub.CoinFarm.ResolveMap()

		if farmCore_param_0215 ~= false then
			farmCore_boolFlag_0217 = Hub.CoinFarm.TeleportToMapSpawn(indexedMap)
		end

		farmCore_boolFlag_0217 = farmCore_boolFlag_0217 or Hub.CoinFarm.TeleportToMapSurface(indexedMap)

		if not farmCore_boolFlag_0217 then
			humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
			humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
			humanoidRootPart.CFrame = humanoidRootPart.CFrame + Vector3.new(0, 8, 0)
			farmCore_boolFlag_0217 = true
		end
	end

	Hub.CoinFarm.DisableUnder()

	if farmCore_boolFlag_0217 and humanoidRootPart and humanoidRootPart.Parent then
		humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
		humanoidRootPart.AssemblyAngularVelocity = Vector3.zero

		pcall(function()
			humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end)

		task.defer(function()
			RunService.Heartbeat:Wait()

			if humanoidRootPart.Parent then
				humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
				humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
			end
		end)
	end

	return farmCore_boolFlag_0217
end

Hub.CoinFarm.OnRoundEnded = function()
	local coinFarm = Hub.CoinFarm
	coinFarm.generation = coinFarm.generation + 1
	Hub.CoinFarm.CancelXPFarmWait()
	Hub.CoinFarm.CancelEndRoundRespawnRetry()
	local blackScreenGui = Hub.CoinFarm.blackScreenGui
	local coinFarm2 = Hub.CoinFarm
	coinFarm2.blackScreenUpdateGeneration = coinFarm2.blackScreenUpdateGeneration + 1

	if blackScreenGui and blackScreenGui.Parent then
		pcall(function()
			blackScreenGui:Destroy()
		end)
	end

	Hub.CoinFarm.blackScreenGui = nil
	table.clear(Hub.CoinFarm.blackScreenLabels)
	local indexedMap = Hub.CoinFarm.indexedMap or Hub.RoundState.currentMapInstance
	local farmCore_enabledValue_0218 = Hub.CoinFarm.enabled and Hub.CoinFarm.ranThisRound and not Hub.CoinFarm.endTeleportDone

	if farmCore_enabledValue_0218 then
		Hub.CoinFarm.endTeleportDone = true
	end

	Hub.CoinFarm.CancelTween()

	if farmCore_enabledValue_0218 then
		if not Hub.CoinFarm.LeaveUnderSafely(indexedMap, true) then
			Hub.CoinFarm.TeleportToMapSpawn(indexedMap)
		end
	else
		Hub.CoinFarm.DisableUnder()
	end

	Hub.CoinFarm.bagCurrentValue = nil
	Hub.CoinFarm.lastBagCount = nil
	Hub.CoinFarm.bagMaximum = nil
	Hub.CoinFarm.bagFull = false
	Hub.CoinFarm.resetRequestedForBag = false
	Hub.CoinFarm.endRoundRunning = false
	Hub.CoinFarm.endRoundCompleted = false
	local coinFarm3 = Hub.CoinFarm
	coinFarm3.endRoundGeneration = coinFarm3.endRoundGeneration + 1
	Hub.CoinFarm.sheriffFlingRunning = false
	Hub.CoinFarm.sheriffFlingBlocking = false
	Hub.CoinFarm.sheriffFlingCompleted = false
	Hub.CoinFarm.endRoundDeathRequested = false
	Hub.CoinFarm.lastLocalDead = false
	Hub.CoinFarm.safetyChecked = false
	Hub.CoinFarm.safetyStartedAt = 0
	Hub.CoinFarm.nextMurdererCheckAt = 0
	Hub.CoinFarm.nextMurdererEscapeAt = 0
	Hub.CoinFarm.ranThisRound = false
	Hub.RoleState.cache = {}
	Hub.RoleState.lastGunDropPicker = nil
	Hub.RoleState.lastGunDropAt = 0
	Hub.CoinFarm.DisconnectMap()

	if type(Hub.DisconnectCoinESPMap) == "function" then
		Hub.DisconnectCoinESPMap(true)
	end

	if Hub.CoinFarm.enabled then
		Hub.CoinFarm.SetPhase("Waiting for round")
	end

	Hub.CoinFarm.RefreshStats()
end

Hub.CoinFarm.TouchCoin = function(farmCore_param_0219, farmCore_param_0220, farmCore_param_0221)
	if not Hub.CoinFarm.IsCoinAvailable(farmCore_param_0221) then
		return false
	end
	farmCore_param_0220.AssemblyLinearVelocity = Vector3.zero
	farmCore_param_0220.CFrame = CFrame.new(Hub.CoinFarm.GetTargetPosition(farmCore_param_0219, farmCore_param_0220, farmCore_param_0221, Hub.CoinFarm.escapeCoin == farmCore_param_0221 and "Under" or nil))
	local head = farmCore_param_0219:FindFirstChild("Head") or farmCore_param_0220

	if type(firetouchinterest) == "function" then
		pcall(function()
			if head and head.Parent then
				firetouchinterest(head, farmCore_param_0221, 0)
				firetouchinterest(head, farmCore_param_0221, 1)
			end
			if farmCore_param_0220 and farmCore_param_0220.Parent and farmCore_param_0220 ~= head then
				firetouchinterest(farmCore_param_0220, farmCore_param_0221, 0)
				firetouchinterest(farmCore_param_0220, farmCore_param_0221, 1)
			end
		end)
	end

	return true
end

Hub.CoinFarm.GetTargetPosition = function(farmCore_param_0222, farmCore_param_0223, farmCore_param_0224, farmCore_param_0225)
	if (farmCore_param_0225 or Hub.CoinFarm.position) ~= "Under" then
		return farmCore_param_0224.Position
	end
	local head = farmCore_param_0222:FindFirstChild("Head")
	head = head and head:IsA("BasePart") and head or farmCore_param_0223
	local farmCore_numericVar_0226 = head.Position.Y + head.Size.Y * 0.5 - farmCore_param_0223.Position.Y
	local farmCore_numericVar_0227 = math.max(0, farmCore_param_0223.Size.Y * 0.5)
	local farmCore_numericVar_0228 = math.clamp(farmCore_numericVar_0226, farmCore_numericVar_0227, math.max(5, farmCore_numericVar_0227))
	local farmCore_numericVar_0229 = farmCore_param_0224.Position.Y - farmCore_param_0224.Size.Y * 0.5
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = { farmCore_param_0222, farmCore_param_0224 }
	local hit = workspace:Raycast(farmCore_param_0224.Position - Vector3.new(0, farmCore_param_0224.Size.Y * 0.5 + 0.05, 0), Vector3.new(0, -16, 0), raycastParams)

	if hit then
		farmCore_numericVar_0229 = hit.Position.Y
	end

	return Vector3.new(farmCore_param_0224.Position.X, farmCore_numericVar_0229 - farmCore_numericVar_0228 - 1.5, farmCore_param_0224.Position.Z)
end

Hub.CoinFarm.IsTravelValid = function(farmCore_param_0230, farmCore_param_0231, farmCore_param_0232, farmCore_param_0233)
	return foxnameMM2Runtime.alive and not isTerminated and Hub.CoinFarm.enabled and not Hub.CoinFarm.sheriffFlingRunning and not Hub.CoinFarm.sheriffFlingBlocking and not Hub.FlingActive and Hub.RoundState.active and Hub.RoundState.coinsReady and Hub.CoinFarm.currentCoin == farmCore_param_0231 and Hub.CoinFarm.mode == farmCore_param_0232 and Hub.CoinFarm.position == farmCore_param_0233 and farmCore_param_0231.Parent ~= nil and Hub.CoinFarm.IsCoinAvailable(farmCore_param_0231) and farmCore_param_0230.Parent ~= nil and Hub.CoinFarm.IsLocalPlayerInRound()
end

Hub.CoinFarm.MoveToCoin = function(farmCore_param_0234, farmCore_param_0235, farmCore_param_0236)
	local mode = Hub.CoinFarm.mode
	local position = Hub.CoinFarm.position
	local escapeUnderActive = Hub.CoinFarm.escapeCoin == farmCore_param_0236
	local farmCore_textValue_0237 = escapeUnderActive and "Under" or position
	Hub.CoinFarm.escapeUnderActive = escapeUnderActive
	local position2 = farmCore_param_0235.Position
	local farmCore_getTargetPositionValue_0238 = Hub.CoinFarm.GetTargetPosition(farmCore_param_0234, farmCore_param_0235, farmCore_param_0236, farmCore_textValue_0237)
	local magnitude = (farmCore_getTargetPositionValue_0238 - position2).Magnitude
	local speed = Hub.CoinFarm.speed or 28
	local farmCore_numericVar_0239 = math.max(magnitude / math.max(1, speed), 0.01)

	if farmCore_textValue_0237 == "Under" or mode == "Tween" then
		Hub.CoinFarm.EnableUnder(farmCore_param_0234, false, escapeUnderActive)
	else
		Hub.CoinFarm.DisableUnder()
	end

	if mode == "Tween" then
		Hub.CoinFarm.CancelTween()
		local tween = TweenService:Create(farmCore_param_0235, TweenInfo.new(farmCore_numericVar_0239, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), { CFrame = CFrame.new(farmCore_getTargetPositionValue_0238) })
		Hub.CoinFarm.activeTween = tween
		tween:Play()

		while tween.PlaybackState == Enum.PlaybackState.Playing do
			if not Hub.CoinFarm.IsTravelValid(farmCore_param_0235, farmCore_param_0236, mode, position) then
				tween:Cancel()
				break
			else
				local farmCore_getNearbyMurdererValue_0240 = Hub.CoinFarm.GetNearbyMurderer(farmCore_param_0235)

				if farmCore_getNearbyMurdererValue_0240 and Hub.CoinFarm.EscapeMurderer(farmCore_param_0235, farmCore_getNearbyMurdererValue_0240) then
					tween:Cancel()
					break
				else
					if farmCore_textValue_0237 == "Under" or mode == "Tween" then
						Hub.CoinFarm.EnableUnder(farmCore_param_0234, false, escapeUnderActive)
					end

					RunService.Heartbeat:Wait()
				end
			end
		end

		local farmCore_boolFlag_0241 = tween.PlaybackState == Enum.PlaybackState.Completed

		if Hub.CoinFarm.activeTween == tween then
			Hub.CoinFarm.activeTween = nil
		end

		pcall(function()
			tween:Destroy()
		end)

		if farmCore_boolFlag_0241 and farmCore_textValue_0237 == "Under" then
			Hub.CoinFarm.EnableUnder(farmCore_param_0234, true, escapeUnderActive)
		end

		return farmCore_boolFlag_0241
	end

	local now = os.clock()
	local farmCore_localValue_0242 = now

	while Hub.CoinFarm.IsTravelValid(farmCore_param_0235, farmCore_param_0236, mode, position) do
		local now2 = os.clock()
		local farmCore_numericVar_0243 = math.clamp((now2 - now) / farmCore_numericVar_0239, 0, 1)

		if farmCore_textValue_0237 == "Under" then
			Hub.CoinFarm.EnableUnder(farmCore_param_0234, false, escapeUnderActive)
		end

		local farmCore_getNearbyMurdererValue_0244 = Hub.CoinFarm.GetNearbyMurderer(farmCore_param_0235)
		if farmCore_getNearbyMurdererValue_0244 and Hub.CoinFarm.EscapeMurderer(farmCore_param_0235, farmCore_getNearbyMurdererValue_0244) then
			return false
		end
		farmCore_param_0235.AssemblyLinearVelocity = Vector3.zero
		farmCore_param_0235.AssemblyAngularVelocity = Vector3.zero
		local farmCore_numericVar_0245 = position2:Lerp(farmCore_getTargetPositionValue_0238, farmCore_numericVar_0243)
		local farmCore_numericVar_0246 = math.max(3, speed * math.min(now2 - farmCore_localValue_0242, 0.12) * 1.35)
		local farmCore_numericVar_0247 = farmCore_numericVar_0245 - farmCore_param_0235.Position

		if farmCore_numericVar_0246 < farmCore_numericVar_0247.Magnitude then
			farmCore_numericVar_0245 = farmCore_param_0235.Position + farmCore_numericVar_0247.Unit * farmCore_numericVar_0246
		end

		farmCore_param_0235.CFrame = CFrame.new(farmCore_numericVar_0245)

		if farmCore_numericVar_0243 >= 1 then
			if farmCore_textValue_0237 == "Under" then
				Hub.CoinFarm.EnableUnder(farmCore_param_0234, true, escapeUnderActive)
			end

			return true
		end

		RunService.Heartbeat:Wait()
		farmCore_localValue_0242 = now2
	end

	return false
end

Hub.CoinFarm.Worker = function()
	if Hub.CoinFarm.workerRunning then
		return
	end
	Hub.CoinFarm.workerRunning = true
	local character_, humanoid, humanoidRootPart, currentCoin, farmCore_boolFlag_0248

	while true do
		local alive = foxnameMM2Runtime.alive
		local farmCore_boolFlag_0249 = alive and not isTerminated
		local exitTo = nil
		local farmCore_boolFlag_0250, farmCore_boolFlag_0251, farmCore_boolFlag_0252, farmCore_boolFlag_0253, farmCore_boolFlag_0254, getTargetPosition, farmCore_textValue_0255, farmCore_localValue_0256, position, farmCore_boolFlag_0257, farmCore_boolFlag_0258, farmCore_localValue_0259, farmCore_localValue_0260, farmCore_numericVar_0261, farmCore_numericVar_0262, farmCore_boolFlag_0263

		while farmCore_boolFlag_0249 do
			if not Hub.CoinFarm.enabled then
				exitTo = 1
				break
			elseif Hub.CoinFarm.sheriffFlingBlocking or Hub.FlingActive then
				exitTo = 2
				break
			elseif not Hub.RoundState.active then
				exitTo = 3
				break
			else
				local farmCore_localValue_0264, farmCore_boolFlag_0265, startedAt, farmCore_boolFlag_0266, sheriffFlingRunning

				if not Hub.RoundState.coinsReady then
					Hub.CoinFarm.IndexMap()

					for k in pairs(Hub.CoinFarm.coins) do
						if Hub.CoinFarm.IsCoinAvailable(k) then
							Hub.RoundState.coinsReady = true
							break
						end
					end

					if not Hub.RoundState.coinsReady then
						exitTo = 14
						break
					elseif not Hub.CoinFarm.IsLocalPlayerInRound() then
						exitTo = 15
						break
					else
						farmCore_localValue_0264 = Hub.CoinFarm.GetCachedRole(localPlayer)
						farmCore_boolFlag_0265 = Hub.CoinFarm.endRoundEnabled and farmCore_localValue_0264 == nil

						if farmCore_boolFlag_0265 then
							startedAt = Hub.RoundState.startedAt
							farmCore_boolFlag_0265 = os.clock() - startedAt < 6
						end

						if farmCore_boolFlag_0265 then
							exitTo = 16
							break
						else
							farmCore_boolFlag_0266 = Hub.CoinFarm.endRoundEnabled and not Hub.CoinFarm.sheriffFlingCompleted and (farmCore_localValue_0264 == "Murderer" or farmCore_localValue_0264 == "Innocent")

							if farmCore_boolFlag_0266 then
								Hub.CoinFarm.StartRoundSheriffFling()
								sheriffFlingRunning = Hub.CoinFarm.sheriffFlingRunning or Hub.CoinFarm.sheriffFlingBlocking

								if sheriffFlingRunning then
									exitTo = 23
									break
								else
									if not Hub.CoinFarm.bagFull then
										Hub.CoinFarm.CheckBagFullGui()
									end

									if Hub.CoinFarm.bagFull then
										Hub.CoinFarm.CancelTween()
										Hub.CoinFarm.LeaveUnderSafely(nil, true)
										Hub.CoinFarm.currentCoin = nil
										farmCore_boolFlag_0250 = type(Hub.CoinFarm.StartXPFarmWait) == "function" and Hub.CoinFarm.StartXPFarmWait()

										if not farmCore_boolFlag_0250 then
											if Hub.CoinFarm.endRoundEnabled then
												Hub.CoinFarm.SetPhase("钱袋已满")
												Hub.CoinFarm.StartEndRoundAction()
											else
												Hub.CoinFarm.ResetAfterBagFull()
											end
										end

										task.wait(0.2)
										alive = foxnameMM2Runtime.alive
										farmCore_boolFlag_0249 = alive and not isTerminated
									elseif not Hub.CoinFarm.IndexMap() then
										Hub.CoinFarm.SetPhase("等待地图加载")
										task.wait(0.2)
										alive = foxnameMM2Runtime.alive
										farmCore_boolFlag_0249 = alive and not isTerminated
									else
										Hub.CoinFarm.ranThisRound = true
										Hub.CoinFarm.SetPhase("Farming")
										character_ = localPlayer.Character
										humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
										humanoidRootPart = character_ and character_:FindFirstChild("HumanoidRootPart")
										farmCore_boolFlag_0251 = not humanoid or humanoid.Health <= 0
										farmCore_boolFlag_0252 = farmCore_boolFlag_0251 or not humanoidRootPart

										if farmCore_boolFlag_0252 then
											humanoid = humanoid and humanoid.Health <= 0 and Hub.CoinFarm.endRoundEnabled and Hub.CoinFarm.ranThisRound and Hub.CoinFarm.GetCachedRole(localPlayer) ~= "Murderer"

											if humanoid then
												Hub.CoinFarm.endRoundDeathRequested = true
												Hub.CoinFarm.StartEndRoundAction()
											end

											Hub.CoinFarm.CancelTween()
											Hub.CoinFarm.DisableUnder()
											Hub.CoinFarm.currentCoin = nil
											Hub.CoinFarm.SetPhase("等待重生")
											task.wait(0.2)
											alive = foxnameMM2Runtime.alive
											farmCore_boolFlag_0249 = alive and not isTerminated
										else
											currentCoin = Hub.CoinFarm.currentCoin
											farmCore_boolFlag_0253 = not currentCoin or not currentCoin.Parent or not Hub.CoinFarm.coins[currentCoin]
											farmCore_boolFlag_0254 = farmCore_boolFlag_0253 or not Hub.CoinFarm.IsCoinAvailable(currentCoin)

											if farmCore_boolFlag_0254 then
												if Hub.CoinFarm.escapeCoin == currentCoin then
													Hub.CoinFarm.escapeCoin = nil
													Hub.CoinFarm.escapeUnderActive = false
												end

												currentCoin = Hub.CoinFarm.GetNearestCoin(humanoidRootPart)
												Hub.CoinFarm.currentCoin = currentCoin
											end

											if not currentCoin then
												Hub.CoinFarm.DisableUnder()
												Hub.CoinFarm.SetPhase("等待金币")
												task.wait(0.15)
												alive = foxnameMM2Runtime.alive
												farmCore_boolFlag_0249 = alive and not isTerminated
											else
												farmCore_boolFlag_0248 = Hub.CoinFarm.escapeCoin == currentCoin
												getTargetPosition = Hub.CoinFarm.GetTargetPosition
												farmCore_textValue_0255 = farmCore_boolFlag_0248 and "Under"
												farmCore_localValue_0256 = farmCore_textValue_0255 or nil
												position = humanoidRootPart.Position

												if not ((getTargetPosition(character_, humanoidRootPart, currentCoin, farmCore_localValue_0256) - position).Magnitude > 2.25) then
													farmCore_boolFlag_0257 = not currentCoin.Parent or Hub.CoinFarm.currentCoin ~= currentCoin

													if farmCore_boolFlag_0257 then
														alive = foxnameMM2Runtime.alive
														farmCore_boolFlag_0249 = alive and not isTerminated
													else
														farmCore_boolFlag_0258 = Hub.CoinFarm.position == "Under"
														farmCore_localValue_0259 = farmCore_boolFlag_0258 or farmCore_boolFlag_0248

														if farmCore_localValue_0259 then
															Hub.CoinFarm.EnableUnder(character_, true, farmCore_boolFlag_0248)
														end

														Hub.CoinFarm.SetPhase("Farming")
														farmCore_localValue_0260 = Hub.CoinFarm.contactAttempts[currentCoin]
														farmCore_numericVar_0261 = farmCore_localValue_0260 or 0
														farmCore_numericVar_0262 = farmCore_numericVar_0261 + 1
														Hub.CoinFarm.contactAttempts[currentCoin] = farmCore_numericVar_0262
														Hub.CoinFarm.TouchCoin(character_, humanoidRootPart, currentCoin)

														if farmCore_boolFlag_0248 then
															Hub.CoinFarm.escapeCoin = nil
															Hub.CoinFarm.escapeUnderActive = false

															if Hub.CoinFarm.position ~= "Under" then
																Hub.CoinFarm.DisableUnder()
															end
														end

														task.wait(0.3)
														farmCore_boolFlag_0263 = Hub.CoinFarm.currentCoin == currentCoin and Hub.CoinFarm.coins[currentCoin]

														if farmCore_boolFlag_0263 then
															if not (farmCore_numericVar_0262 >= 2) then
																alive = foxnameMM2Runtime.alive
																farmCore_boolFlag_0249 = alive and not isTerminated
															else
																Hub.CoinFarm.retryUntil[currentCoin] = os.clock() + 1.5
																Hub.CoinFarm.contactAttempts[currentCoin] = nil
																Hub.CoinFarm.currentCoin = nil

																if Hub.CoinFarm.escapeCoin ~= currentCoin then
																	alive = foxnameMM2Runtime.alive
																	farmCore_boolFlag_0249 = alive and not isTerminated
																else
																	Hub.CoinFarm.escapeCoin = nil
																	Hub.CoinFarm.escapeUnderActive = false
																	alive = foxnameMM2Runtime.alive
																	farmCore_boolFlag_0249 = alive and not isTerminated
																end
															end
														else
															alive = foxnameMM2Runtime.alive
															farmCore_boolFlag_0249 = alive and not isTerminated
														end
													end
												else
													Hub.CoinFarm.SetPhase("Farming")

													if not Hub.CoinFarm.MoveToCoin(character_, humanoidRootPart, currentCoin) then
														if Hub.CoinFarm.currentCoin == currentCoin then
															Hub.CoinFarm.currentCoin = nil
														end

														task.wait(0.05)
														alive = foxnameMM2Runtime.alive
														farmCore_boolFlag_0249 = alive and not isTerminated
													else
														farmCore_boolFlag_0257 = not currentCoin.Parent or Hub.CoinFarm.currentCoin ~= currentCoin

														if farmCore_boolFlag_0257 then
															alive = foxnameMM2Runtime.alive
															farmCore_boolFlag_0249 = alive and not isTerminated
														else
															farmCore_boolFlag_0258 = Hub.CoinFarm.position == "Under"
															farmCore_localValue_0259 = farmCore_boolFlag_0258 or farmCore_boolFlag_0248

															if farmCore_localValue_0259 then
																Hub.CoinFarm.EnableUnder(character_, true, farmCore_boolFlag_0248)
															end

															Hub.CoinFarm.SetPhase("Farming")
															farmCore_localValue_0260 = Hub.CoinFarm.contactAttempts[currentCoin]
															farmCore_numericVar_0261 = farmCore_localValue_0260 or 0
															farmCore_numericVar_0262 = farmCore_numericVar_0261 + 1
															Hub.CoinFarm.contactAttempts[currentCoin] = farmCore_numericVar_0262
															Hub.CoinFarm.TouchCoin(character_, humanoidRootPart, currentCoin)

															if farmCore_boolFlag_0248 then
																Hub.CoinFarm.escapeCoin = nil
																Hub.CoinFarm.escapeUnderActive = false

																if Hub.CoinFarm.position ~= "Under" then
																	Hub.CoinFarm.DisableUnder()
																end
															end

															task.wait(0.3)
															farmCore_boolFlag_0263 = Hub.CoinFarm.currentCoin == currentCoin and Hub.CoinFarm.coins[currentCoin]

															if farmCore_boolFlag_0263 then
																if not (farmCore_numericVar_0262 >= 2) then
																	alive = foxnameMM2Runtime.alive
																	farmCore_boolFlag_0249 = alive and not isTerminated
																else
																	Hub.CoinFarm.retryUntil[currentCoin] = os.clock() + 1.5
																	Hub.CoinFarm.contactAttempts[currentCoin] = nil
																	Hub.CoinFarm.currentCoin = nil

																	if Hub.CoinFarm.escapeCoin ~= currentCoin then
																		alive = foxnameMM2Runtime.alive
																		farmCore_boolFlag_0249 = alive and not isTerminated
																	else
																		Hub.CoinFarm.escapeCoin = nil
																		Hub.CoinFarm.escapeUnderActive = false
																		alive = foxnameMM2Runtime.alive
																		farmCore_boolFlag_0249 = alive and not isTerminated
																	end
																end
															else
																alive = foxnameMM2Runtime.alive
																farmCore_boolFlag_0249 = alive and not isTerminated
															end
														end
													end
												end
											end
										end
									end
								end
							else
								if not Hub.CoinFarm.bagFull then
									Hub.CoinFarm.CheckBagFullGui()
								end

								if Hub.CoinFarm.bagFull then
									exitTo = 17
									break
								elseif not Hub.CoinFarm.IndexMap() then
									exitTo = 18
									break
								else
									Hub.CoinFarm.ranThisRound = true
									Hub.CoinFarm.SetPhase("Farming")
									character_ = localPlayer.Character
									humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
									humanoidRootPart = character_ and character_:FindFirstChild("HumanoidRootPart")
									farmCore_boolFlag_0251 = not humanoid or humanoid.Health <= 0
									farmCore_boolFlag_0252 = farmCore_boolFlag_0251 or not humanoidRootPart

									if farmCore_boolFlag_0252 then
										exitTo = 19
										break
									else
										currentCoin = Hub.CoinFarm.currentCoin
										farmCore_boolFlag_0253 = not currentCoin or not currentCoin.Parent or not Hub.CoinFarm.coins[currentCoin]
										farmCore_boolFlag_0254 = farmCore_boolFlag_0253 or not Hub.CoinFarm.IsCoinAvailable(currentCoin)

										if farmCore_boolFlag_0254 then
											if Hub.CoinFarm.escapeCoin == currentCoin then
												Hub.CoinFarm.escapeCoin = nil
												Hub.CoinFarm.escapeUnderActive = false
											end

											currentCoin = Hub.CoinFarm.GetNearestCoin(humanoidRootPart)
											Hub.CoinFarm.currentCoin = currentCoin
										end

										if not currentCoin then
											exitTo = 20
											break
										else
											farmCore_boolFlag_0248 = Hub.CoinFarm.escapeCoin == currentCoin
											getTargetPosition = Hub.CoinFarm.GetTargetPosition
											farmCore_textValue_0255 = farmCore_boolFlag_0248 and "Under"
											farmCore_localValue_0256 = farmCore_textValue_0255 or nil
											position = humanoidRootPart.Position

											if not ((getTargetPosition(character_, humanoidRootPart, currentCoin, farmCore_localValue_0256) - position).Magnitude > 2.25) then
												exitTo = 21
												break
											else
												Hub.CoinFarm.SetPhase("Farming")

												if not Hub.CoinFarm.MoveToCoin(character_, humanoidRootPart, currentCoin) then
													exitTo = 22
													break
												else
													farmCore_boolFlag_0257 = not currentCoin.Parent or Hub.CoinFarm.currentCoin ~= currentCoin

													if farmCore_boolFlag_0257 then
														alive = foxnameMM2Runtime.alive
														farmCore_boolFlag_0249 = alive and not isTerminated
													else
														farmCore_boolFlag_0258 = Hub.CoinFarm.position == "Under"
														farmCore_localValue_0259 = farmCore_boolFlag_0258 or farmCore_boolFlag_0248

														if farmCore_localValue_0259 then
															Hub.CoinFarm.EnableUnder(character_, true, farmCore_boolFlag_0248)
														end

														Hub.CoinFarm.SetPhase("Farming")
														farmCore_localValue_0260 = Hub.CoinFarm.contactAttempts[currentCoin]
														farmCore_numericVar_0261 = farmCore_localValue_0260 or 0
														farmCore_numericVar_0262 = farmCore_numericVar_0261 + 1
														Hub.CoinFarm.contactAttempts[currentCoin] = farmCore_numericVar_0262
														Hub.CoinFarm.TouchCoin(character_, humanoidRootPart, currentCoin)

														if farmCore_boolFlag_0248 then
															Hub.CoinFarm.escapeCoin = nil
															Hub.CoinFarm.escapeUnderActive = false

															if Hub.CoinFarm.position ~= "Under" then
																Hub.CoinFarm.DisableUnder()
															end
														end

														task.wait(0.3)
														farmCore_boolFlag_0263 = Hub.CoinFarm.currentCoin == currentCoin and Hub.CoinFarm.coins[currentCoin]

														if farmCore_boolFlag_0263 then
															if not (farmCore_numericVar_0262 >= 2) then
																alive = foxnameMM2Runtime.alive
																farmCore_boolFlag_0249 = alive and not isTerminated
															else
																Hub.CoinFarm.retryUntil[currentCoin] = os.clock() + 1.5
																Hub.CoinFarm.contactAttempts[currentCoin] = nil
																Hub.CoinFarm.currentCoin = nil

																if Hub.CoinFarm.escapeCoin ~= currentCoin then
																	alive = foxnameMM2Runtime.alive
																	farmCore_boolFlag_0249 = alive and not isTerminated
																else
																	Hub.CoinFarm.escapeCoin = nil
																	Hub.CoinFarm.escapeUnderActive = false
																	alive = foxnameMM2Runtime.alive
																	farmCore_boolFlag_0249 = alive and not isTerminated
																end
															end
														else
															alive = foxnameMM2Runtime.alive
															farmCore_boolFlag_0249 = alive and not isTerminated
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				elseif not Hub.CoinFarm.IsLocalPlayerInRound() then
					exitTo = 4
					break
				else
					farmCore_localValue_0264 = Hub.CoinFarm.GetCachedRole(localPlayer)
					farmCore_boolFlag_0265 = Hub.CoinFarm.endRoundEnabled and farmCore_localValue_0264 == nil

					if farmCore_boolFlag_0265 then
						startedAt = Hub.RoundState.startedAt
						farmCore_boolFlag_0265 = os.clock() - startedAt < 6
					end

					if farmCore_boolFlag_0265 then
						exitTo = 5
						break
					else
						farmCore_boolFlag_0266 = Hub.CoinFarm.endRoundEnabled and not Hub.CoinFarm.sheriffFlingCompleted and (farmCore_localValue_0264 == "Murderer" or farmCore_localValue_0264 == "Innocent")

						if farmCore_boolFlag_0266 then
							Hub.CoinFarm.StartRoundSheriffFling()
							sheriffFlingRunning = Hub.CoinFarm.sheriffFlingRunning or Hub.CoinFarm.sheriffFlingBlocking

							if sheriffFlingRunning then
								exitTo = 7
								break
							else
								if not Hub.CoinFarm.bagFull then
									Hub.CoinFarm.CheckBagFullGui()
								end

								if Hub.CoinFarm.bagFull then
									exitTo = 8
									break
								elseif not Hub.CoinFarm.IndexMap() then
									exitTo = 9
									break
								else
									Hub.CoinFarm.ranThisRound = true
									Hub.CoinFarm.SetPhase("Farming")
									character_ = localPlayer.Character
									humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
									humanoidRootPart = character_ and character_:FindFirstChild("HumanoidRootPart")
									farmCore_boolFlag_0251 = not humanoid or humanoid.Health <= 0
									farmCore_boolFlag_0252 = farmCore_boolFlag_0251 or not humanoidRootPart

									if farmCore_boolFlag_0252 then
										exitTo = 10
										break
									else
										currentCoin = Hub.CoinFarm.currentCoin
										farmCore_boolFlag_0253 = not currentCoin or not currentCoin.Parent or not Hub.CoinFarm.coins[currentCoin]
										farmCore_boolFlag_0254 = farmCore_boolFlag_0253 or not Hub.CoinFarm.IsCoinAvailable(currentCoin)

										if farmCore_boolFlag_0254 then
											if Hub.CoinFarm.escapeCoin == currentCoin then
												Hub.CoinFarm.escapeCoin = nil
												Hub.CoinFarm.escapeUnderActive = false
											end

											currentCoin = Hub.CoinFarm.GetNearestCoin(humanoidRootPart)
											Hub.CoinFarm.currentCoin = currentCoin
										end

										if not currentCoin then
											exitTo = 11
											break
										else
											farmCore_boolFlag_0248 = Hub.CoinFarm.escapeCoin == currentCoin
											getTargetPosition = Hub.CoinFarm.GetTargetPosition
											farmCore_textValue_0255 = farmCore_boolFlag_0248 and "Under"
											farmCore_localValue_0256 = farmCore_textValue_0255 or nil
											position = humanoidRootPart.Position

											if not ((getTargetPosition(character_, humanoidRootPart, currentCoin, farmCore_localValue_0256) - position).Magnitude > 2.25) then
												exitTo = 12
												break
											else
												Hub.CoinFarm.SetPhase("Farming")

												if not Hub.CoinFarm.MoveToCoin(character_, humanoidRootPart, currentCoin) then
													exitTo = 13
													break
												else
													farmCore_boolFlag_0257 = not currentCoin.Parent or Hub.CoinFarm.currentCoin ~= currentCoin

													if farmCore_boolFlag_0257 then
														alive = foxnameMM2Runtime.alive
														farmCore_boolFlag_0249 = alive and not isTerminated
													else
														farmCore_boolFlag_0258 = Hub.CoinFarm.position == "Under"
														farmCore_localValue_0259 = farmCore_boolFlag_0258 or farmCore_boolFlag_0248

														if farmCore_localValue_0259 then
															Hub.CoinFarm.EnableUnder(character_, true, farmCore_boolFlag_0248)
														end

														Hub.CoinFarm.SetPhase("Farming")
														farmCore_localValue_0260 = Hub.CoinFarm.contactAttempts[currentCoin]
														farmCore_numericVar_0261 = farmCore_localValue_0260 or 0
														farmCore_numericVar_0262 = farmCore_numericVar_0261 + 1
														Hub.CoinFarm.contactAttempts[currentCoin] = farmCore_numericVar_0262
														Hub.CoinFarm.TouchCoin(character_, humanoidRootPart, currentCoin)

														if farmCore_boolFlag_0248 then
															Hub.CoinFarm.escapeCoin = nil
															Hub.CoinFarm.escapeUnderActive = false

															if Hub.CoinFarm.position ~= "Under" then
																Hub.CoinFarm.DisableUnder()
															end
														end

														task.wait(0.3)
														farmCore_boolFlag_0263 = Hub.CoinFarm.currentCoin == currentCoin and Hub.CoinFarm.coins[currentCoin]

														if farmCore_boolFlag_0263 then
															if not (farmCore_numericVar_0262 >= 2) then
																alive = foxnameMM2Runtime.alive
																farmCore_boolFlag_0249 = alive and not isTerminated
															else
																Hub.CoinFarm.retryUntil[currentCoin] = os.clock() + 1.5
																Hub.CoinFarm.contactAttempts[currentCoin] = nil
																Hub.CoinFarm.currentCoin = nil

																if Hub.CoinFarm.escapeCoin ~= currentCoin then
																	alive = foxnameMM2Runtime.alive
																	farmCore_boolFlag_0249 = alive and not isTerminated
																else
																	Hub.CoinFarm.escapeCoin = nil
																	Hub.CoinFarm.escapeUnderActive = false
																	alive = foxnameMM2Runtime.alive
																	farmCore_boolFlag_0249 = alive and not isTerminated
																end
															end
														else
															alive = foxnameMM2Runtime.alive
															farmCore_boolFlag_0249 = alive and not isTerminated
														end
													end
												end
											end
										end
									end
								end
							end
						else
							exitTo = 6
							break
						end
					end
				end
			end
		end

		if exitTo == 1 then
			task.wait(0.2)
			continue
		end

		if exitTo == 2 then
			Hub.CoinFarm.CancelTween()
			Hub.CoinFarm.DisableUnder()
			Hub.CoinFarm.currentCoin = nil
			task.wait(0.1)
			continue
		end

		if exitTo == 3 then
			Hub.CoinFarm.CancelTween()
			Hub.CoinFarm.DisableUnder()
			local serverHopLowPlayers = Hub.CoinFarm.serverHopLowPlayers

			if serverHopLowPlayers then
				local serverHopPlayerThreshold = Hub.CoinFarm.serverHopPlayerThreshold
				serverHopLowPlayers = #Players:GetPlayers() <= serverHopPlayerThreshold
			end

			if serverHopLowPlayers and type(Hub.CoinFarm.StartLowPlayerServerHop) == "function" and Hub.CoinFarm.StartLowPlayerServerHop() or Hub.CoinFarm.serverHopRunning then
				task.wait(1)
			else
				Hub.CoinFarm.SetPhase("Waiting for round")
				task.wait(0.2)
			end

			continue
		end

		if exitTo == 4 then
			Hub.CoinFarm.CancelTween()
			Hub.CoinFarm.DisableUnder()
			Hub.CoinFarm.currentCoin = nil
			Hub.CoinFarm.SetPhase("Waiting for round")
			task.wait(0.2)
			continue
		end

		if exitTo == 5 then
			Hub.CoinFarm.SetPhase("等待身份分配")
			task.wait(0.1)
			continue
		end

		if exitTo == 6 then
			if not Hub.CoinFarm.bagFull then
				Hub.CoinFarm.CheckBagFullGui()
			end

			if Hub.CoinFarm.bagFull then
				Hub.CoinFarm.CancelTween()
				Hub.CoinFarm.LeaveUnderSafely(nil, true)
				Hub.CoinFarm.currentCoin = nil
				farmCore_boolFlag_0250 = type(Hub.CoinFarm.StartXPFarmWait) == "function" and Hub.CoinFarm.StartXPFarmWait()

				if not farmCore_boolFlag_0250 then
					if Hub.CoinFarm.endRoundEnabled then
						Hub.CoinFarm.SetPhase("钱袋已满")
						Hub.CoinFarm.StartEndRoundAction()
					else
						Hub.CoinFarm.ResetAfterBagFull()
					end
				end

				task.wait(0.2)
			elseif not Hub.CoinFarm.IndexMap() then
				Hub.CoinFarm.SetPhase("等待地图加载")
				task.wait(0.2)
			else
				Hub.CoinFarm.ranThisRound = true
				Hub.CoinFarm.SetPhase("Farming")
				character_ = localPlayer.Character
				humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
				humanoidRootPart = character_ and character_:FindFirstChild("HumanoidRootPart")
				farmCore_boolFlag_0251 = not humanoid or humanoid.Health <= 0
				farmCore_boolFlag_0252 = farmCore_boolFlag_0251 or not humanoidRootPart

				if farmCore_boolFlag_0252 then
					humanoid = humanoid and humanoid.Health <= 0 and Hub.CoinFarm.endRoundEnabled and Hub.CoinFarm.ranThisRound and Hub.CoinFarm.GetCachedRole(localPlayer) ~= "Murderer"

					if humanoid then
						Hub.CoinFarm.endRoundDeathRequested = true
						Hub.CoinFarm.StartEndRoundAction()
					end

					Hub.CoinFarm.CancelTween()
					Hub.CoinFarm.DisableUnder()
					Hub.CoinFarm.currentCoin = nil
					Hub.CoinFarm.SetPhase("等待重生")
					task.wait(0.2)
				else
					currentCoin = Hub.CoinFarm.currentCoin
					farmCore_boolFlag_0253 = not currentCoin or not currentCoin.Parent or not Hub.CoinFarm.coins[currentCoin]
					farmCore_boolFlag_0254 = farmCore_boolFlag_0253 or not Hub.CoinFarm.IsCoinAvailable(currentCoin)

					if farmCore_boolFlag_0254 then
						if Hub.CoinFarm.escapeCoin == currentCoin then
							Hub.CoinFarm.escapeCoin = nil
							Hub.CoinFarm.escapeUnderActive = false
						end

						currentCoin = Hub.CoinFarm.GetNearestCoin(humanoidRootPart)
						Hub.CoinFarm.currentCoin = currentCoin
					end

					if not currentCoin then
						Hub.CoinFarm.DisableUnder()
						Hub.CoinFarm.SetPhase("等待金币")
						task.wait(0.15)
					else
						farmCore_boolFlag_0248 = Hub.CoinFarm.escapeCoin == currentCoin
						getTargetPosition = Hub.CoinFarm.GetTargetPosition
						farmCore_textValue_0255 = farmCore_boolFlag_0248 and "Under"
						farmCore_localValue_0256 = farmCore_textValue_0255 or nil
						position = humanoidRootPart.Position

						if not ((getTargetPosition(character_, humanoidRootPart, currentCoin, farmCore_localValue_0256) - position).Magnitude > 2.25) then
							farmCore_boolFlag_0257 = not currentCoin.Parent or Hub.CoinFarm.currentCoin ~= currentCoin

							if not farmCore_boolFlag_0257 then
								farmCore_boolFlag_0258 = Hub.CoinFarm.position == "Under"
								farmCore_localValue_0259 = farmCore_boolFlag_0258 or farmCore_boolFlag_0248

								if farmCore_localValue_0259 then
									Hub.CoinFarm.EnableUnder(character_, true, farmCore_boolFlag_0248)
								end

								Hub.CoinFarm.SetPhase("Farming")
								farmCore_localValue_0260 = Hub.CoinFarm.contactAttempts[currentCoin]
								farmCore_numericVar_0261 = farmCore_localValue_0260 or 0
								farmCore_numericVar_0262 = farmCore_numericVar_0261 + 1
								Hub.CoinFarm.contactAttempts[currentCoin] = farmCore_numericVar_0262
								Hub.CoinFarm.TouchCoin(character_, humanoidRootPart, currentCoin)

								if farmCore_boolFlag_0248 then
									Hub.CoinFarm.escapeCoin = nil
									Hub.CoinFarm.escapeUnderActive = false

									if Hub.CoinFarm.position ~= "Under" then
										Hub.CoinFarm.DisableUnder()
									end
								end

								task.wait(0.3)
								farmCore_boolFlag_0263 = Hub.CoinFarm.currentCoin == currentCoin and Hub.CoinFarm.coins[currentCoin]

								if farmCore_boolFlag_0263 then
									if farmCore_numericVar_0262 >= 2 then
										Hub.CoinFarm.retryUntil[currentCoin] = os.clock() + 1.5
										Hub.CoinFarm.contactAttempts[currentCoin] = nil
										Hub.CoinFarm.currentCoin = nil

										if Hub.CoinFarm.escapeCoin == currentCoin then
											Hub.CoinFarm.escapeCoin = nil
											Hub.CoinFarm.escapeUnderActive = false
										end
									end
								end
							end
						else
							Hub.CoinFarm.SetPhase("Farming")

							if not Hub.CoinFarm.MoveToCoin(character_, humanoidRootPart, currentCoin) then
								if Hub.CoinFarm.currentCoin == currentCoin then
									Hub.CoinFarm.currentCoin = nil
								end

								task.wait(0.05)
							else
								farmCore_boolFlag_0257 = not currentCoin.Parent or Hub.CoinFarm.currentCoin ~= currentCoin

								if not farmCore_boolFlag_0257 then
									farmCore_boolFlag_0258 = Hub.CoinFarm.position == "Under"
									farmCore_localValue_0259 = farmCore_boolFlag_0258 or farmCore_boolFlag_0248

									if farmCore_localValue_0259 then
										Hub.CoinFarm.EnableUnder(character_, true, farmCore_boolFlag_0248)
									end

									Hub.CoinFarm.SetPhase("Farming")
									farmCore_localValue_0260 = Hub.CoinFarm.contactAttempts[currentCoin]
									farmCore_numericVar_0261 = farmCore_localValue_0260 or 0
									farmCore_numericVar_0262 = farmCore_numericVar_0261 + 1
									Hub.CoinFarm.contactAttempts[currentCoin] = farmCore_numericVar_0262
									Hub.CoinFarm.TouchCoin(character_, humanoidRootPart, currentCoin)

									if farmCore_boolFlag_0248 then
										Hub.CoinFarm.escapeCoin = nil
										Hub.CoinFarm.escapeUnderActive = false

										if Hub.CoinFarm.position ~= "Under" then
											Hub.CoinFarm.DisableUnder()
										end
									end

									task.wait(0.3)
									farmCore_boolFlag_0263 = Hub.CoinFarm.currentCoin == currentCoin and Hub.CoinFarm.coins[currentCoin]

									if farmCore_boolFlag_0263 then
										if farmCore_numericVar_0262 >= 2 then
											Hub.CoinFarm.retryUntil[currentCoin] = os.clock() + 1.5
											Hub.CoinFarm.contactAttempts[currentCoin] = nil
											Hub.CoinFarm.currentCoin = nil

											if Hub.CoinFarm.escapeCoin == currentCoin then
												Hub.CoinFarm.escapeCoin = nil
												Hub.CoinFarm.escapeUnderActive = false
											end
										end
									end
								end
							end
						end
					end
				end
			end

			continue
		end

		if exitTo == 7 then
			Hub.CoinFarm.CancelTween()
			Hub.CoinFarm.DisableUnder()
			Hub.CoinFarm.currentCoin = nil
			task.wait(0.1)
			continue
		end

		if exitTo == 8 then
			Hub.CoinFarm.CancelTween()
			Hub.CoinFarm.LeaveUnderSafely(nil, true)
			Hub.CoinFarm.currentCoin = nil
			farmCore_boolFlag_0250 = type(Hub.CoinFarm.StartXPFarmWait) == "function" and Hub.CoinFarm.StartXPFarmWait()

			if not farmCore_boolFlag_0250 then
				if Hub.CoinFarm.endRoundEnabled then
					Hub.CoinFarm.SetPhase("钱袋已满")
					Hub.CoinFarm.StartEndRoundAction()
				else
					Hub.CoinFarm.ResetAfterBagFull()
				end
			end

			task.wait(0.2)
			continue
		end

		if exitTo == 9 then
			Hub.CoinFarm.SetPhase("等待地图加载")
			task.wait(0.2)
			continue
		end

		if exitTo == 10 then
			humanoid = humanoid and humanoid.Health <= 0 and Hub.CoinFarm.endRoundEnabled and Hub.CoinFarm.ranThisRound and Hub.CoinFarm.GetCachedRole(localPlayer) ~= "Murderer"

			if humanoid then
				Hub.CoinFarm.endRoundDeathRequested = true
				Hub.CoinFarm.StartEndRoundAction()
			end

			Hub.CoinFarm.CancelTween()
			Hub.CoinFarm.DisableUnder()
			Hub.CoinFarm.currentCoin = nil
			Hub.CoinFarm.SetPhase("等待重生")
			task.wait(0.2)
			continue
		end

		if exitTo == 11 then
			Hub.CoinFarm.DisableUnder()
			Hub.CoinFarm.SetPhase("等待金币")
			task.wait(0.15)
			continue
		end

		if exitTo == 12 then
			farmCore_boolFlag_0257 = not currentCoin.Parent or Hub.CoinFarm.currentCoin ~= currentCoin
			if farmCore_boolFlag_0257 then
				continue
			end
			farmCore_boolFlag_0258 = Hub.CoinFarm.position == "Under"
			farmCore_localValue_0259 = farmCore_boolFlag_0258 or farmCore_boolFlag_0248

			if farmCore_localValue_0259 then
				Hub.CoinFarm.EnableUnder(character_, true, farmCore_boolFlag_0248)
			end

			Hub.CoinFarm.SetPhase("Farming")
			farmCore_localValue_0260 = Hub.CoinFarm.contactAttempts[currentCoin]
			farmCore_numericVar_0261 = farmCore_localValue_0260 or 0
			farmCore_numericVar_0262 = farmCore_numericVar_0261 + 1
			Hub.CoinFarm.contactAttempts[currentCoin] = farmCore_numericVar_0262
			Hub.CoinFarm.TouchCoin(character_, humanoidRootPart, currentCoin)

			if farmCore_boolFlag_0248 then
				Hub.CoinFarm.escapeCoin = nil
				Hub.CoinFarm.escapeUnderActive = false

				if Hub.CoinFarm.position ~= "Under" then
					Hub.CoinFarm.DisableUnder()
				end
			end

			task.wait(0.3)
			farmCore_boolFlag_0263 = Hub.CoinFarm.currentCoin == currentCoin and Hub.CoinFarm.coins[currentCoin]
			if not farmCore_boolFlag_0263 then
				continue
			end

			if not (farmCore_numericVar_0262 >= 2) then
				continue
			end
			Hub.CoinFarm.retryUntil[currentCoin] = os.clock() + 1.5
			Hub.CoinFarm.contactAttempts[currentCoin] = nil
			Hub.CoinFarm.currentCoin = nil
			if Hub.CoinFarm.escapeCoin ~= currentCoin then
				continue
			end
			Hub.CoinFarm.escapeCoin = nil
			Hub.CoinFarm.escapeUnderActive = false
			continue
		end

		if exitTo == 13 then
			if Hub.CoinFarm.currentCoin == currentCoin then
				Hub.CoinFarm.currentCoin = nil
			end

			task.wait(0.05)
			continue
		end

		if exitTo == 14 then
			local character_2 = localPlayer.Character
			character_2 = character_2 and character_2:FindFirstChild("HumanoidRootPart")
			local farmLoop_getNearbyMurdererValue_0267 = Hub.CoinFarm.GetNearbyMurderer(character_2)

			if farmLoop_getNearbyMurdererValue_0267 then
				Hub.CoinFarm.EscapeMurderer(character_2, farmLoop_getNearbyMurdererValue_0267)
			end

			Hub.CoinFarm.CancelTween()
			Hub.CoinFarm.DisableUnder()
			Hub.CoinFarm.SetPhase("等待金币出现")
			task.wait(0.2)
			continue
		end

		if exitTo == 15 then
			Hub.CoinFarm.CancelTween()
			Hub.CoinFarm.DisableUnder()
			Hub.CoinFarm.currentCoin = nil
			Hub.CoinFarm.SetPhase("Waiting for round")
			task.wait(0.2)
			continue
		end

		if exitTo == 16 then
			Hub.CoinFarm.SetPhase("等待身份分配")
			task.wait(0.1)
			continue
		end

		if exitTo == 17 then
			Hub.CoinFarm.CancelTween()
			Hub.CoinFarm.LeaveUnderSafely(nil, true)
			Hub.CoinFarm.currentCoin = nil
			farmCore_boolFlag_0250 = type(Hub.CoinFarm.StartXPFarmWait) == "function" and Hub.CoinFarm.StartXPFarmWait()

			if not farmCore_boolFlag_0250 then
				if Hub.CoinFarm.endRoundEnabled then
					Hub.CoinFarm.SetPhase("钱袋已满")
					Hub.CoinFarm.StartEndRoundAction()
				else
					Hub.CoinFarm.ResetAfterBagFull()
				end
			end

			task.wait(0.2)
			continue
		end

		if exitTo == 18 then
			Hub.CoinFarm.SetPhase("等待地图加载")
			task.wait(0.2)
			continue
		end

		if exitTo == 19 then
			humanoid = humanoid and humanoid.Health <= 0 and Hub.CoinFarm.endRoundEnabled and Hub.CoinFarm.ranThisRound and Hub.CoinFarm.GetCachedRole(localPlayer) ~= "Murderer"

			if humanoid then
				Hub.CoinFarm.endRoundDeathRequested = true
				Hub.CoinFarm.StartEndRoundAction()
			end

			Hub.CoinFarm.CancelTween()
			Hub.CoinFarm.DisableUnder()
			Hub.CoinFarm.currentCoin = nil
			Hub.CoinFarm.SetPhase("等待重生")
			task.wait(0.2)
			continue
		end

		if exitTo == 20 then
			Hub.CoinFarm.DisableUnder()
			Hub.CoinFarm.SetPhase("等待金币")
			task.wait(0.15)
			continue
		end

		if exitTo == 21 then
			farmCore_boolFlag_0257 = not currentCoin.Parent or Hub.CoinFarm.currentCoin ~= currentCoin
			if farmCore_boolFlag_0257 then
				continue
			end
			farmCore_boolFlag_0258 = Hub.CoinFarm.position == "Under"
			farmCore_localValue_0259 = farmCore_boolFlag_0258 or farmCore_boolFlag_0248

			if farmCore_localValue_0259 then
				Hub.CoinFarm.EnableUnder(character_, true, farmCore_boolFlag_0248)
			end

			Hub.CoinFarm.SetPhase("Farming")
			farmCore_localValue_0260 = Hub.CoinFarm.contactAttempts[currentCoin]
			farmCore_numericVar_0261 = farmCore_localValue_0260 or 0
			farmCore_numericVar_0262 = farmCore_numericVar_0261 + 1
			Hub.CoinFarm.contactAttempts[currentCoin] = farmCore_numericVar_0262
			Hub.CoinFarm.TouchCoin(character_, humanoidRootPart, currentCoin)

			if farmCore_boolFlag_0248 then
				Hub.CoinFarm.escapeCoin = nil
				Hub.CoinFarm.escapeUnderActive = false

				if Hub.CoinFarm.position ~= "Under" then
					Hub.CoinFarm.DisableUnder()
				end
			end

			task.wait(0.3)
			farmCore_boolFlag_0263 = Hub.CoinFarm.currentCoin == currentCoin and Hub.CoinFarm.coins[currentCoin]
			if not farmCore_boolFlag_0263 then
				continue
			end

			if not (farmCore_numericVar_0262 >= 2) then
				continue
			end
			Hub.CoinFarm.retryUntil[currentCoin] = os.clock() + 1.5
			Hub.CoinFarm.contactAttempts[currentCoin] = nil
			Hub.CoinFarm.currentCoin = nil
			if Hub.CoinFarm.escapeCoin ~= currentCoin then
				continue
			end
			Hub.CoinFarm.escapeCoin = nil
			Hub.CoinFarm.escapeUnderActive = false
			continue
		end

		if exitTo == 22 then
			if Hub.CoinFarm.currentCoin == currentCoin then
				Hub.CoinFarm.currentCoin = nil
			end

			task.wait(0.05)
			continue
		end

		if exitTo == 23 then
			Hub.CoinFarm.CancelTween()
			Hub.CoinFarm.DisableUnder()
			Hub.CoinFarm.currentCoin = nil
			task.wait(0.1)
			continue
		end

		break
	end

	Hub.CoinFarm.workerRunning = false
end

Hub.CoinFarm.FindOwnedCoinAmountLabels = function()
	local function blackScreen_helperFunc_0268(blackScreen_param_0269)
		if not blackScreen_param_0269 then
			return nil
		end
		local title = blackScreen_param_0269:FindFirstChild("Title")
		local container = title and title:FindFirstChild("Container")
		container = container and container:FindFirstChild("Coins") or title and title:FindFirstChild("Coins")
		container = container and container:FindFirstChild("Container")
		local amount = container and container:FindFirstChild("Amount")
		if amount and amount:IsA("TextLabel") and amount.Visible then
			return amount
		end
		amount = amount and amount:FindFirstChild("Amount")
		if amount and amount:IsA("TextLabel") and amount.Visible then
			return amount
		end
		return nil
	end

	local function blackScreen_helperFunc_0270(blackScreen_param_0271)
		blackScreen_param_0271 = blackScreen_param_0271 and blackScreen_param_0271:FindFirstChild("CrossPlatform")
		blackScreen_param_0271 = blackScreen_param_0271 and blackScreen_param_0271:FindFirstChild("Shop")
		if not blackScreen_param_0271 then
			return nil
		end
		local small = blackScreen_param_0271:FindFirstChild("Small")
		return blackScreen_helperFunc_0268(small and small:FindFirstChild("Container")), (blackScreen_helperFunc_0268(blackScreen_param_0271:FindFirstChild("Medium")))
	end

	local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
	local CoreGui = nil

	pcall(function()
		CoreGui = game:GetService("CoreGui")
	end)

	local blackScreen_callResult_0272, blackScreen_callResult_0273 = blackScreen_helperFunc_0270(playerGui)
	if blackScreen_callResult_0272 or blackScreen_callResult_0273 then
		return blackScreen_callResult_0272, blackScreen_callResult_0273
	end
	return blackScreen_helperFunc_0270(CoreGui)
end

Hub.CoinFarm.ParseOwnedCoinText = function(blackScreen_param_0274)
	if not blackScreen_param_0274 or not blackScreen_param_0274.Parent or not blackScreen_param_0274:IsA("TextLabel") or not blackScreen_param_0274.Visible then
		return nil
	end
	local match = tostring(blackScreen_param_0274.Text or ""):match("%d[%d%.,]*")
	if not match then
		return nil
	end
	local blackScreen_localValue_0275 = tonumber
	local blackScreen_textValue_0276 = match:gsub("[^%d]", "")
	local blackScreen_callResult_0277 = blackScreen_localValue_0275(blackScreen_textValue_0276)
	return blackScreen_callResult_0277 and math.max(0, math.floor(blackScreen_callResult_0277)) or nil
end

Hub.CoinFarm.FindOwnedCoinAmountLabel = function(blackScreen_param_0278)
	local blackScreen_findOwnedCoinAmountLabelsValue_0279, blackScreen_findOwnedCoinAmountLabelsValue_0280 = Hub.CoinFarm.FindOwnedCoinAmountLabels()
	local blackScreen_parseOwnedCoinTextValue_0281 = Hub.CoinFarm.ParseOwnedCoinText(blackScreen_findOwnedCoinAmountLabelsValue_0279)
	local blackScreen_parseOwnedCoinTextValue_0282 = Hub.CoinFarm.ParseOwnedCoinText(blackScreen_findOwnedCoinAmountLabelsValue_0280)
	if blackScreen_parseOwnedCoinTextValue_0281 == 43000 and blackScreen_parseOwnedCoinTextValue_0282 ~= nil and blackScreen_parseOwnedCoinTextValue_0282 ~= 43000 then
		return blackScreen_findOwnedCoinAmountLabelsValue_0280
	end

	if blackScreen_parseOwnedCoinTextValue_0282 == 43000 and blackScreen_parseOwnedCoinTextValue_0281 ~= nil and blackScreen_parseOwnedCoinTextValue_0281 ~= 43000 then
		return blackScreen_findOwnedCoinAmountLabelsValue_0279
	end
	blackScreen_findOwnedCoinAmountLabelsValue_0280 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and (blackScreen_findOwnedCoinAmountLabelsValue_0279 or blackScreen_findOwnedCoinAmountLabelsValue_0280) or blackScreen_findOwnedCoinAmountLabelsValue_0280 or blackScreen_findOwnedCoinAmountLabelsValue_0279

	if blackScreen_parseOwnedCoinTextValue_0281 == 43000 and blackScreen_parseOwnedCoinTextValue_0282 == 43000 then
		local blackScreen_numericVar_0283 = type(blackScreen_param_0278) == "table" and tonumber(blackScreen_param_0278.Coins) or nil
		if blackScreen_numericVar_0283 and math.floor(blackScreen_numericVar_0283) ~= 43000 then
			return nil
		end
	end

	return blackScreen_findOwnedCoinAmountLabelsValue_0280
end

Hub.CoinFarm.GetOwnedCoinCount = function(blackScreen_param_0284)
	local ownedCoinAmountLabel = Hub.CoinFarm.ownedCoinAmountLabel

	if not ownedCoinAmountLabel or not ownedCoinAmountLabel.Parent or not ownedCoinAmountLabel:IsA("TextLabel") or not ownedCoinAmountLabel.Visible then
		ownedCoinAmountLabel = Hub.CoinFarm.FindOwnedCoinAmountLabel(blackScreen_param_0284)
		Hub.CoinFarm.ownedCoinAmountLabel = ownedCoinAmountLabel
	end

	if ownedCoinAmountLabel then
		local blackScreen_parseOwnedCoinTextValue_0285 = Hub.CoinFarm.ParseOwnedCoinText(ownedCoinAmountLabel)

		if blackScreen_parseOwnedCoinTextValue_0285 == 43000 then
			local blackScreen_findOwnedCoinAmountLabelValue_0286 = Hub.CoinFarm.FindOwnedCoinAmountLabel(blackScreen_param_0284)
			Hub.CoinFarm.ownedCoinAmountLabel = blackScreen_findOwnedCoinAmountLabelValue_0286
			blackScreen_parseOwnedCoinTextValue_0285 = Hub.CoinFarm.ParseOwnedCoinText(blackScreen_findOwnedCoinAmountLabelValue_0286)
		end

		if blackScreen_parseOwnedCoinTextValue_0285 then
			return math.max(0, math.floor(blackScreen_parseOwnedCoinTextValue_0285))
		end
		Hub.CoinFarm.ownedCoinAmountLabel = nil
	end

	local blackScreen_numericVar_0287 = type(blackScreen_param_0284) == "table" and tonumber(blackScreen_param_0284.Coins) or nil
	return blackScreen_numericVar_0287 and math.max(0, math.floor(blackScreen_numericVar_0287)) or 0
end

Hub.CoinFarm.RefreshBlackScreen = function(text)
	local blackScreenLabels = Hub.CoinFarm.blackScreenLabels
	local blackScreenGui = Hub.CoinFarm.blackScreenGui
	if not Hub.CoinFarm.blackScreenEnabled or not blackScreenGui or not blackScreenGui.Parent or type(blackScreenLabels) ~= "table" or not blackScreenLabels.status then
		return
	end

	if text ~= "Innocent" and text ~= "Sheriff" and text ~= "Murderer" and text ~= "Hero" then
		text = type(Hub.CoinFarm.GetCachedRole) == "function" and Hub.CoinFarm.GetCachedRole(localPlayer) or nil
	end

	if text ~= "Innocent" and text ~= "Sheriff" and text ~= "Murderer" and text ~= "Hero" then
		text = "Unknown"
	end

	local blackScreen_bagCurrentValueValue_0288 = tonumber(Hub.CoinFarm.bagCurrentValue) or tonumber(Hub.CoinFarm.lastBagCount) or tonumber(Hub.CoinFarm.GetBagCount()) or 0
	local blackScreen_bagMaximumValue_0289 = tonumber(Hub.CoinFarm.bagMaximum) or 0
	local blackScreen_numericVar_0290 = math.max(0, math.floor(blackScreen_bagCurrentValueValue_0288))
	local blackScreen_numericVar_0291 = math.max(0, math.floor(blackScreen_bagMaximumValue_0289))
	local blackScreen_sessionStartedAtValue_0292 = tonumber(Hub.CoinFarm.sessionStartedAt) or 0
	local blackScreen_timestamp_0293 = blackScreen_sessionStartedAtValue_0292 > 0 and math.max(0, os.clock() - blackScreen_sessionStartedAtValue_0292) or 0
	local blackScreen_numericVar_0294 = math.floor(blackScreen_timestamp_0293 / 60)
	local blackScreen_numericVar_0295 = math.floor(blackScreen_timestamp_0293 % 60)
	local blackScreen_getDataValue_0296, blackScreen_getDataValue_0297 = Hub.AutoPrestige.GetData()
	local blackScreen_numericVar_0298 = type(blackScreen_getDataValue_0296) == "table" and tonumber(blackScreen_getDataValue_0296.NewXP) or 0
	local blackScreen_getOwnedCoinCountValue_0299 = Hub.CoinFarm.GetOwnedCoinCount(blackScreen_getDataValue_0296)
	local blackScreen_numericVar_0300 = math.max(tonumber(localPlayer:GetAttribute("Prestige")) or 0, type(blackScreen_getDataValue_0296) == "table" and tonumber(blackScreen_getDataValue_0296.Prestige) or nil or 0)
	local blackScreen_callResult_0301 = type(blackScreen_getDataValue_0297) == "table" and type(blackScreen_getDataValue_0297.GetLevel) == "function"
	local blackScreen_numericVar_0302 = 1

	if blackScreen_callResult_0301 then
		local ok, result = pcall(blackScreen_getDataValue_0297.GetLevel, blackScreen_numericVar_0298)

		if ok then
			local numericResult = tonumber(result)
			if numericResult then
				blackScreen_numericVar_0302 = math.max(1, math.floor(numericResult))
			end
		end
	end

	local blackScreen_blackScreenPrestigeValue_0303 = tonumber(Hub.AutoPrestige.blackScreenPrestige)

	if blackScreen_blackScreenPrestigeValue_0303 and blackScreen_numericVar_0300 > blackScreen_blackScreenPrestigeValue_0303 then
		Hub.AutoPrestige.blackScreenPrestigeResetPending = true
	end

	if Hub.AutoPrestige.blackScreenPrestigeResetPending and blackScreen_numericVar_0302 >= 100 then
		blackScreen_numericVar_0302 = 1
	elseif blackScreen_numericVar_0302 < 100 then
		Hub.AutoPrestige.blackScreenPrestigeResetPending = false
	end

	Hub.AutoPrestige.blackScreenPrestige = math.max(blackScreen_blackScreenPrestigeValue_0303 or 0, blackScreen_numericVar_0300)

	local function blackScreen_helperFunc_0304(blackScreen_param_0305)
		return tostring(math.max(0, math.floor(tonumber(blackScreen_param_0305) or 0))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
	end

	local text2 = tostring(Hub.CoinFarm.phase)
	local text3 = blackScreen_numericVar_0291 > 0 and tostring(blackScreen_numericVar_0290) .. " / " .. tostring(blackScreen_numericVar_0291) or tostring(blackScreen_numericVar_0290)
	local text4 = blackScreen_helperFunc_0304(Hub.CoinFarm.totalEarnedXP) .. " XP"
	local blackScreen_totalCollectedValue_0306 = blackScreen_helperFunc_0304(Hub.CoinFarm.totalCollected)
	local blackScreen_callResult_0307 = blackScreen_helperFunc_0304(blackScreen_getOwnedCoinCountValue_0299)
	local text5 = string.format("%02d:%02d", blackScreen_numericVar_0294, blackScreen_numericVar_0295)
	local blackScreen_numericVar_0308 = blackScreen_numericVar_0291 > 0 and math.clamp(blackScreen_numericVar_0290 / blackScreen_numericVar_0291, 0, 1) or 0

	if blackScreenLabels.status.Text ~= text2 then
		blackScreenLabels.status.Text = text2
	end

	if blackScreenLabels.role.Text ~= text then
		blackScreenLabels.role.Text = text
	end

	if blackScreenLabels.bag.Text ~= text3 then
		blackScreenLabels.bag.Text = text3
	end

	if blackScreenLabels.level.Text ~= tostring(blackScreen_numericVar_0302) then
		blackScreenLabels.level.Text = tostring(blackScreen_numericVar_0302)
	end

	if blackScreenLabels.prestige.Text ~= tostring(blackScreen_numericVar_0300) then
		blackScreenLabels.prestige.Text = tostring(blackScreen_numericVar_0300)
	end

	if blackScreenLabels.earnedXP.Text ~= text4 then
		blackScreenLabels.earnedXP.Text = text4
	end

	if blackScreenLabels.collectedCoins.Text ~= blackScreen_totalCollectedValue_0306 then
		blackScreenLabels.collectedCoins.Text = blackScreen_totalCollectedValue_0306
	end

	if blackScreenLabels.totalCoins.Text ~= blackScreen_callResult_0307 then
		blackScreenLabels.totalCoins.Text = blackScreen_callResult_0307
	end

	if blackScreenLabels.session.Text ~= text5 then
		blackScreenLabels.session.Text = text5
	end

	if math.abs(blackScreenLabels.progress.Size.X.Scale - blackScreen_numericVar_0308) > 0.001 then
		blackScreenLabels.progress.Size = UDim2.fromScale(blackScreen_numericVar_0308, 1)
	end
end

Hub.CoinFarm.SetBlackScreen = function(blackScreen_param_0309, blackScreen_param_0310)
	local blackScreenEnabled = blackScreen_param_0309 and true or false
	Hub.CoinFarm.blackScreenEnabled = blackScreenEnabled
	local coinFarm = Hub.CoinFarm
	coinFarm.blackScreenUpdateGeneration = coinFarm.blackScreenUpdateGeneration + 1
	local blackScreenUpdateGeneration = Hub.CoinFarm.blackScreenUpdateGeneration
	local blackScreenGui = Hub.CoinFarm.blackScreenGui

	if blackScreenGui and blackScreenGui.Parent then
		blackScreenGui:Destroy()
	end

	Hub.CoinFarm.blackScreenGui = nil
	table.clear(Hub.CoinFarm.blackScreenLabels)
	if not blackScreenEnabled then
		return true
	end

	if not Hub.CoinFarm.enabled or not Hub.RoundState.active or not Hub.CoinFarm.IsLocalPlayerInRound() then
		return true
	end
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "FoxnameCoinFarmBlackScreen_" .. sessionId
	screenGui.IgnoreGuiInset = true
	screenGui.ResetOnSpawn = false
	screenGui.DisplayOrder = 2147483647
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	local textButton = Instance.new("TextButton")
	textButton.Name = "Cover"
	textButton.Size = UDim2.fromScale(1, 1)
	textButton.BackgroundColor3 = Color3.new(0, 0, 0)
	textButton.BackgroundTransparency = 0
	textButton.BorderSizePixel = 0
	textButton.AutoButtonColor = false
	textButton.Text = ""
	textButton.ZIndex = 1000000
	textButton.Parent = screenGui
	local frame = Instance.new("Frame")
	frame.Name = "FarmCard"
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.Position = UDim2.fromScale(0.5, 0.5)
	frame.Size = UDim2.new(0.88, 0, 0, 518)
	frame.BackgroundColor3 = Color3.fromRGB(10, 10, 13)
	frame.BorderSizePixel = 0
	frame.ClipsDescendants = true
	frame.ZIndex = textButton.ZIndex + 1
	frame.Parent = textButton
	local uiSizeConstraint = Instance.new("UISizeConstraint")
	uiSizeConstraint.MinSize = Vector2.new(290, 518)
	uiSizeConstraint.MaxSize = Vector2.new(430, 518)
	uiSizeConstraint.Parent = frame
	local uiScale = Instance.new("UIScale")
	uiScale.Parent = frame
	local connection = nil

	local function blackScreen_helperFunc_0311()
		local currentCamera2 = workspace.CurrentCamera
		currentCamera2 = currentCamera2 and currentCamera2.ViewportSize
		if not currentCamera2 or currentCamera2.X <= 0 or currentCamera2.Y <= 0 then
			uiScale.Scale = 1
			return
		end
		local blackScreen_numericVar_0312 = (currentCamera2.Y - 24) / 518
		uiScale.Scale = math.clamp(math.min((currentCamera2.X - 24) / math.clamp(currentCamera2.X * 0.88, 290, 430), blackScreen_numericVar_0312), 0.55, 1)
	end

	blackScreen_helperFunc_0311()

	if workspace.CurrentCamera then
		connection = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(blackScreen_helperFunc_0311)
	end

	screenGui.Destroying:Once(function()
		if connection then
			connection:Disconnect()
			connection = nil
		end
	end)

	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 20)
	uiCorner.Parent = frame
	local uiStroke = Instance.new("UIStroke")
	uiStroke.Color = Color3.fromRGB(80, 28, 42)
	uiStroke.Transparency = 0.25
	uiStroke.Thickness = 1
	uiStroke.Parent = frame
	local frame2 = Instance.new("Frame")
	frame2.Name = "AccentClip"
	frame2.Position = UDim2.fromOffset(0, 0)
	frame2.Size = UDim2.new(1, 0, 0, 20)
	frame2.BackgroundTransparency = 1
	frame2.BorderSizePixel = 0
	frame2.ClipsDescendants = true
	frame2.ZIndex = frame.ZIndex + 1
	frame2.Parent = frame
	local frame3 = Instance.new("Frame")
	frame3.Name = "Accent"
	frame3.Position = UDim2.fromOffset(0, 0)
	frame3.Size = UDim2.new(1, 0, 0, 518)
	frame3.BackgroundTransparency = 1
	frame3.BorderSizePixel = 0
	frame3.ZIndex = frame2.ZIndex
	frame3.Parent = frame2
	local uiCorner2 = Instance.new("UICorner")
	uiCorner2.CornerRadius = UDim.new(0, 20)
	uiCorner2.Parent = frame3
	local uiStroke2 = Instance.new("UIStroke")
	uiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	uiStroke2.Color = Color3.new(1, 1, 1)
	uiStroke2.Thickness = 3
	uiStroke2.Transparency = 0
	uiStroke2.Parent = frame3
	local uiGradient = Instance.new("UIGradient")
	local colorSequence = ColorSequence.new
	local blackScreen_configTable_0313 = {}
	local blackScreen_colorValue_0314 = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 74))
	local blackScreen_colorValue_0315 = ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 90, 135))
	local new = ColorSequenceKeypoint.new
	local color = Color3.fromRGB
	blackScreen_configTable_0313[1] = blackScreen_colorValue_0314
	blackScreen_configTable_0313[2] = blackScreen_colorValue_0315

	do
		local values = table.pack(new(1, color(255, 35, 74)))
		table.move(values, 1, values.n, 3, blackScreen_configTable_0313)
	end

	uiGradient.Color = colorSequence(blackScreen_configTable_0313)
	uiGradient.Parent = uiStroke2
	local imageLabel = Instance.new("ImageLabel")
	imageLabel.Name = "Icon"
	imageLabel.Position = UDim2.fromOffset(24, 25)
	imageLabel.Size = UDim2.fromOffset(42, 42)
	imageLabel.BackgroundColor3 = Color3.fromRGB(32, 10, 17)
	imageLabel.BorderSizePixel = 0
	imageLabel.Image = "rbxassetid://133245078123989"
	imageLabel.ScaleType = Enum.ScaleType.Fit
	imageLabel.ZIndex = frame.ZIndex + 1
	imageLabel.Parent = frame
	local uiCorner3 = Instance.new("UICorner")
	uiCorner3.CornerRadius = UDim.new(0, 12)
	uiCorner3.Parent = imageLabel

	local function createTextLabel(name, text, position, size, textSize, textColor3, font, textXAlignment)
		local textLabel = Instance.new("TextLabel")
		textLabel.Name = name
		textLabel.Position = position
		textLabel.Size = size
		textLabel.BackgroundTransparency = 1
		textLabel.Text = text
		textLabel.TextColor3 = textColor3
		textLabel.TextSize = textSize
		textLabel.Font = font
		textLabel.TextXAlignment = textXAlignment or Enum.TextXAlignment.Left
		textLabel.TextYAlignment = Enum.TextYAlignment.Center
		textLabel.ZIndex = frame.ZIndex + 1
		textLabel.Parent = frame
		return textLabel
	end

	local gothamBold = Enum.Font.GothamBold
	createTextLabel("Title", "FOXNAME", UDim2.fromOffset(78, 24), UDim2.new(1, -102, 0, 24), 20, Color3.fromRGB(255, 244, 247), gothamBold)
	local gothamBold2 = Enum.Font.GothamBold
	createTextLabel("Subtitle", "挂机刷币模式", UDim2.fromOffset(78, 48), UDim2.new(1, -190, 0, 18), 11, Color3.fromRGB(255, 83, 122), gothamBold2)
	local gothamBold3 = Enum.Font.GothamBold
	local right = Enum.TextXAlignment.Right
	local Session = createTextLabel("Session", "00:00", UDim2.new(1, -98, 0, 48), UDim2.fromOffset(74, 18), 11, Color3.fromRGB(166, 166, 178), gothamBold3, right)
	local frame4 = Instance.new("Frame")
	frame4.Position = UDim2.fromOffset(24, 82)
	frame4.Size = UDim2.new(1, -48, 0, 48)
	frame4.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
	frame4.BorderSizePixel = 0
	frame4.ZIndex = frame.ZIndex + 1
	frame4.Parent = frame
	local uiCorner4 = Instance.new("UICorner")
	uiCorner4.CornerRadius = UDim.new(0, 12)
	uiCorner4.Parent = frame4
	local frame5 = Instance.new("Frame")
	frame5.AnchorPoint = Vector2.new(0, 0.5)
	frame5.Position = UDim2.new(0, 14, 0.5, 0)
	frame5.Size = UDim2.fromOffset(8, 8)
	frame5.BackgroundColor3 = Color3.fromRGB(62, 224, 138)
	frame5.BorderSizePixel = 0
	frame5.ZIndex = frame4.ZIndex + 1
	frame5.Parent = frame4
	local uiCorner5 = Instance.new("UICorner")
	uiCorner5.CornerRadius = UDim.new(1, 0)
	uiCorner5.Parent = frame5
	local textLabel = Instance.new("TextLabel")
	textLabel.Name = "Status"
	textLabel.Position = UDim2.fromOffset(32, 0)
	textLabel.Size = UDim2.new(1, -44, 1, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.Text = "等待对局开始"
	textLabel.TextColor3 = Color3.fromRGB(235, 235, 240)
	textLabel.TextSize = 14
	textLabel.Font = Enum.Font.GothamMedium
	textLabel.TextXAlignment = Enum.TextXAlignment.Left
	textLabel.ZIndex = frame4.ZIndex + 1
	textLabel.Parent = frame4

	local function createTextLabel2(blackScreen_param_0316, text, blackScreen_param_0317, blackScreen_param_0318)
		local frame6 = Instance.new("Frame")
		frame6.Name = blackScreen_param_0316 .. "Card"
		frame6.Position = UDim2.new(blackScreen_param_0317, blackScreen_param_0317 == 0 and 24 or 4, 0, blackScreen_param_0318)
		frame6.Size = UDim2.new(0.5, -28, 0, 62)
		frame6.BackgroundColor3 = Color3.fromRGB(15, 15, 19)
		frame6.BorderSizePixel = 0
		frame6.ZIndex = frame.ZIndex + 1
		frame6.Parent = frame
		local uiCorner6 = Instance.new("UICorner")
		uiCorner6.CornerRadius = UDim.new(0, 12)
		uiCorner6.Parent = frame6
		local textLabel2 = Instance.new("TextLabel")
		textLabel2.Position = UDim2.fromOffset(12, 7)
		textLabel2.Size = UDim2.new(1, -24, 0, 18)
		textLabel2.BackgroundTransparency = 1
		textLabel2.Text = text
		textLabel2.TextColor3 = Color3.fromRGB(126, 126, 138)
		textLabel2.TextSize = 10
		textLabel2.Font = Enum.Font.GothamBold
		textLabel2.TextXAlignment = Enum.TextXAlignment.Left
		textLabel2.ZIndex = frame6.ZIndex + 1
		textLabel2.Parent = frame6
		local textLabel3 = Instance.new("TextLabel")
		textLabel3.Position = UDim2.fromOffset(12, 25)
		textLabel3.Size = UDim2.new(1, -24, 0, 28)
		textLabel3.BackgroundTransparency = 1
		textLabel3.Text = "--"
		textLabel3.TextColor3 = Color3.fromRGB(245, 245, 248)
		textLabel3.TextSize = 17
		textLabel3.Font = Enum.Font.GothamBold
		textLabel3.TextXAlignment = Enum.TextXAlignment.Left
		textLabel3.TextScaled = true
		textLabel3.ZIndex = frame6.ZIndex + 1
		textLabel3.Parent = frame6
		local uiTextSizeConstraint = Instance.new("UITextSizeConstraint")
		uiTextSizeConstraint.MinTextSize = 10
		uiTextSizeConstraint.MaxTextSize = 17
		uiTextSizeConstraint.Parent = textLabel3
		return textLabel3
	end

	local Role = createTextLabel2("Role", "ROLE", 0, 140)
	local Bag = createTextLabel2("Bag", "钱袋", 0.5, 140)
	local Level = createTextLabel2("Level", "LEVEL", 0, 210)
	local Prestige = createTextLabel2("Prestige", "PRESTIGE", 0.5, 210)
	local EarnedXP = createTextLabel2("EarnedXP", "获得经验", 0, 280)
	local CollectedCoins = createTextLabel2("CollectedCoins", "已收集金币", 0.5, 280)
	local TotalCoins = createTextLabel2("TotalCoins", "持有金币", 0, 350)
	TotalCoins.Parent.Size = UDim2.new(1, -48, 0, 62)
	local frame6 = Instance.new("Frame")
	frame6.Name = "ProgressTrack"
	frame6.Position = UDim2.new(0, 24, 0, 426)
	frame6.Size = UDim2.new(1, -48, 0, 5)
	frame6.BackgroundColor3 = Color3.fromRGB(29, 29, 35)
	frame6.BorderSizePixel = 0
	frame6.ZIndex = frame.ZIndex + 1
	frame6.Parent = frame
	local uiCorner6 = Instance.new("UICorner")
	uiCorner6.CornerRadius = UDim.new(1, 0)
	uiCorner6.Parent = frame6
	local frame7 = Instance.new("Frame")
	frame7.Name = "Progress"
	frame7.Size = UDim2.fromScale(0, 1)
	frame7.BackgroundColor3 = Color3.fromRGB(255, 55, 98)
	frame7.BorderSizePixel = 0
	frame7.ZIndex = frame6.ZIndex + 1
	frame7.Parent = frame6
	local uiCorner7 = Instance.new("UICorner")
	uiCorner7.CornerRadius = UDim.new(1, 0)
	uiCorner7.Parent = frame7

	local function createTextButton(name, text, position, backgroundColor3)
		local textButton2 = Instance.new("TextButton")
		textButton2.Name = name
		textButton2.Position = position
		textButton2.Size = UDim2.new(0.5, -30, 0, 42)
		textButton2.BackgroundColor3 = backgroundColor3
		textButton2.BorderSizePixel = 0
		textButton2.AutoButtonColor = true
		textButton2.Text = text
		textButton2.TextColor3 = Color3.fromRGB(248, 248, 251)
		textButton2.TextSize = 13
		textButton2.Font = Enum.Font.GothamBold
		textButton2.ZIndex = frame.ZIndex + 3
		textButton2.Parent = frame
		local uiCorner8 = Instance.new("UICorner")
		uiCorner8.CornerRadius = UDim.new(0, 12)
		uiCorner8.Parent = textButton2
		return textButton2
	end

	local color2 = Color3.fromRGB
	local ExitBlackScreen = createTextButton("ExitBlackScreen", "退出黑屏", UDim2.new(0, 24, 0, 452), color2(119, 27, 48))
	local color3 = Color3.fromRGB
	local HideBlackScreen = createTextButton("HideBlackScreen", "隐藏黑屏", UDim2.new(0.5, 6, 0, 452), color3(28, 28, 35))
	local textButton2 = Instance.new("TextButton")
	textButton2.Name = "ShowBlackScreen"
	textButton2.AnchorPoint = Vector2.new(0.5, 0)
	textButton2.Position = UDim2.new(0.5, 0, 0, 54)
	textButton2.Size = UDim2.fromOffset(190, 44)
	textButton2.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	textButton2.BorderSizePixel = 0
	textButton2.AutoButtonColor = true
	textButton2.Text = "显示黑屏遮罩"
	textButton2.TextColor3 = Color3.fromRGB(255, 235, 241)
	textButton2.TextSize = 13
	textButton2.Font = Enum.Font.GothamBold
	textButton2.Visible = false
	textButton2.ZIndex = textButton.ZIndex + 10
	textButton2.Parent = screenGui
	local uiCorner8 = Instance.new("UICorner")
	uiCorner8.CornerRadius = UDim.new(0, 12)
	uiCorner8.Parent = textButton2
	local uiStroke3 = Instance.new("UIStroke")
	uiStroke3.Color = Color3.fromRGB(255, 55, 98)
	uiStroke3.Transparency = 0.2
	uiStroke3.Thickness = 1
	uiStroke3.Parent = textButton2

	ExitBlackScreen.Activated:Connect(function()
		local blackScreenControl = Hub.CoinFarm.blackScreenControl

		if blackScreenControl and type(blackScreenControl.Set) == "function" then
			pcall(function()
				blackScreenControl:Set(false)
			end)
		end

		Hub.CoinFarm.SetBlackScreen(false, true)
	end)

	HideBlackScreen.Activated:Connect(function()
		textButton.Visible = false
		textButton2.Visible = true
	end)

	textButton2.Activated:Connect(function()
		textButton2.Visible = false
		textButton.Visible = true
		Hub.CoinFarm.RefreshBlackScreen()
	end)

	local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")

	if type(gethui) == "function" then
		local ok, result = pcall(gethui)

		if ok and result then
			playerGui = result
		end
	end

	if not playerGui then
		if not blackScreen_param_0310 then
			WindUI:Notify({ Title = "黑屏遮罩", Content = "UI 父级不可用", Icon = "x", Duration = 2 })
		end

		screenGui:Destroy()
		Hub.CoinFarm.blackScreenEnabled = false
		return false
	end

	screenGui.Parent = playerGui
	Hub.CoinFarm.blackScreenGui = screenGui
	Hub.CoinFarm.blackScreenStartedAt = os.clock()

	Hub.CoinFarm.blackScreenLabels = {
		status = textLabel,
		role = Role,
		bag = Bag,
		level = Level,
		prestige = Prestige,
		earnedXP = EarnedXP,
		collectedCoins = CollectedCoins,
		totalCoins = TotalCoins,
		session = Session,
		progress = frame7,
	}

	Hub.CoinFarm.RefreshBlackScreen()

	task.spawn(function()
		while foxnameMM2Runtime.alive and not isTerminated and Hub.CoinFarm.blackScreenEnabled and Hub.CoinFarm.blackScreenUpdateGeneration == blackScreenUpdateGeneration and screenGui.Parent do
			task.wait(1)
			Hub.CoinFarm.RefreshBlackScreen()
		end
	end)

	return true
end

Hub.CoinFarm.Set3DRenderingDisabled = function(render_param_0319, render_param_0320)
	local disable3DRendering = render_param_0319 and true or false

	if not pcall(function()
		RunService:Set3dRenderingEnabled(not disable3DRendering)
	end) then
		Hub.CoinFarm.disable3DRendering = false

		if not render_param_0320 then
			WindUI:Notify({
				Title = "关闭 3D 渲染",
				Content = "当前执行器不支持修改 3D 渲染。",
				Icon = "triangle-alert",
				Duration = 3,
			})
		end

		return false
	end

	Hub.CoinFarm.disable3DRendering = disable3DRendering
	return true
end

Hub.CoinFarm.SetEnabled = function(render_param_0321)
	local enabled = Hub.CoinFarm.enabled
	local indexedMap = Hub.CoinFarm.indexedMap or Hub.RoundState.currentMapInstance

	if enabled and not render_param_0321 then
		Hub.CoinFarm.SyncEarnedXP()
	end

	Hub.CoinFarm.enabled = render_param_0321 and true or false

	if Hub.CoinFarm.enabled and not enabled then
		Hub.CoinFarm.sessionStartedAt = os.clock() - math.max(0, tonumber(Hub.CoinFarm.resumedSessionElapsed) or 0)
		Hub.CoinFarm.serverHopTimerStartedAt = os.clock()
		Hub.CoinFarm.resumedSessionElapsed = 0
		Hub.CoinFarm.resetRequestedForBag = false
		Hub.CoinFarm.bagCurrentValue = nil
		Hub.CoinFarm.lastBagCount = nil
		Hub.CoinFarm.lastObservedXP = Hub.CoinFarm.GetCurrentXP()
		local render_getBagCountValue_0322 = Hub.CoinFarm.GetBagCount()

		if type(render_getBagCountValue_0322) == "number" then
			Hub.CoinFarm.lastBagCount = math.max(0, math.floor(render_getBagCountValue_0322))
		end

		Hub.CoinFarm.bagWebhookSent = false
		local coinFarm = Hub.CoinFarm
		coinFarm.webhookGeneration = coinFarm.webhookGeneration + 1
		local webhookGeneration = Hub.CoinFarm.webhookGeneration

		if type(Hub.CoinFarm.SendWebhook) == "function" then
			Hub.CoinFarm.SendWebhook("Started")
		end

		task.spawn(function()
			while foxnameMM2Runtime.alive and not isTerminated and Hub.CoinFarm.enabled and Hub.CoinFarm.webhookGeneration == webhookGeneration do
				task.wait(900)

				if foxnameMM2Runtime.alive and not isTerminated and Hub.CoinFarm.enabled and Hub.CoinFarm.webhookGeneration == webhookGeneration then
					if type(Hub.CoinFarm.SendWebhook) == "function" then
						Hub.CoinFarm.SendWebhook("15 分钟更新")
					end
				end
			end
		end)
	elseif not Hub.CoinFarm.enabled then
		if enabled then
			if type(Hub.CoinFarm.SendWebhook) == "function" then
				Hub.CoinFarm.SendWebhook("Stopped")
			end
		end

		local coinFarm = Hub.CoinFarm
		coinFarm.webhookGeneration = coinFarm.webhookGeneration + 1
		Hub.CoinFarm.sessionStartedAt = 0
		Hub.CoinFarm.serverHopTimerStartedAt = 0
		Hub.CoinFarm.lastObservedXP = nil
	end

	Hub.CoinFarm.RefreshBlackScreen()

	if Hub.SetCoinFarmAutoGunTouch then
		Hub.SetCoinFarmAutoGunTouch(Hub.CoinFarm.enabled)
	end

	if Hub.SetXPFarmTimerForced then
		Hub.SetXPFarmTimerForced(Hub.CoinFarm.enabled)
	end

	if type(Hub.SetCoinFarmAntiFling) == "function" then
		Hub.SetCoinFarmAntiFling(Hub.CoinFarm.enabled)
	end

	local coinFarm = Hub.CoinFarm
	coinFarm.generation = coinFarm.generation + 1
	Hub.CoinFarm.CancelXPFarmWait()
	Hub.CoinFarm.CancelEndRoundRespawnRetry()
	Hub.CoinFarm.CancelTween()
	Hub.CoinFarm.currentCoin = nil
	Hub.CoinFarm.escapeCoin = nil
	Hub.CoinFarm.escapeUnderActive = false

	if not Hub.CoinFarm.enabled then
		local blackScreenGui = Hub.CoinFarm.blackScreenGui
		local coinFarm2 = Hub.CoinFarm
		coinFarm2.blackScreenUpdateGeneration = coinFarm2.blackScreenUpdateGeneration + 1

		if blackScreenGui and blackScreenGui.Parent then
			pcall(function()
				blackScreenGui:Destroy()
			end)
		end

		Hub.CoinFarm.blackScreenGui = nil
		table.clear(Hub.CoinFarm.blackScreenLabels)
		Hub.CoinFarm.RestoreCoinVisuals()
		Hub.CoinFarm.serverHopRunning = false
		local coinFarm3 = Hub.CoinFarm
		coinFarm3.endRoundGeneration = coinFarm3.endRoundGeneration + 1
		Hub.CoinFarm.endRoundRunning = false
		Hub.CoinFarm.sheriffFlingRunning = false
		Hub.CoinFarm.sheriffFlingBlocking = false
		Hub.CoinFarm.sheriffFlingCompleted = false

		if enabled then
			if Hub.RoundState.active and Hub.CoinFarm.IsLocalPlayerInRound() then
				if not Hub.CoinFarm.LeaveUnderSafely(indexedMap, true) then
					Hub.CoinFarm.TeleportToMapSpawn(indexedMap)
				end
			else
				Hub.CoinFarm.LeaveUnderSafely(indexedMap, false)
			end
		else
			Hub.CoinFarm.DisableUnder()
		end

		Hub.CoinFarm.DisconnectMap()
		Hub.CoinFarm.SetPhase("Disabled")
		return
	end

	if Hub.RoundState.active and Hub.RoundState.coinsReady then
		Hub.CoinFarm.IndexMap()
	else
		Hub.CoinFarm.SetPhase("Waiting for round")
	end

	Hub.CoinFarm.SetBlackScreen(Hub.CoinFarm.blackScreenEnabled, true)

	if Hub.RoundState.active and Hub.CoinFarm.endRoundEnabled then
		Hub.CoinFarm.StartRoundSheriffFling()
	end

	task.spawn(Hub.CoinFarm.Worker)
end

Hub.CoinFarm.Destroy = function()
	Hub.CoinFarm.enabled = false
	Hub.CoinFarm.sessionStartedAt = 0
	Hub.CoinFarm.serverHopTimerStartedAt = 0
	Hub.CoinFarm.serverHopRunning = false
	Hub.CoinFarm.CancelXPFarmWait()
	Hub.CoinFarm.CancelEndRoundRespawnRetry()

	if Hub.SetCoinFarmAutoGunTouch then
		Hub.SetCoinFarmAutoGunTouch(false)
	end

	if Hub.SetXPFarmTimerForced then
		Hub.SetXPFarmTimerForced(false)
	end

	if type(Hub.SetCoinFarmAntiFling) == "function" then
		Hub.SetCoinFarmAntiFling(false)
	end

	local coinFarm = Hub.CoinFarm
	coinFarm.generation = coinFarm.generation + 1
	local coinFarm2 = Hub.CoinFarm
	coinFarm2.endRoundGeneration = coinFarm2.endRoundGeneration + 1
	Hub.CoinFarm.endRoundRunning = false
	Hub.CoinFarm.sheriffFlingRunning = false
	Hub.CoinFarm.sheriffFlingBlocking = false
	Hub.CoinFarm.sheriffFlingCompleted = false
	Hub.CoinFarm.CancelTween()
	Hub.CoinFarm.DisableUnder()
	Hub.CoinFarm.RestoreCoinVisuals()
	Hub.CoinFarm.SetBlackScreen(false, true)
	Hub.CoinFarm.Set3DRenderingDisabled(false, true)
	Hub.CoinFarm.DisconnectMap()
	Hub.CoinFarm.SetPhase("Disabled")
end

Hub.CoinFarm.ApplyResume = function()
	local genv2 = type(getgenv) == "function" and getgenv() or _G
	local foxnameCoinFarmResume = genv2.__FoxnameCoinFarmResume
	genv2.__FoxnameCoinFarmResume = nil
	local render_localValue_0323

	if type(foxnameCoinFarmResume) ~= "table" and type(isfile) == "function" and type(readfile) == "function" then
		local ok, result = pcall(isfile, "Foxname_MM2/coin_farm_resume.json")

		if ok and result then
			local ok2, result2 = pcall(readfile, "Foxname_MM2/coin_farm_resume.json")
			local ok3, result3 = pcall(HttpService.JSONDecode, HttpService, ok2 and result2 or "")

			if ok3 and type(result3) == "table" then
				local render_numericVar_0324 = tonumber(result3.savedAt) or 0

				if render_numericVar_0324 <= 0 or math.abs(os.time() - render_numericVar_0324) <= 1800 then
					render_localValue_0323 = result3
				else
					render_localValue_0323 = foxnameCoinFarmResume
				end
			else
				render_localValue_0323 = foxnameCoinFarmResume
			end
		else
			render_localValue_0323 = foxnameCoinFarmResume
		end
	else
		render_localValue_0323 = foxnameCoinFarmResume
	end

	if type(render_localValue_0323) ~= "table" then
		return false
	end
	Hub.CoinFarm.resumedFromServerHop = true
	Hub.CoinFarm.totalCollected = math.max(0, math.floor(tonumber(render_localValue_0323.total) or 0))
	Hub.CoinFarm.totalEarnedXP = math.max(0, math.floor(tonumber(render_localValue_0323.totalXP) or 0))
	Hub.CoinFarm.resumedSessionElapsed = math.max(0, tonumber(render_localValue_0323.sessionElapsed) or 0)
	Hub.CoinFarm.serverHopCount = math.max(0, math.floor(tonumber(render_localValue_0323.serverHopCount) or 0))
	Hub.CoinFarm.mode = render_localValue_0323.mode == "Tween" and "Tween" or "CFrame"
	Hub.CoinFarm.position = render_localValue_0323.position == "Under" and "Under" or "Normal"
	Hub.CoinFarm.endRoundEnabled = render_localValue_0323.endRound == true
	Hub.CoinFarm.xpFarmEnabled = render_localValue_0323.xpFarm == true and Hub.CoinFarm.endRoundEnabled
	Hub.CoinFarm.serverHopLowPlayers = render_localValue_0323.serverHopLowPlayers == true
	Hub.CoinFarm.serverHopPlayerThreshold = math.clamp(math.floor(tonumber(render_localValue_0323.serverHopThreshold) or 4), 1, 6)
	Hub.CoinFarm.serverHopTimerMinutes = math.clamp(math.floor(tonumber(render_localValue_0323.serverHopTimerMinutes) or 15), 10, 30)
	Hub.CoinFarm.antiBotEnabled = render_localValue_0323.antiBot == true
	Hub.CoinFarm.blackScreenEnabled = render_localValue_0323.blackScreen == true
	Hub.CoinFarm.disable3DRendering = render_localValue_0323.disable3D == true
	Hub.AutoPrestige.SetEnabled(render_localValue_0323.autoPrestige == true)
	Hub.AutoClaimReward.SetEnabled(render_localValue_0323.autoClaimRewards ~= false)
	Hub.CoinFarm.RefreshStats()

	local function render_helperFunc_0325(render_param_0326, render_param_0327)
		if render_param_0326 and type(render_param_0326.Set) == "function" then
			pcall(function()
				render_param_0326:Set(render_param_0327)
			end)
		end
	end

	local function render_helperFunc_0328(render_param_0329, render_param_0330)
		if render_param_0329 and type(render_param_0329.Select) == "function" then
			pcall(function()
				render_param_0329:Select(YXOpt.zh(render_param_0330))
			end)
		else
			render_helperFunc_0325(render_param_0329, render_param_0330)
		end
	end

	render_helperFunc_0325(Hub.AutoPrestige.control, Hub.AutoPrestige.enabled)
	render_helperFunc_0325(Hub.AutoClaimReward.control, Hub.AutoClaimReward.enabled)
	render_helperFunc_0328(Hub.CoinFarm.modeControl, Hub.CoinFarm.mode)
	render_helperFunc_0328(Hub.CoinFarm.positionControl, Hub.CoinFarm.position)
	render_helperFunc_0325(Hub.CoinFarm.endRoundControl, Hub.CoinFarm.endRoundEnabled)

	if type(Hub.CoinFarm.UpdateXPFarmLock) == "function" then
		Hub.CoinFarm.UpdateXPFarmLock()
	end

	render_helperFunc_0325(Hub.CoinFarm.xpFarmControl, Hub.CoinFarm.xpFarmEnabled)
	render_helperFunc_0325(Hub.CoinFarm.serverHopControl, Hub.CoinFarm.serverHopLowPlayers)
	render_helperFunc_0325(Hub.CoinFarm.serverHopThresholdControl, Hub.CoinFarm.serverHopPlayerThreshold)
	render_helperFunc_0325(Hub.CoinFarm.serverHopTimerControl, Hub.CoinFarm.serverHopTimerMinutes)
	render_helperFunc_0325(Hub.CoinFarm.antiBotControl, Hub.CoinFarm.antiBotEnabled)
	render_helperFunc_0325(Hub.CoinFarm.blackScreenControl, Hub.CoinFarm.blackScreenEnabled)
	render_helperFunc_0325(Hub.CoinFarm.renderingControl, Hub.CoinFarm.disable3DRendering)
	render_helperFunc_0325(Hub.CoinFarm.toggleControl, render_localValue_0323.enabled == true)
	Hub.CoinFarm.SetBlackScreen(Hub.CoinFarm.blackScreenEnabled, true)
	Hub.CoinFarm.Set3DRenderingDisabled(Hub.CoinFarm.disable3DRendering, true)
	local eventBox = Hub.EventBox

	if type(eventBox) == "table" then
		if type(render_localValue_0323.eventBox) == "string" and eventBox.boxes[render_localValue_0323.eventBox] then
			eventBox.selectedBox = render_localValue_0323.eventBox
			render_helperFunc_0328(eventBox.boxDropdown, render_localValue_0323.eventBox)
		end

		if type(render_localValue_0323.eventCurrency) == "string" then
			eventBox.selectedCurrency = render_localValue_0323.eventCurrency
			render_helperFunc_0328(eventBox.currencyDropdown, render_localValue_0323.eventCurrency)
		end

		render_helperFunc_0325(eventBox.autoBuyControl, render_localValue_0323.autoBuyBoxes == true)
	end

	if render_localValue_0323.enabled == true and not Hub.CoinFarm.enabled then
		Hub.CoinFarm.SetEnabled(true)
	end

	if type(isfile) == "function" and type(delfile) == "function" then
		local ok, result = pcall(isfile, "Foxname_MM2/coin_farm_resume.json")

		if ok and result then
			pcall(delfile, "Foxname_MM2/coin_farm_resume.json")
		end
	end

	return true
end

Hub.TouchButtons.ApplySize = function(render_param_0331, render_param_0332, render_param_0333)
	if not render_param_0331 then
		return
	end
	local medium = Hub.TouchButtons.Sizes[render_param_0332] or Hub.TouchButtons.Sizes.Medium
	local render_textValue_0334 = render_param_0333 == "Rectangle" and "Rectangle" or "Square"
	local textWrapped = render_textValue_0334 == "Square"

	if textWrapped then
		local render_numericVar_0335 = math.floor(medium.size.Y.Offset * 1.25 + 0.5)
		render_param_0331.Size = UDim2.fromOffset(render_numericVar_0335, render_numericVar_0335)
	else
		render_param_0331.Size = medium.size
	end

	render_param_0331.Text = ""
	local uiCorner = render_param_0331:FindFirstChildOfClass("UICorner")

	if uiCorner then
		if render_textValue_0334 == "Circle" then
			uiCorner.CornerRadius = UDim.new(1, 0)
		elseif render_textValue_0334 == "Square" then
			uiCorner.CornerRadius = UDim.new(0, 8)
		else
			uiCorner.CornerRadius = UDim.new(0, 12)
		end
	end

	local buttonTitle = render_param_0331:FindFirstChild("ButtonTitle")
	local titleDivider = render_param_0331:FindFirstChild("TitleDivider")
	local buttonIcon = render_param_0331:FindFirstChild("ButtonIcon")
	local statusDot = render_param_0331:FindFirstChild("StatusDot")
	local holdHint = render_param_0331:FindFirstChild("HoldHint")

	if buttonTitle then
		buttonTitle.Visible = not textWrapped
		buttonTitle.Position = UDim2.fromScale(0.34, 0.08)
		buttonTitle.Size = UDim2.fromScale(0.62, 0.42)
		buttonTitle.TextSize = render_param_0332 == "Small" and 11 or render_param_0332 == "Large" and 16 or 14
	end

	if titleDivider then
		titleDivider.Visible = not textWrapped
		titleDivider.Position = UDim2.fromScale(0.36, 0.52)
		titleDivider.Size = UDim2.new(0.56, 0, 0, 1)
	end

	if buttonIcon then
		buttonIcon.Position = textWrapped and UDim2.fromScale(0.1, 0.1) or UDim2.fromScale(0.06, 0.18)
		buttonIcon.Size = textWrapped and UDim2.fromScale(0.8, 0.8) or UDim2.fromScale(0.24, 0.5)
	end

	if statusDot then
		statusDot.Visible = false
		statusDot.Size = UDim2.fromOffset(render_param_0332 == "Small" and 6 or 8, render_param_0332 == "Small" and 6 or 8)
	end

	if holdHint then
		holdHint.Position = textWrapped and UDim2.fromScale(0.13, 0.68) or UDim2.fromScale(0.34, 0.56)
		holdHint.Size = textWrapped and UDim2.fromScale(0.74, 0.23) or UDim2.fromScale(0.62, 0.34)
		holdHint.TextWrapped = textWrapped
		textWrapped = textWrapped and (render_param_0332 == "Small" and 7 or render_param_0332 == "Large" and 9 or 8)
		local textSize

		if textWrapped then
			textSize = textWrapped
		else
			local render_numericVar_0336 = render_param_0332 == "Small" and 9
			local render_numericVar_0337

			if render_numericVar_0336 then
				render_numericVar_0337 = render_numericVar_0336
			else
				render_numericVar_0337 = render_param_0332 == "Large" and 12
			end

			textSize = render_numericVar_0337 or 11
		end

		holdHint.TextSize = textSize
	end
end

Hub.TouchButtons.ApplyAppearance = function(render_param_0338, render_param_0339)
	if not render_param_0338 or not render_param_0339 then
		return
	end
	local theme = Hub.TouchButtons.Theme
	local backgroundColor = theme.backgroundColor
	local outlineColor = render_param_0339.outlineColor or theme.accentColor
	local color = Color3.new(1, 1, 1)
	render_param_0338.BackgroundColor3 = backgroundColor
	render_param_0338.BackgroundTransparency = 0.28
	render_param_0338.TextColor3 = color
	local uiStroke = render_param_0338:FindFirstChildOfClass("UIStroke")

	if uiStroke then
		uiStroke.Color = outlineColor
		uiStroke.Transparency = 0
		uiStroke.Thickness = 3
	end

	local buttonTitle = render_param_0338:FindFirstChild("ButtonTitle")
	local titleDivider = render_param_0338:FindFirstChild("TitleDivider")
	local buttonIcon = render_param_0338:FindFirstChild("ButtonIcon")
	local holdHint = render_param_0338:FindFirstChild("HoldHint")

	if buttonTitle then
		buttonTitle.TextColor3 = color
	end

	if titleDivider then
		titleDivider.BackgroundColor3 = outlineColor
		titleDivider.BackgroundTransparency = 0.15
	end

	if buttonIcon then
		if buttonIcon:IsA("ImageLabel") then
			buttonIcon.ImageColor3 = outlineColor
		else
			buttonIcon.TextColor3 = outlineColor
			buttonIcon.TextStrokeColor3 = backgroundColor
		end
	end

	if holdHint then
		holdHint.TextColor3 = color
		holdHint.TextStrokeColor3 = Color3.new(0, 0, 0)
		holdHint.TextStrokeTransparency = 0.35
	end
end

Hub.TouchButtons.ForEachStyledButton = function(render_param_0340)
	for _, render_loopVar_0341 in ipairs({
		Hub.XRayButtonState,
		Hub.AimlockButtonState,
		Hub.GetGunButtonState,
		Hub.BombJumpButtonState,
		Hub.ThrowKnifeButtonState,
		Hub.WallPhaseButtonState,
		Hub.FlyButtonState,
		Hub.NoclipButtonState,
	}) do
		render_param_0340(render_loopVar_0341, render_loopVar_0341.button)
	end

	render_param_0340(Hub.AutoShootDragState, Hub.AutoShootDragState.button or Hub.AutoShootTouchButton)
end

Hub.TouchButtons.SetThemeColor = function(render_param_0342, render_param_0343)
	Hub.TouchButtons.Theme[render_param_0342 == "outlineColor" and "accentColor" or render_param_0342] = render_param_0343

	Hub.TouchButtons.ForEachStyledButton(function(render_param_0344, render_param_0345)
		render_param_0344[render_param_0342] = render_param_0343

		if render_param_0345 and render_param_0345.Parent then
			Hub.TouchButtons.ApplyAppearance(render_param_0345, render_param_0344)
		end
	end)
end

Hub.TouchButtons.RefreshAllHoldHints = function()
	Hub.TouchButtons.ForEachStyledButton(function(render_param_0346, render_param_0347)
		Hub.TouchButtons.UpdateHoldHint(render_param_0346, render_param_0347)
	end)
end

Hub.ESPColors = {
	Murderer = Color3.new(1, 0, 0.0156863),
	Sheriff = Color3.new(0, 0.6, 1),
	Innocent = Color3.new(0, 1, 0.0313725),
	Gun = Color3.new(0.952941, 1, 0.0745098),
}

Hub.OwnerESPColors = {
	Black = Color3.fromRGB(18, 18, 22),
	Gray = Color3.fromRGB(125, 125, 135),
	White = Color3.fromRGB(245, 245, 250),
}

do
	local colorSequence = ColorSequence.new
	local render_configTable_0348 = {}
	local render_blackValue_0349 = ColorSequenceKeypoint.new(0, Hub.OwnerESPColors.Black)
	local render_grayValue_0350 = ColorSequenceKeypoint.new(0.25, Hub.OwnerESPColors.Gray)
	local render_whiteValue_0351 = ColorSequenceKeypoint.new(0.5, Hub.OwnerESPColors.White)
	local render_grayValue_0352 = ColorSequenceKeypoint.new(0.75, Hub.OwnerESPColors.Gray)
	local new = ColorSequenceKeypoint.new
	local black = Hub.OwnerESPColors.Black
	render_configTable_0348[1] = render_blackValue_0349
	render_configTable_0348[2] = render_grayValue_0350
	render_configTable_0348[3] = render_whiteValue_0351
	render_configTable_0348[4] = render_grayValue_0352

	do
		local values = table.pack(new(1, black))
		table.move(values, 1, values.n, 5, render_configTable_0348)
	end

	Hub.OwnerESPGradient = colorSequence(render_configTable_0348)
end

Hub.GetOwnerESPGradientColor = function(render_param_0353)
	local render_timestamp_0354 = (math.sin((render_param_0353 or os.clock()) * 1.15) + 1) * 0.5
	if render_timestamp_0354 < 0.5 then
		return Hub.OwnerESPColors.Black:Lerp(Hub.OwnerESPColors.Gray, render_timestamp_0354 * 2)
	end
	return Hub.OwnerESPColors.Gray:Lerp(Hub.OwnerESPColors.White, (render_timestamp_0354 - 0.5) * 2)
end

Hub.WorldFeatureConfig = { safezoneModelName = "Foxname_MM2_Safezone", xrayTransparency = 0.72 }

do
	local function crosshair_helperFunc_0355()
		if type(request) == "function" then
			return request
		end

		if type(http_request) == "function" then
			return http_request
		end

		if type(syn) == "table" and type(syn.request) == "function" then
			return syn.request
		end

		if type(fluxus) == "table" and type(fluxus.request) == "function" then
			return fluxus.request
		end
		return nil
	end

	local function crosshair_helperFunc_0356()
		local crosshair_callResult_0357 = tostring(genv.FOXNAME_COIN_FARM_WEBHOOK or "")

		if crosshair_callResult_0357 == "" and type(isfile) == "function" and type(readfile) == "function" then
			local ok, result = pcall(isfile, "Foxname_MM2/coin_farm_webhook.txt")

			if ok and result then
				local ok2, result2 = pcall(readfile, "Foxname_MM2/coin_farm_webhook.txt")

				if ok2 then
					crosshair_callResult_0357 = tostring(result2 or "")
				end
			end
		end

		local match = crosshair_callResult_0357:match("^%s*(.-)%s*$") or ""
		Hub.CoinFarm.webhookUrl = match
		Hub.CoinFarm.webhookDraft = match
	end

	Hub.CoinFarm.SaveWebhook = function(crosshair_param_0358)
		local match = tostring(crosshair_param_0358 or ""):match("^%s*(.-)%s*$") or ""
		local match2 = match:match("^https://discord%.com/api/webhooks/") or match:match("^https://discordapp%.com/api/webhooks/") or match:match("^https://ptb%.discord%.com/api/webhooks/") or match:match("^https://canary%.discord%.com/api/webhooks/")
		if match ~= "" and not match2 then
			return false, "请输入有效的 Discord Webhook 地址。"
		end

		if type(isfolder) ~= "function" or type(makefolder) ~= "function" or type(writefile) ~= "function" then
			return false, "当前执行器不支持文件存储。"
		end

		if not pcall(function()
			if not isfolder("Foxname_MM2") then
				makefolder("Foxname_MM2")
			end

			writefile("Foxname_MM2/coin_farm_webhook.txt", match)
		end) then
			return false, "Webhook 保存失败。"
		end

		Hub.CoinFarm.webhookUrl = match
		Hub.CoinFarm.webhookDraft = match
		genv.FOXNAME_COIN_FARM_WEBHOOK = match
		return true, match == "" and "Webhook 已清除。" or "Webhook 已保存。"
	end

	local function crosshair_helperFunc_0359(crosshair_param_0360)
		local crosshair_numericVar_0361 = math.max(0, math.floor(tonumber(crosshair_param_0360) or 0))
		return string.format("%02d:%02d:%02d", math.floor(crosshair_numericVar_0361 / 3600), math.floor(crosshair_numericVar_0361 / 60) % 60, crosshair_numericVar_0361 % 60)
	end

	Hub.CoinFarm.SendWebhook = function(crosshair_param_0362, crosshair_param_0363)
		local crosshair_webhookUrlValue_0364 = tostring(Hub.CoinFarm.webhookUrl or "")
		local crosshair_callResult_0365 = crosshair_helperFunc_0355()
		if crosshair_webhookUrlValue_0364 == "" or type(crosshair_callResult_0365) ~= "function" then
			return false
		end
		local crosshair_sessionStartedAtValue_0366 = Hub.CoinFarm.sessionStartedAt > 0

		if crosshair_sessionStartedAtValue_0366 then
			local sessionStartedAt = Hub.CoinFarm.sessionStartedAt
			crosshair_sessionStartedAtValue_0366 = math.max(0, os.clock() - sessionStartedAt)
		end

		local crosshair_numericVar_0367 = crosshair_sessionStartedAtValue_0366 or 0
		local crosshair_numericVar_0368 = crosshair_numericVar_0367 / 60
		local crosshair_totalCollectedValue_0369 = math.max(0, math.floor(tonumber(Hub.CoinFarm.totalCollected) or 0))
		local crosshair_totalEarnedXPValue_0370 = math.max(0, math.floor(tonumber(Hub.CoinFarm.totalEarnedXP) or 0))
		local crosshair_numericVar_0371 = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png", tonumber(localPlayer.UserId) or 0)

		local crosshair_configTable_0372 = {
			Started = 5763719,
			Stopped = 15158332,
			["15 分钟更新"] = 3447003,
			["Bag Full"] = 16753920,
			["Server Hop"] = 10181046,
		}

		local crosshair_configTable_0373 = {}
		local crosshair_fieldTable_0374 = { name = "Username", value = "`" .. tostring(localPlayer.Name) .. "`", inline = true }
		local crosshair_fieldTable_0375 = { name = "Display Name", value = "`" .. tostring(localPlayer.DisplayName) .. "`", inline = true }
		local crosshair_fieldTable_0376 = { name = "UserId", value = "`" .. tostring(localPlayer.UserId) .. "`", inline = true }
		local crosshair_fieldTable_0377 = { name = "Report Type", value = "`" .. tostring(crosshair_param_0362) .. "`", inline = true }
		local crosshair_fieldTable_0378 = { name = "Farm Duration", value = "`" .. crosshair_helperFunc_0359(crosshair_numericVar_0367) .. "`", inline = true }

		local crosshair_configTable_0379 = {
			name = "Server Hops",
			value = "`" .. tostring(Hub.CoinFarm.serverHopCount or 0) .. "`",
			inline = true,
		}

		local crosshair_fieldTable_0380 = { name = "Collected Coins", value = "`" .. tostring(crosshair_totalCollectedValue_0369) .. "`", inline = true }
		local crosshair_fieldTable_0381 = { name = "Earned XP", value = "`" .. tostring(crosshair_totalEarnedXPValue_0370) .. "`", inline = true }

		local crosshair_configTable_0382 = {
			name = "Coins / Minute",
			value = "`" .. string.format("%.2f", crosshair_numericVar_0368 > 0 and crosshair_totalCollectedValue_0369 / crosshair_numericVar_0368 or 0) .. "`",
			inline = true,
		}

		local crosshair_configTable_0383 = {
			name = "XP / Minute",
			value = "`" .. string.format("%.2f", crosshair_numericVar_0368 > 0 and crosshair_totalEarnedXPValue_0370 / crosshair_numericVar_0368 or 0) .. "`",
			inline = true,
		}

		local crosshair_modeValue_0384 = { name = "Mode", value = "`" .. tostring(Hub.CoinFarm.mode) .. "`", inline = true }
		local crosshair_positionValue_0385 = { name = "Position", value = "`" .. tostring(Hub.CoinFarm.position) .. "`", inline = true }
		crosshair_configTable_0373[1] = crosshair_fieldTable_0374
		crosshair_configTable_0373[2] = crosshair_fieldTable_0375
		crosshair_configTable_0373[3] = crosshair_fieldTable_0376
		crosshair_configTable_0373[4] = crosshair_fieldTable_0377
		crosshair_configTable_0373[5] = crosshair_fieldTable_0378
		crosshair_configTable_0373[6] = crosshair_configTable_0379
		crosshair_configTable_0373[7] = crosshair_fieldTable_0380
		crosshair_configTable_0373[8] = crosshair_fieldTable_0381
		crosshair_configTable_0373[9] = crosshair_configTable_0382
		crosshair_configTable_0373[10] = crosshair_configTable_0383
		crosshair_configTable_0373[11] = crosshair_modeValue_0384
		crosshair_configTable_0373[12] = crosshair_positionValue_0385
		crosshair_configTable_0373[13] = { name = "Speed", value = "`30`", inline = true }

		if crosshair_param_0362 == "Server Hop" then
			table.insert(crosshair_configTable_0373, { name = "Server Hop Reason", value = "`" .. tostring(crosshair_param_0363 or "Unknown") .. "`", inline = true })
		end

		table.insert(crosshair_configTable_0373, {
			name = "Date / Time",
			value = "`" .. tostring(os.date("%Y-%m-%d %H:%M:%S %Z")) .. "`",
			inline = false,
		})

		local crosshair_configTable_0386 = {}

		crosshair_configTable_0386.embeds = {
			{
				title = "Coin Farm - " .. tostring(crosshair_param_0362),
				color = crosshair_configTable_0372[crosshair_param_0362] or 9807270,
				thumbnail = { url = crosshair_numericVar_0371 },
				fields = crosshair_configTable_0373,
			},
		}

		task.spawn(function()
			pcall(crosshair_callResult_0365, {
				Url = crosshair_webhookUrlValue_0364,
				Method = "POST",
				Headers = { ["Content-Type"] = "application/json" },
				Body = HttpService:JSONEncode(crosshair_configTable_0386),
			})
		end)

		return true
	end

	Hub.CoinFarm.ReportBagFull = function()
		if Hub.CoinFarm.bagWebhookSent then
			return
		end
		Hub.CoinFarm.bagWebhookSent = true
		Hub.CoinFarm.SendWebhook("Bag Full")
	end

	Hub.CoinFarm.ReportServerHop = function(crosshair_param_0387)
		Hub.CoinFarm.serverHopCount = math.max(0, math.floor(tonumber(Hub.CoinFarm.serverHopCount) or 0)) + 1
		Hub.CoinFarm.SendWebhook("Server Hop", crosshair_param_0387)
	end

	crosshair_helperFunc_0356()
end

local getSafeGuiParent, createScreenGui
local crosshair_optionalValue_0388 = nil

getSafeGuiParent = function()
	if gethui then
		local ok, result = pcall(function()
			return gethui()
		end)

		if ok and result then
			return result
		end
	end

	local ok, result = pcall(function()
		return game:GetService("CoreGui")
	end)

	if ok and result then
		return result
	end
	return localPlayer:WaitForChild("PlayerGui")
end

createScreenGui = function()
	if crosshair_optionalValue_0388 and crosshair_optionalValue_0388.Parent then
		return crosshair_optionalValue_0388
	end
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "Foxname_MM2_Overlay"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.DisplayOrder = 999999

	pcall(function()
		if syn and syn.protect_gui then
			syn.protect_gui(screenGui)
		elseif protect_gui then
			protect_gui(screenGui)
		end
	end)

	screenGui.Parent = getSafeGuiParent()
	crosshair_optionalValue_0388 = screenGui
	return screenGui
end

local crosshair_helperFunc_0389, crosshair_helperFunc_0390, crosshair_helperFunc_0391, crosshair_helperFunc_0392, crosshair_helperFunc_0393, crosshair_helperFunc_0394, crosshair_helperFunc_0395, crosshair_helperFunc_0396, crosshair_helperFunc_0397, crosshair_helperFunc_0398
local crosshair_helperFunc_0399, crosshair_helperFunc_0400, crosshair_helperFunc_0401, crosshair_helperFunc_0402, crosshair_helperFunc_0403, crosshair_helperFunc_0404, crosshair_helperFunc_0405, crosshair_helperFunc_0406, crosshair_helperFunc_0407, crosshair_helperFunc_0408
local crosshair_helperFunc_0409, crosshair_helperFunc_0410

do
	local function crosshair_helperFunc_0411()
		local crosshair_callResult_0412 = createScreenGui()
		local imageLabel = Instance.new("ImageLabel")
		imageLabel.Name = "ESP360Arrow"
		imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		imageLabel.Size = UDim2.fromOffset(34, 34)
		imageLabel.BackgroundTransparency = 1
		imageLabel.Image = "rbxassetid://97136202386756"
		imageLabel.Visible = false
		imageLabel.ZIndex = 20
		imageLabel.Parent = crosshair_callResult_0412
		local textLabel = Instance.new("TextLabel")
		textLabel.Name = "ESP360Distance"
		textLabel.AnchorPoint = Vector2.new(0.5, 0)
		textLabel.Size = UDim2.fromOffset(90, 22)
		textLabel.BackgroundTransparency = 1
		textLabel.Font = Enum.Font.GothamBold
		textLabel.TextSize = 17
		textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
		textLabel.TextStrokeTransparency = 0.25
		textLabel.Visible = false
		textLabel.ZIndex = 21
		textLabel.Parent = crosshair_callResult_0412
		return imageLabel, textLabel
	end

	crosshair_helperFunc_0389 = function(crosshair_param_0413, crosshair_param_0414)
		if crosshair_param_0413 then
			crosshair_param_0413.Visible = false
		end

		if crosshair_param_0414 then
			crosshair_param_0414.Visible = false
		end
	end

	crosshair_helperFunc_0390 = function(crosshair_param_0415, crosshair_param_0416, crosshair_param_0417, imageColor3, crosshair_param_0418, crosshair_param_0419)
		if not crosshair_param_0415 or not crosshair_param_0416 or not crosshair_param_0417 then
			crosshair_helperFunc_0389(crosshair_param_0415, crosshair_param_0416)
			return
		end
		local crosshair_localValue_0420, crosshair_localValue_0421 = currentCamera:WorldToViewportPoint(crosshair_param_0417)
		if crosshair_localValue_0421 and crosshair_localValue_0420.Z > 0 and crosshair_localValue_0420.X >= 48 and crosshair_localValue_0420.X <= crosshair_param_0418.X - 48 and crosshair_localValue_0420.Y >= 48 and crosshair_localValue_0420.Y <= crosshair_param_0418.Y - 48 then
			crosshair_helperFunc_0389(crosshair_param_0415, crosshair_param_0416)
			return
		end
		local cFrame = currentCamera.CFrame
		local crosshair_localValue_0422 = cFrame:VectorToObjectSpace(crosshair_param_0417 - cFrame.Position)
		local vector2 = Vector2.new(crosshair_localValue_0422.X, crosshair_localValue_0422.Y)
		local vector22

		if vector2.Magnitude < 0.001 then
			vector22 = Vector2.new(0, -1)
		else
			vector22 = vector2.Unit
		end

		local crosshair_numericVar_0423 = math.max(1, crosshair_param_0418.X * 0.5 - 48)
		local crosshair_numericVar_0424 = math.max(1, crosshair_param_0418.Y * 0.5 - 48)
		local crosshair_numericVar_0425 = vector22 * math.min(math.abs(vector22.X) > 0.001 and crosshair_numericVar_0423 / math.abs(vector22.X) or math.huge, math.abs(vector22.Y) > 0.001 and crosshair_numericVar_0424 / math.abs(vector22.Y) or math.huge)
		local vector23 = Vector2.new(crosshair_param_0418.X * 0.5 + crosshair_numericVar_0425.X, crosshair_param_0418.Y * 0.5 - crosshair_numericVar_0425.Y)
		crosshair_param_0415.Position = UDim2.fromOffset(vector23.X, vector23.Y)
		crosshair_param_0415.Rotation = math.deg(math.atan2(vector22.X, vector22.Y))
		crosshair_param_0415.ImageColor3 = imageColor3
		crosshair_param_0415.Visible = true
		crosshair_param_0419 = crosshair_param_0419 and crosshair_param_0419.Position or cFrame.Position
		crosshair_param_0416.Position = UDim2.fromOffset(vector23.X, vector23.Y + 18)
		crosshair_param_0416.Text = tostring(math.floor((crosshair_param_0417 - crosshair_param_0419).Magnitude + 0.5))
		crosshair_param_0416.TextColor3 = imageColor3
		crosshair_param_0416.Visible = true
	end

	Hub.Crosshair.RestoreCursor = function()
		local crosshair = Hub.Crosshair
		crosshair.suppressCursor = false

		if crosshair.cursorHidden then
			if crosshair.originalMouseIconEnabled ~= nil then
				UserInputService.MouseIconEnabled = crosshair.originalMouseIconEnabled
			end
		end

		crosshair.cursorHidden = false
		crosshair.originalMouseIconEnabled = nil
	end

	Hub.Crosshair.HideCursor = function()
		local crosshair = Hub.Crosshair

		if not crosshair.cursorHidden then
			crosshair.originalMouseIconEnabled = UserInputService.MouseIconEnabled
			crosshair.cursorHidden = true
		end

		crosshair.suppressCursor = true
		UserInputService.MouseIconEnabled = false
	end

	Hub.Crosshair.Destroy = function()
		local crosshair = Hub.Crosshair

		if crosshair.connection then
			crosshair.connection:Disconnect()
			crosshair.connection = nil
		end

		if crosshair.cursorConnection then
			crosshair.cursorConnection:Disconnect()
			crosshair.cursorConnection = nil
		end

		if crosshair.root then
			crosshair.root:Destroy()
			crosshair.root = nil
		end

		table.clear(crosshair.parts)
		crosshair.angle = 0
		crosshair.lastUpdate = 0
		Hub.Crosshair.RestoreCursor()
	end

	Hub.Crosshair.ApplyAppearance = function()
		local crosshair = Hub.Crosshair
		local color = crosshair.rgb and Color3.fromHSV(os.clock() * 0.16 % 1, 0.9, 1) or crosshair.color

		for _, part in ipairs(crosshair.parts) do
			if part and part.Parent then
				part.ImageColor3 = color
			end
		end
	end

	Hub.Crosshair.Rebuild = function()
		local crosshair = Hub.Crosshair
		Hub.Crosshair.Destroy()
		if not crosshair.enabled then
			return
		end
		local frame = Instance.new("Frame")
		frame.Name = "CustomCrosshair"
		frame.AnchorPoint = Vector2.new(0.5, 0.5)
		frame.Position = UDim2.fromScale(0.5, 0.5)
		frame.Size = UDim2.fromOffset(crosshair.size, crosshair.size)
		frame.BackgroundTransparency = 1
		frame.BorderSizePixel = 0
		frame.ZIndex = 100
		frame.Parent = createScreenGui()
		crosshair.root = frame
		local crosshair_localValue_0426 = crosshair.icons[crosshair.style]

		if not crosshair_localValue_0426 then
			frame:Destroy()
			crosshair.root = nil
			return
		end

		local image = type(crosshair_localValue_0426) == "table" and crosshair_localValue_0426.image or crosshair_localValue_0426
		local imageLabel = Instance.new("ImageLabel")
		imageLabel.Name = "Lucide_" .. crosshair.style
		imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		imageLabel.Position = UDim2.fromScale(0.5, 0.5)
		imageLabel.Size = UDim2.fromScale(1, 1)
		imageLabel.BackgroundTransparency = 1
		imageLabel.Image = image

		if type(crosshair_localValue_0426) == "table" then
			imageLabel.ImageRectSize = crosshair_localValue_0426.rectSize or Vector2.zero
			imageLabel.ImageRectOffset = crosshair_localValue_0426.rectPosition or Vector2.zero
		end

		imageLabel.ImageColor3 = crosshair.color
		imageLabel.ScaleType = Enum.ScaleType.Fit
		imageLabel.ZIndex = 101
		imageLabel.Parent = frame
		table.insert(crosshair.parts, imageLabel)
		Hub.Crosshair.ApplyAppearance()
		crosshair.lastUpdate = os.clock()

		crosshair.cursorConnection = UserInputService:GetPropertyChangedSignal("MouseIconEnabled"):Connect(function()
			if crosshair.enabled and crosshair.suppressCursor and UserInputService.MouseIconEnabled then
				UserInputService.MouseIconEnabled = false
			end
		end)

		crosshair.connection = RunService.RenderStepped:Connect(function(deltaTime)
			if not crosshair.enabled or not crosshair.root or not crosshair.root.Parent then
				return
			end
			local now = os.clock()
			local crosshair_numericVar_0427 = now - crosshair.lastUpdate
			if crosshair_numericVar_0427 < crosshair.frameInterval then
				return
			end
			crosshair.lastUpdate = now
			local character_ = localPlayer.Character
			character_ = character_ and character_:FindFirstChild("Head")
			local crosshair_cframeValue_0428 = localPlayer.CameraMode == Enum.CameraMode.LockFirstPerson or character_ and (currentCamera.CFrame.Position - character_.Position).Magnitude <= 1.25 or false
			local icon = localPlayer:GetMouse().Icon
			local crosshair_callResult_0429 = type(icon) == "string" and string.find(string.lower(icon), "mouselockedcursor", 1, true) ~= nil
			crosshair_cframeValue_0428 = crosshair_cframeValue_0428 or crosshair_callResult_0429 or crosshair.userGameSettings.RotationType == Enum.RotationType.CameraRelative
			crosshair.root.Visible = crosshair.mode == "Always" or crosshair_cframeValue_0428

			if crosshair_cframeValue_0428 then
				Hub.Crosshair.HideCursor()
			else
				Hub.Crosshair.RestoreCursor()
			end

			crosshair.angle = (crosshair.angle + crosshair.speed * math.max(crosshair_numericVar_0427, deltaTime)) % 360
			crosshair.root.Rotation = crosshair.angle

			if crosshair.rgb then
				Hub.Crosshair.ApplyAppearance()
			end
		end)
	end

	Hub.Crosshair.SetEnabled = function(crosshair_param_0430)
		Hub.Crosshair.enabled = crosshair_param_0430 and true or false
		Hub.Crosshair.Rebuild()
	end

	Hub.Crosshair.SetCustomIcon = function(crosshair_param_0431)
		local crosshair = Hub.Crosshair
		local crosshair_localValue_0432 = string.gsub(string.gsub(string.gsub(string.lower(tostring(crosshair_param_0431 or "")), "^%s+", ""), "%s+$", ""), "%s+", "-")
		if crosshair_localValue_0432 == "" then
			return
		end

		if not string.match(crosshair_localValue_0432, "^[a-z0-9%-]+$") then
			WindUI:Notify({
				Title = "无效的光标名称",
				Content = "请填写 Lucide 图标名，例如 sparkles",
				Icon = "x",
				Duration = 2.5,
			})

			return
		end

		if crosshair.icons[crosshair_localValue_0432] then
			crosshair.style = crosshair_localValue_0432

			if crosshair.enabled then
				crosshair.Rebuild()
			end

			return
		end

		if crosshair.iconLoading then
			WindUI:Notify({
				Title = "光标加载中",
				Content = "请等待当前图标加载完成",
				Icon = "loader",
				Duration = 2,
			})

			return
		end

		crosshair.iconLoading = true

		task.spawn(function()
			local ok, result = pcall(function()
				if not crosshair.iconModule then
					crosshair.iconModule = Hub.TouchButtons and Hub.TouchButtons.iconModule
				end

				if not crosshair.iconModule then
					crosshair.iconModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"))()
				end

				return crosshair.iconModule.Icon2(crosshair_localValue_0432)
			end)

			crosshair.iconLoading = false

			if not ok or type(result) ~= "table" or type(result[1]) ~= "string" then
				WindUI:Notify({
					Title = "未找到光标",
					Content = crosshair_localValue_0432 .. " is not a valid Lucide icon",
					Icon = "search-x",
					Duration = 3,
				})

				return
			end

			local crosshair_dataTable_0433 = result[2] or {}
			crosshair.icons[crosshair_localValue_0432] = { image = result[1], rectSize = crosshair_dataTable_0433.ImageRectSize, rectPosition = crosshair_dataTable_0433.ImageRectPosition }
			crosshair.style = crosshair_localValue_0432

			if crosshair.enabled then
				crosshair.Rebuild()
			end

			WindUI:Notify({ Title = "准星已更新", Content = crosshair_localValue_0432, Icon = "check", Duration = 2 })
		end)
	end

	Hub.Spinbot.RestoreHumanoid = function()
		local spinbot = Hub.Spinbot

		if spinbot.humanoid and spinbot.humanoid.Parent and spinbot.originalAutoRotate ~= nil then
			spinbot.humanoid.AutoRotate = spinbot.originalAutoRotate
		end

		spinbot.humanoid = nil
		spinbot.originalAutoRotate = nil
	end

	Hub.Spinbot.SetEnabled = function(crosshair_param_0434)
		local spinbot = Hub.Spinbot
		spinbot.enabled = crosshair_param_0434 and true or false

		if spinbot.connection then
			spinbot.connection:Disconnect()
			spinbot.connection = nil
		end

		Hub.Spinbot.RestoreHumanoid()
		if not spinbot.enabled then
			return
		end

		spinbot.connection = RunService.Heartbeat:Connect(function(deltaTime)
			if not spinbot.enabled then
				return
			end
			local character_ = localPlayer.Character
			local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
			character_ = character_ and character_:FindFirstChild("HumanoidRootPart")
			if not humanoid or not character_ or humanoid.Health <= 0 then
				return
			end

			if spinbot.humanoid ~= humanoid then
				Hub.Spinbot.RestoreHumanoid()
				spinbot.humanoid = humanoid
				spinbot.originalAutoRotate = humanoid.AutoRotate
				humanoid.AutoRotate = false
			elseif humanoid.AutoRotate then
				humanoid.AutoRotate = false
			end

			character_.CFrame = character_.CFrame * CFrame.Angles(0, math.rad(spinbot.speed * 1440 * deltaTime), 0)
		end)
	end

	Hub.HitboxExpander.RestorePart = function(crosshair_param_0435)
		local hitboxExpander = Hub.HitboxExpander
		local crosshair_localValue_0436 = hitboxExpander.originals[crosshair_param_0435]
		if not crosshair_localValue_0436 then
			return
		end
		local hitbox_localValue_0437 = hitboxExpander.partConnections[crosshair_param_0435]

		if hitbox_localValue_0437 then
			if type(hitbox_localValue_0437) == "table" then
				for _, hitbox_loopVar_0438 in pairs(hitbox_localValue_0437) do
					if hitbox_loopVar_0438 and hitbox_loopVar_0438.Connected then
						hitbox_loopVar_0438:Disconnect()
					end
				end
			elseif hitbox_localValue_0437.Connected then
				hitbox_localValue_0437:Disconnect()
			end

			hitboxExpander.partConnections[crosshair_param_0435] = nil
		end

		hitboxExpander.originals[crosshair_param_0435] = nil
		if not crosshair_param_0435.Parent then
			return
		end

		pcall(function()
			crosshair_param_0435.Size = crosshair_localValue_0436.Size
			crosshair_param_0435.CanCollide = crosshair_localValue_0436.CanCollide
			crosshair_param_0435.CanQuery = crosshair_localValue_0436.CanQuery
			crosshair_param_0435.CanTouch = crosshair_localValue_0436.CanTouch
			crosshair_param_0435.Massless = crosshair_localValue_0436.Massless
			crosshair_param_0435.Transparency = crosshair_localValue_0436.Transparency
			crosshair_param_0435.LocalTransparencyModifier = crosshair_localValue_0436.LocalTransparencyModifier
			crosshair_param_0435.Color = crosshair_localValue_0436.Color
			crosshair_param_0435.Material = crosshair_localValue_0436.Material
		end)
	end

	Hub.HitboxExpander.ApplyCharacter = function(hitbox_param_0439, hitbox_param_0440)
		local hitboxExpander = Hub.HitboxExpander
		if not hitboxExpander.enabled or not hitboxExpander.stabActive or hitbox_param_0439 == localPlayer or services_helperFunc_0106(hitbox_param_0439) and not isOwner or not hitbox_param_0440 then
			return
		end
		local humanoidRootPart = hitbox_param_0440:FindFirstChild("HumanoidRootPart") or hitbox_param_0440:WaitForChild("HumanoidRootPart", 5)
		if not hitboxExpander.enabled or not hitboxExpander.stabActive or not humanoidRootPart or not humanoidRootPart:IsA("BasePart") then
			return
		end

		if not hitboxExpander.originals[humanoidRootPart] then
			hitboxExpander.originals[humanoidRootPart] = {
				Size = humanoidRootPart.Size,
				CanCollide = humanoidRootPart.CanCollide,
				CanQuery = humanoidRootPart.CanQuery,
				CanTouch = humanoidRootPart.CanTouch,
				Massless = humanoidRootPart.Massless,
				Transparency = humanoidRootPart.Transparency,
				LocalTransparencyModifier = humanoidRootPart.LocalTransparencyModifier,
				Color = humanoidRootPart.Color,
				Material = humanoidRootPart.Material,
			}
		end

		local hitbox_numericVar_0441 = math.clamp(tonumber(hitboxExpander.size) or 6, 2, 50)

		if not hitboxExpander.partConnections[humanoidRootPart] then
			hitboxExpander.partConnections[humanoidRootPart] = {
				Size = humanoidRootPart:GetPropertyChangedSignal("Size"):Connect(function()
					if not hitboxExpander.enabled or not hitboxExpander.stabActive or not humanoidRootPart.Parent then
						return
					end
					local hitbox_numericVar_0442 = math.clamp(tonumber(hitboxExpander.size) or 6, 2, 50)
					if (humanoidRootPart.Size - Vector3.new(hitbox_numericVar_0442, hitbox_numericVar_0442, hitbox_numericVar_0442)).Magnitude <= 0.01 then
						return
					end
					local hitbox_localValue_0443 = hitboxExpander.originals[humanoidRootPart]

					if hitbox_localValue_0443 then
						hitbox_localValue_0443.Size = humanoidRootPart.Size
					end

					task.defer(Hub.HitboxExpander.ApplyCharacter, hitbox_param_0439, hitbox_param_0440)
				end),
				CanCollide = humanoidRootPart:GetPropertyChangedSignal("CanCollide"):Connect(function()
					if hitboxExpander.enabled and hitboxExpander.stabActive and humanoidRootPart.Parent and humanoidRootPart.CanCollide then
						humanoidRootPart.CanCollide = false
					end
				end),
				Massless = humanoidRootPart:GetPropertyChangedSignal("Massless"):Connect(function()
					if hitboxExpander.enabled and hitboxExpander.stabActive and humanoidRootPart.Parent and not humanoidRootPart.Massless then
						humanoidRootPart.Massless = true
					end
				end),
			}
		end

		pcall(function()
			humanoidRootPart.Size = Vector3.new(hitbox_numericVar_0441, hitbox_numericVar_0441, hitbox_numericVar_0441)
			humanoidRootPart.CanCollide = false
			humanoidRootPart.Massless = true
			humanoidRootPart.CanQuery = true
			humanoidRootPart.CanTouch = true
			humanoidRootPart.Transparency = hitboxExpander.visible and 0.55 or 0.99
			humanoidRootPart.LocalTransparencyModifier = hitboxExpander.visible and 0 or 1

			if hitboxExpander.visible then
				humanoidRootPart.Color = Color3.fromRGB(255, 70, 70)
				humanoidRootPart.Material = Enum.Material.Neon
			end
		end)
	end

	Hub.HitboxExpander.ApplyAll = function()
		if not Hub.HitboxExpander.enabled then
			return
		end

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer and player.Character then
				task.spawn(Hub.HitboxExpander.ApplyCharacter, player, player.Character)
			end
		end
	end

	Hub.HitboxExpander.RestoreAll = function()
		local hitbox_configTable_0444 = {}

		for k in pairs(Hub.HitboxExpander.originals) do
			hitbox_configTable_0444[#hitbox_configTable_0444 + 1] = k
		end

		for _, hitbox_loopVar_0445 in ipairs(hitbox_configTable_0444) do
			Hub.HitboxExpander.RestorePart(hitbox_loopVar_0445)
		end
	end

	Hub.HitboxExpander.TrackPlayer = function(hitbox_param_0446)
		local hitboxExpander = Hub.HitboxExpander
		if hitbox_param_0446 == localPlayer or hitboxExpander.playerConnections[hitbox_param_0446] then
			return
		end

		hitboxExpander.playerConnections[hitbox_param_0446] = hitbox_param_0446.CharacterAdded:Connect(function(character_)
			if hitboxExpander.enabled then
				task.spawn(Hub.HitboxExpander.ApplyCharacter, hitbox_param_0446, character_)
			end
		end)

		if hitboxExpander.enabled and hitbox_param_0446.Character then
			task.spawn(Hub.HitboxExpander.ApplyCharacter, hitbox_param_0446, hitbox_param_0446.Character)
		end
	end

	Hub.HitboxExpander.DisconnectKnifeTracking = function()
		local hitboxExpander = Hub.HitboxExpander

		if hitboxExpander.localCharacterConnection then
			hitboxExpander.localCharacterConnection:Disconnect()
			hitboxExpander.localCharacterConnection = nil
		end

		for k, localToolConnection in pairs(hitboxExpander.localToolConnections) do
			if localToolConnection and localToolConnection.Connected then
				localToolConnection:Disconnect()
			end

			hitboxExpander.localToolConnections[k] = nil
		end
	end

	Hub.HitboxExpander.EndActionWindow = function(hitbox_param_0447)
		local hitboxExpander = Hub.HitboxExpander
		if hitbox_param_0447 and hitboxExpander.stabGeneration ~= hitbox_param_0447 then
			return false
		end
		hitboxExpander.stabGeneration = hitboxExpander.stabGeneration + 1
		hitboxExpander.stabActive = false
		Hub.HitboxExpander.RestoreAll()
		return true
	end

	Hub.HitboxExpander.BeginStabWindow = function()
		local hitboxExpander = Hub.HitboxExpander
		if not hitboxExpander.enabled then
			return nil
		end
		local character_ = localPlayer.Character
		character_ = character_ and character_:FindFirstChild("Knife")
		if not character_ or not character_:IsA("Tool") then
			return nil
		end
		hitboxExpander.stabGeneration = hitboxExpander.stabGeneration + 1
		local stabGeneration = hitboxExpander.stabGeneration
		hitboxExpander.stabActive = true
		Hub.HitboxExpander.ApplyAll()

		task.delay(0.55, function()
			Hub.HitboxExpander.EndActionWindow(stabGeneration)
		end)

		return stabGeneration
	end

	Hub.HitboxExpander.TrackKnife = function(hitbox_param_0448)
		local hitboxExpander = Hub.HitboxExpander
		if not hitboxExpander.enabled or not hitbox_param_0448 or not hitbox_param_0448:IsA("Tool") or hitbox_param_0448.Name ~= "Knife" or hitboxExpander.localToolConnections[hitbox_param_0448] then
			return
		end

		hitboxExpander.localToolConnections[hitbox_param_0448] = hitbox_param_0448.Activated:Connect(function()
			Hub.HitboxExpander.BeginStabWindow()
		end)
	end

	Hub.HitboxExpander.StartKnifeTracking = function()
		local hitboxExpander = Hub.HitboxExpander
		Hub.HitboxExpander.DisconnectKnifeTracking()
		local character_ = localPlayer.Character
		if not character_ then
			return
		end

		for _, child in ipairs(character_:GetChildren()) do
			Hub.HitboxExpander.TrackKnife(child)
		end

		hitboxExpander.localCharacterConnection = character_.ChildAdded:Connect(function(child)
			Hub.HitboxExpander.TrackKnife(child)
		end)
	end

	Hub.HitboxExpander.SetEnabled = function(hitbox_param_0449)
		local hitboxExpander = Hub.HitboxExpander
		hitboxExpander.enabled = hitbox_param_0449 and true or false

		if hitboxExpander.enabled then
			Hub.HitboxExpander.StartKnifeTracking()

			if hitboxExpander.localPlayerConnection then
				hitboxExpander.localPlayerConnection:Disconnect()
			end

			hitboxExpander.localPlayerConnection = localPlayer.CharacterAdded:Connect(function()
				task.defer(Hub.HitboxExpander.StartKnifeTracking)
			end)
		else
			hitboxExpander.stabGeneration = hitboxExpander.stabGeneration + 1
			hitboxExpander.stabActive = false
			Hub.HitboxExpander.DisconnectKnifeTracking()

			if hitboxExpander.localPlayerConnection then
				hitboxExpander.localPlayerConnection:Disconnect()
				hitboxExpander.localPlayerConnection = nil
			end

			Hub.HitboxExpander.RestoreAll()
		end
	end

	Hub.HitboxExpander.Destroy = function()
		local hitboxExpander = Hub.HitboxExpander
		hitboxExpander.enabled = false
		hitboxExpander.stabGeneration = hitboxExpander.stabGeneration + 1
		hitboxExpander.stabActive = false
		Hub.HitboxExpander.DisconnectKnifeTracking()

		if hitboxExpander.localPlayerConnection then
			hitboxExpander.localPlayerConnection:Disconnect()
			hitboxExpander.localPlayerConnection = nil
		end

		Hub.HitboxExpander.RestoreAll()

		for k, playerConnection in pairs(hitboxExpander.playerConnections) do
			if playerConnection and playerConnection.Connected then
				playerConnection:Disconnect()
			end

			hitboxExpander.playerConnections[k] = nil
		end
	end

	for _, player in ipairs(Players:GetPlayers()) do
		Hub.HitboxExpander.TrackPlayer(player)
	end

	trackConn(Players.PlayerAdded:Connect(function(player)
		Hub.HitboxExpander.TrackPlayer(player)
	end))

	trackConn(Players.PlayerRemoving:Connect(function(player)
		local hitboxExpander = Hub.HitboxExpander
		local hitbox_localValue_0450 = hitboxExpander.playerConnections[player]

		if hitbox_localValue_0450 then
			hitbox_localValue_0450:Disconnect()
			hitboxExpander.playerConnections[player] = nil
		end

		if player.Character then
			local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")

			if humanoidRootPart then
				Hub.HitboxExpander.RestorePart(humanoidRootPart)
			end
		end
	end))

	local function createFrame(hitbox_param_0451)
		local frame = Instance.new("Frame")
		frame.Name = "ESPLine"
		frame.BorderSizePixel = 0
		frame.BackgroundColor3 = Color3.new(1, 1, 1)
		frame.BackgroundTransparency = 0
		frame.Size = UDim2.new(0, 0, 0, hitbox_param_0451 or 2)
		frame.AnchorPoint = Vector2.new(0.5, 0.5)
		frame.Visible = false
		frame.ZIndex = 10
		frame.Parent = createScreenGui()
		return frame
	end

	crosshair_helperFunc_0391 = function(hitbox_param_0452)
		if not hitbox_param_0452 then
			return
		end

		if typeof(hitbox_param_0452) == "Instance" then
			hitbox_param_0452:Destroy()
		elseif type(hitbox_param_0452.Remove) == "function" then
			hitbox_param_0452:Remove()
		end
	end

	crosshair_helperFunc_0392 = function(hitbox_param_0453, hitbox_param_0454, hitbox_param_0455, backgroundColor3)
		if not hitbox_param_0453 then
			return
		end
		local hitbox_numericVar_0456 = hitbox_param_0455 - hitbox_param_0454
		local magnitude = hitbox_numericVar_0456.Magnitude
		if magnitude < 1 then
			hitbox_param_0453.Visible = false
			return
		end

		if backgroundColor3 then
			hitbox_param_0453.BackgroundColor3 = backgroundColor3
		end

		local hitbox_numericVar_0457 = (hitbox_param_0454 + hitbox_param_0455) * 0.5
		hitbox_param_0453.Size = UDim2.new(0, magnitude, 0, hitbox_param_0453.Size.Y.Offset)
		hitbox_param_0453.Position = UDim2.new(0, hitbox_numericVar_0457.X, 0, hitbox_numericVar_0457.Y)
		hitbox_param_0453.Rotation = math.deg(math.atan2(hitbox_numericVar_0456.Y, hitbox_numericVar_0456.X))
		hitbox_param_0453.Visible = true
	end

	local function hitbox_helperFunc_0458(hitbox_param_0459)
		if not hitbox_param_0459:IsA("BasePart") then
			return
		end

		if Hub.NoclipParts[hitbox_param_0459] == nil then
			Hub.NoclipParts[hitbox_param_0459] = hitbox_param_0459.CanCollide
		end

		if hitbox_param_0459.CanCollide then
			hitbox_param_0459.CanCollide = false
		end
	end

	crosshair_helperFunc_0393 = function()
		local character_ = localPlayer.Character

		if character_ then
			for _, descendant in ipairs(character_:GetDescendants()) do
				hitbox_helperFunc_0458(descendant)
			end
		end

		if Hub.NoclipConn then
			Hub.NoclipConn:Disconnect()
			Hub.NoclipConn = nil
		end

		if Hub.NoclipStepConn then
			Hub.NoclipStepConn:Disconnect()
			Hub.NoclipStepConn = nil
		end

		if character_ then
			Hub.NoclipConn = character_.DescendantAdded:Connect(function(descendant)
				if Hub.NoclipEnabled then
					hitbox_helperFunc_0458(descendant)
				end
			end)
		end

		Hub.NoclipNextRefresh = 0

		Hub.NoclipStepConn = RunService.Heartbeat:Connect(function()
			if not Hub.NoclipEnabled then
				return
			end
			local now = tick()
			if now < Hub.NoclipNextRefresh then
				return
			end
			Hub.NoclipNextRefresh = now + 0.2
			local character_2 = localPlayer.Character
			if not character_2 then
				return
			end

			for _, descendant in ipairs(character_2:GetDescendants()) do
				if descendant:IsA("BasePart") and descendant.CanCollide then
					hitbox_helperFunc_0458(descendant)
				end
			end
		end)
	end

	crosshair_helperFunc_0394 = function()
		if Hub.NoclipConn then
			Hub.NoclipConn:Disconnect()
			Hub.NoclipConn = nil
		end

		if Hub.NoclipStepConn then
			Hub.NoclipStepConn:Disconnect()
			Hub.NoclipStepConn = nil
		end

		for k, noclipPart in pairs(Hub.NoclipParts) do
			if k and k.Parent then
				k.CanCollide = noclipPart
			end
		end

		Hub.NoclipNextRefresh = 0
		table.clear(Hub.NoclipParts)
	end

	Hub.SpeedGlitchConn = RunService.Heartbeat:Connect(function(deltaTime)
		if not Hub.SpeedGlitchEnabled then
			return
		end
		local character_ = localPlayer.Character
		if not character_ then
			return
		end
		local humanoid = character_:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = character_:FindFirstChild("HumanoidRootPart")
		if not humanoid or not humanoidRootPart then
			return
		end

		if humanoid.MoveDirection.Magnitude > 0 and humanoid.FloorMaterial == Enum.Material.Air then
			humanoidRootPart.CFrame = humanoidRootPart.CFrame + humanoid.MoveDirection * Hub.SpeedGlitchPower * 15 * deltaTime
			local assemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity

			if assemblyLinearVelocity.Y < 0 then
				humanoidRootPart.AssemblyLinearVelocity = Vector3.new(assemblyLinearVelocity.X, assemblyLinearVelocity.Y * 0.97, assemblyLinearVelocity.Z)
			end
		end
	end)

	local hitbox_optionalValue_0460 = nil

	local function hitbox_helperFunc_0461()
		WindUI:Notify({ Title = "完成", Content = "甩飞完成", Icon = "check", Duration = 1.5 })
	end

	crosshair_helperFunc_0395 = function(hitbox_param_0462)
		WindUI:Notify({ Title = "错误", Content = hitbox_param_0462 or "未找到", Icon = "x", Duration = 1.5 })
	end

	local function hitbox_helperFunc_0463(hitbox_param_0464)
		local character_ = localPlayer.Character
		local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
		local rootPart = humanoid and humanoid.RootPart
		hitbox_param_0464 = hitbox_param_0464 and hitbox_param_0464.Character
		if not hitbox_param_0464 then
			return
		end
		local humanoid2 = hitbox_param_0464:FindFirstChildOfClass("Humanoid")
		local rootPart2 = humanoid2 and humanoid2.RootPart
		local head = hitbox_param_0464:FindFirstChild("Head")
		local accessory = hitbox_param_0464:FindFirstChildOfClass("Accessory")
		accessory = accessory and accessory:FindFirstChild("Handle")
		if not (character_ and humanoid and rootPart) then
			return
		end

		if rootPart.Velocity.Magnitude < 50 then
			Hub.FlingOldPos = rootPart.CFrame
		end

		if humanoid2 and humanoid2.Sit then
			return
		end
		local currentCamera2 = workspace.CurrentCamera

		if currentCamera2 then
			if head then
				currentCamera2.CameraSubject = head
			elseif accessory then
				currentCamera2.CameraSubject = accessory
			elseif humanoid2 then
				currentCamera2.CameraSubject = humanoid2
			end
		end

		if not hitbox_param_0464:FindFirstChildWhichIsA("BasePart") then
			return
		end

		local function hitbox_helperFunc_0465(hitbox_param_0466, hitbox_param_0467, hitbox_param_0468)
			rootPart.CFrame = CFrame.new(hitbox_param_0466.Position) * hitbox_param_0467 * hitbox_param_0468

			if character_.PrimaryPart then
				character_:SetPrimaryPartCFrame(CFrame.new(hitbox_param_0466.Position) * hitbox_param_0467 * hitbox_param_0468)
			end

			rootPart.Velocity = Vector3.new(90000000, -900000000, 90000000)
			rootPart.RotVelocity = Vector3.new(900000000, 900000000, 900000000)
		end

		local function hitbox_helperFunc_0469(hitbox_param_0470)
			local now = tick()
			local hitbox_numericVar_0471 = 0

			while true do
				if rootPart and humanoid2 then
					if hitbox_param_0470.Velocity.Magnitude < 50 then
						hitbox_numericVar_0471 += 100
						local hitbox_numericVar_0472 = humanoid2.MoveDirection * hitbox_param_0470.Velocity.Magnitude / 1.25
						local cframe = CFrame.Angles
						hitbox_helperFunc_0465(hitbox_param_0470, CFrame.new(0, 1.5, 0) + hitbox_numericVar_0472, cframe(math.rad(hitbox_numericVar_0471), 0, 0))
						task.wait()
						local cframe2 = CFrame.Angles
						hitbox_helperFunc_0465(hitbox_param_0470, CFrame.new(0, -1.5, 0) + hitbox_numericVar_0472, cframe2(math.rad(hitbox_numericVar_0471), 0, 0))
						task.wait()
						local cframe3 = CFrame.Angles
						hitbox_helperFunc_0465(hitbox_param_0470, CFrame.new(0, 1.5, 0) + hitbox_numericVar_0472, cframe3(math.rad(hitbox_numericVar_0471), 0, 0))
						task.wait()
						local cframe4 = CFrame.Angles
						hitbox_helperFunc_0465(hitbox_param_0470, CFrame.new(0, -1.5, 0) + hitbox_numericVar_0472, cframe4(math.rad(hitbox_numericVar_0471), 0, 0))
						task.wait()
						local moveDirection = humanoid2.MoveDirection
						local cframe5 = CFrame.Angles
						hitbox_helperFunc_0465(hitbox_param_0470, CFrame.new(0, 1.5, 0) + moveDirection, cframe5(math.rad(hitbox_numericVar_0471), 0, 0))
						task.wait()
						local moveDirection2 = humanoid2.MoveDirection
						local cframe6 = CFrame.Angles
						hitbox_helperFunc_0465(hitbox_param_0470, CFrame.new(0, -1.5, 0) + moveDirection2, cframe6(math.rad(hitbox_numericVar_0471), 0, 0))
						task.wait()
					else
						local cframe = CFrame.Angles
						hitbox_helperFunc_0465(hitbox_param_0470, CFrame.new(0, 1.5, humanoid2.WalkSpeed), cframe(1.5707963267948966, 0, 0))
						task.wait()
						local cframe2 = CFrame.Angles
						hitbox_helperFunc_0465(hitbox_param_0470, CFrame.new(0, -1.5, -humanoid2.WalkSpeed), cframe2(0, 0, 0))
						task.wait()
						local cframe3 = CFrame.Angles
						hitbox_helperFunc_0465(hitbox_param_0470, CFrame.new(0, 1.5, humanoid2.WalkSpeed), cframe3(1.5707963267948966, 0, 0))
						task.wait()
						local cframe4 = CFrame.Angles
						hitbox_helperFunc_0465(hitbox_param_0470, CFrame.new(0, -1.5, 0), cframe4(1.5707963267948966, 0, 0))
						task.wait()
						local cframe5 = CFrame.Angles
						hitbox_helperFunc_0465(hitbox_param_0470, CFrame.new(0, -1.5, 0), cframe5(0, 0, 0))
						task.wait()
						local cframe6 = CFrame.Angles
						hitbox_helperFunc_0465(hitbox_param_0470, CFrame.new(0, -1.5, 0), cframe6(1.5707963267948966, 0, 0))
						task.wait()
						local cframe7 = CFrame.Angles
						hitbox_helperFunc_0465(hitbox_param_0470, CFrame.new(0, -1.5, 0), cframe7(0, 0, 0))
						task.wait()
					end
				end

				if not (now + 2 < tick() or not Hub.FlingActive or humanoid.Health <= 0) then
					continue
				end
				break
			end
		end

		local fallenPartsDestroyHeight = workspace.FallenPartsDestroyHeight
		workspace.FallenPartsDestroyHeight = (0/0)
		local bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.Parent = rootPart
		bodyVelocity.Velocity = Vector3.zero
		bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

		if rootPart2 then
			hitbox_helperFunc_0469(rootPart2)
		elseif head then
			hitbox_helperFunc_0469(head)
		else
			if not accessory then
				bodyVelocity:Destroy()
				humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
				workspace.FallenPartsDestroyHeight = fallenPartsDestroyHeight
				return
			end

			hitbox_helperFunc_0469(accessory)
		end

		bodyVelocity:Destroy()
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)

		if currentCamera2 then
			currentCamera2.CameraSubject = humanoid
		end

		if Hub.FlingOldPos and humanoid.Health > 0 then
			while true do
				rootPart.CFrame = Hub.FlingOldPos * CFrame.new(0, 0.5, 0)

				if character_.PrimaryPart then
					character_:SetPrimaryPartCFrame(Hub.FlingOldPos * CFrame.new(0, 0.5, 0))
				end

				humanoid:ChangeState("GettingUp")

				for _, child in pairs(character_:GetChildren()) do
					if child:IsA("BasePart") then
						local vector = Vector3.new()
						local vector2 = Vector3.new()
						child.Velocity = vector
						child.RotVelocity = vector2
					end
				end

				task.wait()
				if not ((rootPart.Position - Hub.FlingOldPos.p).Magnitude < 25 or not Hub.FlingActive or humanoid.Health <= 0) then
					continue
				end
				break
			end
		end

		workspace.FallenPartsDestroyHeight = fallenPartsDestroyHeight
	end

	local function fling_helperFunc_0473(fling_param_0474)
		fling_param_0474 = fling_param_0474 and fling_param_0474.Character
		if not fling_param_0474 then
			return nil
		end
		local humanoid = fling_param_0474:FindFirstChildOfClass("Humanoid")
		humanoid = humanoid and humanoid.RootPart
		if humanoid then
			return humanoid
		end
		local head = fling_param_0474:FindFirstChild("Head")
		if head then
			return head
		end
		local accessory = fling_param_0474:FindFirstChildOfClass("Accessory")
		return accessory and accessory:FindFirstChild("Handle")
	end

	crosshair_helperFunc_0396 = function(fling_param_0475, fling_param_0476, fling_param_0477, fling_param_0478)
		if Hub.FlingActive then
			return false
		end

		if not fling_param_0475 then
			return false
		end
		local fling_localValue_0479 = Players:FindFirstChild(fling_param_0475)
		if not fling_localValue_0479 then
			crosshair_helperFunc_0395("Player not found")
			return false
		end

		local function fling_helperFunc_0480()
			local character_ = localPlayer.Character
			local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
			return humanoid ~= nil and humanoid.Health > 0
		end

		local function fling_helperFunc_0481()
			if type(fling_param_0476) ~= "function" then
				return true
			end
			local ok, result = pcall(fling_param_0476)
			return ok and result == true
		end

		local function fling_helperFunc_0482(fling_param_0483, fling_param_0484)
			local fling_timestamp_0485 = tick() + 0.8
			local fling_numericVar_0486 = 0

			while true do
				if not fling_helperFunc_0480() then
					return false, true
				else
					if not fling_localValue_0479.Parent or fling_localValue_0479.Character ~= fling_param_0483 then
						return true, false
					end
					local character_ = fling_localValue_0479.Character
					local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
					if not character_ or not character_:IsDescendantOf(workspace) or not humanoid or humanoid.Health <= 0 then
						return true, false
					end

					if not fling_helperFunc_0481() then
						return false, true
					end
					local fling_callResult_0487 = fling_helperFunc_0473(fling_localValue_0479)

					if fling_callResult_0487 and fling_param_0484 then
						fling_numericVar_0486 = (fling_callResult_0487.Position - fling_param_0484).Magnitude
					end

					task.wait(0.1)
					if not (fling_timestamp_0485 <= tick()) then
						continue
					end
					break
				end
			end

			return fling_numericVar_0486 >= 30, false
		end

		local fling_antiFlingEnabledState_0488 = Hub.AntiFlingEnabled == true

		if fling_antiFlingEnabledState_0488 then
			hitbox_optionalValue_0460(false)
			RunService.Heartbeat:Wait()
			RunService.Heartbeat:Wait()

			if not fling_helperFunc_0481() or not fling_helperFunc_0480() then
				if Hub.AntiFlingEnabled then
					hitbox_optionalValue_0460(true)
				end

				return false
			end
		end

		Hub.FlingActive = true

		if type(fling_param_0476) == "function" then
			task.spawn(function()
				while Hub.FlingActive do
					if not fling_helperFunc_0481() then
						Hub.FlingActive = false
						break
					else
						task.wait(0.05)
					end
				end
			end)
		end

		local fling_numericVar_0489 = math.clamp(tonumber(fling_param_0477) or 3, 1, 3)
		local fling_boolFlag_0490 = false

		for i = 1, fling_numericVar_0489 do
			if not (not Hub.FlingActive or not fling_helperFunc_0481()) then
				if not (not fling_localValue_0479 or not fling_localValue_0479.Parent) then
					local position = fling_helperFunc_0473(fling_localValue_0479)
					position = position and position.Position
					local character_ = fling_localValue_0479.Character

					local ok = pcall(function()
						hitbox_helperFunc_0463(fling_localValue_0479)
					end)

					if fling_helperFunc_0480() then
						local fling_boolFlag_0491 = false
						local fling_boolFlag_0492 = false

						if ok then
							fling_boolFlag_0491, fling_boolFlag_0492 = fling_helperFunc_0482(character_, position)
						end

						if fling_boolFlag_0491 then
							fling_boolFlag_0490 = true
							break
						elseif not (fling_boolFlag_0492 or not fling_helperFunc_0480()) then
							if i < fling_numericVar_0489 then
								task.wait(0.25)
							end

							continue
						end
					end
				end
			end

			break
		end

		Hub.FlingActive = false

		if fling_antiFlingEnabledState_0488 and Hub.AntiFlingEnabled then
			hitbox_optionalValue_0460(true)
		end

		local character_ = localPlayer.Character
		character_ = character_ and character_:FindFirstChildOfClass("Humanoid")
		local currentCamera2 = workspace.CurrentCamera

		if currentCamera2 and character_ then
			currentCamera2.CameraSubject = character_
		end

		if fling_boolFlag_0490 and not fling_param_0478 then
			hitbox_helperFunc_0461()
		end

		return fling_boolFlag_0490
	end

	crosshair_helperFunc_0397 = function()
		if not Hub.FlingActive then
			return
		end
		Hub.FlingActive = false
		local character_ = localPlayer.Character
		character_ = character_ and character_:FindFirstChildOfClass("Humanoid")
		local currentCamera2 = workspace.CurrentCamera

		if currentCamera2 and character_ then
			currentCamera2.CameraSubject = character_
		end
	end

	local fling_configTable_0493 = { antiFlingController = nil }

	local function fling_helperFunc_0494()
		local fling_configTable_0495 = {
			enabled = false,
			connections = {},
			playerConnections = {},
			characterConnections = {},
			parts = {},
			originalCollision = {},
			lastSafeCFrame = nil,
			lastRoot = nil,
			motionAccumulator = 0,
			motionRefreshRate = 0.033333333333333333,
			collisionAccumulator = 0,
			collisionRefreshRate = 0.1,
			horizontalLimit = 120,
			verticalLimit = 500,
			angularLimit = 45,
		}

		local function fling_helperFunc_0496(fling_param_0497)
			if fling_param_0497 then
				fling_param_0497:Disconnect()
			end
		end

		local function fling_helperFunc_0498(fling_param_0499, fling_param_0500)
			if not fling_param_0500:IsA("BasePart") then
				return
			end
			local fling_localValue_0501 = fling_configTable_0495.parts[fling_param_0499]
			if not fling_localValue_0501 or fling_localValue_0501[fling_param_0500] then
				return
			end
			fling_localValue_0501[fling_param_0500] = true
			fling_configTable_0495.originalCollision[fling_param_0500] = fling_param_0500.CanCollide

			if fling_configTable_0495.enabled then
				fling_param_0500.CanCollide = false
			end
		end

		local function fling_helperFunc_0502(fling_param_0503)
			local fling_localValue_0504 = fling_configTable_0495.parts[fling_param_0503]
			if not fling_localValue_0504 then
				return
			end

			for k in pairs(fling_localValue_0504) do
				if k.Parent then
					local fling_localValue_0505 = fling_configTable_0495.originalCollision[k]

					if fling_localValue_0505 ~= nil then
						k.CanCollide = fling_localValue_0505
					end
				end

				fling_configTable_0495.originalCollision[k] = nil
			end
		end

		local function fling_helperFunc_0506(fling_param_0507)
			fling_helperFunc_0502(fling_param_0507)
			local fling_localValue_0508 = fling_configTable_0495.characterConnections[fling_param_0507]

			if fling_localValue_0508 then
				for _, fling_loopVar_0509 in ipairs(fling_localValue_0508) do
					fling_helperFunc_0496(fling_loopVar_0509)
				end
			end

			fling_configTable_0495.characterConnections[fling_param_0507] = nil
			fling_configTable_0495.parts[fling_param_0507] = nil
		end

		local function fling_helperFunc_0510(character_)
			if not fling_configTable_0495.enabled or not character_ or character_ == localPlayer.Character then
				return
			end
			fling_helperFunc_0506(character_)
			fling_configTable_0495.parts[character_] = {}
			fling_configTable_0495.characterConnections[character_] = {}

			for _, descendant in ipairs(character_:GetDescendants()) do
				fling_helperFunc_0498(character_, descendant)
			end

			table.insert(fling_configTable_0495.characterConnections[character_], character_.DescendantAdded:Connect(function(descendant)
				fling_helperFunc_0498(character_, descendant)
			end))

			table.insert(fling_configTable_0495.characterConnections[character_], character_.DescendantRemoving:Connect(function(descendant)
				local fling_localValue_0511 = fling_configTable_0495.parts[character_]

				if fling_localValue_0511 then
					fling_localValue_0511[descendant] = nil
				end

				fling_configTable_0495.originalCollision[descendant] = nil
			end))
		end

		local function fling_helperFunc_0512(player)
			local fling_localValue_0513 = fling_configTable_0495.playerConnections[player]

			if fling_localValue_0513 then
				for _, fling_loopVar_0514 in ipairs(fling_localValue_0513) do
					fling_helperFunc_0496(fling_loopVar_0514)
				end
			end

			fling_configTable_0495.playerConnections[player] = nil

			if player.Character then
				fling_helperFunc_0506(player.Character)
			end
		end

		local function fling_helperFunc_0515(player)
			if not fling_configTable_0495.enabled or player == localPlayer then
				return
			end
			fling_helperFunc_0512(player)
			local characterRemoving = player.CharacterRemoving
			local connect = characterRemoving.Connect
			fling_configTable_0495.playerConnections[player] = { player.CharacterAdded:Connect(fling_helperFunc_0510), connect(characterRemoving, fling_helperFunc_0506) }

			if player.Character then
				fling_helperFunc_0510(player.Character)
			end
		end

		local function fling_helperFunc_0516()
			fling_configTable_0495.enabled = false
			local fling_configTable_0517 = {}

			for k in pairs(fling_configTable_0495.parts) do
				table.insert(fling_configTable_0517, k)
			end

			for _, fling_loopVar_0518 in ipairs(fling_configTable_0517) do
				fling_helperFunc_0506(fling_loopVar_0518)
			end

			for _, playerConnection in pairs(fling_configTable_0495.playerConnections) do
				for _, fling_loopVar_0519 in ipairs(playerConnection) do
					fling_helperFunc_0496(fling_loopVar_0519)
				end
			end

			for _, connection in ipairs(fling_configTable_0495.connections) do
				fling_helperFunc_0496(connection)
			end

			table.clear(fling_configTable_0495.connections)
			table.clear(fling_configTable_0495.playerConnections)
			table.clear(fling_configTable_0495.characterConnections)
			table.clear(fling_configTable_0495.parts)
			table.clear(fling_configTable_0495.originalCollision)
			fling_configTable_0495.lastSafeCFrame = nil
			fling_configTable_0495.lastRoot = nil
			fling_configTable_0495.motionAccumulator = 0
			fling_configTable_0495.collisionAccumulator = 0
		end

		local function fling_helperFunc_0520()
			if fling_configTable_0495.enabled then
				return
			end
			fling_configTable_0495.enabled = true

			for _, player in ipairs(Players:GetPlayers()) do
				fling_helperFunc_0515(player)
			end

			table.insert(fling_configTable_0495.connections, Players.PlayerAdded:Connect(fling_helperFunc_0515))
			table.insert(fling_configTable_0495.connections, Players.PlayerRemoving:Connect(fling_helperFunc_0512))

			table.insert(fling_configTable_0495.connections, RunService.Heartbeat:Connect(function(deltaTime)
				if not fling_configTable_0495.enabled then
					return
				end
				fling_configTable_0495.motionAccumulator = fling_configTable_0495.motionAccumulator + deltaTime
				if fling_configTable_0495.motionAccumulator < fling_configTable_0495.motionRefreshRate then
					return
				end
				local motionAccumulator = fling_configTable_0495.motionAccumulator
				fling_configTable_0495.motionAccumulator = 0
				local character_ = localPlayer.Character
				local humanoidRootPart = character_ and character_:FindFirstChild("HumanoidRootPart")
				character_ = character_ and character_:FindFirstChildOfClass("Humanoid")

				if not humanoidRootPart or not character_ then
					fling_configTable_0495.lastSafeCFrame = nil
					fling_configTable_0495.lastRoot = nil
					return
				end

				if fling_configTable_0495.lastRoot ~= humanoidRootPart then
					fling_configTable_0495.lastRoot = humanoidRootPart
					fling_configTable_0495.lastSafeCFrame = nil
				end

				local assemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity
				local magnitude = Vector3.new(assemblyLinearVelocity.X, 0, assemblyLinearVelocity.Z).Magnitude
				local fling_numericVar_0521 = math.abs(assemblyLinearVelocity.Y)
				local magnitude2 = assemblyLinearVelocity.Magnitude
				local magnitude3 = humanoidRootPart.AssemblyAngularVelocity.Magnitude
				local fling_enabledValue_0522 = Hub.CoinFarm.enabled and Hub.CoinFarm.currentCoin ~= nil and (Hub.CoinFarm.phase == "Farming" or Hub.CoinFarm.phase == "正在躲避杀手")

				if not (Hub.FlingActive or Hub.FlyEnabled or fling_enabledValue_0522) and character_.FloorMaterial ~= Enum.Material.Air and magnitude2 < 45 and magnitude3 < 15 then
					fling_configTable_0495.lastSafeCFrame = humanoidRootPart.CFrame
				end

				local fling_flingActiveState_0523 = not Hub.FlingActive and not Hub.FlyEnabled

				if fling_flingActiveState_0523 then
					fling_flingActiveState_0523 = magnitude > fling_configTable_0495.horizontalLimit or fling_numericVar_0521 > fling_configTable_0495.verticalLimit or magnitude3 > fling_configTable_0495.angularLimit
				end

				if fling_flingActiveState_0523 then
					humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
					humanoidRootPart.AssemblyAngularVelocity = Vector3.zero

					if not fling_enabledValue_0522 and fling_configTable_0495.lastSafeCFrame then
						humanoidRootPart.CFrame = fling_configTable_0495.lastSafeCFrame + Vector3.new(0, 2, 0)
					end

					character_:ChangeState(Enum.HumanoidStateType.GettingUp)
				end

				fling_configTable_0495.collisionAccumulator = fling_configTable_0495.collisionAccumulator + motionAccumulator
				if fling_configTable_0495.collisionAccumulator < fling_configTable_0495.collisionRefreshRate then
					return
				end
				fling_configTable_0495.collisionAccumulator = 0

				for _, part in pairs(fling_configTable_0495.parts) do
					for k in pairs(part) do
						if k.Parent and k.CanCollide then
							k.CanCollide = false
						end
					end
				end
			end))
		end

		fling_configTable_0495.SetEnabled = function(fling_param_0524, fling_param_0525)
			if fling_param_0525 then
				fling_helperFunc_0520()
			else
				fling_helperFunc_0516()
			end

			return fling_param_0524.enabled
		end

		fling_configTable_0495.Destroy = function()
			fling_helperFunc_0516()
		end

		return fling_configTable_0495
	end

	hitbox_optionalValue_0460 = function(fling_param_0526)
		if fling_param_0526 and not fling_configTable_0493.antiFlingController then
			fling_configTable_0493.antiFlingController = fling_helperFunc_0494()
		end

		local antiFlingController = fling_configTable_0493.antiFlingController

		if antiFlingController then
			local ok, result = pcall(antiFlingController.SetEnabled, antiFlingController, fling_param_0526 and true or false)
			if not ok then
				warn("[防甩飞错误] " .. tostring(result))
				return false
			end
		end

		return true
	end

	Hub.SetAntiFlingSource = function(fling_param_0527, fling_param_0528)
		if fling_param_0527 ~= "manual" then
			return false
		end
		Hub.AntiFlingSources[fling_param_0527] = fling_param_0528 and true or false
		local manual = Hub.AntiFlingSources.manual

		if manual and not Hub.AntiFlingEnabled then
			Hub.AntiFlingEnabled = hitbox_optionalValue_0460(true) == true
		elseif not manual and Hub.AntiFlingEnabled then
			hitbox_optionalValue_0460(false)
			Hub.AntiFlingEnabled = false
		end

		return Hub.AntiFlingEnabled
	end

	crosshair_helperFunc_0398 = function()
		local currentCamera2 = workspace.CurrentCamera

		if currentCamera2 and localChar.humanoid then
			currentCamera2.CameraType = Enum.CameraType.Custom
			currentCamera2.CameraSubject = localChar.humanoid
		end
	end

	local function fling_helperFunc_0529()
		local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
		return humanoidRootPart and humanoidRootPart.Position or Vector3.new(0, 200, 0)
	end

	local function createPart()
		if Hub.SafezonePart and Hub.SafezonePart.Parent then
			return Hub.SafezonePart
		end
		local fling_safezoneModelNameValue_0530 = workspace:FindFirstChild(Hub.WorldFeatureConfig.safezoneModelName)

		if fling_safezoneModelNameValue_0530 and fling_safezoneModelNameValue_0530:IsA("Model") then
			local base = fling_safezoneModelNameValue_0530:FindFirstChild("Base") or fling_safezoneModelNameValue_0530:FindFirstChildWhichIsA("BasePart")
			if base then
				Hub.SafezonePart = base
				return base
			end
		end

		local model = Instance.new("Model")
		model.Name = Hub.WorldFeatureConfig.safezoneModelName
		model.Parent = workspace
		local part = Instance.new("Part")
		part.Name = "Base"
		part.Size = Vector3.new(40, 1, 40)
		part.Anchored = true
		part.CanCollide = true
		part.Material = Enum.Material.Neon
		part.Color = Color3.fromRGB(0, 170, 255)
		part.Transparency = 0.2
		part.TopSurface = Enum.SurfaceType.Smooth
		part.BottomSurface = Enum.SurfaceType.Smooth
		part.Parent = model
		part.CFrame = CFrame.new(fling_helperFunc_0529() + Vector3.new(10000, 150, 0))
		Hub.SafezonePart = part
		return part
	end

	crosshair_helperFunc_0399 = function()
		local character_ = localPlayer.Character or localPlayer.CharacterAdded:Wait()

		if character_ then
			character_ = character_:FindFirstChild("HumanoidRootPart") or character_:WaitForChild("HumanoidRootPart", 5)
		end

		if not character_ then
			return false
		end
		local fling_callResult_0531 = createPart()
		if not fling_callResult_0531 then
			return false
		end
		local cFrame = fling_callResult_0531.CFrame + Vector3.new(0, 3, 0)
		character_.CFrame = cFrame

		task.delay(0.15, function()
			local character_2 = localPlayer.Character
			character_2 = character_2 and character_2:FindFirstChild("HumanoidRootPart")
			if not character_2 then
				return
			end

			if (character_2.Position - cFrame.Position).Magnitude > 4 then
				character_2.CFrame = cFrame
			end
		end)

		return true
	end

	crosshair_helperFunc_0400 = function(roundState_param_0532)
		return roundState_param_0532 and roundState_param_0532:IsA("BasePart") and roundState_param_0532.Name == "GunDrop"
	end

	local function roundState_helperFunc_0533()
		local gunDrop = workspace:FindFirstChild("GunDrop")
		return gunDrop ~= nil and gunDrop:IsA("BasePart")
	end

	local function roundState_helperFunc_0534(lastGunDropPicker)
		if not lastGunDropPicker then
			return
		end
		Hub.RoleState.lastGunDropPicker = lastGunDropPicker
		Hub.RoleState.lastGunDropAt = tick()
	end

	local function roundState_helperFunc_0535()
		if not Hub.RoleState.lastGunDropPicker or not Hub.RoleState.lastGunDropPicker.Parent then
			return nil
		end
		local lastGunDropAt = Hub.RoleState.lastGunDropAt
		if Hub.RoleState.gunDropPickerTtl < tick() - lastGunDropAt then
			return nil
		end
		return Hub.RoleState.lastGunDropPicker
	end

	Hub.LobbyCache = workspace:FindFirstChild("Lobby")

	local function roundState_helperFunc_0536()
		if Hub.LobbyCache and Hub.LobbyCache.Parent then
			return Hub.LobbyCache
		end
		Hub.LobbyCache = workspace:FindFirstChild("Lobby")
		return Hub.LobbyCache
	end

	crosshair_helperFunc_0401 = function(roundState_param_0537)
		local roundState_callResult_0538 = roundState_helperFunc_0536()
		roundState_param_0537 = roundState_param_0537 and roundState_param_0537.Character
		return roundState_callResult_0538 and roundState_param_0537 and roundState_param_0537:IsDescendantOf(roundState_callResult_0538)
	end

	crosshair_helperFunc_0402 = function(roundState_param_0539)
		local character_ = roundState_param_0539 and roundState_param_0539.Character
		character_ = character_ and character_:FindFirstChildOfClass("Humanoid")
		return character_ and character_.Health > 0
	end

	crosshair_helperFunc_0403 = function(roundState_param_0540)
		if not roundState_param_0540 or type(Hub.RoleState.cache) ~= "table" then
			return nil
		end
		local roundState_cacheValue_0541 = Hub.RoleState.cache[roundState_param_0540.Name] or Hub.RoleState.cache[tostring(roundState_param_0540.UserId)] or Hub.RoleState.cache[roundState_param_0540.UserId]
		if type(roundState_cacheValue_0541) ~= "table" then
			return nil
		end
		local role = roundState_cacheValue_0541.Role
		if role == "Murderer" or role == "Sheriff" or role == "Innocent" then
			return role
		end
		return nil
	end

	crosshair_helperFunc_0404 = nil

	crosshair_helperFunc_0405 = function(roundState_param_0542)
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer and player.Character then
				if crosshair_helperFunc_0404(player) == roundState_param_0542 then
					return player
				end
			end
		end

		return nil
	end

	crosshair_helperFunc_0406 = function()
		for _, player in ipairs(Players:GetPlayers()) do
			if not crosshair_helperFunc_0402(player) then
				continue
			end
			local backpack = player:FindFirstChildOfClass("Backpack")
			if backpack and backpack:FindFirstChild("Knife") then
				return player
			end
		end

		for _, player in ipairs(Players:GetPlayers()) do
			if not crosshair_helperFunc_0402(player) then
				continue
			end
			local character_ = player.Character
			if character_ and character_:FindFirstChild("Knife") then
				return player
			end
		end

		for _, player in ipairs(Players:GetPlayers()) do
			if crosshair_helperFunc_0402(player) and crosshair_helperFunc_0403(player) == "Murderer" then
				return player
			end
		end

		return nil
	end

	crosshair_helperFunc_0407 = function()
		for _, player in ipairs(Players:GetPlayers()) do
			if not crosshair_helperFunc_0402(player) then
				continue
			end
			local backpack = player:FindFirstChildOfClass("Backpack")
			if backpack and backpack:FindFirstChild("Gun") then
				return player
			end
		end

		for _, player in ipairs(Players:GetPlayers()) do
			if not crosshair_helperFunc_0402(player) then
				continue
			end
			local character_ = player.Character
			if character_ and character_:FindFirstChild("Gun") then
				return player
			end
		end

		local roundState_callResult_0543 = roundState_helperFunc_0535()
		if roundState_callResult_0543 and crosshair_helperFunc_0402(roundState_callResult_0543) then
			return roundState_callResult_0543
		end

		if not roundState_helperFunc_0533() then
			for _, player in ipairs(Players:GetPlayers()) do
				if crosshair_helperFunc_0402(player) and crosshair_helperFunc_0403(player) == "Sheriff" then
					return player
				end
			end
		end

		return nil
	end

	crosshair_helperFunc_0404 = function(roundState_param_0544)
		if not roundState_param_0544 or not crosshair_helperFunc_0402(roundState_param_0544) then
			return "Innocent"
		end

		if roundState_param_0544 == crosshair_helperFunc_0406() then
			return "Murderer"
		end

		if roundState_param_0544 == crosshair_helperFunc_0407() then
			return "Sheriff"
		end
		return "Innocent"
	end

	Hub.CoinFarm.flingMurderer = function()
		local roundState_callResult_0545 = crosshair_helperFunc_0406()
		if not roundState_callResult_0545 or roundState_callResult_0545 == localPlayer then
			return false
		end
		return crosshair_helperFunc_0396(roundState_callResult_0545.Name) == true
	end

	Hub.CoinFarm.getSheriffFlingTarget = function()
		for _, player in ipairs(Players:GetPlayers()) do
			local roundState_cacheValue_0546 = Hub.RoleState.cache[player.Name] or Hub.RoleState.cache[tostring(player.UserId)] or Hub.RoleState.cache[player.UserId]
			if type(roundState_cacheValue_0546) == "table" and roundState_cacheValue_0546.Dead ~= true and roundState_cacheValue_0546.Role == "Sheriff" then
				return player
			end
		end

		local roundState_callResult_0547 = crosshair_helperFunc_0407()
		return roundState_callResult_0547 ~= localPlayer and roundState_callResult_0547 or nil
	end

	Hub.CoinFarm.flingSheriff = function(roundState_param_0548, roundState_param_0549)
		if not roundState_param_0549 or roundState_param_0549 == localPlayer then
			return false
		end

		local function roundState_helperFunc_0550()
			if not Hub.CoinFarm.enabled or not Hub.CoinFarm.endRoundEnabled or not Hub.RoundState.active or not Hub.CoinFarm.IsLocalPlayerInRound() or roundState_param_0548 and Hub.CoinFarm.endRoundGeneration ~= roundState_param_0548 then
				return false
			end
			local character_ = roundState_param_0549.Character
			local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
			local roundState_cacheValue_0551 = Hub.RoleState.cache[roundState_param_0549.Name] or Hub.RoleState.cache[tostring(roundState_param_0549.UserId)] or Hub.RoleState.cache[roundState_param_0549.UserId]
			local roundState_callResult_0552 = type(roundState_cacheValue_0551) == "table" and roundState_cacheValue_0551.Dead ~= true and roundState_cacheValue_0551.Role == "Sheriff"
			local backpack = roundState_param_0549:FindFirstChildOfClass("Backpack")
			backpack = character_:FindFirstChild("Gun") ~= nil or backpack and backpack:FindFirstChild("Gun") ~= nil
			return humanoid ~= nil and humanoid.Health > 0 and character_:IsDescendantOf(workspace) and character_:FindFirstChild("HumanoidRootPart") ~= nil and (roundState_callResult_0552 or backpack)
		end

		if not roundState_helperFunc_0550() then
			return false
		end
		return crosshair_helperFunc_0396(roundState_param_0549.Name, roundState_helperFunc_0550, 3) == true
	end

	task.spawn(function()
		local remotes = ReplicatedStorage:FindFirstChild("Remotes") or ReplicatedStorage:WaitForChild("Remotes", 8)

		if remotes then
			remotes = remotes:FindFirstChild("Gameplay") or remotes:WaitForChild("Gameplay", 8)
		end

		local playerDataChanged = remotes and (remotes:FindFirstChild("PlayerDataChanged") or remotes:WaitForChild("PlayerDataChanged", 8))
		local modules = ReplicatedStorage:FindFirstChild("Modules")
		local currentRoundClient = modules and (modules:FindFirstChild("CurrentRoundClient") or modules:WaitForChild("CurrentRoundClient", 8))

		if currentRoundClient then
			local ok, result = pcall(require, currentRoundClient)
			ok = ok and type(result) == "table" and result.PlayerData or nil

			if type(ok) == "table" then
				Hub.RoleState.cache = ok
				Hub.RoundState.active = next(ok) ~= nil
				Hub.RoundState.coinsReady = Hub.RoundState.active
				Hub.CoinFarm.OnPlayerDataChanged()
			end
		end

		Hub.RoundState.initialized = true
		local roundState_optionalValue_0553 = nil
		local roundState_optionalValue_0554 = nil

		local function roundState_helperFunc_0555()
			if Hub.MobileRoundTimerGui then
				Hub.MobileRoundTimerGui:Destroy()
				Hub.MobileRoundTimerGui = nil
			end
		end

		local function roundState_helperFunc_0556()
			if Hub.MobileRoundTimerGui and Hub.MobileRoundTimerGui.Parent then
				return Hub.MobileRoundTimerGui:FindFirstChild("Timer")
			end
			local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
			if not playerGui then
				return nil
			end
			local foxnameMobileRoundTimer = playerGui:FindFirstChild("FoxnameMobileRoundTimer")

			if foxnameMobileRoundTimer then
				foxnameMobileRoundTimer:Destroy()
			end

			local screenGui = Instance.new("ScreenGui")
			screenGui.Name = "FoxnameMobileRoundTimer"
			screenGui.ResetOnSpawn = false
			screenGui.IgnoreGuiInset = false
			screenGui.DisplayOrder = 20
			screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			local mainGUI = playerGui:FindFirstChild("MainGUI")
			mainGUI = mainGUI and mainGUI:FindFirstChild("Game")
			mainGUI = mainGUI and mainGUI:FindFirstChild("Timer")
			local clone

			if mainGUI and mainGUI:IsA("Frame") then
				clone = mainGUI:Clone()
			else
				clone = Instance.new("Frame")
				clone.BackgroundTransparency = 1
				clone.Size = UDim2.fromOffset(150, 75)
				local textLabel = Instance.new("TextLabel")
				textLabel.Name = "XPText"
				textLabel.BackgroundTransparency = 1
				textLabel.Position = UDim2.fromOffset(0, 15)
				textLabel.Size = UDim2.new(1, 0, 0, 40)
				textLabel.Font = Enum.Font.SourceSansBold
				textLabel.TextColor3 = Color3.new(1, 1, 1)
				textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
				textLabel.TextStrokeTransparency = 0
				textLabel.TextSize = 48
				textLabel.Parent = clone
			end

			clone.Name = "Timer"
			clone.Position = UDim2.new(0.5, -75, 0, 0)
			clone.Size = UDim2.fromOffset(150, 75)
			clone.Visible = false
			clone.Parent = screenGui
			screenGui.Parent = playerGui
			Hub.MobileRoundTimerGui = screenGui
			return clone
		end

		local function updateRoundTimer()
			local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
			if not playerGui then
				return
			end

			if not Hub.ShowRoundTimer then
				roundState_helperFunc_0555()
				return
			end
			local roundState_callResult_0557 = roundState_helperFunc_0556()
			local xpText = roundState_callResult_0557 and roundState_callResult_0557:FindFirstChild("XPText")
			if not roundState_callResult_0557 or not roundState_callResult_0557:IsA("GuiObject") then
				return
			end
			local mainGUI = playerGui:FindFirstChild("MainGUI")
			mainGUI = mainGUI and mainGUI:FindFirstChild("Game")
			mainGUI = mainGUI and mainGUI:FindFirstChild("Timer")
			mainGUI = mainGUI and mainGUI:FindFirstChild("XPText")
			local text = mainGUI and mainGUI:IsA("TextLabel") and mainGUI.Text or ""
			local roundTimerPart = workspace:FindFirstChild("RoundTimerPart")
			local roundState_numericVar_0558 = roundTimerPart and tonumber(roundTimerPart:GetAttribute("Time")) or -1
			local visible = Hub.RoundState.active and (text ~= "" or roundState_numericVar_0558 > 0)
			roundState_callResult_0557.Visible = visible

			if visible and xpText and xpText:IsA("TextLabel") then
				if text ~= "" then
					xpText.Text = text
				else
					local roundState_numericVar_0559 = math.max(0, math.floor(roundState_numericVar_0558))
					local roundState_numericVar_0560 = math.floor(roundState_numericVar_0559 / 60)
					xpText.Text = (roundState_numericVar_0560 > 0 and tostring(roundState_numericVar_0560) .. "m " or "") .. tostring(roundState_numericVar_0559 - roundState_numericVar_0560 * 60) .. "s"
				end
			end
		end

		Hub.UpdateRoundTimer = updateRoundTimer

		local function roundState_helperFunc_0561()
			if roundState_optionalValue_0553 then
				roundState_optionalValue_0553:Disconnect()
				roundState_optionalValue_0553 = nil
			end

			if roundState_optionalValue_0554 then
				roundState_optionalValue_0554:Disconnect()
				roundState_optionalValue_0554 = nil
			end

			local roundTimerPart = workspace:FindFirstChild("RoundTimerPart")

			if roundTimerPart then
				roundState_optionalValue_0553 = trackConn(roundTimerPart:GetAttributeChangedSignal("Time"):Connect(function()
					task.defer(updateRoundTimer)
				end))
			end

			local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
			playerGui = playerGui and playerGui:FindFirstChild("MainGUI")
			playerGui = playerGui and playerGui:FindFirstChild("Game")
			local timer = playerGui and playerGui:FindFirstChild("Timer")
			timer = timer and timer:FindFirstChild("XPText")

			if timer and timer:IsA("TextLabel") then
				roundState_optionalValue_0554 = trackConn(timer:GetPropertyChangedSignal("Text"):Connect(function()
					task.defer(updateRoundTimer)
				end))
			end

			task.defer(updateRoundTimer)
		end

		roundState_helperFunc_0561()

		trackConn(workspace.ChildAdded:Connect(function(child)
			if child.Name == "RoundTimerPart" then
				task.defer(roundState_helperFunc_0561)
			end
		end))

		local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")

		if playerGui then
			trackConn(playerGui.DescendantAdded:Connect(function(descendant)
				if descendant.Name == "XPText" and descendant.Parent and descendant.Parent.Name == "Timer" and descendant:IsA("TextLabel") and playerGui:FindFirstChild("MainGUI") and descendant:IsDescendantOf(playerGui:FindFirstChild("MainGUI")) then
					task.defer(roundState_helperFunc_0561)
				end
			end))
		end

		if playerDataChanged and playerDataChanged:IsA("RemoteEvent") then
			trackConn(playerDataChanged.OnClientEvent:Connect(function(cache)
				if type(cache) ~= "table" then
					return
				end
				Hub.RoleState.cache = cache
				Hub.CoinFarm.OnPlayerDataChanged()
				Hub.CoinFarm.RefreshStats()

				if next(cache) == nil then
					Hub.RoundState.active = false
					Hub.RoundState.coinsReady = false
					Hub.CoinFarm.OnRoundEnded()
					task.defer(updateRoundTimer)
				end
			end))
		end

		local roundStart = remotes and remotes:FindFirstChild("RoundStart")

		if roundStart and roundStart:IsA("RemoteEvent") then
			trackConn(roundStart.OnClientEvent:Connect(function(roundState_param_0562, cache)
				if type(cache) == "table" then
					Hub.RoleState.cache = cache
				else
					Hub.RoleState.cache = {}
				end

				Hub.RoundState.active = true
				Hub.RoundState.coinsReady = false
				Hub.RoundState.startedAt = os.clock()
				Hub.CoinFarm.OnRoundStarted()
				task.defer(updateRoundTimer)
			end))
		end

		local coinsStarted = remotes and remotes:FindFirstChild("CoinsStarted")

		if coinsStarted and coinsStarted:IsA("RemoteEvent") then
			trackConn(coinsStarted.OnClientEvent:Connect(function(roundState_param_0563)
				Hub.RoundState.coinsReady = Hub.RoundState.active and type(roundState_param_0563) == "table" and (roundState_param_0563.Coin ~= nil or roundState_param_0563.Candy ~= nil)
				Hub.CoinFarm.OnCoinsStarted(roundState_param_0563)
			end))
		end

		local coinCollected = remotes and remotes:FindFirstChild("CoinCollected")

		if coinCollected and coinCollected:IsA("RemoteEvent") then
			trackConn(coinCollected.OnClientEvent:Connect(function(roundState_param_0564, roundState_param_0565, roundState_param_0566)
				local currency = tostring(roundState_param_0564)
				if currency ~= "Coin" and currency ~= "Candy" then
					return
				end
				local roundState_numericVar_0567 = tonumber(roundState_param_0565)
				local roundState_numericVar_0568 = tonumber(roundState_param_0566)

				if not (roundState_numericVar_0567 and roundState_numericVar_0568 and roundState_numericVar_0567 > roundState_numericVar_0568) then
					local roundState_localValue_0569 = roundState_numericVar_0568
					roundState_numericVar_0568 = roundState_numericVar_0567
					roundState_numericVar_0567 = roundState_localValue_0569
				end

				if not roundState_numericVar_0568 then
					roundState_numericVar_0568 = (Hub.CoinFarm.bagCurrentValue or Hub.CoinFarm.lastBagCount or Hub.CoinFarm.GetBagCount() or 0) + 1
				end

				Hub.CoinFarm.MarkCurrentCollected()
				Hub.CoinFarm.ApplyBagCount(roundState_numericVar_0568, roundState_numericVar_0567)
			end))
		end

		local function roundState_helperFunc_0570()
			Hub.RoundState.active = false
			Hub.RoundState.coinsReady = false
			Hub.CoinFarm.OnRoundEnded()
			task.defer(updateRoundTimer)
		end

		local roundState_optionalValue_0571 = nil

		roundState_optionalValue_0571 = function(roundState_param_0572)
			if typeof(roundState_param_0572) == "Instance" then
				if roundState_param_0572:IsA("Model") or roundState_param_0572:IsA("Folder") then
					return roundState_param_0572.Name, roundState_param_0572
				end
				return nil, nil
			end

			if type(roundState_param_0572) == "string" then
				local match = roundState_param_0572:match("^%s*(.-)%s*$")
				if match ~= "" then
					return match, nil
				end
				return nil, nil
			end

			if type(roundState_param_0572) ~= "table" then
				return nil, nil
			end

			for _, roundState_loopVar_0573 in ipairs({ "MapName", "mapName", "Name", "name", "Map", "map", "MapModel", "mapModel" }) do
				local roundState_callResult_0574, roundState_callResult_0575 = roundState_optionalValue_0571(roundState_param_0572[roundState_loopVar_0573])
				if roundState_callResult_0574 then
					return roundState_callResult_0574, roundState_callResult_0575
				end
			end

			return nil, nil
		end

		local loadingMap = remotes and remotes:FindFirstChild("LoadingMap")

		if loadingMap and loadingMap:IsA("RemoteEvent") then
			trackConn(loadingMap.OnClientEvent:Connect(function(...)
				roundState_helperFunc_0570()
				Hub.RoundState.currentMapName = nil
				Hub.RoundState.currentMapInstance = nil
				Hub.RoundState.mapReceivedAt = os.clock()
				local roundState_textValue_0576 = table.pack(...)

				for i = 1, roundState_textValue_0576.n do
					local roundState_callResult_0577, roundState_callResult_0578 = roundState_optionalValue_0571(roundState_textValue_0576[i])

					if roundState_callResult_0577 then
						Hub.RoundState.currentMapName = roundState_callResult_0577
						Hub.RoundState.currentMapInstance = roundState_callResult_0578
						break
					end
				end
			end))
		end

		for _, roundState_loopVar_0579 in ipairs({ "VictoryScreen", "GameOver", "RoundEndFade" }) do
			local roundState_localValue_0580 = remotes and remotes:FindFirstChild(roundState_loopVar_0579)

			if roundState_localValue_0580 and roundState_localValue_0580:IsA("RemoteEvent") then
				trackConn(roundState_localValue_0580.OnClientEvent:Connect(roundState_helperFunc_0570))
			end
		end
	end)

	crosshair_helperFunc_0408 = function(roundState_param_0581)
		local roundState_eSPTableState_0582 = Hub.ESPTable[roundState_param_0581]
		if not roundState_eSPTableState_0582 then
			return
		end
		crosshair_helperFunc_0391(roundState_eSPTableState_0582.Line)

		if roundState_eSPTableState_0582.BoxLines then
			for _, boxLine in pairs(roundState_eSPTableState_0582.BoxLines) do
				boxLine:Remove()
			end
		end

		for _, roundState_loopVar_0583 in pairs(roundState_eSPTableState_0582) do
			if typeof(roundState_loopVar_0583) == "Instance" then
				roundState_loopVar_0583:Destroy()
			end
		end

		Hub.ESPTable[roundState_param_0581] = nil
	end

	local function roundState_helperFunc_0584(roundState_param_0585, adornee)
		crosshair_helperFunc_0408(roundState_param_0585)
		local head = adornee:FindFirstChild("Head") or adornee:WaitForChild("Head", 5)
		local humanoidRootPart = adornee:FindFirstChild("HumanoidRootPart") or adornee:WaitForChild("HumanoidRootPart", 5)
		if not head or not humanoidRootPart then
			return
		end
		local highlight = Instance.new("Highlight")
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Adornee = adornee
		highlight.Enabled = false
		highlight.Parent = adornee
		local billboardGui = Instance.new("BillboardGui")
		billboardGui.Size = UDim2.fromOffset(220, 32)
		billboardGui.StudsOffset = Vector3.new(0, 2.75, 0)
		billboardGui.AlwaysOnTop = true
		billboardGui.Enabled = false
		billboardGui.Parent = head
		local textLabel = Instance.new("TextLabel", billboardGui)
		textLabel.Size = UDim2.fromScale(1, 1)
		textLabel.BackgroundTransparency = 1
		textLabel.TextScaled = false
		textLabel.TextSize = 14
		textLabel.Font = Enum.Font.GothamBold
		local uiGradient = Instance.new("UIGradient")
		uiGradient.Color = Hub.OwnerESPGradient
		uiGradient.Enabled = false
		uiGradient.Parent = textLabel
		local uiStroke = Instance.new("UIStroke", textLabel)
		uiStroke.Thickness = 1.25
		uiStroke.Color = Color3.new(0, 0, 0)
		local roundState_callResult_0586 = createFrame(2)
		local roundState_callResult_0587, roundState_callResult_0588 = crosshair_helperFunc_0411()

		Hub.ESPTable[roundState_param_0585] = {
			Highlight = highlight,
			Billboard = billboardGui,
			Text = textLabel,
			OwnerGradient = uiGradient,
			Line = roundState_callResult_0586,
			Arrow = roundState_callResult_0587,
			ArrowDistance = roundState_callResult_0588,
			BoxLines = {},
			HRP = humanoidRootPart,
			Head = head,
		}
	end

	local function espTable_helperFunc_0589(espTable_param_0590)
		if espTable_param_0590 == localPlayer then
			return
		end

		if espTable_param_0590.Character then
			roundState_helperFunc_0584(espTable_param_0590, espTable_param_0590.Character)
		end

		if not Hub.ESPPlayerConnections[espTable_param_0590] then
			Hub.ESPPlayerConnections[espTable_param_0590] = espTable_param_0590.CharacterAdded:Connect(function(character_)
				roundState_helperFunc_0584(espTable_param_0590, character_)
			end)
		end
	end

	crosshair_helperFunc_0409 = function(espTable_param_0591)
		local espTable_gunESPTableState_0592 = espTable_param_0591 and Hub.GunESPTable[espTable_param_0591]
		if not Hub.DroppedGunNotify or not espTable_gunESPTableState_0592 or espTable_gunESPTableState_0592.Notified then
			return
		end
		espTable_gunESPTableState_0592.Notified = true
		local character_ = localPlayer.Character
		character_ = character_ and character_:FindFirstChild("HumanoidRootPart")
		character_ = character_ and math.floor((espTable_param_0591.Position - character_.Position).Magnitude + 0.5)

		WindUI:Notify({
			Title = "掉落的枪",
			Content = character_ and "A dropped gun was detected " .. tostring(character_) .. " studs away." or "A dropped gun was detected.",
			Icon = "locate-fixed",
			Duration = 4,
		})
	end

	local function espTable_helperFunc_0593(parent)
		if Hub.GunESPTable[parent] then
			return
		end
		local billboardGui = Instance.new("BillboardGui")
		billboardGui.Size = UDim2.fromOffset(120, 40)
		billboardGui.AlwaysOnTop = true
		billboardGui.StudsOffset = Vector3.new(0, 3, 0)
		billboardGui.Enabled = Hub.GunESP
		local textLabel = Instance.new("TextLabel", billboardGui)
		textLabel.Size = UDim2.fromScale(1, 1)
		textLabel.BackgroundTransparency = 1
		textLabel.Font = Enum.Font.GothamBold
		textLabel.TextSize = 32
		textLabel.Text = "GUN"
		textLabel.TextStrokeTransparency = 0.5
		textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
		billboardGui.Parent = parent
		local espTable_callResult_0594 = createFrame(2)
		espTable_callResult_0594.Visible = Hub.GunESP
		local espTable_callResult_0595, espTable_callResult_0596 = crosshair_helperFunc_0411()

		Hub.GunESPTable[parent] = {
			Billboard = billboardGui,
			TextLabel = textLabel,
			Line = espTable_callResult_0594,
			Arrow = espTable_callResult_0595,
			ArrowDistance = espTable_callResult_0596,
			Notified = false,
			TouchedConnection = parent.Touched:Connect(function(hit)
				local model = hit and hit:FindFirstAncestorOfClass("Model")
				local playerFromCharacter = model and Players:GetPlayerFromCharacter(model)

				if playerFromCharacter then
					roundState_helperFunc_0534(playerFromCharacter)
				end
			end),
		}

		crosshair_helperFunc_0409(parent)
	end

	local color = Color3.fromRGB(255, 190, 35)

	local function espTable_helperFunc_0597(espTable_param_0598)
		return espTable_param_0598 and espTable_param_0598:IsA("BasePart") and (espTable_param_0598.Name == "Coin_Server" or espTable_param_0598.Name == "Candy_Server")
	end

	local function espTable_helperFunc_0599(espTable_param_0600)
		local espTable_coinESPTableState_0601 = Hub.CoinESPTable[espTable_param_0600]

		if espTable_coinESPTableState_0601 then
			pcall(function()
				espTable_coinESPTableState_0601:Destroy()
			end)

			Hub.CoinESPTable[espTable_param_0600] = nil
		end
	end

	local function espTable_helperFunc_0602(espTable_param_0603)
		local coinVisual = espTable_param_0603 and espTable_param_0603:FindFirstChild("CoinVisual")
		if not coinVisual then
			return espTable_param_0603
		end

		if coinVisual:IsA("Model") then
			return coinVisual
		end
		local mainCoin = coinVisual:FindFirstChild("MainCoin", true)
		if mainCoin and mainCoin:IsA("BasePart") and mainCoin.Transparency < 0.99 and mainCoin.LocalTransparencyModifier < 0.99 then
			return mainCoin
		end

		for _, descendant in ipairs(coinVisual:GetDescendants()) do
			if descendant:IsA("BasePart") and descendant.Transparency < 0.99 and descendant.LocalTransparencyModifier < 0.99 then
				return descendant
			end
		end

		return coinVisual
	end

	local function espTable_helperFunc_0604(parent)
		if not Hub.CoinESP or not espTable_helperFunc_0597(parent) or Hub.CoinESPTable[parent] then
			return
		end
		local folder = Instance.new("Folder")
		folder.Name = "FoxnameCoinESP"
		folder.Parent = parent
		local highlight = Instance.new("Highlight")
		highlight.Name = "Highlight"
		highlight.Adornee = espTable_helperFunc_0602(parent)
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.FillColor = color
		highlight.FillTransparency = 0.3
		highlight.OutlineColor = Color3.fromRGB(255, 226, 110)
		highlight.OutlineTransparency = 0
		highlight.Parent = folder
		Hub.CoinESPTable[parent] = folder

		task.defer(function()
			if Hub.CoinESP and parent.Parent and folder.Parent and highlight.Parent then
				highlight.Adornee = espTable_helperFunc_0602(parent)
			end
		end)
	end

	local function disconnectCoinESPMap(espTable_param_0605)
		Hub.CoinESPGeneration = Hub.CoinESPGeneration + 1

		if Hub.CoinESPAddedConnection then
			Hub.CoinESPAddedConnection:Disconnect()
			Hub.CoinESPAddedConnection = nil
		end

		if Hub.CoinESPRemovingConnection then
			Hub.CoinESPRemovingConnection:Disconnect()
			Hub.CoinESPRemovingConnection = nil
		end

		Hub.CoinESPMap = nil
		Hub.CoinESPContainer = nil

		if espTable_param_0605 then
			for k in pairs(Hub.CoinESPTable) do
				espTable_helperFunc_0599(k)
			end
		end
	end

	Hub.DisconnectCoinESPMap = disconnectCoinESPMap

	local function espTable_helperFunc_0606(espTable_param_0607)
		if not espTable_param_0607 or not espTable_param_0607.Parent then
			return nil
		end
		local coinContainer = espTable_param_0607:FindFirstChild("CoinContainer") or espTable_param_0607:FindFirstChild("CandyContainer") or espTable_param_0607:FindFirstChild("CoinContainer", true) or espTable_param_0607:FindFirstChild("CandyContainer", true)
		if coinContainer and (coinContainer:IsA("Model") or coinContainer:IsA("Folder")) then
			return coinContainer
		end
		return nil
	end

	local function refreshCoinESP()
		disconnectCoinESPMap(true)
		if not Hub.CoinESP then
			return false
		end
		local coinESPGeneration = Hub.CoinESPGeneration
		local espTable_resolveMapValue_0608 = Hub.CoinFarm.ResolveMap()
		if not espTable_resolveMapValue_0608 then
			return false
		end
		local espTable_callResult_0609 = espTable_helperFunc_0606(espTable_resolveMapValue_0608)
		local espTable_localValue_0610 = espTable_callResult_0609 or espTable_resolveMapValue_0608
		Hub.CoinESPMap = espTable_resolveMapValue_0608
		Hub.CoinESPContainer = espTable_callResult_0609
		local descendants = espTable_localValue_0610:GetDescendants()

		for i, descendant in ipairs(descendants) do
			if not Hub.CoinESP or Hub.CoinESPMap ~= espTable_resolveMapValue_0608 or Hub.CoinESPGeneration ~= coinESPGeneration then
				return false
			end

			if espTable_helperFunc_0597(descendant) then
				espTable_helperFunc_0604(descendant)
			end

			if i % 100 == 0 then
				RunService.Heartbeat:Wait()
			end
		end

		if not Hub.CoinESP or not espTable_localValue_0610.Parent or Hub.CoinESPGeneration ~= coinESPGeneration then
			return false
		end

		Hub.CoinESPAddedConnection = espTable_localValue_0610.DescendantAdded:Connect(function(descendant)
			if Hub.CoinESP and espTable_helperFunc_0597(descendant) then
				espTable_helperFunc_0604(descendant)
			end
		end)

		Hub.CoinESPRemovingConnection = espTable_localValue_0610.DescendantRemoving:Connect(function(descendant)
			if Hub.CoinESPTable[descendant] then
				espTable_helperFunc_0599(descendant)
			end
		end)

		return true
	end

	Hub.RefreshCoinESP = refreshCoinESP

	local function espTable_helperFunc_0611()
		task.spawn(function()
			for i = 1, 40 do
				if not Hub.CoinESP then
					return
				end

				if refreshCoinESP() then
					return
				end
				task.wait(0.2)
			end
		end)
	end

	crosshair_helperFunc_0410 = function(espTable_param_0612)
		Hub.CoinESP = espTable_param_0612 and true or false
		if not Hub.CoinESP then
			disconnectCoinESPMap(true)
			return
		end
		espTable_helperFunc_0611()
	end

	local function espTable_helperFunc_0613(espTable_param_0614, espTable_param_0615)
		local espTable_boolFlag_0616 = not espTable_param_0615
		if espTable_boolFlag_0616 and not Hub.AutoGunTouchEnabled then
			return
		end

		if espTable_boolFlag_0616 and Hub.CoinFarm.enabled and Hub.CoinFarm.GetCachedRole(localPlayer) == "Murderer" then
			return
		end

		if Hub.AutoGunTouchPending[espTable_param_0614] then
			return
		end
		Hub.AutoGunTouchPending[espTable_param_0614] = true

		task.spawn(function()
			if not espTable_param_0614 or not espTable_param_0614.Parent then
				Hub.AutoGunTouchPending[espTable_param_0614] = nil
				return
			end
			local character_ = localPlayer.Character
			local humanoidRootPart

			if character_ then
				humanoidRootPart = character_:FindFirstChild("HumanoidRootPart") or character_:FindFirstChild("Torso")
			else
				humanoidRootPart = character_
			end

			local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")

			if humanoidRootPart and typeof(firetouchinterest) == "function" then
				for i = 1, 4 do
					if not (not espTable_param_0614 or not espTable_param_0614.Parent) then
						pcall(function()
							firetouchinterest(humanoidRootPart, espTable_param_0614, 0)
							firetouchinterest(humanoidRootPart, espTable_param_0614, 1)
						end)

						continue
					end

					break
				end
			end

			local touchTransmitter = espTable_param_0614:FindFirstChildOfClass("TouchTransmitter") or espTable_param_0614:FindFirstChild("TouchInterest")

			if touchTransmitter and typeof(firetouchtransmitter) == "function" then
				pcall(function()
					firetouchtransmitter(touchTransmitter)
				end)
			end

			task.spawn(function()
				local backpack = localPlayer:FindFirstChildOfClass("Backpack")

				for i = 1, 10 do
					local gun = backpack and backpack:FindFirstChild("Gun")

					if gun and gun:IsA("Tool") and humanoid and humanoid.Health > 0 then
						pcall(function()
							humanoid:EquipTool(gun)
						end)

						break
					else
						task.wait(0.03)
					end
				end
			end)

			task.wait(0.1)
			Hub.AutoGunTouchPending[espTable_param_0614] = nil
		end)
	end

	Hub.TakeDroppedGunOnce = function()
		local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
		local huge = math.huge
		local espTable_optionalValue_0617 = nil

		for k in pairs(Hub.GunESPTable) do
			if crosshair_helperFunc_0400(k) and k.Parent then
				local magnitude = humanoidRootPart and (k.Position - humanoidRootPart.Position).Magnitude or 0

				if magnitude < huge then
					huge = magnitude
					espTable_optionalValue_0617 = k
				end
			end
		end

		if not espTable_optionalValue_0617 then
			local gunDrop = workspace:FindFirstChild("GunDrop")

			if crosshair_helperFunc_0400(gunDrop) then
				espTable_optionalValue_0617 = gunDrop
			end
		end

		if not espTable_optionalValue_0617 then
			WindUI:Notify({ Title = "拿枪", Content = "未发现掉落的枪。", Icon = "x", Duration = 2 })
			return false
		end
		espTable_helperFunc_0613(espTable_optionalValue_0617, true)
		return true
	end

	Hub.SetAutoGunTouchSource = function(espTable_param_0618, espTable_param_0619)
		if espTable_param_0618 ~= "misc" then
			return false
		end
		local autoGunTouchEnabled = Hub.AutoGunTouchEnabled
		Hub.AutoGunTouchSources[espTable_param_0618] = espTable_param_0619 and true or false
		Hub.AutoGunTouchEnabled = Hub.AutoGunTouchSources.misc

		if Hub.AutoGunTouchEnabled and not autoGunTouchEnabled then
			task.spawn(function()
				local descendants = workspace:GetDescendants()

				for i, descendant in ipairs(descendants) do
					if Hub.AutoGunTouchEnabled then
						if crosshair_helperFunc_0400(descendant) then
							espTable_helperFunc_0613(descendant)
						end

						if i % 250 == 0 then
							RunService.Heartbeat:Wait()
						end

						continue
					end

					break
				end
			end)
		end

		return Hub.AutoGunTouchEnabled
	end

	trackConn(workspace.DescendantAdded:Connect(function(descendant)
		if crosshair_helperFunc_0400(descendant) then
			espTable_helperFunc_0593(descendant)
			espTable_helperFunc_0613(descendant)
		end
	end))

	trackConn(workspace.DescendantRemoving:Connect(function(descendant)
		Hub.AutoGunTouchPending[descendant] = nil

		if Hub.GunESPTable[descendant] then
			local espTable_gunESPTableState_0620 = Hub.GunESPTable[descendant]

			if espTable_gunESPTableState_0620.TouchedConnection then
				espTable_gunESPTableState_0620.TouchedConnection:Disconnect()
			end

			crosshair_helperFunc_0391(espTable_gunESPTableState_0620.Line)

			if espTable_gunESPTableState_0620.Arrow then
				espTable_gunESPTableState_0620.Arrow:Destroy()
			end

			if espTable_gunESPTableState_0620.ArrowDistance then
				espTable_gunESPTableState_0620.ArrowDistance:Destroy()
			end

			espTable_gunESPTableState_0620.Billboard:Destroy()
			Hub.GunESPTable[descendant] = nil
		end
	end))

	task.spawn(function()
		local descendants = workspace:GetDescendants()

		for i, descendant in ipairs(descendants) do
			if crosshair_helperFunc_0400(descendant) then
				espTable_helperFunc_0593(descendant)
				espTable_helperFunc_0613(descendant)
			end

			if i % 250 == 0 then
				RunService.Heartbeat:Wait()
			end
		end
	end)

	for _, player in ipairs(Players:GetPlayers()) do
		espTable_helperFunc_0589(player)
		services_helperFunc_0110(player)
	end

	trackConn(Players.PlayerAdded:Connect(function(player)
		espTable_helperFunc_0589(player)
		services_helperFunc_0110(player)
	end))
end

trackConn(Players.PlayerRemoving:Connect(function(player)
	local espTable_eSPPlayerConnectionsState_0621 = Hub.ESPPlayerConnections[player]

	if espTable_eSPPlayerConnectionsState_0621 then
		espTable_eSPPlayerConnectionsState_0621:Disconnect()
		Hub.ESPPlayerConnections[player] = nil
	end

	crosshair_helperFunc_0408(player)
end))

Hub.ReexecuteScriptUrl = "https://raw.githubusercontent.com/FoxnameTeam/OSS/main/Murder-Mystery-2/main.luau"
Hub.AdminReexecuteScriptUrl = Hub.ReexecuteScriptUrl
Hub.CoinFarmKickRecoveryStarted = false
Hub.SuppressCoinFarmKickRecovery = false

do
	local function espTable_helperFunc_0622()
		local espTable_sessionStartedAtValue_0623 = Hub.CoinFarm.sessionStartedAt > 0

		if espTable_sessionStartedAtValue_0623 then
			local sessionStartedAt = Hub.CoinFarm.sessionStartedAt
			espTable_sessionStartedAtValue_0623 = math.max(0, os.clock() - sessionStartedAt)
		end

		espTable_sessionStartedAtValue_0623 = espTable_sessionStartedAtValue_0623 or 0
		local eventBox = Hub.EventBox

		local ok, result = pcall(HttpService.JSONEncode, HttpService, {
			version = 2,
			savedAt = os.time(),
			enabled = Hub.CoinFarm.enabled == true,
			total = math.max(0, math.floor(tonumber(Hub.CoinFarm.totalCollected) or 0)),
			totalXP = math.max(0, math.floor(tonumber(Hub.CoinFarm.totalEarnedXP) or 0)),
			sessionElapsed = espTable_sessionStartedAtValue_0623,
			serverHopCount = math.max(0, math.floor(tonumber(Hub.CoinFarm.serverHopCount) or 0)),
			serverHopTimerMinutes = math.clamp(math.floor(tonumber(Hub.CoinFarm.serverHopTimerMinutes) or 15), 10, 30),
			mode = Hub.CoinFarm.mode,
			position = Hub.CoinFarm.position,
			xpFarm = Hub.CoinFarm.xpFarmEnabled == true,
			endRound = Hub.CoinFarm.endRoundEnabled == true,
			serverHopLowPlayers = Hub.CoinFarm.serverHopLowPlayers == true,
			serverHopThreshold = math.clamp(math.floor(tonumber(Hub.CoinFarm.serverHopPlayerThreshold) or 4), 1, 6),
			antiBot = Hub.CoinFarm.antiBotEnabled == true,
			autoPrestige = Hub.AutoPrestige.enabled == true,
			autoClaimRewards = Hub.AutoClaimReward.enabled == true,
			blackScreen = Hub.CoinFarm.blackScreenEnabled == true,
			disable3D = Hub.CoinFarm.disable3DRendering == true,
			eventBox = type(eventBox) == "table" and eventBox.selectedBox or nil,
			eventCurrency = type(eventBox) == "table" and eventBox.selectedCurrency or nil,
			autoBuyBoxes = type(eventBox) == "table" and eventBox.autoBuy == true or false,
		})

		if ok and type(result) == "string" then
			pcall(function()
				if type(isfolder) == "function" and type(makefolder) == "function" and not isfolder("Foxname_MM2") then
					makefolder("Foxname_MM2")
				end

				if type(writefile) == "function" then
					writefile("Foxname_MM2/coin_farm_resume.json", result)
				end
			end)
		end

		local espTable_callResult_0624 = type(queue_on_teleport) == "function" and queue_on_teleport or type(queueonteleport) == "function" and queueonteleport
		local queueOnTeleport

		if espTable_callResult_0624 then
			queueOnTeleport = espTable_callResult_0624
		else
			local espTable_callResult_0625 = type(syn) == "table"

			if espTable_callResult_0625 then
				queueOnTeleport = syn.queue_on_teleport or syn.queueonteleport
			else
				queueOnTeleport = espTable_callResult_0625
			end
		end

		queueOnTeleport = queueOnTeleport or type(fluxus) == "table" and (fluxus.queue_on_teleport or fluxus.queueonteleport)
		if type(queueOnTeleport) ~= "function" then
			return false, "queue_on_teleport unavailable"
		end
		local espTable_adminReexecuteScriptUrlState_0626 = tostring(Hub.AdminReexecuteScriptUrl or "")
		if espTable_adminReexecuteScriptUrlState_0626 == "" then
			return false, "re-execute URL unavailable"
		end

		if not ok or type(result) ~= "string" then
			return false, "resume state could not be encoded"
		end
		local espTable_textValue_0627 = string.format("if not game:IsLoaded() then game.Loaded:Wait() end;%sloadstring(game:HttpGet(%q))()", string.format("local e=(getgenv and getgenv()) or _G;e.__FoxnameCoinFarmResume=game:GetService('HttpService'):JSONDecode(%q);", result), espTable_adminReexecuteScriptUrlState_0626)
		local ok2, result2 = pcall(queueOnTeleport, espTable_textValue_0627)
		return ok2, ok2 and nil or tostring(result2)
	end

	Hub.CoinFarm.FetchServerCandidates = function(espTable_param_0628, espTable_param_0629, espTable_param_0630)
		local espTable_configTable_0631 = {}
		local espTable_numericVar_0632 = math.clamp(math.floor(tonumber(espTable_param_0630) or 2), 1, 3)
		espTable_param_0629 = type(espTable_param_0629) == "table" and espTable_param_0629 or {}
		local nextPageCursor = nil

		for i = 1, espTable_numericVar_0632 do
			local espTable_numericVar_0633 = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&excludeFullGames=true&limit=100%s", tonumber(espTable_param_0628) or game.PlaceId, nextPageCursor and "&cursor=" .. HttpService:UrlEncode(nextPageCursor) or "")
			local genv2 = type(getgenv) == "function" and getgenv() or _G

			if type(genv2) ~= "table" then
				genv2 = _G
			end

			local request_ = genv2.request or genv2.http_request or type(genv2.syn) == "table" and genv2.syn.request
			local body = nil

			if type(request_) == "function" then
				local ok, result = pcall(request_, { Url = espTable_numericVar_0633, Method = "GET", Headers = { Accept = "application/json" } })
				ok = ok and type(result) == "table"
				body = nil

				if ok then
					local espTable_numericVar_0634 = tonumber(result.StatusCode or result.Status)
					local espTable_boolFlag_0635 = not espTable_numericVar_0634 or espTable_numericVar_0634 >= 200 and espTable_numericVar_0634 < 300
					body = nil

					if espTable_boolFlag_0635 then
						body = result.Body or result.body
					end
				end
			end

			if type(body) ~= "string" or body == "" then
				local ok, result = pcall(game.HttpGet, game, espTable_numericVar_0633)

				if ok and type(result) == "string" then
					body = result
				end
			end

			local ok, result = pcall(HttpService.JSONDecode, HttpService, body or "")

			if not (not ok or type(result) ~= "table" or type(result.data) ~= "table") then
				for _, espTable_loopVar_0636 in ipairs(result.data) do
					local reconnect_callResult_0637 = type(espTable_loopVar_0636) == "table"

					if reconnect_callResult_0637 then
						reconnect_callResult_0637 = tostring(espTable_loopVar_0636.id or "")
					end

					reconnect_callResult_0637 = reconnect_callResult_0637 or ""
					local reconnect_numericVar_0638 = tonumber(type(espTable_loopVar_0636) == "table" and espTable_loopVar_0636.playing) or 0
					local reconnect_numericVar_0639 = tonumber(type(espTable_loopVar_0636) == "table" and espTable_loopVar_0636.maxPlayers) or 0

					if reconnect_callResult_0637 ~= "" and reconnect_callResult_0637 ~= tostring(game.JobId) and not espTable_param_0629[reconnect_callResult_0637] and reconnect_numericVar_0639 > reconnect_numericVar_0638 then
						table.insert(espTable_configTable_0631, { id = reconnect_callResult_0637, playing = reconnect_numericVar_0638, safe = reconnect_numericVar_0639 - reconnect_numericVar_0638 >= 2, randomOrder = math.random() })
					end
				end

				nextPageCursor = type(result.nextPageCursor) == "string" and result.nextPageCursor ~= "" and result.nextPageCursor or nil
				if nextPageCursor then
					continue
				end
			end

			break
		end

		table.sort(espTable_configTable_0631, function(reconnect_param_0640, reconnect_param_0641)
			if reconnect_param_0640.safe ~= reconnect_param_0641.safe then
				return reconnect_param_0640.safe
			end

			if reconnect_param_0640.playing ~= reconnect_param_0641.playing then
				return reconnect_param_0640.playing > reconnect_param_0641.playing
			end
			return reconnect_param_0640.randomOrder < reconnect_param_0641.randomOrder
		end)

		return espTable_configTable_0631
	end

	Hub.CoinFarm.TryServerTeleport = function(reconnect_param_0642, reconnect_param_0643, reconnect_param_0644)
		local reconnect_boolFlag_0645 = false
		local reconnect_boolFlag_0646 = false
		local bindableEvent = Instance.new("BindableEvent")

		local function reconnect_helperFunc_0647(reconnect_param_0648)
			if reconnect_boolFlag_0645 then
				return
			end
			reconnect_boolFlag_0645 = true
			reconnect_boolFlag_0646 = reconnect_param_0648 == true
			bindableEvent:Fire()
		end

		local reconnect_configTable_0649 = {
			localPlayer.OnTeleport:Connect(function(reconnect_param_0650)
				if reconnect_param_0650 == Enum.TeleportState.Started or reconnect_param_0650 == Enum.TeleportState.WaitingForServer or reconnect_param_0650 == Enum.TeleportState.InProgress then
					reconnect_helperFunc_0647(true)
				elseif reconnect_param_0650 == Enum.TeleportState.Failed then
					reconnect_helperFunc_0647(false)
				end
			end),
			(TeleportService.TeleportInitFailed:Connect(function(reconnect_param_0651)
				if reconnect_param_0651 == localPlayer then
					reconnect_helperFunc_0647(false)
				end
			end)),
		}

		task.delay(math.max(3, tonumber(reconnect_param_0644) or 8), function()
			reconnect_helperFunc_0647(false)
		end)

		if not pcall(function()
			if type(reconnect_param_0643) == "string" and reconnect_param_0643 ~= "" then
				TeleportService:TeleportToPlaceInstance(reconnect_param_0642, reconnect_param_0643, localPlayer)
			else
				TeleportService:Teleport(reconnect_param_0642, localPlayer)
			end
		end) then
			reconnect_helperFunc_0647(false)
		end

		if not reconnect_boolFlag_0645 then
			bindableEvent.Event:Wait()
		end

		for _, reconnect_loopVar_0652 in ipairs(reconnect_configTable_0649) do
			if reconnect_loopVar_0652.Connected then
				reconnect_loopVar_0652:Disconnect()
			end
		end

		bindableEvent:Destroy()
		return reconnect_boolFlag_0646
	end

	Hub.CoinFarm.StartLowPlayerServerHop = function()
		local serverHopRunning = Hub.CoinFarm.serverHopRunning or not Hub.CoinFarm.enabled or not Hub.CoinFarm.serverHopLowPlayers or Hub.RoundState.active

		if not serverHopRunning then
			local serverHopPlayerThreshold = Hub.CoinFarm.serverHopPlayerThreshold
			serverHopRunning = #Players:GetPlayers() > serverHopPlayerThreshold
		end

		if serverHopRunning then
			return false
		end
		Hub.CoinFarm.serverHopRunning = true
		Hub.CoinFarm.serverHopTimerStartedAt = os.clock()
		Hub.CoinFarm.SetPhase("Server hopping")
		Hub.CoinFarm.ReportServerHop("Low player server")

		task.spawn(function()
			espTable_helperFunc_0622()
			Hub.CoinFarm.failedServerJobIds = Hub.CoinFarm.failedServerJobIds or {}
			local failedServerJobIds = Hub.CoinFarm.failedServerJobIds
			local reconnect_fetchServerCandidatesValue_0653 = Hub.CoinFarm.FetchServerCandidates(game.PlaceId, failedServerJobIds, 2)

			for i = 1, math.min(#reconnect_fetchServerCandidatesValue_0653, 8) do
				if not Hub.CoinFarm.enabled or not Hub.CoinFarm.serverHopLowPlayers then
					Hub.CoinFarm.serverHopRunning = false
					return
				end
				local id = reconnect_fetchServerCandidatesValue_0653[i].id
				failedServerJobIds[id] = true

				if Hub.CoinFarm.TryServerTeleport(game.PlaceId, id, 7) then
					local jobId = game.JobId

					task.delay(15, function()
						if game.JobId == jobId then
							Hub.CoinFarm.serverHopRunning = false
						end
					end)

					return
				end

				task.wait(2)
			end

			if Hub.CoinFarm.enabled and Hub.CoinFarm.serverHopLowPlayers then
				if Hub.CoinFarm.TryServerTeleport(game.PlaceId, nil, 8) then
					local jobId = game.JobId

					task.delay(15, function()
						if game.JobId == jobId then
							Hub.CoinFarm.serverHopRunning = false
						end
					end)

					return
				end
			end

			Hub.CoinFarm.serverHopRunning = false
		end)

		return true
	end

	Hub.CoinFarm.CountLikelyBotPlayers = function()
		local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
		playerGui = playerGui and playerGui:FindFirstChild("MainGUI")
		playerGui = playerGui and playerGui:FindFirstChild("Game")
		playerGui = playerGui and playerGui:FindFirstChild("Leaderboard")
		playerGui = playerGui and playerGui:FindFirstChild("Container")
		local reconnect_configTable_0654 = { I = 1, II = 2, III = 3, IV = 4, V = 5, VI = 6, VII = 7, VIII = 8, IX = 9, X = 10 }
		Hub.CoinFarm.antiBotSamples = Hub.CoinFarm.antiBotSamples or {}
		local antiBotSamples = Hub.CoinFarm.antiBotSamples
		local now = os.clock()
		local antiBotLastCount = 0

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer then
				local reconnect_numericVar_0655 = tonumber(player:GetAttribute("Level"))
				local reconnect_numericVar_0656 = tonumber(player:GetAttribute("Prestige"))

				if reconnect_numericVar_0655 == nil or reconnect_numericVar_0656 == nil then
					local level = playerGui and playerGui:FindFirstChild(player.Name)
					level = level and level:FindFirstChild("Level")
					local level2 = level and level:FindFirstChild("Level")
					level = level and level:FindFirstChild("Prestige")

					if reconnect_numericVar_0655 == nil and level2 and level2:IsA("TextLabel") then
						reconnect_numericVar_0655 = tonumber(tostring(level2.Text):match("%d+"))
					end

					if reconnect_numericVar_0656 == nil and level and level:IsA("TextLabel") then
						local match = tostring(level.Text or ""):upper():match("^%s*(.-)%s*$")
						reconnect_numericVar_0656 = match == "" and 0 or reconnect_configTable_0654[match]
					end
				end

				local reconnect_dataTable_0657 = antiBotSamples[player]

				if type(reconnect_dataTable_0657) ~= "table" then
					reconnect_dataTable_0657 = { score = 0, observations = 0, lastPosition = nil, lastAt = now }
					antiBotSamples[player] = reconnect_dataTable_0657
				end

				local character_ = player.Character
				local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
				character_ = character_ and character_:FindFirstChild("HumanoidRootPart")

				if character_ and humanoid and humanoid.Health > 0 then
					local reconnect_numericVar_0658 = math.max(0.05, now - (reconnect_dataTable_0657.lastAt or now))
					local magnitude = reconnect_dataTable_0657.lastPosition and (character_.Position - reconnect_dataTable_0657.lastPosition).Magnitude or 0
					local reconnect_numericVar_0659 = magnitude / reconnect_numericVar_0658
					local huge = math.huge
					local reconnect_boolFlag_0660 = false

					for k in pairs(Hub.CoinFarm.coins) do
						if Hub.CoinFarm.IsCoinAvailable(k) then
							local magnitude2 = (character_.Position - k.Position).Magnitude

							if magnitude2 < huge then
								reconnect_boolFlag_0660 = character_.Position.Y < k.Position.Y - 4
								huge = magnitude2
							end
						end
					end

					if reconnect_dataTable_0657.lastPosition then
						reconnect_dataTable_0657.observations = reconnect_dataTable_0657.observations + 1

						if huge <= 7 and reconnect_numericVar_0659 >= 9 or magnitude >= 18 and reconnect_numericVar_0659 >= 18 or reconnect_boolFlag_0660 and huge <= 12 and reconnect_numericVar_0659 >= 7 then
							reconnect_dataTable_0657.score = math.min(12, reconnect_dataTable_0657.score + 2)
						else
							reconnect_dataTable_0657.score = math.max(0, reconnect_dataTable_0657.score - 0.5)
						end
					end

					reconnect_dataTable_0657.lastPosition = character_.Position
					reconnect_dataTable_0657.lastAt = now
				else
					reconnect_dataTable_0657.score = math.max(0, reconnect_dataTable_0657.score - 1)
					reconnect_dataTable_0657.lastPosition = nil
					reconnect_dataTable_0657.lastAt = now
				end

				local reconnect_boolFlag_0661 = reconnect_numericVar_0655 and reconnect_numericVar_0655 >= 1 and reconnect_numericVar_0655 <= 30 and reconnect_numericVar_0656 == 0
				local reconnect_boolFlag_0662 = reconnect_dataTable_0657.observations >= 2

				if reconnect_boolFlag_0662 then
					reconnect_boolFlag_0662 = reconnect_dataTable_0657.score >= (reconnect_boolFlag_0661 and 4 or 6)
				end

				if reconnect_boolFlag_0662 then
					antiBotLastCount += 1
				end
			end
		end

		for k in pairs(antiBotSamples) do
			if k.Parent ~= Players then
				antiBotSamples[k] = nil
			end
		end

		Hub.CoinFarm.antiBotLastCount = antiBotLastCount
		return antiBotLastCount
	end

	Hub.CoinFarm.StartAntiBotServerHop = function()
		if Hub.CoinFarm.serverHopRunning or not Hub.CoinFarm.enabled or not Hub.CoinFarm.antiBotEnabled or Hub.CoinFarm.CountLikelyBotPlayers() < 4 then
			return false
		end
		Hub.CoinFarm.serverHopRunning = true
		Hub.CoinFarm.serverHopTimerStartedAt = os.clock()
		Hub.CoinFarm.SetPhase("Anti Bot: Server hopping")
		Hub.CoinFarm.ReportServerHop("Bot server detected")

		task.spawn(function()
			espTable_helperFunc_0622()
			local reconnect_configTable_0663 = {}
			local reconnect_fetchServerCandidatesValue_0664 = Hub.CoinFarm.FetchServerCandidates(game.PlaceId, reconnect_configTable_0663, 3)

			for i = 1, math.min(#reconnect_fetchServerCandidatesValue_0664, 12) do
				if not Hub.CoinFarm.enabled or not Hub.CoinFarm.antiBotEnabled then
					Hub.CoinFarm.serverHopRunning = false
					return
				end
				local id = reconnect_fetchServerCandidatesValue_0664[i].id
				reconnect_configTable_0663[id] = true

				if Hub.CoinFarm.TryServerTeleport(game.PlaceId, id, 7) then
					task.delay(15, function()
						if foxnameMM2Runtime.alive and Hub.CoinFarm.enabled then
							Hub.CoinFarm.serverHopRunning = false
						end
					end)

					return
				end

				task.wait(1.5)
			end

			if Hub.CoinFarm.enabled and Hub.CoinFarm.antiBotEnabled then
				if Hub.CoinFarm.TryServerTeleport(game.PlaceId, nil, 8) then
					task.delay(15, function()
						if foxnameMM2Runtime.alive and Hub.CoinFarm.enabled then
							Hub.CoinFarm.serverHopRunning = false
						end
					end)

					return
				end
			end

			Hub.CoinFarm.serverHopRunning = false
		end)

		return true
	end

	Hub.CoinFarm.StartTimerServerHop = function(reconnect_param_0665, reconnect_param_0666)
		if Hub.CoinFarm.serverHopRunning or not Hub.CoinFarm.enabled then
			return false
		end
		Hub.CoinFarm.serverHopRunning = true
		Hub.CoinFarm.serverHopTimerStartedAt = os.clock()
		Hub.CoinFarm.SetPhase(reconnect_param_0666 or "Timer: Server hopping")
		Hub.CoinFarm.ReportServerHop(reconnect_param_0665 or "Server hop timer")

		task.spawn(function()
			espTable_helperFunc_0622()
			local reconnect_configTable_0667 = {}
			local reconnect_fetchServerCandidatesValue_0668 = Hub.CoinFarm.FetchServerCandidates(game.PlaceId, reconnect_configTable_0667, 3)

			for i = 1, math.min(#reconnect_fetchServerCandidatesValue_0668, 12) do
				if not Hub.CoinFarm.enabled then
					Hub.CoinFarm.serverHopRunning = false
					return
				end
				local id = reconnect_fetchServerCandidatesValue_0668[i].id
				reconnect_configTable_0667[id] = true

				if Hub.CoinFarm.TryServerTeleport(game.PlaceId, id, 7) then
					task.delay(15, function()
						if foxnameMM2Runtime.alive and Hub.CoinFarm.enabled then
							Hub.CoinFarm.serverHopRunning = false
							Hub.CoinFarm.serverHopTimerStartedAt = os.clock()
						end
					end)

					return
				end

				task.wait(1.5)
			end

			if Hub.CoinFarm.enabled and Hub.CoinFarm.TryServerTeleport(game.PlaceId, nil, 8) then
				task.delay(15, function()
					if foxnameMM2Runtime.alive and Hub.CoinFarm.enabled then
						Hub.CoinFarm.serverHopRunning = false
						Hub.CoinFarm.serverHopTimerStartedAt = os.clock()
					end
				end)

				return
			end

			Hub.CoinFarm.serverHopRunning = false
			Hub.CoinFarm.serverHopTimerStartedAt = os.clock()
		end)

		return true
	end

	task.spawn(function()
		while foxnameMM2Runtime.alive and not isTerminated do
			if Hub.CoinFarm.enabled and Hub.CoinFarm.antiBotEnabled and not Hub.CoinFarm.serverHopRunning then
				Hub.CoinFarm.StartAntiBotServerHop()
			end

			task.wait(3)
		end
	end)

	task.spawn(function()
		while foxnameMM2Runtime.alive and not isTerminated do
			if Hub.CoinFarm.enabled and not Hub.CoinFarm.serverHopRunning then
				if Hub.CoinFarm.serverHopTimerStartedAt <= 0 then
					Hub.CoinFarm.serverHopTimerStartedAt = os.clock()
				end

				local clamp = math.clamp
				local reconnect_serverHopTimerMinutesValue_0669 = tonumber(Hub.CoinFarm.serverHopTimerMinutes) or 15
				local serverHopTimerStartedAt = Hub.CoinFarm.serverHopTimerStartedAt

				if clamp(reconnect_serverHopTimerMinutesValue_0669, 10, 30) * 60 <= os.clock() - serverHopTimerStartedAt then
					Hub.CoinFarm.StartTimerServerHop()
				end
			end

			task.wait(1)
		end
	end)

	task.spawn(function()
		while foxnameMM2Runtime.alive and not isTerminated and not Hub.CoinFarm.resumedFromServerHop do
			task.wait(0.5)
		end

		if not foxnameMM2Runtime.alive or UserInputService.TouchEnabled or not UserInputService.KeyboardEnabled then
			return
		end
		task.wait(8)
		local CoreGui = nil

		pcall(function()
			CoreGui = game:GetService("CoreGui")
		end)

		local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")

		local function reconnect_helperFunc_0670(reconnect_param_0671, reconnect_param_0672)
			while reconnect_param_0671 and reconnect_param_0671 ~= reconnect_param_0672 do
				if reconnect_param_0671:IsA("GuiObject") and not reconnect_param_0671.Visible then
					return false
				end

				if reconnect_param_0671:IsA("LayerCollector") and not reconnect_param_0671.Enabled then
					return false
				end
				reconnect_param_0671 = reconnect_param_0671.Parent
			end

			return reconnect_param_0671 == reconnect_param_0672
		end

		local function reconnect_helperFunc_0673()
			playerGui = localPlayer:FindFirstChildOfClass("PlayerGui") or playerGui
			local joinPhone = playerGui and playerGui:FindFirstChild("JoinPhone")
			if joinPhone and reconnect_helperFunc_0670(joinPhone, playerGui) then
				return true
			end
			local touchGui = CoreGui and CoreGui:FindFirstChild("TouchGui", true)
			if not touchGui or not reconnect_helperFunc_0670(touchGui, CoreGui) then
				return false
			end
			local touchControlFrame = touchGui:FindFirstChild("TouchControlFrame", true)
			if touchControlFrame and reconnect_helperFunc_0670(touchControlFrame, CoreGui) then
				return true
			end

			for _, descendant in ipairs(touchGui:GetDescendants()) do
				if descendant:IsA("GuiButton") and reconnect_helperFunc_0670(descendant, CoreGui) then
					return true
				end
			end

			return false
		end

		local reconnect_timestamp_0674 = os.clock() + 40
		local reconnect_numericVar_0675 = 0

		while foxnameMM2Runtime.alive and not isTerminated and Hub.CoinFarm.enabled and os.clock() < reconnect_timestamp_0674 do
			if reconnect_helperFunc_0673() then
				reconnect_numericVar_0675 += 1
				if reconnect_numericVar_0675 >= 4 then
					Hub.CoinFarm.StartTimerServerHop("检测到移动端控件异常", "Device UI mismatch: Server hopping")
					return
				end
			else
				reconnect_numericVar_0675 = 0
			end

			task.wait(0.75)
		end
	end)

	local reconnect_optionalValue_0676 = nil

	reconnect_optionalValue_0676 = function(reconnect_param_0677)
		if Hub.CoinFarmKickRecoveryStarted or Hub.SuppressCoinFarmKickRecovery or not Hub.CoinFarm.enabled then
			return
		end

		if Hub.CoinFarm.serverHopRunning and not reconnect_param_0677 then
			return
		end
		Hub.CoinFarm.serverHopRunning = false
		Hub.CoinFarm.serverHopTimerStartedAt = os.clock()
		Hub.CoinFarmKickRecoveryStarted = true
		Hub.CoinFarm.SetPhase("连接断开：正在换服")
		Hub.CoinFarm.ReportServerHop("因位置异常被踢出")
		local reconnect_callResult_0678, reconnect_callResult_0679 = espTable_helperFunc_0622()

		if not reconnect_callResult_0678 then
			warn("[Foxname] Coin Farm re-execute queue failed: " .. tostring(reconnect_callResult_0679))
		end

		local placeId = game.PlaceId

		task.spawn(function()
			local reconnect_configTable_0680 = {}
			local reconnect_configTable_0681 = {}
			local reconnect_numericVar_0682 = 1

			for i = 1, 30 do
				if not Hub.CoinFarm.enabled or Hub.SuppressCoinFarmKickRecovery then
					break
				end

				if reconnect_numericVar_0682 > math.min(#reconnect_configTable_0681, 12) then
					reconnect_numericVar_0682 = 1
					reconnect_configTable_0681 = Hub.CoinFarm.FetchServerCandidates(placeId, reconnect_configTable_0680, 2)
				end

				local reconnect_optionalValue_0683 = nil

				if reconnect_configTable_0681[reconnect_numericVar_0682] then
					local id = reconnect_configTable_0681[reconnect_numericVar_0682].id
					reconnect_numericVar_0682 += 1
					reconnect_configTable_0680[id] = true
					reconnect_optionalValue_0683 = id
				end

				if Hub.CoinFarm.TryServerTeleport(placeId, reconnect_optionalValue_0683, 8) then
					task.delay(15, function()
						if Hub.CoinFarm.enabled then
							Hub.CoinFarmKickRecoveryStarted = false
							task.defer(reconnect_optionalValue_0676)
						end
					end)

					return
				end

				task.wait(i < 3 and 5 or i < 10 and 12 or 30)
			end

			Hub.CoinFarmKickRecoveryStarted = false
		end)
	end

	if GuiService and GuiService.ErrorMessageChanged then
		trackConn(GuiService.ErrorMessageChanged:Connect(function(reconnect_param_0684)
			local reconnect_localValue_0685 = string.lower(tostring(reconnect_param_0684 or ""))

			if reconnect_localValue_0685:match("%S") and Hub.CoinFarm.enabled and not Hub.SuppressCoinFarmKickRecovery then
				task.defer(reconnect_optionalValue_0676, (reconnect_localValue_0685:find("invalid position", 1, true) or reconnect_localValue_0685:find("error code: 267", 1, true) or reconnect_localValue_0685:find("error code 267", 1, true)) and true or false)
			end
		end))
	end

	task.spawn(function()
		local CoreGui = nil

		pcall(function()
			CoreGui = game:GetService("CoreGui")
		end)

		while foxnameMM2Runtime.alive and not isTerminated do
			if Hub.CoinFarm.enabled and not Hub.SuppressCoinFarmKickRecovery and not Hub.CoinFarmKickRecoveryStarted then
				local reconnect_textValue_0686 = ""

				pcall(function()
					if type(GuiService.GetErrorMessage) == "function" then
						reconnect_textValue_0686 = tostring(GuiService:GetErrorMessage() or "")
					end
				end)

				local reconnect_localValue_0687 = string.lower(reconnect_textValue_0686)
				local pos = reconnect_localValue_0687:find("invalid position", 1, true) or reconnect_localValue_0687:find("error code: 267", 1, true) or reconnect_localValue_0687:find("error code 267", 1, true)

				if pos or pos then
					task.defer(reconnect_optionalValue_0676, true)
				end
			end

			task.wait(0.25)
		end
	end)

	local function reconnect_helperFunc_0688(reconnect_param_0689, reconnect_param_0690, reconnect_param_0691)
		Hub.SuppressCoinFarmKickRecovery = true
		local reconnect_callResult_0692, reconnect_callResult_0693 = espTable_helperFunc_0622()

		if not reconnect_callResult_0692 then
			warn("[Foxname] Re-execute queue failed: " .. tostring(reconnect_callResult_0693))
		end

		local placeId = tonumber(reconnect_param_0690) or game.PlaceId
		local reconnect_callResult_0694 = tostring(reconnect_param_0691 or "")

		if reconnect_callResult_0694 == "" then
			reconnect_callResult_0694 = tostring(game.JobId or "")
		end

		local reconnect_boolFlag_0695 = false
		local reconnect_boolFlag_0696 = false
		local reconnect_numericVar_0697 = 0
		local reconnect_optionalValue_0698 = nil

		local function reconnect_helperFunc_0699(reconnect_param_0700)
			local reconnect_localValue_0701 = reconnect_boolFlag_0695
			local xray_localValue_0702

			if reconnect_boolFlag_0695 then
				xray_localValue_0702 = reconnect_localValue_0701
			else
				xray_localValue_0702 = reconnect_boolFlag_0696
			end

			if xray_localValue_0702 then
				return
			end
			reconnect_boolFlag_0696 = true

			task.delay(reconnect_param_0700 or 1.5, function()
				reconnect_boolFlag_0696 = false

				if not reconnect_boolFlag_0695 then
					reconnect_optionalValue_0698()
				end
			end)
		end

		trackConn(localPlayer.OnTeleport:Connect(function(xray_param_0703)
			if xray_param_0703 == Enum.TeleportState.Started or xray_param_0703 == Enum.TeleportState.InProgress then
				reconnect_boolFlag_0695 = true
			elseif xray_param_0703 == Enum.TeleportState.Failed then
				reconnect_boolFlag_0695 = false
				reconnect_helperFunc_0699(1)
			end
		end))

		trackConn(TeleportService.TeleportInitFailed:Connect(function(xray_param_0704)
			if xray_param_0704 == localPlayer then
				reconnect_boolFlag_0695 = false
				reconnect_helperFunc_0699(1)
			end
		end))

		trackConn(GuiService.ErrorMessageChanged:Connect(function(xray_param_0705)
			if tostring(xray_param_0705 or ""):match("%S") and not reconnect_boolFlag_0695 then
				task.defer(reconnect_optionalValue_0698)
			end
		end))

		reconnect_optionalValue_0698 = function()
			if reconnect_boolFlag_0695 then
				return
			end
			reconnect_numericVar_0697 += 1
			local xray_boolFlag_0706 = false

			if reconnect_callResult_0694 ~= "" then
				xray_boolFlag_0706 = pcall(function()
					TeleportService:TeleportToPlaceInstance(placeId, reconnect_callResult_0694, localPlayer)
				end)
			end

			if not xray_boolFlag_0706 and reconnect_numericVar_0697 >= 6 then
				pcall(function()
					TeleportService:Teleport(placeId, localPlayer)
				end)
			end

			if not reconnect_boolFlag_0695 then
				reconnect_helperFunc_0699(reconnect_numericVar_0697 < 6 and 1.5 or 2.5)
			end
		end

		WindUI:Notify({
			Title = "正在重连服务器",
			Content = "正在重新加入原服务器…",
			Icon = "refresh-cw",
			Duration = 3,
		})

		task.delay(0.35, function()
			if not reconnect_boolFlag_0695 then
				reconnect_optionalValue_0698()
			end
		end)

		FoxnameKickPlayer(localPlayer, reconnect_param_0689)
	end

	Hub.RunBombJump = function()
		local bombJump = Hub.BombJump
		local now = os.clock()
		if bombJump.busy then
			return false
		end

		if now < bombJump.nextReadyAt then
			WindUI:Notify({
				Title = "炸弹跳",
				Content = string.format("%.1f 秒后就绪", bombJump.nextReadyAt - now),
				Icon = "clock",
				Duration = 1.5,
			})

			return false
		end

		local character_ = localPlayer.Character
		local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = character_ and character_:FindFirstChild("HumanoidRootPart")
		local backpack = localPlayer:FindFirstChildOfClass("Backpack")
		if not character_ or not humanoid or not humanoidRootPart or not backpack or humanoid.Health <= 0 then
			return false
		end

		if humanoid.FloorMaterial ~= Enum.Material.Air then
			WindUI:Notify({
				Title = "炸弹跳",
				Content = "先起跳，然后在空中触发炸弹跳。",
				Icon = "info",
				Duration = 1.8,
			})

			return false
		end

		local fakeBomb = character_:FindFirstChild("FakeBomb") or backpack:FindFirstChild("FakeBomb")
		if not fakeBomb or not fakeBomb:IsA("Tool") then
			WindUI:Notify({ Title = "炸弹跳", Content = "假炸弹不可用", Icon = "x", Duration = 2 })
			return false
		end
		local remote = fakeBomb:FindFirstChild("Remote")
		if not remote or not remote:IsA("RemoteEvent") then
			WindUI:Notify({ Title = "炸弹跳", Content = "未找到假炸弹远程事件", Icon = "x", Duration = 2 })
			return false
		end
		bombJump.busy = true
		bombJump.nextReadyAt = now + bombJump.cooldown

		task.spawn(function()
			local tool = character_:FindFirstChildOfClass("Tool")
			local client = fakeBomb:FindFirstChild("Client")
			local disabled = nil

			if client and client:IsA("LocalScript") then
				disabled = client.Disabled

				pcall(function()
					client.Disabled = true
				end)
			end

			local connection = nil
			local connection2 = nil
			local connection3 = nil
			local xray_optionalValue_0707 = nil
			local xray_boolFlag_0708 = false

			local function xray_helperFunc_0709()
				if connection then
					connection:Disconnect()
					connection = nil
				end

				if connection2 then
					connection2:Disconnect()
					connection2 = nil
				end

				if connection3 then
					connection3:Disconnect()
					connection3 = nil
				end
			end

			local function xray_helperFunc_0710(xray_param_0711)
				if not xray_param_0711 or not xray_param_0711:IsA("BasePart") or xray_param_0711.Name ~= "Handle" then
					return false
				end

				if not xray_param_0711:IsDescendantOf(workspace) or (xray_param_0711.Position - humanoidRootPart.Position).Magnitude > 60 then
					return false
				end
				return xray_param_0711:FindFirstChild("Fuse") or xray_param_0711:FindFirstChild("Beep") or xray_param_0711:FindFirstChild("PleaseNo") or xray_param_0711:FindFirstChild("Smoke")
			end

			local function xray_helperFunc_0712(xray_param_0713)
				if xray_optionalValue_0707 or not xray_helperFunc_0710(xray_param_0713) then
					return
				end
				xray_optionalValue_0707 = xray_param_0713
			end

			local ok, result = pcall(function()
				humanoid:EquipTool(fakeBomb)
				task.wait()

				if fakeBomb.Parent ~= character_ then
					error("无法装备假炸弹")
				end

				local moveDirection = humanoid.MoveDirection
				local vector

				if moveDirection.Magnitude < 0.05 then
					vector = Vector3.new(humanoidRootPart.CFrame.LookVector.X, 0, humanoidRootPart.CFrame.LookVector.Z)
				else
					vector = Vector3.new(moveDirection.X, 0, moveDirection.Z)
				end

				if vector.Magnitude < 0.05 then
					vector = Vector3.new(0, 0, -1)
				end

				local unit = vector.Unit
				local vector2 = Vector3.new(-unit.Z, 0, unit.X)
				local raycastParams = RaycastParams.new()
				raycastParams.FilterType = Enum.RaycastFilterType.Exclude
				raycastParams.FilterDescendantsInstances = { character_ }
				raycastParams.IgnoreWater = true
				local hit = workspace:Raycast(humanoidRootPart.Position, Vector3.new(0, -24, 0), raycastParams)
				local xray_numericVar_0714 = (hit and humanoidRootPart.Position.Y - hit.Position.Y or math.huge) <= 8 and -0.24 or -0.73
				local unit2 = (unit * math.sqrt(1 - xray_numericVar_0714 * xray_numericVar_0714) + Vector3.new(0, xray_numericVar_0714, 0)).Unit
				local xray_vectorValue_0715 = humanoidRootPart.Position + vector2 * 1.75 + Vector3.new(0, 0.8, 0) - unit2 * 13.6
				local raycastParams2 = RaycastParams.new()
				raycastParams2.FilterType = Enum.RaycastFilterType.Exclude
				raycastParams2.FilterDescendantsInstances = { character_ }
				raycastParams2.IgnoreWater = true
				local hit2 = workspace:Raycast(xray_vectorValue_0715, unit2 * 1000, raycastParams2)
				local position = hit2 and hit2.Position or xray_vectorValue_0715 + unit2 * 1000
				local cframe = CFrame.lookAt(position, position + unit2)

				connection = workspace.ChildAdded:Connect(function(child)
					if child:IsA("BasePart") and child.Name == "Handle" then
						task.defer(function()
							local xray_timestamp_0716 = os.clock() + 0.25

							while true do
								if xray_helperFunc_0710(child) then
									xray_helperFunc_0712(child)
									return
								else
									task.wait()
									if os.clock() >= xray_timestamp_0716 or not child.Parent then
										break
									end
								end
							end
						end)
					end
				end)

				connection2 = workspace.DescendantAdded:Connect(function(descendant)
					if descendant.Name == "Fuse" or descendant.Name == "Beep" or descendant.Name == "PleaseNo" or descendant.Name == "Smoke" then
						xray_helperFunc_0712(descendant.Parent)
					end
				end)

				remote:FireServer(cframe, 50)
				local xray_timestamp_0717 = os.clock() + 0.85

				while true do
					task.wait()
					if not (xray_optionalValue_0707 or os.clock() >= xray_timestamp_0717) then
						continue
					end
					break
				end

				if not xray_optionalValue_0707 then
					return
				end

				connection3 = xray_optionalValue_0707.Touched:Connect(function(hit3)
					if hit3 and hit3:IsDescendantOf(character_) then
						xray_boolFlag_0708 = true
					end
				end)

				local VirtualInputManager = nil

				if not UserInputService.TouchEnabled then
					pcall(function()
						VirtualInputManager = game:GetService("VirtualInputManager")
					end)
				end

				local xray_timestamp_0718 = os.clock() + 0.48
				local now2 = nil

				while not (humanoid.Health <= 0 or not humanoidRootPart.Parent) do
					humanoid.Jump = true

					if humanoid.FloorMaterial ~= Enum.Material.Air then
						humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
					end

					if VirtualInputManager then
						pcall(function()
							VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
							VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
						end)
					end

					if xray_boolFlag_0708 and not now2 then
						now2 = os.clock()
					end

					task.wait(0.03)
					if os.clock() >= xray_timestamp_0718 or now2 and os.clock() - now2 >= 0.1 then
						break
					end
				end
			end)

			xray_helperFunc_0709()

			if fakeBomb and fakeBomb.Parent == character_ then
				pcall(function()
					humanoid:UnequipTools()
				end)
			end

			if tool and tool.Parent and tool ~= fakeBomb then
				pcall(function()
					humanoid:EquipTool(tool)
				end)
			end

			if client and client.Parent and disabled ~= nil then
				pcall(function()
					client.Disabled = disabled
				end)
			end

			bombJump.busy = false

			if not ok then
				bombJump.nextReadyAt = 0
				WindUI:Notify({ Title = "炸弹跳", Content = tostring(result), Icon = "x", Duration = 2 })
			end
		end)

		return true
	end

	local function xray_helperFunc_0719(xray_param_0720)
	end

	local function xray_helperFunc_0721(xray_param_0722)
	end

end

do
	local function xray_helperFunc_0723()
		Hub.XRayScanGeneration = Hub.XRayScanGeneration + 1

		for k, xray_loopVar_0724 in pairs(Hub.XRayOriginal) do
			if k and k.Parent then
				pcall(function()
					k.LocalTransparencyModifier = xray_loopVar_0724
				end)
			end

			Hub.XRayOriginal[k] = nil
		end

		Hub.XRayMap = nil
	end

	local function xray_helperFunc_0725()
		if not Hub.RoundState.active then
			return nil
		end
		local currentMapInstance = Hub.RoundState.currentMapInstance
		local lobby = workspace:FindFirstChild("Lobby")
		local xray_boolFlag_0726 = currentMapInstance and currentMapInstance.Parent and currentMapInstance:IsDescendantOf(workspace) and currentMapInstance ~= lobby

		if xray_boolFlag_0726 then
			xray_boolFlag_0726 = not (lobby and currentMapInstance:IsDescendantOf(lobby))
		end

		if xray_boolFlag_0726 then
			return currentMapInstance
		end
		local currentMapName = Hub.RoundState.currentMapName

		if type(currentMapName) == "string" and currentMapName ~= "" then
			local xray_textValue_0727 = currentMapName:lower():gsub("[^%w]", "")

			for _, child in ipairs(workspace:GetChildren()) do
				if child ~= lobby and (child:IsA("Model") or child:IsA("Folder")) and child.Name:lower():gsub("[^%w]", "") == xray_textValue_0727 then
					Hub.RoundState.currentMapInstance = child
					return child
				end
			end
		end

		for _, child in ipairs(workspace:GetChildren()) do
			if child ~= lobby and (child:IsA("Model") or child:IsA("Folder")) and (child:FindFirstChild("CoinContainer", true) or child:FindFirstChild("Coin_Server", true)) then
				Hub.RoundState.currentMapInstance = child
				Hub.RoundState.currentMapName = child.Name
				return child
			end
		end

		return nil
	end

	local function xray_helperFunc_0728(xray_param_0729)
		if not Hub.XRayEnabled or not Hub.XRayMap or not xray_param_0729:IsA("BasePart") or xray_param_0729.Name == "Coin_Server" or xray_param_0729.Transparency >= 1 then
			return
		end

		if Hub.XRayOriginal[xray_param_0729] == nil then
			Hub.XRayOriginal[xray_param_0729] = xray_param_0729.LocalTransparencyModifier
		end

		xray_param_0729.LocalTransparencyModifier = math.clamp((Hub.WorldFeatureConfig.xrayTransparency - xray_param_0729.Transparency) / (1 - xray_param_0729.Transparency), 0, 1)
	end

	local function xray_helperFunc_0730()
		if not Hub.XRayEnabled then
			return
		end
		local xray_callResult_0731 = xray_helperFunc_0725()
		if not xray_callResult_0731 then
			return
		end

		if Hub.XRayMap ~= xray_callResult_0731 then
			xray_helperFunc_0723()
			if not Hub.XRayEnabled then
				return
			end
			Hub.XRayMap = xray_callResult_0731
		else
			Hub.XRayScanGeneration = Hub.XRayScanGeneration + 1
		end

		local xRayScanGeneration = Hub.XRayScanGeneration

		task.spawn(function()
			for i, descendant in ipairs(xray_callResult_0731:GetDescendants()) do
				if not Hub.XRayEnabled or Hub.XRayScanGeneration ~= xRayScanGeneration or Hub.XRayMap ~= xray_callResult_0731 then
					return
				end
				xray_helperFunc_0728(descendant)

				if i % 300 == 0 then
					RunService.Heartbeat:Wait()
				end
			end
		end)
	end

	local function xray_helperFunc_0732()
		Hub.XRayEnabled = false

		if Hub.XRayConn then
			Hub.XRayConn:Disconnect()
			Hub.XRayConn = nil
		end

		if Hub.XRayRemoveConn then
			Hub.XRayRemoveConn:Disconnect()
			Hub.XRayRemoveConn = nil
		end

		if Hub.XRayRefreshConn then
			Hub.XRayRefreshConn:Disconnect()
			Hub.XRayRefreshConn = nil
		end

		xray_helperFunc_0723()
	end

	local function xray_helperFunc_0733(xray_param_0734)
		Hub.XRayEnabled = xray_param_0734 and true or false
		if not Hub.XRayEnabled then
			xray_helperFunc_0732()
			return
		end
		xray_helperFunc_0730()

		if Hub.XRayConn then
			Hub.XRayConn:Disconnect()
		end

		Hub.XRayConn = workspace.DescendantAdded:Connect(function(descendant)
			if not Hub.XRayEnabled then
				return
			end

			if Hub.XRayMap and descendant:IsDescendantOf(Hub.XRayMap) then
				xray_helperFunc_0728(descendant)
			else
				local xray_boolFlag_0735 = descendant.Parent == workspace
				local isModel

				if xray_boolFlag_0735 then
					isModel = descendant:IsA("Model") or descendant:IsA("Folder")
				else
					isModel = xray_boolFlag_0735
				end

				if isModel then
					task.delay(0.25, function()
						if not Hub.XRayEnabled then
							return
						end
						local xray_callResult_0736 = xray_helperFunc_0725()

						if xray_callResult_0736 and xray_callResult_0736 ~= Hub.XRayMap then
							xray_helperFunc_0730()
						end
					end)
				end
			end
		end)

		if Hub.XRayRemoveConn then
			Hub.XRayRemoveConn:Disconnect()
		end

		Hub.XRayRemoveConn = workspace.ChildRemoved:Connect(function(child)
			if Hub.XRayEnabled and child == Hub.XRayMap then
				xray_helperFunc_0723()
			end
		end)

		if Hub.XRayRefreshConn then
			Hub.XRayRefreshConn:Disconnect()
		end

		local xray_numericVar_0737 = 0

		Hub.XRayRefreshConn = RunService.Heartbeat:Connect(function(deltaTime)
			if not Hub.XRayEnabled then
				return
			end
			xray_numericVar_0737 += deltaTime
			if xray_numericVar_0737 < 0.5 then
				return
			end
			xray_numericVar_0737 = 0
			local xray_callResult_0738 = xray_helperFunc_0725()

			if xray_callResult_0738 ~= Hub.XRayMap then
				if xray_callResult_0738 then
					xray_helperFunc_0730()
				elseif Hub.XRayMap then
					xray_helperFunc_0723()
				end
			end
		end)
	end

	Hub.TouchButtons.SetControlValue = function(xray_param_0739, xray_param_0740)
		if not xray_param_0739 then
			return false
		end

		for _, xray_loopVar_0741 in ipairs({ "Set", "SetValue", "SetState" }) do
			local xray_localValue_0742 = xray_param_0739[xray_loopVar_0741]
			if type(xray_localValue_0742) ~= "function" then
				continue
			end

			if pcall(xray_localValue_0742, xray_param_0739, xray_param_0740) then
				return true
			end
		end

		return false
	end

	Hub.TouchButtons.ApplyLucideIcon = function(xray_param_0743, xray_param_0744)
		if not xray_param_0743 or not xray_param_0743:IsA("ImageLabel") then
			return
		end
		local xray_remoteIconsValue_0745 = Hub.TouchButtons.RemoteIcons[xray_param_0744]
		local xray_remoteIconCacheValue_0746 = xray_remoteIconsValue_0745 and Hub.TouchButtons.remoteIconCache[xray_remoteIconsValue_0745]

		if xray_remoteIconCacheValue_0746 then
			xray_param_0743.Image = xray_remoteIconCacheValue_0746
			xray_param_0743.ImageRectSize = Vector2.zero
			xray_param_0743.ImageRectOffset = Vector2.zero
			return
		end

		local xray_iconsValue_0747 = Hub.TouchButtons.Icons[xray_param_0744] or "circle"
		local xray_iconCacheValue_0748 = Hub.TouchButtons.iconCache[xray_iconsValue_0747]

		if not xray_iconCacheValue_0748 then
			local xray_iconFallbackValue_0749 = Hub.TouchButtons.iconFallback[xray_iconsValue_0747]
			local xray_boolFlag_0750 = xray_iconFallbackValue_0749 ~= nil
			xray_param_0743.Image = xray_iconFallbackValue_0749 or Hub.TouchButtons.iconFallback.default
			xray_param_0743.ImageRectSize = Vector2.zero
			xray_param_0743.ImageRectOffset = Vector2.zero

			if not xray_boolFlag_0750 then
				Hub.TouchButtons.LoadLucideIcons()
			end
		else
			xray_param_0743.Image = xray_iconCacheValue_0748.image
			xray_param_0743.ImageRectSize = xray_iconCacheValue_0748.rectSize or Vector2.zero
			xray_param_0743.ImageRectOffset = xray_iconCacheValue_0748.rectPosition or Vector2.zero
		end

		if xray_remoteIconsValue_0745 and not Hub.TouchButtons.remoteIconFailed[xray_remoteIconsValue_0745] then
			Hub.TouchButtons.LoadRemoteIcon(xray_remoteIconsValue_0745)
		end
	end

	Hub.TouchButtons.LoadRemoteIcon = function(touchIcons_param_0751)
		if type(touchIcons_param_0751) ~= "string" or not touchIcons_param_0751:match("^[%w_%-]+%.png$") or Hub.TouchButtons.remoteIconCache[touchIcons_param_0751] or Hub.TouchButtons.remoteIconLoading[touchIcons_param_0751] or Hub.TouchButtons.remoteIconFailed[touchIcons_param_0751] then
			return
		end
		local touchIcons_callResult_0752 = type(getcustomasset) == "function" and getcustomasset or type(getsynasset) == "function" and getsynasset
		if type(touchIcons_callResult_0752) ~= "function" or type(writefile) ~= "function" or type(isfile) ~= "function" or type(makefolder) ~= "function" or type(isfolder) ~= "function" then
			Hub.TouchButtons.remoteIconFailed[touchIcons_param_0751] = true
			return
		end
		Hub.TouchButtons.remoteIconLoading[touchIcons_param_0751] = true

		task.spawn(function()
			local ok, image = pcall(function()
				for _, touchIcons_loopVar_0753 in ipairs({ "FoxnameMM2", "FoxnameMM2/icons_v1" }) do
					if not isfolder(touchIcons_loopVar_0753) then
						makefolder(touchIcons_loopVar_0753)
					end
				end

				local function touchIcons_helperFunc_0754(touchIcons_param_0755)
					return type(touchIcons_param_0755) == "string" and #touchIcons_param_0755 >= 8 and touchIcons_param_0755:sub(1, 8) == "\137PNG\r\n\26\n"
				end

				local touchIcons_textValue_0756 = "FoxnameMM2/icons_v1/" .. touchIcons_param_0751
				local ok = isfile(touchIcons_textValue_0756)

				if ok and type(readfile) == "function" then
					local result
					ok, result = pcall(readfile, touchIcons_textValue_0756)
					ok = ok and touchIcons_helperFunc_0754(result)
				end

				local ok2, result = pcall(game.HttpGet, game, "https://raw.githubusercontent.com/FoxnameTeam/OSS/main/Murder-Mystery-2/icons/" .. touchIcons_param_0751)

				if ok2 and touchIcons_helperFunc_0754(result) then
					writefile(touchIcons_textValue_0756, result)
					ok = true
				end

				if not ok then
					error("PNG 图标下载失败")
				end

				return touchIcons_callResult_0752(touchIcons_textValue_0756)
			end)

			if ok and type(image) == "string" and image ~= "" then
				local touchIcons_boolFlag_0757 = false
				local imageLabel = Instance.new("ImageLabel")
				imageLabel.Name = "FoxnameRemoteIconPreload"
				imageLabel.Size = UDim2.fromOffset(1, 1)
				imageLabel.Position = UDim2.fromOffset(-100, -100)
				imageLabel.BackgroundTransparency = 1
				imageLabel.ImageTransparency = 1
				imageLabel.Image = image
				local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")

				if type(gethui) == "function" then
					pcall(function()
						playerGui = gethui() or playerGui
					end)
				end

				imageLabel.Parent = playerGui
				local ContentProvider = game:GetService("ContentProvider")

				touchIcons_boolFlag_0757 = pcall(function()
					ContentProvider:PreloadAsync({ imageLabel }, function(touchIcons_param_0758, touchIcons_param_0759)
						if touchIcons_param_0759 == Enum.AssetFetchStatus.Success then
							touchIcons_boolFlag_0757 = true
						end
					end)
				end) and (touchIcons_boolFlag_0757 or imageLabel.IsLoaded)

				imageLabel:Destroy()

				if not touchIcons_boolFlag_0757 then
					image = "当前执行器不支持 PNG 自定义资源"
					ok = false
				end
			end

			Hub.TouchButtons.remoteIconLoading[touchIcons_param_0751] = nil

			if ok and type(image) == "string" and image ~= "" then
				Hub.TouchButtons.remoteIconCache[touchIcons_param_0751] = image
				Hub.TouchButtons.RefreshLucideIcons()
			else
				Hub.TouchButtons.remoteIconFailed[touchIcons_param_0751] = true
				Hub.TouchButtons.RefreshLucideIcons()
			end
		end)
	end

	Hub.TouchButtons.RefreshLucideIcons = function()
		Hub.TouchButtons.ForEachStyledButton(function(touchIcons_param_0760, touchIcons_param_0761)
			if not touchIcons_param_0761 or not touchIcons_param_0761.Parent then
				return
			end
			local buttonTitle = touchIcons_param_0761:FindFirstChild("ButtonTitle")
			Hub.TouchButtons.ApplyLucideIcon(touchIcons_param_0761:FindFirstChild("ButtonIcon"), buttonTitle and buttonTitle.Text or "")
		end)
	end

	Hub.TouchButtons.GenerateLucideIconCache = function()
		local iconModule = Hub.TouchButtons.iconModule
		if not iconModule or type(iconModule.Icon2) ~= "function" then
			return
		end
		local touchIcons_configTable_0762 = {}
		local touchIcons_configTable_0763 = {}

		for _, icon in pairs(Hub.TouchButtons.Icons) do
			if not touchIcons_configTable_0762[icon] then
				touchIcons_configTable_0762[icon] = true
				table.insert(touchIcons_configTable_0763, icon)
			end
		end

		if not touchIcons_configTable_0762.circle then
			table.insert(touchIcons_configTable_0763, "circle")
		end

		for _, touchIcons_loopVar_0764 in ipairs(touchIcons_configTable_0763) do
			local ok, result = pcall(iconModule.Icon2, touchIcons_loopVar_0764)

			if ok and type(result) == "table" and type(result[1]) == "string" then
				local touchIcons_dataTable_0765 = result[2] or {}
				Hub.TouchButtons.iconCache[touchIcons_loopVar_0764] = { image = result[1], rectSize = touchIcons_dataTable_0765.ImageRectSize, rectPosition = touchIcons_dataTable_0765.ImageRectPosition }
			end
		end
	end

	Hub.TouchButtons.LoadLucideIcons = function()
		if Hub.TouchButtons.iconModule or Hub.TouchButtons.iconLoading then
			return
		end
		local iconModule = Hub.Crosshair and Hub.Crosshair.iconModule

		if iconModule and type(iconModule.Icon2) == "function" then
			Hub.TouchButtons.iconModule = iconModule
			Hub.TouchButtons.GenerateLucideIconCache()
			Hub.TouchButtons.RefreshLucideIcons()
			return
		end

		Hub.TouchButtons.iconLoading = true

		task.spawn(function()
			local ok, iconModule2 = pcall(function()
				return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"))()
			end)

			if ok and type(iconModule2) == "table" and type(iconModule2.Icon2) == "function" then
				Hub.TouchButtons.iconModule = iconModule2

				if Hub.Crosshair and not Hub.Crosshair.iconModule then
					Hub.Crosshair.iconModule = iconModule2
				end

				Hub.TouchButtons.GenerateLucideIconCache()
			end

			Hub.TouchButtons.iconLoading = false

			if Hub.TouchButtons.iconModule then
				Hub.TouchButtons.RefreshLucideIcons()
			end
		end)
	end

	for _, remoteIcon in pairs(Hub.TouchButtons.RemoteIcons) do
		Hub.TouchButtons.LoadRemoteIcon(remoteIcon)
	end

	task.spawn(function()
		local touchIcons_configTable_0766 = {}

		for k, touchIcons_loopVar_0767 in pairs(Hub.TouchButtons.iconFallback) do
			if k ~= "default" then
				local imageLabel = Instance.new("ImageLabel")
				imageLabel.Image = touchIcons_loopVar_0767
				table.insert(touchIcons_configTable_0766, imageLabel)
			end
		end

		local ok, result = pcall(game.GetService, game, "ContentProvider")

		if ok and result then
			pcall(result.PreloadAsync, result, touchIcons_configTable_0766)
		end

		for _, touchIcons_loopVar_0768 in ipairs(touchIcons_configTable_0766) do
			touchIcons_loopVar_0768:Destroy()
		end

		Hub.TouchButtons.RefreshLucideIcons()
	end)

	Hub.TouchButtons.UpdateDisplay = function(touchIcons_param_0769, text, touchIcons_param_0770)
		local button = touchIcons_param_0769.button

		if button and button.Parent then
			button.Text = ""
			local buttonTitle = button:FindFirstChild("ButtonTitle")
			local buttonIcon = button:FindFirstChild("ButtonIcon")
			local statusDot = button:FindFirstChild("StatusDot")

			if buttonTitle then
				buttonTitle.Text = text
			end

			if buttonIcon then
				Hub.TouchButtons.ApplyLucideIcon(buttonIcon, text)
			end

			if statusDot then
				statusDot.Visible = false
				statusDot.BackgroundColor3 = touchIcons_param_0770 and Color3.fromRGB(72, 235, 145) or Color3.fromRGB(105, 101, 115)
			end
		end
	end

	Hub.TouchButtons.UpdateText = function(touchIcons_param_0771, touchIcons_param_0772, touchIcons_param_0773)
		Hub.TouchButtons.UpdateDisplay(touchIcons_param_0771, touchIcons_param_0772, touchIcons_param_0773, false)
	end

	Hub.TouchButtons.UpdateHoldHint = function(touchIcons_param_0774, touchIcons_param_0775)
		local button = touchIcons_param_0775 or touchIcons_param_0774.button
		button = button and button:FindFirstChild("HoldHint")
		if not button then
			return
		end
		button.Text = ""
		button.Visible = false
	end

	Hub.TouchButtons.BindHoldDrag = function(touchIcons_param_0776, touchIcons_param_0777, touchIcons_param_0778)
		Hub.TouchButtons.Disconnect(touchIcons_param_0776)
		touchIcons_param_0778 = touchIcons_param_0778 or "position"
		touchIcons_param_0776.suppressNextActivation = false

		touchIcons_param_0776.beginConn = touchIcons_param_0777.InputBegan:Connect(function(input)
			local userInputType = input.UserInputType
			if userInputType ~= Enum.UserInputType.MouseButton1 and userInputType ~= Enum.UserInputType.Touch then
				return
			end
			touchIcons_param_0776.dragging = touchIcons_param_0776.draggable == true
			touchIcons_param_0776.input = input
			touchIcons_param_0776.start = input.Position
			touchIcons_param_0776.startPos = touchIcons_param_0777.Position

			if touchIcons_param_0776.endConn then
				touchIcons_param_0776.endConn:Disconnect()
			end

			touchIcons_param_0776.endConn = input.Changed:Connect(function()
				if input.UserInputState ~= Enum.UserInputState.End then
					return
				end
				touchIcons_param_0776.dragging = false
				touchIcons_param_0776[touchIcons_param_0778] = touchIcons_param_0777.Position

				if touchIcons_param_0776.endConn then
					touchIcons_param_0776.endConn:Disconnect()
					touchIcons_param_0776.endConn = nil
				end

				task.delay(0.15, function()
					touchIcons_param_0776.suppressNextActivation = false
				end)
			end)
		end)

		touchIcons_param_0776.inputConn = touchIcons_param_0777.InputChanged:Connect(function(input)
			local userInputType = input.UserInputType

			if userInputType == Enum.UserInputType.MouseMovement or userInputType == Enum.UserInputType.Touch then
				touchIcons_param_0776.input = input
			end
		end)

		touchIcons_param_0776.globalConn = UserInputService.InputChanged:Connect(function(input)
			if not touchIcons_param_0776.dragging or input ~= touchIcons_param_0776.input then
				return
			end

			if not touchIcons_param_0776.start or not touchIcons_param_0776.startPos then
				return
			end
			local touchIcons_numericVar_0779 = input.Position - touchIcons_param_0776.start

			if touchIcons_numericVar_0779.Magnitude > 6 then
				touchIcons_param_0776.suppressNextActivation = true
			end

			touchIcons_param_0777.Position = UDim2.new(touchIcons_param_0776.startPos.X.Scale, touchIcons_param_0776.startPos.X.Offset + touchIcons_numericVar_0779.X, touchIcons_param_0776.startPos.Y.Scale, touchIcons_param_0776.startPos.Y.Offset + touchIcons_numericVar_0779.Y)
			touchIcons_param_0776[touchIcons_param_0778] = touchIcons_param_0777.Position
		end)

		Hub.TouchButtons.UpdateHoldHint(touchIcons_param_0776, touchIcons_param_0777)
	end

	Hub.TouchButtons.ShouldSuppressActivation = function(touchIcons_param_0780)
		if not touchIcons_param_0780.suppressNextActivation then
			return false
		end
		touchIcons_param_0780.suppressNextActivation = false
		return true
	end

	Hub.TouchButtons.DecorateActionButton = function(parent, touchIcons_param_0781, text)
		if not parent then
			return
		end
		local buttonTitle = parent:FindFirstChild("ButtonTitle") or Instance.new("TextLabel")
		buttonTitle.Name = "ButtonTitle"
		buttonTitle.BackgroundTransparency = 1
		buttonTitle.Font = Enum.Font.GothamBold
		buttonTitle.Text = text
		buttonTitle.TextXAlignment = Enum.TextXAlignment.Center
		buttonTitle.TextYAlignment = Enum.TextYAlignment.Center
		buttonTitle.ZIndex = parent.ZIndex + 1
		buttonTitle.Parent = parent
		local titleDivider = parent:FindFirstChild("TitleDivider") or Instance.new("Frame")
		titleDivider.Name = "TitleDivider"
		titleDivider.BorderSizePixel = 0
		titleDivider.ZIndex = parent.ZIndex + 1
		titleDivider.Parent = parent
		local buttonIcon = parent:FindFirstChild("ButtonIcon")
		local touchIcons_localValue_0782

		if buttonIcon and not buttonIcon:IsA("ImageLabel") then
			buttonIcon:Destroy()
			touchIcons_localValue_0782 = nil
		else
			touchIcons_localValue_0782 = buttonIcon
		end

		local imageLabel = touchIcons_localValue_0782 or Instance.new("ImageLabel")
		imageLabel.Name = "ButtonIcon"
		imageLabel.BackgroundTransparency = 1
		imageLabel.ScaleType = Enum.ScaleType.Fit
		imageLabel.ZIndex = parent.ZIndex + 1
		imageLabel.Parent = parent
		Hub.TouchButtons.ApplyLucideIcon(imageLabel, text)
		local holdHint = parent:FindFirstChild("HoldHint") or Instance.new("TextLabel")
		holdHint.Name = "HoldHint"
		holdHint.BackgroundTransparency = 1
		holdHint.Font = Enum.Font.GothamMedium
		holdHint.TextXAlignment = Enum.TextXAlignment.Center
		holdHint.TextYAlignment = Enum.TextYAlignment.Center
		holdHint.TextTruncate = Enum.TextTruncate.None
		holdHint.TextWrapped = true
		holdHint.ZIndex = parent.ZIndex + 1
		holdHint.Parent = parent
		parent.Text = ""
		Hub.TouchButtons.ApplySize(parent, touchIcons_param_0781.size, touchIcons_param_0781.shape)
		Hub.TouchButtons.ApplyAppearance(parent, touchIcons_param_0781)
		Hub.TouchButtons.UpdateHoldHint(touchIcons_param_0781, parent)
	end

	Hub.TouchButtons.SetXRayEnabled = function(touchIcons_param_0783, touchIcons_param_0784)
		local touchIcons_boolFlag_0785 = touchIcons_param_0783 and true or false

		if Hub.XRayEnabled ~= touchIcons_boolFlag_0785 then
			xray_helperFunc_0733(touchIcons_boolFlag_0785)
		end

		Hub.TouchButtons.UpdateText(Hub.XRayButtonState, "XRay", touchIcons_boolFlag_0785)

		if touchIcons_param_0784 then
			Hub.TouchButtons.SetControlValue(Hub.TouchButtons.XRayToggleControl, touchIcons_boolFlag_0785)
		end

		if Hub.TouchButtons.RefreshQuickMenu then
			Hub.TouchButtons.RefreshQuickMenu()
		end
	end
end

Hub.TouchButtons.SetAimEnabled = function(aimEnabled, touchIcons_param_0786)
	aimEnabled = aimEnabled and true or false
	Hub.AimEnabled = aimEnabled

	if Hub.UpdateAimBinding then
		Hub.UpdateAimBinding()
	end

	Hub.TouchButtons.UpdateText(Hub.AimlockButtonState, "Aimlock", aimEnabled)

	if touchIcons_param_0786 then
		Hub.TouchButtons.SetControlValue(Hub.TouchButtons.AimToggleControl, aimEnabled)
	end

	if Hub.TouchButtons.RefreshQuickMenu then
		Hub.TouchButtons.RefreshQuickMenu()
	end
end

Hub.TouchButtons.SetNoclipEnabled = function(touchIcons_param_0787, touchIcons_param_0788)
	local noclipEnabled = touchIcons_param_0787 and true or false
	Hub.NoclipEnabled = noclipEnabled

	if noclipEnabled then
		crosshair_helperFunc_0393()
	else
		crosshair_helperFunc_0394()
	end

	Hub.TouchButtons.UpdateText(Hub.NoclipButtonState, "Noclip", noclipEnabled)

	if touchIcons_param_0788 then
		Hub.TouchButtons.SetControlValue(Hub.TouchButtons.NoclipToggleControl, noclipEnabled)
	end
end

Hub.TouchButtons.SetFlyEnabled = function(flyEnabled, touchIcons_param_0789)
	flyEnabled = flyEnabled and true or false
	Hub.FlyEnabled = flyEnabled

	if flyEnabled then
		if Hub.StartFly then
			Hub.StartFly()
		end
	else
		if Hub.StopFly then
			Hub.StopFly()
		end

		if localChar.rootPart then
			localChar.rootPart.Velocity = Vector3.zero
		end
	end

	Hub.TouchButtons.UpdateText(Hub.FlyButtonState, "Fly", flyEnabled)

	if touchIcons_param_0789 then
		Hub.TouchButtons.SetControlValue(Hub.TouchButtons.FlyToggleControl, flyEnabled)
	end
end

Hub.TouchButtons.Disconnect = function(touchIcons_param_0790)
	if touchIcons_param_0790.beginConn then
		touchIcons_param_0790.beginConn:Disconnect()
		touchIcons_param_0790.beginConn = nil
	end

	if touchIcons_param_0790.inputConn then
		touchIcons_param_0790.inputConn:Disconnect()
		touchIcons_param_0790.inputConn = nil
	end

	if touchIcons_param_0790.globalConn then
		touchIcons_param_0790.globalConn:Disconnect()
		touchIcons_param_0790.globalConn = nil
	end

	if touchIcons_param_0790.endConn then
		touchIcons_param_0790.endConn:Disconnect()
		touchIcons_param_0790.endConn = nil
	end

	touchIcons_param_0790.input = nil
	touchIcons_param_0790.start = nil
	touchIcons_param_0790.startPos = nil
	touchIcons_param_0790.dragging = false
end

Hub.TouchButtons.Destroy = function(touchIcons_param_0791)
	Hub.TouchButtons.Disconnect(touchIcons_param_0791)

	if touchIcons_param_0791.button then
		touchIcons_param_0791.position = touchIcons_param_0791.button.Position
		touchIcons_param_0791.button:Destroy()
		touchIcons_param_0791.button = nil
	end

	if touchIcons_param_0791.gui then
		touchIcons_param_0791.gui:Destroy()
		touchIcons_param_0791.gui = nil
	end
end

Hub.TouchButtons.Create = function(touchIcons_param_0792, name, name2, text, touchIcons_param_0793, touchIcons_param_0794, touchIcons_param_0795)
	if touchIcons_param_0792.gui and touchIcons_param_0792.gui.Parent and touchIcons_param_0792.button and touchIcons_param_0792.button.Parent then
		local updateDisplay = Hub.TouchButtons.UpdateDisplay

		if touchIcons_param_0795 then
		end

		updateDisplay(touchIcons_param_0792, text, touchIcons_param_0793(), touchIcons_param_0795)
		Hub.TouchButtons.ApplySize(touchIcons_param_0792.button, touchIcons_param_0792.size, touchIcons_param_0792.shape)
		Hub.TouchButtons.ApplyAppearance(touchIcons_param_0792.button, touchIcons_param_0792)
		return
	end

	Hub.TouchButtons.Destroy(touchIcons_param_0792)
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = name
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.DisplayOrder = 999996

	pcall(function()
		if syn and syn.protect_gui then
			syn.protect_gui(screenGui)
		elseif protect_gui then
			protect_gui(screenGui)
		end
	end)

	screenGui.Parent = getSafeGuiParent()
	local textButton = Instance.new("TextButton")
	textButton.Name = name2
	textButton.AnchorPoint = Vector2.new(0.5, 0.5)
	textButton.Position = touchIcons_param_0792.position or touchIcons_param_0792.buttonPos or UDim2.new(0.84, 0, 0.62, 0)
	textButton.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	textButton.BackgroundTransparency = 0.35
	textButton.BorderSizePixel = 0
	textButton.Text = ""
	textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	textButton.Font = Enum.Font.GothamBold
	textButton.AutoButtonColor = true
	textButton.Active = true
	textButton.ZIndex = 30
	textButton.Parent = screenGui
	Hub.TouchButtons.ApplySize(textButton, touchIcons_param_0792.size, touchIcons_param_0792.shape)
	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 12)
	uiCorner.Parent = textButton
	local uiStroke = Instance.new("UIStroke")
	uiStroke.Thickness = 1.5
	uiStroke.Color = Color3.fromRGB(255, 255, 255)
	uiStroke.Transparency = 0.4
	uiStroke.Parent = textButton
	local textLabel = Instance.new("TextLabel")
	textLabel.Name = "ButtonTitle"
	textLabel.BackgroundTransparency = 1
	textLabel.Font = Enum.Font.GothamBold
	textLabel.Text = text
	textLabel.TextColor3 = Color3.fromRGB(240, 236, 247)
	textLabel.TextXAlignment = Enum.TextXAlignment.Center
	textLabel.TextYAlignment = Enum.TextYAlignment.Center
	textLabel.ZIndex = textButton.ZIndex + 1
	textLabel.Parent = textButton
	local frame = Instance.new("Frame")
	frame.Name = "TitleDivider"
	frame.BorderSizePixel = 0
	frame.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
	frame.ZIndex = textButton.ZIndex + 1
	frame.Parent = textButton
	local imageLabel = Instance.new("ImageLabel")
	imageLabel.Name = "ButtonIcon"
	imageLabel.BackgroundTransparency = 1
	imageLabel.ImageColor3 = Color3.fromRGB(0, 255, 255)
	imageLabel.ScaleType = Enum.ScaleType.Fit
	imageLabel.ZIndex = textButton.ZIndex + 1
	imageLabel.Parent = textButton
	Hub.TouchButtons.ApplyLucideIcon(imageLabel, text)
	local frame2 = Instance.new("Frame")
	frame2.Name = "StatusDot"
	frame2.AnchorPoint = Vector2.new(0.5, 0.5)
	frame2.BorderSizePixel = 0
	frame2.ZIndex = textButton.ZIndex + 2
	frame2.Parent = textButton
	local uiCorner2 = Instance.new("UICorner")
	uiCorner2.CornerRadius = UDim.new(1, 0)
	uiCorner2.Parent = frame2
	local textLabel2 = Instance.new("TextLabel")
	textLabel2.Name = "HoldHint"
	textLabel2.BackgroundTransparency = 1
	textLabel2.Font = Enum.Font.GothamMedium
	textLabel2.TextColor3 = Color3.fromRGB(174, 168, 185)
	textLabel2.TextXAlignment = Enum.TextXAlignment.Center
	textLabel2.TextYAlignment = Enum.TextYAlignment.Center
	textLabel2.TextTruncate = Enum.TextTruncate.None
	textLabel2.TextWrapped = false
	textLabel2.ZIndex = textButton.ZIndex + 1
	textLabel2.Parent = textButton
	Hub.TouchButtons.ApplySize(textButton, touchIcons_param_0792.size, touchIcons_param_0792.shape)
	Hub.TouchButtons.ApplyAppearance(textButton, touchIcons_param_0792)
	touchIcons_param_0792.gui = screenGui
	touchIcons_param_0792.button = textButton
	local updateDisplay = Hub.TouchButtons.UpdateDisplay

	if touchIcons_param_0795 then
	end

	updateDisplay(touchIcons_param_0792, text, touchIcons_param_0793(), touchIcons_param_0795)

	textButton.Activated:Connect(function()
		if Hub.TouchButtons.ShouldSuppressActivation(touchIcons_param_0792) then
			return
		end

		if touchIcons_param_0795 then
			touchIcons_param_0794()
		else
			touchIcons_param_0794(not touchIcons_param_0793())
		end
	end)

	Hub.TouchButtons.BindHoldDrag(touchIcons_param_0792, textButton, "position")
end

Hub.TouchButtons.ToggleGetGunButton = function(quickMenu_param_0796)
	local getGunButtonState = Hub.GetGunButtonState
	getGunButtonState.enabled = quickMenu_param_0796 and true or false

	if getGunButtonState.enabled then
		Hub.TouchButtons.Create(getGunButtonState, "Foxname_MM2_GetGunButton", "GetGunButton", "Get Gun", function()
			return false
		end, function()
			if Hub.TakeDroppedGunOnce then
				Hub.TakeDroppedGunOnce()
			end
		end, true)
	else
		Hub.TouchButtons.Destroy(getGunButtonState)
	end
end

Hub.TouchButtons.ToggleBombJumpButton = function(quickMenu_param_0797)
	local bombJumpButtonState = Hub.BombJumpButtonState
	bombJumpButtonState.enabled = quickMenu_param_0797 and true or false

	if bombJumpButtonState.enabled then
		Hub.TouchButtons.Create(bombJumpButtonState, "Foxname_MM2_BombJumpButton", "BombJumpButton", "Bomb Jump", function()
			return false
		end, function()
			if Hub.RunBombJump then
				Hub.RunBombJump()
			end
		end, true)
	else
		Hub.TouchButtons.Destroy(bombJumpButtonState)
	end
end

Hub.TouchButtons.ToggleXRayButton = function(quickMenu_param_0798)
	local xRayButtonState = Hub.XRayButtonState
	xRayButtonState.enabled = quickMenu_param_0798 and true or false

	if xRayButtonState.enabled then
		Hub.TouchButtons.Create(xRayButtonState, "Foxname_MM2_XRayButton", "XRayButton", "XRay", function()
			return Hub.XRayEnabled
		end, function(quickMenu_param_0799)
			Hub.TouchButtons.SetXRayEnabled(quickMenu_param_0799, true)
		end)
	else
		Hub.TouchButtons.Destroy(xRayButtonState)
	end
end

Hub.TouchButtons.ToggleAimlockButton = function(quickMenu_param_0800)
	local aimlockButtonState = Hub.AimlockButtonState
	aimlockButtonState.enabled = quickMenu_param_0800 and true or false

	if aimlockButtonState.enabled then
		Hub.TouchButtons.Create(aimlockButtonState, "Foxname_MM2_AimlockButton", "AimlockButton", "Aimlock", function()
			return Hub.AimEnabled
		end, function(quickMenu_param_0801)
			Hub.TouchButtons.SetAimEnabled(quickMenu_param_0801, true)
		end)
	else
		Hub.TouchButtons.Destroy(aimlockButtonState)
	end
end

Hub.TouchButtons.ToggleFlyButton = function(quickMenu_param_0802)
	local flyButtonState = Hub.FlyButtonState
	flyButtonState.enabled = quickMenu_param_0802 and true or false

	if flyButtonState.enabled then
		Hub.TouchButtons.Create(flyButtonState, "Foxname_MM2_FlyButton", "FlyButton", "Fly", function()
			return Hub.FlyEnabled
		end, function(quickMenu_param_0803)
			Hub.TouchButtons.SetFlyEnabled(quickMenu_param_0803, true)
		end)
	else
		Hub.TouchButtons.Destroy(flyButtonState)
	end
end

Hub.TouchButtons.ToggleNoclipButton = function(quickMenu_param_0804)
	local noclipButtonState = Hub.NoclipButtonState
	noclipButtonState.enabled = quickMenu_param_0804 and true or false

	if noclipButtonState.enabled then
		Hub.TouchButtons.Create(noclipButtonState, "Foxname_MM2_NoclipButton", "NoclipButton", "Noclip", function()
			return Hub.NoclipEnabled
		end, function(quickMenu_param_0805)
			Hub.TouchButtons.SetNoclipEnabled(quickMenu_param_0805, true)
		end)
	else
		Hub.TouchButtons.Destroy(noclipButtonState)
	end
end

Hub.TouchButtons.ToggleThrowKnifeButton = function(quickMenu_param_0806)
	local throwKnifeButtonState = Hub.ThrowKnifeButtonState
	throwKnifeButtonState.enabled = quickMenu_param_0806 and true or false

	if throwKnifeButtonState.enabled then
		Hub.TouchButtons.Create(throwKnifeButtonState, "Foxname_MM2_ThrowKnifeButton", "ThrowKnifeButton", "Throw Knife", function()
			return false
		end, function()
			if Hub.TriggerThrowKnifeInput then
				Hub.TriggerThrowKnifeInput()
			end
		end, true)
	else
		Hub.TouchButtons.Destroy(throwKnifeButtonState)
	end
end

Hub.TouchButtons.ToggleAutoShootButton = function(quickMenu_param_0807)
	local autoShootDragState = Hub.AutoShootDragState
	autoShootDragState.enabled = quickMenu_param_0807 and true or false
	Hub.AutoShootState.enabled = autoShootDragState.enabled

	if autoShootDragState.enabled then
		Hub.TouchButtons.Create(autoShootDragState, "Foxname_MM2_AutoShootButton", "AutoShootButton", "Shoot", function()
			return false
		end, function()
			if Hub.TriggerAutoShootInput then
				Hub.TriggerAutoShootInput()
			elseif Hub.UpdateAutoShoot then
				Hub.UpdateAutoShoot()
			end
		end, true)

		Hub.AutoShootTouchButton = autoShootDragState.button
	else
		Hub.TouchButtons.Destroy(autoShootDragState)
		Hub.AutoShootTouchButton = nil
	end
end

Hub.TouchButtons.ToggleShootButton = Hub.TouchButtons.ToggleAutoShootButton
Hub.ToggleThrowKnifeButton = Hub.TouchButtons.ToggleThrowKnifeButton
Hub.ToggleAutoShoot = Hub.TouchButtons.ToggleAutoShootButton

Hub.TouchButtons.RefreshQuickMenu = function()
	local actions = Hub.QuickMenuState.actions
	local xRay = actions.XRay
	local aimlock = actions.Aimlock

	if xRay and xRay.Parent then
		xRay.Text = Hub.XRayEnabled and "XRay ON" or "XRay"
		xRay.BackgroundColor3 = Hub.XRayEnabled and Color3.fromRGB(210, 45, 90) or Color3.fromRGB(22, 22, 25)
	end

	if aimlock and aimlock.Parent then
		aimlock.Text = Hub.AimEnabled and "Aim ON" or "Aimlock"
		aimlock.BackgroundColor3 = Hub.AimEnabled and Color3.fromRGB(210, 45, 90) or Color3.fromRGB(22, 22, 25)
	end
end

Hub.TouchButtons.PositionQuickMenuActions = function(quickMenu_param_0808)
	local quickMenuState = Hub.QuickMenuState
	local button = quickMenuState.button
	if not button or not button.Parent then
		return
	end
	local currentCamera2 = workspace.CurrentCamera
	local quickMenu_numericVar_0809 = button.AbsolutePosition.X + button.AbsoluteSize.X * 0.5 > (currentCamera2 and currentCamera2.ViewportSize.X or 1000) * 0.5 and -1 or 1

	local quickMenu_configTable_0810 = {
		Shoot = Vector2.new(48 * quickMenu_numericVar_0809, -132),
		Throw = Vector2.new(108 * quickMenu_numericVar_0809, -88),
		GetGun = Vector2.new(140 * quickMenu_numericVar_0809, -24),
		BombJump = Vector2.new(132 * quickMenu_numericVar_0809, 48),
		XRay = Vector2.new(82 * quickMenu_numericVar_0809, 108),
		Aimlock = Vector2.new(16 * quickMenu_numericVar_0809, 138),
		WallPhase = Vector2.new(-52 * quickMenu_numericVar_0809, 124),
	}

	for k, action in pairs(quickMenuState.actions) do
		if action and action.Parent then
			local vector2 = quickMenu_configTable_0810[k] or Vector2.zero
			local udim2 = UDim2.new(quickMenuState.position.X.Scale, quickMenuState.position.X.Offset + vector2.X, quickMenuState.position.Y.Scale, quickMenuState.position.Y.Offset + vector2.Y)

			if quickMenuState.open then
				action.Visible = true

				if quickMenu_param_0808 then
					TweenService:Create(action, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = udim2, BackgroundTransparency = 0.18, TextTransparency = 0 }):Play()
				else
					action.Position = udim2
					action.BackgroundTransparency = 0.18
					action.TextTransparency = 0
				end
			elseif quickMenu_param_0808 then
				local quickMenu_configTable_0811 = { Position = quickMenuState.position, BackgroundTransparency = 1, TextTransparency = 1 }
				TweenService:Create(action, TweenInfo.new(0.11, Enum.EasingStyle.Quad, Enum.EasingDirection.In), quickMenu_configTable_0811):Play()

				task.delay(0.12, function()
					if action.Parent and not quickMenuState.open then
						action.Visible = false
					end
				end)
			else
				action.Position = quickMenuState.position
				action.BackgroundTransparency = 1
				action.TextTransparency = 1
				action.Visible = false
			end
		end
	end
end

Hub.TouchButtons.SetQuickMenuOpen = function(quickMenu_param_0812, quickMenu_param_0813)
	Hub.QuickMenuState.open = quickMenu_param_0812 and true or false
	local button = Hub.QuickMenuState.button

	if button and button.Parent then
		button.Text = Hub.QuickMenuState.open and "Ã—" or "Quick"
	end

	Hub.TouchButtons.PositionQuickMenuActions(quickMenu_param_0813 ~= false)
end

Hub.TouchButtons.DestroyQuickMenu = function()
	local quickMenuState = Hub.QuickMenuState

	if quickMenuState.button and quickMenuState.button.Parent then
		quickMenuState.position = quickMenuState.button.Position
	end

	for _, connection in ipairs(quickMenuState.connections) do
		if connection and connection.Connected then
			connection:Disconnect()
		end
	end

	table.clear(quickMenuState.connections)
	table.clear(quickMenuState.actions)

	if quickMenuState.gui then
		quickMenuState.gui:Destroy()
	end

	quickMenuState.gui = nil
	quickMenuState.button = nil
	quickMenuState.open = false
	quickMenuState.dragging = false
	quickMenuState.dragInput = nil
end

Hub.TouchButtons.ToggleQuickMenu = function(quickMenu_param_0814)
	local quickMenuState = Hub.QuickMenuState
	quickMenuState.enabled = quickMenu_param_0814 and true or false
	if not quickMenuState.enabled then
		Hub.TouchButtons.DestroyQuickMenu()
		return
	end

	if quickMenuState.gui and quickMenuState.gui.Parent and quickMenuState.button and quickMenuState.button.Parent then
		return
	end
	Hub.TouchButtons.DestroyQuickMenu()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "Foxname_MM2_QuickMenu"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.DisplayOrder = 999998

	pcall(function()
		if syn and syn.protect_gui then
			syn.protect_gui(screenGui)
		elseif protect_gui then
			protect_gui(screenGui)
		end
	end)

	screenGui.Parent = getSafeGuiParent()

	local function quickMenu_helperFunc_0815(parent, size, textSize)
		parent.AnchorPoint = Vector2.new(0.5, 0.5)
		parent.Size = size
		parent.BackgroundColor3 = Color3.fromRGB(22, 22, 25)
		parent.BorderSizePixel = 0
		parent.TextColor3 = Color3.fromRGB(255, 255, 255)
		parent.Font = Enum.Font.GothamBold
		parent.TextSize = textSize
		parent.AutoButtonColor = true
		parent.Active = true
		parent.ZIndex = 50
		parent.Parent = screenGui
		local uiCorner = Instance.new("UICorner")
		uiCorner.CornerRadius = UDim.new(0, 12)
		uiCorner.Parent = parent
		local uiStroke = Instance.new("UIStroke")
		uiStroke.Thickness = 1.5
		uiStroke.Color = Color3.fromRGB(240, 55, 100)
		uiStroke.Transparency = 0.12
		uiStroke.Parent = parent
	end

	local textButton = Instance.new("TextButton")
	textButton.Name = "QuickMenuButton"
	textButton.Text = "快捷"
	textButton.Position = quickMenuState.position
	quickMenu_helperFunc_0815(textButton, UDim2.fromOffset(58, 58), 14)
	quickMenuState.gui = screenGui
	quickMenuState.button = textButton

	for _, quickMenu_loopVar_0816 in ipairs({
		{
			"Shoot",
			"Shoot",
			function()
				if Hub.TriggerAutoShootInput then
					Hub.TriggerAutoShootInput()
				end
			end,
		},
		{
			"Throw",
			"Throw",
			function()
				if Hub.TriggerThrowKnifeInput then
					Hub.TriggerThrowKnifeInput()
				end
			end,
		},
		{
			"GetGun",
			"Gun",
			function()
				if Hub.TakeDroppedGunOnce then
					Hub.TakeDroppedGunOnce()
				end
			end,
		},
		{
			"BombJump",
			"Bomb",
			function()
				if Hub.RunBombJump then
					Hub.RunBombJump()
				end
			end,
		},
		{
			"XRay",
			"XRay",
			function()
				Hub.TouchButtons.SetXRayEnabled(not Hub.XRayEnabled, true)
			end,
		},
		{
			"Aimlock",
			"Aimlock",
			function()
				Hub.TouchButtons.SetAimEnabled(not Hub.AimEnabled, true)
			end,
		},
		{
			"WallPhase",
			"Wall Glitch",
			function()
				local wallPhaseAssist = Hub.WallPhaseAssist

				if wallPhaseAssist and type(wallPhaseAssist.Run) == "function" then
					wallPhaseAssist.Run()
				end
			end,
		},
	}) do
		local textButton2 = Instance.new("TextButton")
		textButton2.Name = quickMenu_loopVar_0816[1] .. "QuickAction"
		textButton2.Text = quickMenu_loopVar_0816[2]
		textButton2.Position = quickMenuState.position
		quickMenu_helperFunc_0815(textButton2, UDim2.fromOffset(68, 40), 13)
		textButton2.Visible = false
		textButton2.BackgroundTransparency = 1
		textButton2.TextTransparency = 1
		quickMenuState.actions[quickMenu_loopVar_0816[1]] = textButton2
		table.insert(quickMenuState.connections, textButton2.Activated:Connect(quickMenu_loopVar_0816[3]))
	end

	table.insert(quickMenuState.connections, textButton.Activated:Connect(function()
		if quickMenuState.dragMoved then
			quickMenuState.dragMoved = false
			return
		end
		Hub.TouchButtons.SetQuickMenuOpen(not quickMenuState.open, true)
	end))

	table.insert(quickMenuState.connections, textButton.InputBegan:Connect(function(input)
		local userInputType = input.UserInputType
		if userInputType ~= Enum.UserInputType.Touch and userInputType ~= Enum.UserInputType.MouseButton1 then
			return
		end
		quickMenuState.dragging = true
		quickMenuState.dragInput = input
		quickMenuState.dragStart = input.Position
		quickMenuState.dragStartPosition = textButton.Position
		quickMenuState.dragMoved = false
		local connection = nil

		connection = input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				quickMenuState.dragging = false
				quickMenuState.position = textButton.Position

				if connection then
					connection:Disconnect()
					connection = nil
				end

				task.defer(function()
					quickMenuState.dragMoved = false
				end)
			end
		end)
	end))

	table.insert(quickMenuState.connections, textButton.InputChanged:Connect(function(input)
		local userInputType = input.UserInputType

		if userInputType == Enum.UserInputType.Touch or userInputType == Enum.UserInputType.MouseMovement then
			quickMenuState.dragInput = input
		end
	end))

	table.insert(quickMenuState.connections, UserInputService.InputChanged:Connect(function(input)
		if not quickMenuState.dragging or input ~= quickMenuState.dragInput or not quickMenuState.dragStart or not quickMenuState.dragStartPosition then
			return
		end
		local quickMenu_numericVar_0817 = input.Position - quickMenuState.dragStart

		if quickMenu_numericVar_0817.Magnitude > 7 then
			quickMenuState.dragMoved = true
		end

		textButton.Position = UDim2.new(quickMenuState.dragStartPosition.X.Scale, quickMenuState.dragStartPosition.X.Offset + quickMenu_numericVar_0817.X, quickMenuState.dragStartPosition.Y.Scale, quickMenuState.dragStartPosition.Y.Offset + quickMenu_numericVar_0817.Y)
		quickMenuState.position = textButton.Position
		Hub.TouchButtons.PositionQuickMenuActions(false)
	end))

	Hub.TouchButtons.RefreshQuickMenu()
	Hub.TouchButtons.SetQuickMenuOpen(false, false)
end

local quickMenu_helperFunc_0818, quickMenu_helperFunc_0819

do
	local function quickMenu_helperFunc_0820()
		local quickMenu_invisibilitySeatNameState_0821 = workspace:FindFirstChild(Hub.InvisibilitySeatName)

		if quickMenu_invisibilitySeatNameState_0821 then
			pcall(function()
				quickMenu_invisibilitySeatNameState_0821:Destroy()
			end)
		end
	end

	local function quickMenu_helperFunc_0822()
		if Hub.InvisibilityDescAddedConn then
			pcall(function()
				Hub.InvisibilityDescAddedConn:Disconnect()
			end)

			Hub.InvisibilityDescAddedConn = nil
		end

		if Hub.InvisibilityRefreshConn then
			pcall(function()
				Hub.InvisibilityRefreshConn:Disconnect()
			end)

			Hub.InvisibilityRefreshConn = nil
		end
	end

	local function quickMenu_helperFunc_0823(quickMenu_param_0824, transparency)
		if not quickMenu_param_0824 then
			return
		end

		for _, descendant in ipairs(quickMenu_param_0824:GetDescendants()) do
			if descendant:IsA("BasePart") then
				if descendant.Name ~= "HumanoidRootPart" then
					descendant.Transparency = transparency
				end

				descendant.LocalTransparencyModifier = transparency
			elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
				descendant.Transparency = transparency
			end
		end
	end

	local function quickMenu_helperFunc_0825(quickMenu_param_0826)
		if not quickMenu_param_0826 or not quickMenu_param_0826.Parent then
			return false
		end
		local humanoidRootPart = quickMenu_param_0826:FindFirstChild("HumanoidRootPart") or quickMenu_param_0826:WaitForChild("HumanoidRootPart", 3)
		if not humanoidRootPart then
			return false
		end
		quickMenu_helperFunc_0823(quickMenu_param_0826, Hub.InvisibilityTransparency)
		local cFrame = humanoidRootPart.CFrame

		pcall(function()
			quickMenu_param_0826:MoveTo(Hub.InvisibilitySeatTeleportPosition)
		end)

		task.wait(0.05)
		local humanoidRootPart2 = quickMenu_param_0826:FindFirstChild("HumanoidRootPart")

		if not humanoidRootPart2 or humanoidRootPart2.Position.Y < -50 then
			pcall(function()
				quickMenu_param_0826:MoveTo(cFrame.Position)
			end)

			quickMenu_helperFunc_0823(quickMenu_param_0826, 0)
			return false
		end

		quickMenu_helperFunc_0820()
		local seat = Instance.new("Seat")
		seat.Name = Hub.InvisibilitySeatName
		seat.Transparency = 1
		seat.CanCollide = false
		seat.Anchored = false
		seat.Position = Hub.InvisibilitySeatTeleportPosition
		seat.Parent = workspace
		local torso = quickMenu_param_0826:FindFirstChild("Torso") or quickMenu_param_0826:FindFirstChild("UpperTorso")
		if not torso then
			seat:Destroy()
			return false
		end
		local weld = Instance.new("Weld")
		weld.Part0 = seat
		weld.Part1 = torso
		weld.Parent = seat
		local weld2 = Instance.new("Weld")
		weld2.Part0 = seat
		weld2.Part1 = humanoidRootPart
		weld2.Parent = seat
		task.wait()

		pcall(function()
			seat.CFrame = cFrame
		end)

		return true
	end

	local function quickMenu_helperFunc_0827()
		Hub.InvisibilityEnabled = false
		quickMenu_helperFunc_0822()
		quickMenu_helperFunc_0820()
		quickMenu_helperFunc_0823(localPlayer.Character, 0)
	end

	local function quickMenu_helperFunc_0828(quickMenu_param_0829)
		quickMenu_helperFunc_0822()
		if not quickMenu_param_0829 or not quickMenu_param_0829.Parent then
			return
		end
		quickMenu_helperFunc_0823(quickMenu_param_0829, Hub.InvisibilityTransparency)

		Hub.InvisibilityDescAddedConn = quickMenu_param_0829.DescendantAdded:Connect(function(descendant)
			if not Hub.InvisibilityEnabled then
				return
			end

			if descendant:IsA("BasePart") then
				if descendant.Name ~= "HumanoidRootPart" then
					descendant.Transparency = Hub.InvisibilityTransparency
				end

				descendant.LocalTransparencyModifier = Hub.InvisibilityTransparency
			elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
				descendant.Transparency = Hub.InvisibilityTransparency
			end
		end)

		local quickMenu_numericVar_0830 = 0

		Hub.InvisibilityRefreshConn = RunService.Heartbeat:Connect(function()
			if not Hub.InvisibilityEnabled then
				return
			end
			local character_ = localPlayer.Character
			if not character_ or character_ ~= quickMenu_param_0829 then
				return
			end
			local now = tick()
			if now < quickMenu_numericVar_0830 then
				return
			end
			quickMenu_numericVar_0830 = now + 0.2
			quickMenu_helperFunc_0823(character_, Hub.InvisibilityTransparency)
		end)
	end

	quickMenu_helperFunc_0818 = function()
		local character_ = localPlayer.Character or localPlayer.CharacterAdded:Wait()

		if not quickMenu_helperFunc_0825(character_) then
			Hub.InvisibilityEnabled = false

			WindUI:Notify({
				Title = "隐身",
				Content = "本次出生隐身失败。",
				Icon = "x",
				Duration = 2,
			})

			quickMenu_helperFunc_0822()
			return
		end

		quickMenu_helperFunc_0828(character_)
	end

	quickMenu_helperFunc_0819 = function(stealth_param_0831)
		if stealth_param_0831 == Hub.InvisibilityEnabled then
			return
		end
		Hub.InvisibilityEnabled = stealth_param_0831 and true or false

		if Hub.InvisibilityEnabled then
			quickMenu_helperFunc_0818()
		else
			quickMenu_helperFunc_0827()
		end
	end
end

Hub.MM2StartupDataReady = false

local function stealth_helperFunc_0832()
	local stealth_configTable_0833 = {
		{ name = "Fake Dead 1", id = 132384701706046 },
		{ name = "Fake Dead 2", id = 89258194846699 },
		{ name = "Wall Phase (GLITCH)", id = 79017619155911 },
	}

	local stealth_configTable_0834 = {}
	local name = stealth_configTable_0833[1].name
	local stealth_configTable_0835 = {}
	local stealth_configTable_0836 = {}
	local stealth_configTable_0837 = {}
	local stealth_configTable_0838 = {}
	local stealth_textValue_0839 = ""
	local stealth_numericVar_0840 = 1
	local stealth_optionalValue_0841 = nil
	local connection = nil
	local stealth_optionalValue_0842 = nil
	local stealth_boolFlag_0843 = false
	local stealth_boolFlag_0844 = false

	local stealth_configTable_0845 = {
		pages = {},
		page = 1,
		mergedEmotes = {},
		interceptedNames = {},
		interceptedIds = {},
		navigationFrame = nil,
		navigationRetryPending = false,
		navigationRetryCount = 0,
		hookInstalled = false,
		syncedToyOrder = {},
		maxSyncedToyTemplates = 48,
	}

	local stealth_configTable_0846 = {}
	local stealth_configTable_0847 = {}
	local stealth_optionalValue_0848 = nil
	local stealth_optionalValue_0849 = nil
	local stealth_optionalValue_0850 = nil
	local stealth_optionalValue_0851 = nil
	local stealth_optionalValue_0852 = nil

	local function stealth_helperFunc_0853()
		local database = ReplicatedStorage:FindFirstChild("Database")
		local modules = ReplicatedStorage:FindFirstChild("Modules")
		database = database and database:FindFirstChild("Sync")
		modules = modules and modules:FindFirstChild("ProfileData")

		if not stealth_optionalValue_0851 and database then
			local ok, result = pcall(require, database)

			if ok and type(result) == "table" then
				stealth_optionalValue_0851 = result
			end
		end

		if not stealth_optionalValue_0852 and modules then
			local ok, result = pcall(require, modules)

			if ok and type(result) == "table" then
				stealth_optionalValue_0852 = result
			end
		end

		return stealth_optionalValue_0851 ~= nil and stealth_optionalValue_0852 ~= nil
	end

	task.spawn(function()
		local stealth_timestamp_0854 = os.clock() + 5

		while true do
			if foxnameMM2Runtime.alive and not isTerminated then
				if stealth_helperFunc_0853() then
					Hub.MM2StartupDataReady = true
					break
				else
					task.wait(os.clock() < stealth_timestamp_0854 and 0.1 or 1)
					continue
				end
			end

			break
		end
	end)

	local function stealth_helperFunc_0855()
		table.clear(stealth_configTable_0835)
		table.clear(stealth_configTable_0836)

		for _, stealth_loopVar_0856 in ipairs(stealth_configTable_0834) do
			stealth_configTable_0835[stealth_loopVar_0856.name] = stealth_loopVar_0856
			stealth_configTable_0836[tostring(stealth_loopVar_0856.id)] = stealth_loopVar_0856
		end
	end

	stealth_helperFunc_0855()

	local function stealth_helperFunc_0857(stealth_param_0858)
		stealth_param_0858 = stealth_param_0858 and stealth_param_0858.Animation
		stealth_param_0858 = stealth_param_0858 and stealth_param_0858.AnimationId
		return stealth_param_0858 and stealth_param_0858:match("(%d+)") or nil
	end

	local function stealth_helperFunc_0859(stealth_param_0860)
		if connection then
			connection:Disconnect()
			connection = nil
		end

		stealth_param_0860 = stealth_param_0860 and stealth_param_0860:FindFirstChildOfClass("Humanoid")

		if stealth_param_0860 then
			stealth_param_0860 = stealth_param_0860:FindFirstChildOfClass("Animator") or stealth_param_0860:FindFirstChild("Animator")
		end

		if not stealth_param_0860 then
			return
		end

		connection = stealth_param_0860.AnimationPlayed:Connect(function(stealth_param_0861)
			local stealth_callResult_0862 = stealth_helperFunc_0857(stealth_param_0861)

			if stealth_callResult_0862 and stealth_configTable_0836[stealth_callResult_0862] then
				stealth_optionalValue_0841 = stealth_param_0861
				stealth_param_0861:AdjustSpeed(stealth_numericVar_0840)
			end
		end)
	end

	local function stealth_helperFunc_0863()
		if not stealth_optionalValue_0842 then
			return
		end
		local stealth_configTable_0864 = { "None" }
		local stealth_configTable_0865 = {}

		for k in pairs(stealth_configTable_0837) do
			table.insert(stealth_configTable_0865, k)
		end

		table.sort(stealth_configTable_0865)

		for _, stealth_loopVar_0866 in ipairs(stealth_configTable_0865) do
			table.insert(stealth_configTable_0864, stealth_loopVar_0866)
		end

		local stealth_boolFlag_0867 = false

		if stealth_optionalValue_0842.SetValues then
			stealth_boolFlag_0867 = pcall(function()
				stealth_optionalValue_0842:SetValues(YXOpt.list(stealth_configTable_0864))
			end)
		end

		if not stealth_boolFlag_0867 and stealth_optionalValue_0842.Refresh then
			stealth_boolFlag_0867 = pcall(function()
				stealth_optionalValue_0842:Refresh(YXOpt.list(stealth_configTable_0864))
			end)
		end

		if not stealth_boolFlag_0867 and stealth_optionalValue_0842.Update then
			pcall(function()
				stealth_optionalValue_0842:Update(YXOpt.list(stealth_configTable_0864))
			end)
		end
	end

	local function stealth_helperFunc_0868()
		if stealth_optionalValue_0841 then
			pcall(function()
				stealth_optionalValue_0841:Stop(0.15)
			end)

			stealth_optionalValue_0841 = nil
		end
	end

	local function stealth_helperFunc_0869(stealth_param_0870, stealth_param_0871)
		stealth_helperFunc_0868()
		if not stealth_param_0870 or stealth_param_0870 == "None" then
			return nil
		end
		local stealth_localValue_0872 = stealth_configTable_0838[stealth_param_0870]

		if stealth_localValue_0872 and not stealth_param_0871 then
			local playEmote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Misc") and ReplicatedStorage.Remotes.Misc:FindFirstChild("PlayEmote")
			if playEmote and playEmote:IsA("BindableEvent") then
				playEmote:Fire(stealth_localValue_0872)
				return true
			end
		end

		local stealth_localValue_0873 = stealth_configTable_0837[stealth_param_0870]
		local character_ = localPlayer.Character
		local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
		if not stealth_localValue_0873 or not humanoid then
			return nil
		end
		stealth_configTable_0845.humanoid = humanoid
		local stealth_optionalValue_0874 = nil

		local ok, result, result2 = pcall(function()
			return humanoid:PlayEmoteAndGetAnimTrackById(stealth_localValue_0873)
		end)

		if ok then
			if typeof(result) == "Instance" and result:IsA("AnimationTrack") then
				stealth_optionalValue_0874 = result
			elseif result == true and typeof(result2) == "Instance" and result2:IsA("AnimationTrack") then
				stealth_optionalValue_0874 = result2
			end
		end

		if not stealth_optionalValue_0874 then
			local animator = humanoid:FindFirstChildOfClass("Animator") or humanoid:FindFirstChild("Animator")

			if not animator then
				animator = Instance.new("Animator")
				animator.Parent = humanoid
			end

			local animation = Instance.new("Animation")
			animation.AnimationId = "rbxassetid://" .. tostring(stealth_localValue_0873)

			local ok2, result3 = pcall(function()
				return animator:LoadAnimation(animation)
			end)

			animation:Destroy()

			if ok2 then
				stealth_optionalValue_0874 = result3

				pcall(function()
					stealth_optionalValue_0874:Play(0.15)
				end)
			end
		end

		if stealth_optionalValue_0874 then
			stealth_optionalValue_0841 = stealth_optionalValue_0874

			pcall(function()
				stealth_optionalValue_0874:AdjustSpeed(stealth_numericVar_0840)
			end)
		end

		return stealth_optionalValue_0874
	end

	Hub.TouchButtons.ToggleWallPhaseButton = function(stealth_param_0875)
		local wallPhaseButtonState = Hub.WallPhaseButtonState
		wallPhaseButtonState.enabled = stealth_param_0875 and true or false

		if wallPhaseButtonState.enabled then
			Hub.TouchButtons.Create(wallPhaseButtonState, "Foxname_MM2_WallPhaseButton", "WallPhaseButton", "Wall Glitch", function()
				return false
			end, function()
				local wallPhaseAssist = Hub.WallPhaseAssist

				if wallPhaseAssist and type(wallPhaseAssist.Run) == "function" then
					wallPhaseAssist.Run()
				end
			end, true)
		else
			Hub.TouchButtons.Destroy(wallPhaseButtonState)
		end
	end

	Hub.WallPhaseAssist = { busy = false, emoteName = "Wall Phase (GLITCH)", maxWallDistance = 3 }

	Hub.WallPhaseAssist.Run = function()
		local wallPhaseAssist = Hub.WallPhaseAssist
		if wallPhaseAssist.busy or not foxnameMM2Runtime.alive then
			return false
		end
		wallPhaseAssist.busy = true
		local character_ = localPlayer.Character
		local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = character_ and character_:FindFirstChild("HumanoidRootPart")
		local currentCamera2 = workspace.CurrentCamera

		if not character_ or not humanoid or humanoid.Health <= 0 or not humanoidRootPart or not currentCamera2 then
			wallPhaseAssist.busy = false

			WindUI:Notify({
				Title = "穿墙",
				Content = "角色或相机尚未就绪。",
				Icon = "x",
				Duration = 2,
			})

			return false
		end

		local vector = Vector3.new(currentCamera2.CFrame.LookVector.X, 0, currentCamera2.CFrame.LookVector.Z)

		if vector.Magnitude < 0.01 then
			vector = Vector3.new(humanoidRootPart.CFrame.LookVector.X, 0, humanoidRootPart.CFrame.LookVector.Z)
		end

		local unit = vector.Unit
		local vector2 = Vector3.new(humanoidRootPart.CFrame.LookVector.X, 0, humanoidRootPart.CFrame.LookVector.Z)
		local unit2 = vector2.Magnitude > 0.01 and vector2.Unit or unit
		local stealth_configTable_0876 = {}
		local stealth_vectorValue_0877 = unit:Cross(Vector3.new(0, 1, 0))
		local stealth_vectorValue_0878 = -unit:Cross(Vector3.new(0, 1, 0))
		stealth_configTable_0876[1] = -unit
		stealth_configTable_0876[2] = -unit2
		stealth_configTable_0876[3] = unit
		stealth_configTable_0876[4] = unit2
		stealth_configTable_0876[5] = stealth_vectorValue_0877
		stealth_configTable_0876[6] = stealth_vectorValue_0878
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.FilterDescendantsInstances = { character_ }
		raycastParams.IgnoreWater = true
		local hit = nil

		for _, stealth_loopVar_0879 in ipairs(stealth_configTable_0876) do
			hit = workspace:Raycast(humanoidRootPart.Position, stealth_loopVar_0879.Unit * wallPhaseAssist.maxWallDistance, raycastParams)
			if not (hit and hit.Instance and hit.Instance:IsA("BasePart") and hit.Instance.CanCollide and math.abs(hit.Normal.Y) < 0.45) then
				hit = nil
				continue
			end
			break
		end

		if not hit then
			wallPhaseAssist.busy = false

			WindUI:Notify({
				Title = "穿墙",
				Content = "附近没有墙，请站在距墙 3 格以内。",
				Icon = "scan-search",
				Duration = 3,
			})

			return false
		end

		local stealth_vectorValue_0880 = humanoidRootPart.Position + Vector3.new(0, 1.5, 0)
		local stealth_cframeValue_0881 = currentCamera2.CFrame.Position - stealth_vectorValue_0880

		if Vector3.new(stealth_cframeValue_0881.X, 0, stealth_cframeValue_0881.Z).Magnitude < 0.5 then
			stealth_cframeValue_0881 = Vector3.new(0, 2, 8)
		end

		local vector3 = Vector3.new(-stealth_cframeValue_0881.X, stealth_cframeValue_0881.Y, -stealth_cframeValue_0881.Z)
		local cameraType = currentCamera2.CameraType
		currentCamera2.CameraType = Enum.CameraType.Scriptable
		currentCamera2.CFrame = CFrame.lookAt(stealth_vectorValue_0880 + vector3, stealth_vectorValue_0880, Vector3.new(0, 1, 0))
		RunService.RenderStepped:Wait()

		local ok, result, result2 = pcall(function()
			return humanoid:PlayEmoteAndGetAnimTrackById(79017619155911)
		end)

		local isAnimationTrack = typeof(result) == "Instance" and result:IsA("AnimationTrack") and result
		local isAnimationTrack2

		if isAnimationTrack then
			isAnimationTrack2 = isAnimationTrack
		else
			isAnimationTrack2 = result == true and typeof(result2) == "Instance" and result2:IsA("AnimationTrack") and result2 or nil
		end

		local stealth_boolFlag_0882

		if ok then
			stealth_boolFlag_0882 = result == true or isAnimationTrack2 ~= nil
		else
			stealth_boolFlag_0882 = ok
		end

		if not stealth_boolFlag_0882 then
			currentCamera2.CameraType = cameraType
			wallPhaseAssist.busy = false

			WindUI:Notify({
				Title = "穿墙",
				Content = "动作播放失败，请勿移动或重生后重试。",
				Icon = "x",
				Duration = 3,
			})

			return false
		end

		if isAnimationTrack2 then
			stealth_optionalValue_0841 = isAnimationTrack2

			pcall(function()
				isAnimationTrack2:AdjustSpeed(stealth_numericVar_0840)
			end)
		end

		task.wait(0.5)
		currentCamera2.CameraType = cameraType
		RunService.RenderStepped:Wait()
		local stealth_boolFlag_0883 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
		local ok2, result3 = pcall(game.GetService, game, "VirtualInputManager")

		if not ok2 then
			result3 = nil
		end

		local ok3

		if stealth_boolFlag_0883 then
			local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
			local stealth_optionalValue_0884 = nil

			if playerGui then
				for _, descendant in ipairs(playerGui:GetDescendants()) do
					if descendant:IsA("GuiButton") then
						local stealth_textValue_0885 = string.lower(tostring(descendant.Name) .. " " .. tostring(descendant:IsA("TextButton") and descendant.Text or "") .. " " .. tostring(descendant:GetAttribute("Action") or ""))
						if stealth_textValue_0885:find("shiftlock", 1, true) or stealth_textValue_0885:find("shift lock", 1, true) or stealth_textValue_0885:find("mouselock", 1, true) or stealth_textValue_0885:find("mouse lock", 1, true) then
							stealth_optionalValue_0884 = descendant
							break
						end
					end
				end
			end

			if stealth_optionalValue_0884 and type(firesignal) == "function" then
				ok3 = pcall(function()
					firesignal(stealth_optionalValue_0884.Activated)
				end)
			else
				local stealth_localValue_0886 = stealth_optionalValue_0884 and result3
				ok3 = false

				if stealth_localValue_0886 then
					local stealth_numericVar_0887 = stealth_optionalValue_0884.AbsolutePosition + stealth_optionalValue_0884.AbsoluteSize / 2

					ok3 = pcall(function()
						result3:SendMouseButtonEvent(stealth_numericVar_0887.X, stealth_numericVar_0887.Y, 0, true, game, 0)
						RunService.RenderStepped:Wait()
						result3:SendMouseButtonEvent(stealth_numericVar_0887.X, stealth_numericVar_0887.Y, 0, false, game, 0)
					end)
				end
			end
		else
			ok3 = false

			if result3 then
				ok3 = pcall(function()
					result3:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
					RunService.RenderStepped:Wait()
					result3:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
				end)
			end
		end

		if ok3 then
			RunService.RenderStepped:Wait()

			pcall(function()
				local cameraRelative = Enum.RotationType.CameraRelative
				UserSettings():GetService("UserGameSettings").RotationType = cameraRelative
			end)

			pcall(function()
				UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
			end)
		end

		local stealth_boolFlag_0888

		if not ok3 then
			local lookVector = currentCamera2.CFrame.LookVector
			local vector4 = Vector3.new(lookVector.X, 0, lookVector.Z)

			if vector4.Magnitude > 0.01 then
				humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
				humanoidRootPart.CFrame = CFrame.lookAt(humanoidRootPart.Position, humanoidRootPart.Position + vector4.Unit, Vector3.new(0, 1, 0))
				stealth_boolFlag_0888 = true
			else
				stealth_boolFlag_0888 = ok3
			end
		else
			stealth_boolFlag_0888 = ok3
		end

		wallPhaseAssist.busy = false

		if not stealth_boolFlag_0888 then
			WindUI:Notify({
				Title = "穿墙",
				Content = "动作已开始，但 Shift Lock 或角色转向失败。",
				Icon = "triangle-alert",
				Duration = 3,
			})

			return false
		end

		WindUI:Notify({ Title = "穿墙", Content = "成功！", Icon = "door-open", Duration = 3 })
		return true
	end

	local function stealth_helperFunc_0889()
		local character_ = localPlayer.Character
		local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
		stealth_configTable_0845.humanoid = humanoid

		if humanoid then
			humanoid = humanoid:FindFirstChildOfClass("HumanoidDescription") or humanoid:FindFirstChild("HumanoidDescription") or humanoid:WaitForChild("HumanoidDescription", 3)
		end

		return humanoid, character_
	end

	local stealth_optionalValue_0890 = nil

	local function stealth_helperFunc_0891(stealth_param_0892)
		local stealth_callResult_0893, stealth_callResult_0894 = stealth_helperFunc_0889()
		local stealth_numericVar_0895 = #stealth_configTable_0845.pages
		if not stealth_callResult_0893 or stealth_numericVar_0895 == 0 then
			return false
		end
		stealth_configTable_0845.page = math.clamp(stealth_configTable_0845.page, 1, stealth_numericVar_0895)
		local stealth_localValue_0896 = stealth_configTable_0845.pages[stealth_configTable_0845.page]

		if not pcall(function()
			stealth_callResult_0893:SetEmotes(stealth_configTable_0845.mergedEmotes)
			stealth_callResult_0893:SetEquippedEmotes(stealth_localValue_0896)
		end) then
			return false
		end

		pcall(function()
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, true)
		end)

		stealth_helperFunc_0859(stealth_callResult_0894)

		task.defer(function()
			if stealth_optionalValue_0890 then
				stealth_optionalValue_0890()
			end
		end)

		if stealth_param_0892 then
			task.delay(0.12, function()
				pcall(function()
					GuiService:SetEmotesMenuOpen(true)
				end)
			end)
		end

		return true
	end

	stealth_optionalValue_0890 = function()
		local stealth_numericVar_0897 = #stealth_configTable_0845.pages
		local navigationFrame = stealth_configTable_0845.navigationFrame

		if navigationFrame and not navigationFrame.Parent then
			stealth_configTable_0845.navigationFrame = nil
			navigationFrame = nil
		end

		local robloxGui = game:GetService("CoreGui"):FindFirstChild("RobloxGui")
		robloxGui = robloxGui and robloxGui:FindFirstChild("EmotesMenu")
		robloxGui = robloxGui and robloxGui:FindFirstChild("Children")
		local main = robloxGui and robloxGui:FindFirstChild("Main")
		local emotesWheel = main and main:FindFirstChild("EmotesWheel")

		if not emotesWheel then
			if not stealth_configTable_0845.navigationRetryPending and stealth_configTable_0845.navigationRetryCount < 12 then
				stealth_configTable_0845.navigationRetryCount = stealth_configTable_0845.navigationRetryCount + 1
				stealth_configTable_0845.navigationRetryPending = true

				task.delay(0.25, function()
					stealth_configTable_0845.navigationRetryPending = false
					stealth_optionalValue_0890()
				end)
			end

			return
		end

		stealth_configTable_0845.navigationRetryCount = 0

		pcall(function()
			emotesWheel.ClipsDescendants = false
		end)

		navigationFrame = navigationFrame or emotesWheel:FindFirstChild("FoxnameEmotePages")

		if not navigationFrame then
			navigationFrame = Instance.new("Frame")
			navigationFrame.Name = "FoxnameEmotePages"
			navigationFrame.AnchorPoint = Vector2.new(0.5, 0)
			navigationFrame.Position = UDim2.new(0.5, 0, 1, 12)
			navigationFrame.Size = UDim2.fromOffset(150, 34)
			navigationFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
			navigationFrame.BackgroundTransparency = 0.15
			navigationFrame.BorderSizePixel = 0
			navigationFrame.ZIndex = 100
			navigationFrame.Parent = emotesWheel
			local uiCorner = Instance.new("UICorner")
			uiCorner.CornerRadius = UDim.new(0, 10)
			uiCorner.Parent = navigationFrame
			local textButton = Instance.new("TextButton")
			textButton.Name = "Previous"
			textButton.Size = UDim2.fromOffset(42, 34)
			textButton.BackgroundTransparency = 1
			textButton.Text = "<"
			textButton.TextColor3 = Color3.new(1, 1, 1)
			textButton.TextSize = 22
			textButton.Font = Enum.Font.GothamBold
			textButton.ZIndex = 101
			textButton.Parent = navigationFrame
			local textLabel = Instance.new("TextLabel")
			textLabel.Name = "Page"
			textLabel.Position = UDim2.fromOffset(42, 0)
			textLabel.Size = UDim2.fromOffset(66, 34)
			textLabel.BackgroundTransparency = 1
			textLabel.TextColor3 = Color3.new(1, 1, 1)
			textLabel.TextSize = 15
			textLabel.Font = Enum.Font.GothamSemibold
			textLabel.ZIndex = 101
			textLabel.Parent = navigationFrame
			local textButton2 = Instance.new("TextButton")
			textButton2.Name = "Next"
			textButton2.Position = UDim2.fromOffset(108, 0)
			textButton2.Size = UDim2.fromOffset(42, 34)
			textButton2.BackgroundTransparency = 1
			textButton2.Text = ">"
			textButton2.TextColor3 = Color3.new(1, 1, 1)
			textButton2.TextSize = 22
			textButton2.Font = Enum.Font.GothamBold
			textButton2.ZIndex = 101
			textButton2.Parent = navigationFrame

			textButton.Activated:Connect(function()
				local stealth_numericVar_0898 = #stealth_configTable_0845.pages
				if stealth_numericVar_0898 <= 1 then
					return
				end
				stealth_configTable_0845.page = (stealth_configTable_0845.page - 2) % stealth_numericVar_0898 + 1
				stealth_helperFunc_0891(false)
			end)

			textButton2.Activated:Connect(function()
				local stealth_numericVar_0899 = #stealth_configTable_0845.pages
				if stealth_numericVar_0899 <= 1 then
					return
				end
				stealth_configTable_0845.page = stealth_configTable_0845.page % stealth_numericVar_0899 + 1
				stealth_helperFunc_0891(false)
			end)
		end

		stealth_configTable_0845.navigationFrame = navigationFrame
		navigationFrame.Visible = stealth_numericVar_0897 > 1
		local page = navigationFrame:FindFirstChild("Page")

		if page then
			page.Text = string.format("%d / %d", stealth_configTable_0845.page, math.max(stealth_numericVar_0897, 1))
		end
	end

	local function stealth_helperFunc_0900()
		if stealth_configTable_0845.hookInstalled or not hookSupported then
			return
		end
		local stealth_optionalValue_0901 = nil

		stealth_configTable_0845.hookInstalled = pcall(function()
			local function stealth_helperFunc_0902(stealth_param_0903, ...)
				local stealth_textValue_0904 = table.pack(...)
				local stealth_callResult_0905 = getnamecallmethod()
				if stealth_param_0903 ~= stealth_configTable_0845.humanoid then
					return stealth_optionalValue_0901(stealth_param_0903, ...)
				end
				local value = select(1, ...)

				if stealth_callResult_0905 == "PlayEmote" and type(value) == "string" then
					if stealth_configTable_0845.interceptedNames[value] then
						task.defer(function()
							stealth_helperFunc_0869(value, true)
						end)

						return true
					end
				elseif stealth_callResult_0905 == "PlayEmoteAndGetAnimTrackById" and type(checkcaller) == "function" and not checkcaller() then
					local stealth_localValue_0906 = stealth_configTable_0845.interceptedIds[tostring(value)]
					if stealth_localValue_0906 then
						local stealth_callResult_0907 = stealth_helperFunc_0869(stealth_localValue_0906, true)
						return stealth_callResult_0907 ~= nil, stealth_callResult_0907
					end
				end

				return stealth_optionalValue_0901(stealth_param_0903, table.unpack(stealth_textValue_0904, 1, stealth_textValue_0904.n))
			end

			if type(newcclosure) == "function" then
				stealth_helperFunc_0902 = newcclosure(stealth_helperFunc_0902)
			end

			stealth_optionalValue_0901 = hookmetamethod(game, "__namecall", stealth_helperFunc_0902)
		end) and type(stealth_optionalValue_0901) == "function"

		if not stealth_configTable_0845.hookInstalled then
			hookSupported = false
		end
	end

	local function stealth_helperFunc_0908()
		local stealth_callResult_0909 = stealth_helperFunc_0889()
		if not stealth_callResult_0909 then
			return false
		end
		local mergedEmotes = {}
		local stealth_configTable_0910 = {}
		local stealth_configTable_0911 = {}
		local stealth_configTable_0912 = { stealth_callResult_0909 }

		local ok, result = pcall(function()
			return Players:GetHumanoidDescriptionFromUserId(localPlayer.UserId)
		end)

		if not ok or typeof(result) ~= "Instance" or not result:IsA("HumanoidDescription") then
			result = nil
		end

		if result then
			table.insert(stealth_configTable_0912, result)
		end

		for _, stealth_loopVar_0913 in ipairs(stealth_configTable_0912) do
			local ok2, result2 = pcall(function()
				return stealth_loopVar_0913:GetEmotes()
			end)

			if ok2 and type(result2) == "table" then
				for k, stealth_loopVar_0914 in pairs(result2) do
					if type(k) == "string" and k ~= "Next Emote Page" and k:sub(1, 6) ~= "MM2 - " and type(stealth_loopVar_0914) == "table" and not mergedEmotes[k] then
						local stealth_configTable_0915 = {}

						for _, stealth_loopVar_0916 in ipairs(stealth_loopVar_0914) do
							if tonumber(stealth_loopVar_0916) then
								table.insert(stealth_configTable_0915, tonumber(stealth_loopVar_0916))
							end
						end

						if #stealth_configTable_0915 > 0 then
							mergedEmotes[k] = stealth_configTable_0915
						end
					end
				end
			end
		end

		for _, stealth_loopVar_0917 in ipairs(stealth_configTable_0912) do
			local ok2, result2 = pcall(function()
				return stealth_loopVar_0917:GetEquippedEmotes()
			end)

			if ok2 and type(result2) == "table" then
				local stealth_configTable_0918 = {}

				for i, stealth_loopVar_0919 in ipairs(result2) do
					if type(stealth_loopVar_0919) ~= "string" then
						local stealth_optionalValue_0920 = nil

						if type(stealth_loopVar_0919) == "table" then
							local name2 = stealth_loopVar_0919.Name or stealth_loopVar_0919.name
							local stealth_numericVar_0921 = tonumber(stealth_loopVar_0919.Slot or stealth_loopVar_0919.slot)

							if stealth_numericVar_0921 then
								stealth_loopVar_0919 = name2
								i = stealth_numericVar_0921
							else
								stealth_loopVar_0919 = name2
							end
						else
							stealth_loopVar_0919 = stealth_optionalValue_0920
						end
					end

					if type(stealth_loopVar_0919) == "string" then
						table.insert(stealth_configTable_0918, { name = stealth_loopVar_0919, slot = i })
					end
				end

				table.sort(stealth_configTable_0918, function(stealth_param_0922, stealth_param_0923)
					return stealth_param_0922.slot < stealth_param_0923.slot
				end)

				for _, stealth_loopVar_0924 in ipairs(stealth_configTable_0918) do
					if not (#stealth_configTable_0910 >= 8) then
						local stealth_numericVar_0925 = mergedEmotes[stealth_loopVar_0924.name]
						stealth_numericVar_0925 = stealth_numericVar_0925 and tonumber(stealth_numericVar_0925[1])
						local stealth_boolFlag_0926 = stealth_loopVar_0924.name == "Next Emote Page" or stealth_loopVar_0924.name:sub(1, 6) == "MM2 - "

						if stealth_numericVar_0925 then
							for _, stealth_loopVar_0927 in ipairs(stealth_configTable_0834) do
								if tonumber(stealth_loopVar_0927.id) == stealth_numericVar_0925 then
									stealth_boolFlag_0926 = true
									break
								end
							end
						end

						if not stealth_boolFlag_0926 and mergedEmotes[stealth_loopVar_0924.name] and not stealth_configTable_0911[stealth_loopVar_0924.name] then
							stealth_configTable_0911[stealth_loopVar_0924.name] = true
							table.insert(stealth_configTable_0910, stealth_loopVar_0924.name)
						end

						continue
					end

					break
				end
			end
		end

		table.clear(stealth_configTable_0837)
		table.clear(stealth_configTable_0836)
		table.clear(stealth_configTable_0838)
		table.clear(stealth_configTable_0845.interceptedNames)
		table.clear(stealth_configTable_0845.interceptedIds)

		for k, mergedEmote in pairs(mergedEmotes) do
			local stealth_numericVar_0928 = tonumber(mergedEmote[1])

			if stealth_numericVar_0928 then
				stealth_configTable_0837[k] = stealth_numericVar_0928
				stealth_configTable_0836[tostring(stealth_numericVar_0928)] = true
			end
		end

		local stealth_configTable_0929 = {}

		for _, stealth_loopVar_0930 in ipairs(stealth_configTable_0834) do
			if stealth_loopVar_0930.nativeSelector == false or not hookSupported then
				stealth_configTable_0837[stealth_loopVar_0930.name] = stealth_loopVar_0930.id
				stealth_configTable_0836[tostring(stealth_loopVar_0930.id)] = stealth_loopVar_0930

				if stealth_loopVar_0930.gameKey then
					stealth_configTable_0838[stealth_loopVar_0930.name] = stealth_loopVar_0930.gameKey
				end
			else
				local name2 = stealth_loopVar_0930.name
				local stealth_numericVar_0931 = 2

				while mergedEmotes[name2] and tonumber(mergedEmotes[name2][1]) ~= tonumber(stealth_loopVar_0930.id) do
					name2 = stealth_loopVar_0930.name .. " (" .. stealth_numericVar_0931 .. ")"
					stealth_numericVar_0931 += 1
				end

				mergedEmotes[name2] = { stealth_loopVar_0930.id }
				stealth_configTable_0837[name2] = stealth_loopVar_0930.id
				stealth_configTable_0836[tostring(stealth_loopVar_0930.id)] = stealth_loopVar_0930

				if stealth_loopVar_0930.gameKey then
					stealth_configTable_0838[name2] = stealth_loopVar_0930.gameKey
				end

				stealth_configTable_0845.interceptedNames[name2] = true
				stealth_configTable_0845.interceptedIds[tostring(stealth_loopVar_0930.id)] = name2
				table.insert(stealth_configTable_0929, name2)
			end
		end

		local stealth_configTable_0932 = {}
		local stealth_configTable_0933 = {}

		for _, stealth_loopVar_0934 in ipairs(stealth_configTable_0910) do
			if not stealth_configTable_0933[stealth_loopVar_0934] then
				stealth_configTable_0933[stealth_loopVar_0934] = true
				table.insert(stealth_configTable_0932, stealth_loopVar_0934)
			end
		end

		for _, stealth_loopVar_0935 in ipairs(stealth_configTable_0929) do
			if not stealth_configTable_0933[stealth_loopVar_0935] then
				stealth_configTable_0933[stealth_loopVar_0935] = true
				table.insert(stealth_configTable_0932, stealth_loopVar_0935)
			end
		end

		table.clear(stealth_configTable_0845.pages)

		for i = 1, #stealth_configTable_0932, 8 do
			local stealth_configTable_0936 = {}

			for i2 = i, math.min(i + 8 - 1, #stealth_configTable_0932) do
				table.insert(stealth_configTable_0936, stealth_configTable_0932[i2])
			end

			table.insert(stealth_configTable_0845.pages, stealth_configTable_0936)
		end

		if #stealth_configTable_0845.pages == 0 then
			table.insert(stealth_configTable_0845.pages, {})
		end

		stealth_configTable_0845.mergedEmotes = mergedEmotes
		stealth_configTable_0845.page = math.clamp(stealth_configTable_0845.page, 1, #stealth_configTable_0845.pages)
		stealth_helperFunc_0900()
		local stealth_callResult_0937 = stealth_helperFunc_0891(false)

		pcall(function()
			GuiService:SetEmotesMenuOpen(false)
		end)

		stealth_helperFunc_0863()

		if typeof(result) == "Instance" and result:IsA("HumanoidDescription") and result.Parent == nil then
			result:Destroy()
		end

		return stealth_callResult_0937
	end

	Hub.SyncReadySelectorEmote = function(stealth_param_0938)
		local stealth_optionalValue_0939 = nil

		for _, stealth_loopVar_0940 in ipairs(stealth_configTable_0833) do
			if stealth_loopVar_0940.name == stealth_param_0938 then
				stealth_optionalValue_0939 = stealth_loopVar_0940
				break
			else
				stealth_optionalValue_0939 = nil
			end
		end

		if not stealth_optionalValue_0939 then
			WindUI:Notify({ Title = "可用动作", Content = "请先选择一个动作。", Icon = "x", Duration = 2 })
			return false
		end

		for _, stealth_loopVar_0941 in ipairs(stealth_configTable_0834) do
			if stealth_loopVar_0941.id == stealth_optionalValue_0939.id then
				WindUI:Notify({ Title = "动作已同步", Content = stealth_optionalValue_0939.name, Icon = "info", Duration = 2 })
				return true
			end
		end

		table.insert(stealth_configTable_0834, { name = stealth_optionalValue_0939.name, id = stealth_optionalValue_0939.id })
		stealth_helperFunc_0855()
		if stealth_helperFunc_0908() then
			WindUI:Notify({ Title = "动作同步完成", Content = stealth_optionalValue_0939.name, Icon = "check", Duration = 2 })
			return true
		end
		table.remove(stealth_configTable_0834, #stealth_configTable_0834)
		stealth_helperFunc_0855()
		WindUI:Notify({ Title = "选择器错误", Content = "请重生后重新同步。", Icon = "x", Duration = 2 })
		return false
	end

	local function stealth_helperFunc_0942(stealth_param_0943)
		local match = tostring(stealth_param_0943 or ""):match("^%s*(.-)%s*$")
		if match == "" then
			return nil
		end
		local stealth_numericVar_0944 = tonumber(match:match("/catalog/(%d+)") or match:match("rbxassetid://(%d+)") or match:match("[?&]id=(%d+)") or match:match("^%d+$") or match:match("(%d%d%d%d%d+)"))
		if not stealth_numericVar_0944 or stealth_numericVar_0944 <= 0 then
			return nil
		end
		local match2 = match:match("^%s*([^:\r\n]+)%s*:%s*https?://")
		local match3 = match:match("/catalog/%d+/([^?/#]+)")
		match2 = match2 or match3
		match2 = match2 and match2:gsub("%%20", " "):gsub("[_%-]+", " "):match("^%s*(.-)%s*$")

		if not match2 or match2 == "" then
			match2 = "Custom Emote " .. tostring(stealth_numericVar_0944)
		end

		return stealth_numericVar_0944, match2
	end

	local function stealth_helperFunc_0945(stealth_param_0946)
		local stealth_callResult_0947, stealth_callResult_0948 = stealth_helperFunc_0942(stealth_param_0946)

		if not stealth_callResult_0947 then
			WindUI:Notify({
				Title = "无效动作",
				Content = "请输入 Roblox 商店链接或动画 ID",
				Icon = "x",
				Duration = 2,
			})

			return
		end

		for _, stealth_loopVar_0949 in ipairs(stealth_configTable_0834) do
			if stealth_loopVar_0949.id == stealth_callResult_0947 then
				WindUI:Notify({ Title = "动作已存在", Content = stealth_loopVar_0949.name, Icon = "info", Duration = 2 })
				return
			end
		end

		local stealth_numericVar_0950 = 2
		local stealth_textValue_0951 = stealth_callResult_0948

		while stealth_configTable_0835[stealth_textValue_0951] do
			stealth_textValue_0951 = stealth_callResult_0948 .. " (" .. stealth_numericVar_0950 .. ")"
			stealth_numericVar_0950 += 1
		end

		local stealth_fieldTable_0952 = { name = stealth_textValue_0951, id = stealth_callResult_0947 }
		table.insert(stealth_configTable_0834, stealth_fieldTable_0952)
		stealth_configTable_0835[stealth_textValue_0951] = stealth_fieldTable_0952
		stealth_configTable_0836[tostring(stealth_callResult_0947)] = stealth_fieldTable_0952

		if stealth_helperFunc_0908() then
			WindUI:Notify({ Title = "动作已添加", Content = stealth_textValue_0951, Icon = "check", Duration = 2 })
		else
			WindUI:Notify({ Title = "选择器错误", Content = "请重生后重试", Icon = "x", Duration = 2 })
		end
	end

	local function stealth_helperFunc_0953(stealth_param_0954, stealth_param_0955)
		if type(stealth_param_0954) ~= "table" or table.find(stealth_param_0954, stealth_param_0955) then
			return false
		end
		table.insert(stealth_param_0954, stealth_param_0955)
		return true
	end

	local function stealth_helperFunc_0956(stealth_param_0957, stealth_param_0958)
		local remotes = ReplicatedStorage:FindFirstChild("Remotes")
		remotes = remotes and remotes:FindFirstChild("Inventory")
		local inventoryDataChanged = remotes and remotes:FindFirstChild("InventoryDataChanged")

		if inventoryDataChanged and inventoryDataChanged:IsA("BindableEvent") then
			pcall(function()
				inventoryDataChanged:Fire(stealth_param_0957, stealth_param_0958, 1)
			end)
		end
	end

	local function stealth_helperFunc_0959()
		local emotes = stealth_optionalValue_0851 and stealth_optionalValue_0851.Emotes
		local owned = stealth_optionalValue_0852 and stealth_optionalValue_0852.Emotes and stealth_optionalValue_0852.Emotes.Owned
		if type(emotes) ~= "table" then
			WindUI:Notify({ Title = "同步失败", Content = "未找到 MM2 动作数据库", Icon = "x", Duration = 2 })
			return
		end
		local stealth_numericVar_0960 = 0

		for k, emote in pairs(emotes) do
			local stealth_numericVar_0961 = type(emote) == "table" and tonumber(emote.AnimationID)

			if stealth_numericVar_0961 then
				local stealth_boolFlag_0962 = false

				for _, stealth_loopVar_0963 in ipairs(stealth_configTable_0834) do
					if stealth_loopVar_0963.id == stealth_numericVar_0961 or stealth_loopVar_0963.gameKey == k then
						stealth_boolFlag_0962 = true
						break
					end
				end

				if not stealth_boolFlag_0962 then
					table.insert(stealth_configTable_0834, {
						name = "MM2 - " .. tostring(emote.Name or k),
						id = stealth_numericVar_0961,
						gameKey = k,
						nativeSelector = false,
					})

					stealth_numericVar_0960 += 1
				end

				stealth_helperFunc_0953(owned, k)
			end
		end

		stealth_helperFunc_0855()
		stealth_helperFunc_0908()
		stealth_helperFunc_0956("Emotes", "Synced")

		WindUI:Notify({
			Title = "游戏内动作已同步",
			Content = tostring(stealth_numericVar_0960) .. " new emote(s) added",
			Icon = "check",
			Duration = 2,
		})
	end

	local function stealth_helperFunc_0964()
		if not stealth_optionalValue_0848 then
			return
		end
		local stealth_configTable_0965 = {}
		table.clear(stealth_configTable_0847)

		for k in pairs(stealth_configTable_0846) do
			local toys = stealth_optionalValue_0851 and stealth_optionalValue_0851.Toys and stealth_optionalValue_0851.Toys[k]
			local stealth_callResult_0966 = type(toys) == "table"

			if stealth_callResult_0966 then
				stealth_callResult_0966 = tostring(toys.Name or k)
			end

			local stealth_localValue_0967 = stealth_callResult_0966 or k

			if stealth_configTable_0847[stealth_localValue_0967] and stealth_configTable_0847[stealth_localValue_0967] ~= k then
				stealth_localValue_0967 ..= " [" .. k .. "]"
			end

			stealth_configTable_0847[stealth_localValue_0967] = k
			table.insert(stealth_configTable_0965, stealth_localValue_0967)
		end

		table.sort(stealth_configTable_0965)

		if #stealth_configTable_0965 == 0 then
			stealth_configTable_0965 = { "(No synced items)" }
		end

		local stealth_textValue_0968 = table.concat(stealth_configTable_0965, "\0")
		if stealth_textValue_0968 == stealth_optionalValue_0850 then
			return
		end
		stealth_optionalValue_0850 = stealth_textValue_0968
		local stealth_boolFlag_0969 = false

		if stealth_optionalValue_0848.SetValues then
			stealth_boolFlag_0969 = pcall(function()
				stealth_optionalValue_0848:SetValues(YXOpt.list(stealth_configTable_0965))
			end)
		end

		if not stealth_boolFlag_0969 and stealth_optionalValue_0848.Refresh then
			stealth_boolFlag_0969 = pcall(function()
				stealth_optionalValue_0848:Refresh(YXOpt.list(stealth_configTable_0965))
			end)
		end

		if not stealth_boolFlag_0969 and stealth_optionalValue_0848.Update then
			pcall(function()
				stealth_optionalValue_0848:Update(YXOpt.list(stealth_configTable_0965))
			end)
		end
	end

	local function stealth_helperFunc_0970(stealth_param_0971)
		if not stealth_param_0971 or not stealth_param_0971:IsA("Tool") or stealth_configTable_0846[stealth_param_0971.Name] then
			return false
		end
		local clone = stealth_param_0971:Clone()
		clone.Parent = nil
		stealth_configTable_0846[stealth_param_0971.Name] = clone
		table.insert(stealth_configTable_0845.syncedToyOrder, stealth_param_0971.Name)

		while stealth_configTable_0845.maxSyncedToyTemplates < #stealth_configTable_0845.syncedToyOrder do
			local emoteUI_localValue_0972 = table.remove(stealth_configTable_0845.syncedToyOrder, 1)
			local emoteUI_localValue_0973 = stealth_configTable_0846[emoteUI_localValue_0972]

			if emoteUI_localValue_0973 then
				emoteUI_localValue_0973:Destroy()
				stealth_configTable_0846[emoteUI_localValue_0972] = nil
				stealth_optionalValue_0850 = nil
			end
		end

		local owned = stealth_optionalValue_0852 and stealth_optionalValue_0852.Emotes and stealth_optionalValue_0852.Emotes.Owned
		stealth_helperFunc_0953(stealth_optionalValue_0852 and stealth_optionalValue_0852.Toys and stealth_optionalValue_0852.Toys.Owned, stealth_param_0971.Name)
		stealth_helperFunc_0953(owned, stealth_param_0971.Name)
		return true
	end

	local function emoteUI_helperFunc_0974(emoteUI_param_0975)
		local emoteUI_numericVar_0976 = 0

		for _, player in ipairs(Players:GetPlayers()) do
			local backpack = player:FindFirstChildOfClass("Backpack")
			backpack = backpack and backpack:FindFirstChild("Toys")

			if backpack then
				for _, child in ipairs(backpack:GetChildren()) do
					if stealth_helperFunc_0970(child) then
						emoteUI_numericVar_0976 += 1
					end
				end
			end
		end

		if emoteUI_numericVar_0976 > 0 then
			stealth_helperFunc_0964()
			stealth_helperFunc_0956("Toys", "Synced")
		end

		if not emoteUI_param_0975 then
			WindUI:Notify({
				Title = "游戏内道具已同步",
				Content = tostring(emoteUI_numericVar_0976) .. " new item(s) found",
				Icon = "check",
				Duration = 2,
			})
		end
	end

	local function emoteUI_helperFunc_0977(emoteUI_param_0978)
		if emoteUI_param_0978 then
			emoteUI_param_0978 = stealth_configTable_0847[emoteUI_param_0978] or emoteUI_param_0978
		end

		local emoteUI_localValue_0979 = emoteUI_param_0978 and stealth_configTable_0846[emoteUI_param_0978]
		local backpack = localPlayer:FindFirstChildOfClass("Backpack")
		local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

		if not emoteUI_localValue_0979 or not backpack or not humanoid then
			WindUI:Notify({
				Title = "道具不可用",
				Content = "请在有玩家的服务器中重新同步道具",
				Icon = "x",
				Duration = 2,
			})

			return
		end

		local emoteUI_localValue_0980 = backpack:FindFirstChild(emoteUI_param_0978)

		if emoteUI_localValue_0980 and emoteUI_localValue_0980:GetAttribute("FoxnameSyncedItem") then
			emoteUI_localValue_0980:Destroy()
		end

		local character_ = localPlayer.Character and localPlayer.Character:FindFirstChild(emoteUI_param_0978)

		if character_ and character_:GetAttribute("FoxnameSyncedItem") then
			character_:Destroy()
		end

		local clone = emoteUI_localValue_0979:Clone()
		clone:SetAttribute("FoxnameSyncedItem", true)
		clone.Parent = backpack
		humanoid:EquipTool(clone)
	end

	trackConn(Players.DescendantAdded:Connect(function(descendant)
		if not stealth_boolFlag_0844 or not descendant:IsA("Tool") or not descendant.Parent or descendant.Parent.Name ~= "Toys" or not descendant:FindFirstAncestorOfClass("Player") then
			return
		end

		if stealth_helperFunc_0970(descendant) then
			stealth_helperFunc_0964()
			stealth_helperFunc_0956("Toys", descendant.Name)
		end
	end))

	trackConn(localPlayer.CharacterAdded:Connect(function(character_)
		stealth_optionalValue_0841 = nil

		task.delay(1, function()
			stealth_helperFunc_0859(character_)
			stealth_helperFunc_0908()
		end)
	end))

	task.defer(function()
		stealth_helperFunc_0859(localPlayer.Character)
		stealth_helperFunc_0908()
	end)

	Hub.CleanupSelector = function()
		stealth_boolFlag_0843 = false
		stealth_boolFlag_0844 = false

		if Hub.WallPhaseAssist then
			Hub.WallPhaseAssist.busy = false
		end

		if connection then
			connection:Disconnect()
			connection = nil
		end

		stealth_helperFunc_0868()

		for k, emoteUI_loopVar_0981 in pairs(stealth_configTable_0846) do
			if emoteUI_loopVar_0981 then
				pcall(function()
					emoteUI_loopVar_0981:Destroy()
				end)
			end

			stealth_configTable_0846[k] = nil
		end

		table.clear(stealth_configTable_0847)
		table.clear(stealth_configTable_0845.syncedToyOrder)
		stealth_optionalValue_0850 = nil
		local character_ = localPlayer.Character

		for _, emoteUI_loopVar_0982 in ipairs({ localPlayer:FindFirstChildOfClass("Backpack"), character_ }) do
			if emoteUI_loopVar_0982 then
				for _, child in ipairs(emoteUI_loopVar_0982:GetChildren()) do
					if child:GetAttribute("FoxnameSyncedItem") then
						child:Destroy()
					end
				end
			end
		end
	end

	task.wait(UI_BUILD_DELAY)

	Tabs.Anims:Dropdown({
		Title = "可用动作",
		Values = { "假死 1", "假死 2", "穿墙卡位（异常）" },
		Value = YXOpt.zh(name),
		AllowNone = false,
		Callback = function(emoteUI_param_0983)
			emoteUI_param_0983 = YXOpt.en(emoteUI_param_0983)
			name = tostring(emoteUI_param_0983 or "")
		end,
	})

	Tabs.Anims:Button({
		Title = "同步选中的动作",
		Icon = "download",
		Callback = function()
			Hub.SyncReadySelectorEmote(name)
		end,
	})

	Tabs.Anims:Divider()

	Tabs.Anims:Input({
		Title = "添加自定义动作",
		Type = "Input",
		Desc = "动作商店链接或 ID",
		Callback = function(emoteUI_param_0984)
			stealth_textValue_0839 = tostring(emoteUI_param_0984 or "")
		end,
	})

	Tabs.Anims:Button({
		Title = "添加自定义动作",
		Callback = function()
			stealth_helperFunc_0945(stealth_textValue_0839)
		end,
	})

	Hub.AutoGunTouchControl = services_dataTable_0104.General:Toggle({
		Title = "瞬间自动拿枪（不传送）",
		Flag = "General_InstantAutoTakeGun",
		Default = false,
		LockedTitle = "刷币开启时自动启用并锁定。",
		Callback = function(emoteUI_param_0985)
			Hub.SetAutoGunTouchSource("misc", emoteUI_param_0985)
		end,
	})

	Hub.SetCoinFarmAutoGunTouch = function(emoteUI_param_0986)
		if emoteUI_param_0986 then
			if not Hub.AutoGunTouchForcedByCoinFarm then
				Hub.AutoGunTouchBeforeCoinFarm = Hub.AutoGunTouchSources.misc == true
			end

			Hub.AutoGunTouchForcedByCoinFarm = true
			Hub.SetAutoGunTouchSource("misc", true)
			Hub.AutoGunTouchControl:Unlock()
			Hub.AutoGunTouchControl:Set(true, false, true)
			Hub.AutoGunTouchControl:Lock()
		else
			Hub.AutoGunTouchControl:Unlock()

			if Hub.AutoGunTouchForcedByCoinFarm then
				Hub.AutoGunTouchForcedByCoinFarm = false
				Hub.SetAutoGunTouchSource("misc", Hub.AutoGunTouchBeforeCoinFarm)
				Hub.AutoGunTouchControl:Set(Hub.AutoGunTouchBeforeCoinFarm, false, true)
			end
		end
	end

	services_dataTable_0104.General:Keybind({
		Title = "穿墙快捷键",
		Flag = "Anims_WallPhaseKeybind",
		Value = "G",
		Callback = function()
			Hub.WallPhaseAssist.Run()
		end,
	})

	services_dataTable_0104.General:Toggle({
		Title = "穿墙按钮",
		Flag = "Anims_WallPhaseButton",
		Default = false,
		Callback = function(emoteUI_param_0987)
			Hub.TouchButtons.ToggleWallPhaseButton(emoteUI_param_0987)
		end,
	})

	services_dataTable_0104.General:Dropdown({
		Title = "穿墙按钮大小",
		Flag = "Anims_WallPhaseButtonSize",
		Values = { "小", "中", "大" },
		Value = YXOpt.zh(Hub.WallPhaseButtonState.size),
		Callback = function(size)
			size = YXOpt.en(size)
			if Hub.TouchButtons.Sizes[size] then
				Hub.WallPhaseButtonState.size = size
				Hub.TouchButtons.ApplySize(Hub.WallPhaseButtonState.button, size, Hub.WallPhaseButtonState.shape)
			end
		end,
	})

	services_dataTable_0104.General:Dropdown({
		Title = "穿墙按钮形状",
		Flag = "Anims_WallPhaseButtonShape",
		Values = { "方形", "矩形" },
		Value = YXOpt.zh(Hub.WallPhaseButtonState.shape),
		Callback = function(emoteUI_param_0988)
			emoteUI_param_0988 = YXOpt.en(emoteUI_param_0988)
			Hub.WallPhaseButtonState.shape = emoteUI_param_0988 == "Rectangle" and "Rectangle" or "Square"
			Hub.TouchButtons.ApplySize(Hub.WallPhaseButtonState.button, Hub.WallPhaseButtonState.size, Hub.WallPhaseButtonState.shape)
			Hub.TouchButtons.UpdateHoldHint(Hub.WallPhaseButtonState, Hub.WallPhaseButtonState.button)
		end,
	})

	services_dataTable_0104.General:Colorpicker({
		Title = "穿墙图标颜色",
		Flag = "Anims_WallPhaseButtonColor",
		Default = Hub.WallPhaseButtonState.outlineColor,
		Callback = function(outlineColor)
			Hub.WallPhaseButtonState.outlineColor = outlineColor
			Hub.TouchButtons.ApplyAppearance(Hub.WallPhaseButtonState.button, Hub.WallPhaseButtonState)
		end,
	})

	services_dataTable_0104.General:Toggle({
		Title = "穿墙按钮可拖动",
		Flag = "Anims_WallPhaseButtonDraggable",
		Default = Hub.WallPhaseButtonState.draggable,
		Callback = function(emoteUI_param_0989)
			Hub.WallPhaseButtonState.draggable = emoteUI_param_0989 and true or false
		end,
	})

	task.wait(UI_BUILD_DELAY)

	Tabs.Anims:Button({
		Title = "同步游戏内动作",
		Callback = function()
			stealth_helperFunc_0959()
		end,
	})

	Tabs.Anims:Toggle({
		Title = "自动同步游戏内动作",
		Flag = "Anims_AutoSyncInGameEmotes",
		Default = false,
		Callback = function(emoteUI_param_0990)
			stealth_boolFlag_0843 = emoteUI_param_0990 and true or false

			if stealth_boolFlag_0843 then
				task.defer(stealth_helperFunc_0959)
			end
		end,
	})

	stealth_optionalValue_0842 = Tabs.Anims:Dropdown({
		Title = "播放动作",
		Values = { "无" },
		Value = YXOpt.zh("None"),
		Callback = function(emoteUI_param_0991)
			emoteUI_param_0991 = YXOpt.en(emoteUI_param_0991)
			stealth_helperFunc_0869(emoteUI_param_0991)
		end,
	})

	Tabs.Anims:Slider({
		Title = "动作速度",
		Flag = "Anims_AnimationSpeed",
		Value = { Min = 0.1, Max = 3, Default = 1 },
		Step = 0.1,
		Callback = function(emoteUI_param_0992)
			stealth_numericVar_0840 = tonumber(emoteUI_param_0992) or 1

			if stealth_optionalValue_0841 and stealth_optionalValue_0841.IsPlaying then
				stealth_optionalValue_0841:AdjustSpeed(stealth_numericVar_0840)
			end
		end,
	})

	Tabs.Anims:Divider()

	Tabs.Anims:Button({
		Title = "同步游戏内道具",
		Callback = function()
			emoteUI_helperFunc_0974(false)
		end,
	})

	Tabs.Anims:Toggle({
		Title = "自动同步游戏内道具",
		Flag = "Anims_AutoSyncInGameItems",
		Default = false,
		Callback = function(emoteUI_param_0993)
			stealth_boolFlag_0844 = emoteUI_param_0993 and true or false

			if stealth_boolFlag_0844 then
				task.defer(emoteUI_helperFunc_0974, true)
			end
		end,
	})

	stealth_optionalValue_0848 = Tabs.Anims:Dropdown({
		Title = "游戏内道具",
		Values = { "（暂无同步项目）" },
		Value = YXOpt.zh(nil),
		Callback = function(emoteUI_param_0994)
			emoteUI_param_0994 = YXOpt.en(emoteUI_param_0994)
			if emoteUI_param_0994 ~= "(No synced items)" then
				stealth_optionalValue_0849 = emoteUI_param_0994
			end
		end,
	})

	Tabs.Anims:Button({
		Title = "装备选中道具",
		Callback = function()
			emoteUI_helperFunc_0977(stealth_optionalValue_0849)
		end,
	})
end

stealth_helperFunc_0832()

do
	local SoundService = game:GetService("SoundService")
	local playSong = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Inventory") and ReplicatedStorage.Remotes.Inventory:FindFirstChild("PlaySong")
	local emoteUI_textValue_0995 = "Server (FE)"
	local emoteUI_textValue_0996 = ""
	local emoteUI_numericVar_0997 = 50
	local looped = false
	local sound = nil
	local emoteUI_boolFlag_0998 = false
	local obj = setmetatable({}, { __mode = "k" })
	local connection = nil
	local connection2 = nil

	local function emoteUI_helperFunc_0999(emoteUI_param_1000)
		if not emoteUI_param_1000 or not emoteUI_param_1000:IsA("Sound") or emoteUI_param_1000 == sound then
			return false
		end

		for _, player in ipairs(Players:GetPlayers()) do
			local character_ = player ~= localPlayer and player.Character or nil

			if character_ and emoteUI_param_1000:IsDescendantOf(character_) then
				while emoteUI_param_1000 and emoteUI_param_1000 ~= character_ do
					local emoteUI_textValue_1001 = emoteUI_param_1000.Name:lower()
					if emoteUI_textValue_1001:find("radio", 1, true) or emoteUI_textValue_1001:find("boombox", 1, true) then
						return true
					end
					emoteUI_param_1000 = emoteUI_param_1000.Parent
				end

				return false
			end
		end

		return false
	end

	local function emoteUI_helperFunc_1002(emoteUI_param_1003)
		local emoteUI_localValue_1004 = obj[emoteUI_param_1003]
		if not emoteUI_localValue_1004 then
			return
		end

		if emoteUI_localValue_1004.connection then
			emoteUI_localValue_1004.connection:Disconnect()
		end

		if emoteUI_param_1003 and emoteUI_param_1003.Parent then
			pcall(function()
				emoteUI_param_1003.Volume = emoteUI_localValue_1004.volume
			end)
		end

		obj[emoteUI_param_1003] = nil
	end

	local function emoteUI_helperFunc_1005(descendant)
		if not emoteUI_boolFlag_0998 or not emoteUI_helperFunc_0999(descendant) or obj[descendant] then
			return
		end

		obj[descendant] = {
			volume = descendant.Volume,
			connection = descendant:GetPropertyChangedSignal("Volume"):Connect(function()
				if emoteUI_boolFlag_0998 and descendant.Parent and descendant.Volume ~= 0 then
					descendant.Volume = 0
				end
			end),
		}

		descendant.Volume = 0
	end

	local function emoteUI_helperFunc_1006(emoteUI_param_1007)
		emoteUI_boolFlag_0998 = emoteUI_param_1007 and true or false

		if not emoteUI_boolFlag_0998 then
			if connection then
				connection:Disconnect()
				connection = nil
			end

			if connection2 then
				connection2:Disconnect()
				connection2 = nil
			end

			for k in pairs(obj) do
				emoteUI_helperFunc_1002(k)
			end

			return
		end

		if not connection then
			connection = workspace.DescendantAdded:Connect(emoteUI_helperFunc_1005)
		end

		if not connection2 then
			connection2 = workspace.DescendantRemoving:Connect(function(descendant)
				if obj[descendant] then
					emoteUI_helperFunc_1002(descendant)
				end
			end)
		end

		task.spawn(function()
			for i, descendant in ipairs(workspace:GetDescendants()) do
				if emoteUI_boolFlag_0998 then
					if descendant:IsA("Sound") then
						emoteUI_helperFunc_1005(descendant)
					end

					if i % 250 == 0 then
						RunService.Heartbeat:Wait()
					end

					continue
				end

				break
			end
		end)
	end

	local function emoteUI_helperFunc_1008()
		if sound and sound.Parent then
			return sound
		end
		local foxnameLocalRadio = SoundService:FindFirstChild("FoxnameLocalRadio")

		if foxnameLocalRadio then
			foxnameLocalRadio:Destroy()
		end

		sound = Instance.new("Sound")
		sound.Name = "FoxnameLocalRadio"
		sound.Volume = emoteUI_numericVar_0997 / 100
		sound.Looped = looped
		sound.Parent = SoundService
		return sound
	end

	local function emoteUI_helperFunc_1009(emoteUI_param_1010)
		local match = tostring(emoteUI_param_1010 or ""):match("(%d+)")
		if not match or tonumber(match) == 0 then
			return nil
		end
		return match
	end

	local function emoteUI_helperFunc_1011(emoteUI_param_1012)
		local emoteUI_callResult_1013 = emoteUI_helperFunc_1008()
		emoteUI_callResult_1013:Stop()
		emoteUI_callResult_1013.SoundId = "rbxassetid://" .. emoteUI_param_1012
		emoteUI_callResult_1013.TimePosition = 0
		emoteUI_callResult_1013:Play()
	end

	local function emoteUI_helperFunc_1014()
		local emoteUI_callResult_1015 = emoteUI_helperFunc_1009(emoteUI_textValue_0996)

		if not emoteUI_callResult_1015 then
			WindUI:Notify({
				Title = "收音机",
				Content = "请输入有效的 Roblox 音频 ID。",
				Icon = "triangle-alert",
				Duration = 3,
			})

			return
		end

		if emoteUI_textValue_0995 == "Server (FE)" then
			if localPlayer:GetAttribute("Radio") and playSong and playSong:IsA("RemoteEvent") then
				playSong:FireServer("https://www.roblox.com/asset/?id=" .. emoteUI_callResult_1015)

				WindUI:Notify({
					Title = "服务器收音机 (FE)",
					Content = "通过 MM2 服务器收音机播放。",
					Icon = "radio",
					Duration = 3,
				})

				return
			end

			emoteUI_helperFunc_1011(emoteUI_callResult_1015)

			WindUI:Notify({
				Title = "收音机",
				Content = "未检测到 MM2 收音机权限，改为本地播放。",
				Icon = "headphones",
				Duration = 4,
			})

			return
		end

		emoteUI_helperFunc_1011(emoteUI_callResult_1015)
	end

	local function emoteUI_helperFunc_1016()
		if sound then
			sound:Stop()
			sound.SoundId = ""
		end

		if emoteUI_textValue_0995 == "Server (FE)" and localPlayer:GetAttribute("Radio") and playSong and playSong:IsA("RemoteEvent") then
			playSong:FireServer("")
		end
	end

	task.wait(UI_BUILD_DELAY)

	Tabs.Radio:Paragraph({
		Title = "服务器收音机 (FE)",
		Desc = "服务器 (FE) 模式使用 MM2 的同步收音机，需要收音机权限；本地模式只有你自己能听到。",
		Image = "radio",
		ImageSize = 34,
	})

	Tabs.Radio:Input({
		Title = "音频 ID",
		Type = "Input",
		Placeholder = "输入 Roblox 音频 ID",
		ClearTextOnFocus = false,
		Callback = function(tracerUI_param_1017)
			emoteUI_textValue_0996 = tostring(tracerUI_param_1017 or "")
		end,
	})

	Tabs.Radio:Dropdown({
		Title = "收音机模式",
		Flag = "Radio_Mode",
		Values = { "服务器 (FE)", "本地" },
		Value = YXOpt.zh("Server (FE)"),
		Callback = function(tracerUI_param_1018)
			tracerUI_param_1018 = YXOpt.en(tracerUI_param_1018)
			if tracerUI_param_1018 == "Server (FE)" or tracerUI_param_1018 == "Local" then
				emoteUI_helperFunc_1016()
				emoteUI_textValue_0995 = tracerUI_param_1018
			end
		end,
	})

	task.wait(UI_BUILD_DELAY)

	Tabs.Radio:Slider({
		Title = "本地音量",
		Flag = "Radio_LocalVolume",
		Value = { Min = 0, Max = 100, Default = 50 },
		Step = 1,
		Callback = function(tracerUI_param_1019)
			emoteUI_numericVar_0997 = math.clamp(tonumber(tracerUI_param_1019) or 50, 0, 100)

			if sound then
				sound.Volume = emoteUI_numericVar_0997 / 100
			end
		end,
	})

	Tabs.Radio:Toggle({
		Title = "循环播放本地收音机",
		Flag = "Radio_LocalLoop",
		Default = false,
		Callback = function(tracerUI_param_1020)
			looped = tracerUI_param_1020 and true or false

			if sound then
				sound.Looped = looped
			end
		end,
	})

	Tabs.Radio:Toggle({
		Title = "静音其他玩家的收音机",
		Flag = "Radio_MuteOthers",
		Default = false,
		Callback = emoteUI_helperFunc_1006,
	})

	Tabs.Radio:Button({ Title = "播放收音机", Icon = "play", Callback = emoteUI_helperFunc_1014 })
	Tabs.Radio:Button({ Title = "停止收音机", Icon = "square", Callback = emoteUI_helperFunc_1016 })

	Hub.CleanupRadio = function()
		emoteUI_helperFunc_1006(false)

		if sound then
			sound:Destroy()
			sound = nil
		end
	end
end

do
	local function tracerUI_helperFunc_1021()
		local folder = Hub.BulletTracer.folder
		Hub.BulletTracer.folder = nil

		if folder and folder.Parent then
			folder:Destroy()
		end
	end

	local function tracerUI_helperFunc_1022(tracerUI_param_1023, tracerUI_param_1024)
		local bulletTracer = Hub.BulletTracer
		if not bulletTracer.enabled or not foxnameMM2Runtime.alive then
			return
		end
		local position = typeof(tracerUI_param_1023) == "CFrame" and tracerUI_param_1023.Position or typeof(tracerUI_param_1023) == "Vector3" and tracerUI_param_1023 or typeof(tracerUI_param_1023) == "Instance" and tracerUI_param_1023:IsA("Attachment") and tracerUI_param_1023.WorldPosition

		if not position then
			position = typeof(tracerUI_param_1023) == "Instance" and tracerUI_param_1023:IsA("BasePart") and tracerUI_param_1023.Position
		end

		position = position or nil
		local position2 = typeof(tracerUI_param_1024) == "CFrame" and tracerUI_param_1024.Position or typeof(tracerUI_param_1024) == "Vector3" and tracerUI_param_1024 or typeof(tracerUI_param_1024) == "Instance" and tracerUI_param_1024:IsA("BasePart") and tracerUI_param_1024.Position or nil
		if not position or not position2 then
			return
		end
		local tracerUI_numericVar_1025 = position2 - position
		if tracerUI_numericVar_1025.Magnitude < 0.05 then
			return
		end
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.FilterDescendantsInstances = localPlayer.Character and { localPlayer.Character } or {}
		local hit = workspace:Raycast(position, tracerUI_numericVar_1025, raycastParams)

		if hit then
			position2 = hit.Position
		end

		local magnitude = (position2 - position).Magnitude
		if magnitude < 0.05 then
			return
		end
		local folder = bulletTracer.folder

		if not folder or not folder.Parent then
			folder = Instance.new("Folder")
			folder.Name = "FoxnameLocalBulletTracers_" .. sessionId
			folder.Parent = workspace
			bulletTracer.folder = folder
		end

		local part = Instance.new("Part")
		part.Name = "LocalShotTracer"
		part.Anchored = true
		part.CanCollide = false
		part.CanTouch = false
		part.CanQuery = false
		part.CastShadow = false
		part.Material = Enum.Material.Neon
		part.Color = bulletTracer.color
		part.Transparency = 0.05
		part.Size = Vector3.new(0.35, 0.35, magnitude)
		part.CFrame = CFrame.lookAt(position:Lerp(position2, 0.5), position2)
		part.Parent = folder
		local tracerUI_numericVar_1026 = math.clamp(tonumber(bulletTracer.duration) or 0.35, 0.05, 3)
		local tween = TweenService:Create(part, TweenInfo.new(tracerUI_numericVar_1026, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Transparency = 1 })
		tween:Play()

		task.delay(tracerUI_numericVar_1026 + 0.05, function()
			pcall(function()
				tween:Destroy()
			end)

			if part.Parent then
				part:Destroy()
			end
		end)
	end

	local function tracerUI_helperFunc_1027(tracerUI_param_1028, tracerUI_param_1029, tracerUI_param_1030)
		local character_ = localPlayer.Character
		if not character_ or not Hub.BulletTracer.enabled then
			return
		end

		if not (tracerUI_param_1028 and tracerUI_param_1028:IsDescendantOf(character_) or character_:FindFirstChild("Gun") ~= nil) then
			return
		end
		local now = os.clock()
		local bulletTracer = Hub.BulletTracer
		if now - bulletTracer.lastDrawAt < bulletTracer.shotCooldown then
			return
		end
		bulletTracer.lastDrawAt = now
		tracerUI_helperFunc_1022(tracerUI_param_1029, tracerUI_param_1030)
	end

	pcall(function()
		local weaponEvents = ReplicatedStorage:WaitForChild("WeaponEvents", 3)
		weaponEvents = weaponEvents and weaponEvents:WaitForChild("GunBeam", 3)

		if weaponEvents and weaponEvents:IsA("RemoteEvent") then
			weaponEvents.OnClientEvent:Connect(function(tracerUI_param_1031, tracerUI_param_1032, tracerUI_param_1033)
				tracerUI_helperFunc_1027(tracerUI_param_1031, tracerUI_param_1032, tracerUI_param_1033)
			end)
		end
	end)

	pcall(function()
		local clientServices = ReplicatedStorage:WaitForChild("ClientServices", 3)
		clientServices = clientServices and clientServices:WaitForChild("WeaponService", 3)

		if clientServices then
			local module = require(clientServices)

			if module and module.GunFired and module.GunFired.OnClientEvent then
				module.GunFired.OnClientEvent:Connect(function(tracerUI_param_1034, tracerUI_param_1035, tracerUI_param_1036)
					tracerUI_helperFunc_1027(tracerUI_param_1034, tracerUI_param_1035, tracerUI_param_1036)
				end)
			end
		end
	end)

	task.wait(UI_BUILD_DELAY)

	Tabs.ESP:Toggle({
		Title = "玩家透视 (ESP)",
		Flag = "ESP_Player",
		Callback = function(playerESP)
			Hub.PlayerESP = playerESP
		end,
	})

	Tabs.ESP:Dropdown({
		Title = "玩家透视样式",
		Flag = "ESP_PlayerStyle",
		Values = { "填充", "描边" },
		Value = YXOpt.zh("Filled"),
		Callback = function(playerESPStyle)
			playerESPStyle = YXOpt.en(playerESPStyle)
			if playerESPStyle == "Filled" or playerESPStyle == "Outline" then
				Hub.PlayerESPStyle = playerESPStyle
			end
		end,
	})

	Tabs.ESP:Toggle({
		Title = "线条透视",
		Flag = "ESP_Line",
		Callback = function(lineESP)
			Hub.LineESP = lineESP
		end,
	})

	Tabs.ESP:Toggle({
		Title = "名牌透视",
		Flag = "ESP_Nametag",
		Callback = function(nametagESP)
			Hub.NametagESP = nametagESP
		end,
	})

	Tabs.ESP:Toggle({
		Title = "枪械透视",
		Flag = "ESP_Gun",
		Callback = function(gunESP)
			Hub.GunESP = gunESP
		end,
	})

	Tabs.ESP:Toggle({
		Title = "弹道轨迹",
		Desc = "仅为你自己作为警长/英雄的射击绘制霓虹弹道。",
		Flag = "ESP_BulletTracer",
		Default = false,
		Callback = function(tracerUI_param_1037)
			Hub.BulletTracer.enabled = tracerUI_param_1037 and true or false

			if not Hub.BulletTracer.enabled then
				tracerUI_helperFunc_1021()
			end
		end,
	})
end

Tabs.ESP:Colorpicker({
	Title = "弹道颜色",
	Flag = "ESP_BulletTracerColor",
	Default = Hub.BulletTracer.color,
	Callback = function(color)
		if typeof(color) == "Color3" then
			Hub.BulletTracer.color = color
		end
	end,
})

Tabs.ESP:Slider({
	Title = "弹道持续时间",
	Flag = "ESP_BulletTracerDuration",
	Value = { Min = 1, Max = 5, Default = Hub.BulletTracer.duration },
	Step = 0.5,
	Callback = function(tracerUI_param_1038)
		Hub.BulletTracer.duration = math.clamp(tonumber(tracerUI_param_1038) or 1, 1, 5)
	end,
})

task.wait(UI_BUILD_DELAY)

Tabs.ESP:Toggle({ Title = "金币透视", Flag = "ESP_Coin", Default = false, Callback = crosshair_helperFunc_0410 })

Tabs.ESP:Toggle({
	Title = "360° 透视",
	Desc = "为杀手、警长和掉落的枪显示屏幕外方向箭头。",
	Flag = "ESP_360",
	Callback = function(tracerUI_param_1039)
		Hub.ESP360 = tracerUI_param_1039 and true or false
	end,
})


Tabs.ESP:Toggle({
	Title = "掉落枪提醒",
	Flag = "ESP_DroppedGunNotify",
	Callback = function(tracerUI_param_1040)
		Hub.DroppedGunNotify = tracerUI_param_1040 and true or false

		if Hub.DroppedGunNotify then
			for k in pairs(Hub.GunESPTable) do
				crosshair_helperFunc_0409(k)
			end
		end
	end,
})

Hub.TouchButtons.XRayToggleControl = Tabs.ESP:Toggle({
	Title = "X光",
	Flag = "ESP_XRay",
	Callback = function(tracerUI_param_1041)
		Hub.TouchButtons.SetXRayEnabled(tracerUI_param_1041, false)
	end,
})

Hub.TouchButtons.XRayKeybindControl = Tabs.ESP:Keybind({
	Title = "X光快捷键",
	Flag = "ESP_XRayKeybind",
	Value = "V",
	Callback = function()
		Hub.TouchButtons.SetXRayEnabled(not Hub.XRayEnabled, true)
	end,
})

Tabs.ESP:Toggle({
	Title = "X光按钮",
	Flag = "ESP_XRayButton",
	Default = false,
	Callback = function(tracerUI_param_1042)
		Hub.TouchButtons.ToggleXRayButton(tracerUI_param_1042)
	end,
})

Tabs.ESP:Dropdown({
	Title = "X光按钮大小",
	Flag = "ESP_XRayButtonSize",
	Values = { "小", "中", "大" },
	Value = YXOpt.zh(Hub.XRayButtonState.size),
	Callback = function(size)
		size = YXOpt.en(size)
		if Hub.TouchButtons.Sizes[size] then
			Hub.XRayButtonState.size = size
			Hub.TouchButtons.ApplySize(Hub.XRayButtonState.button, size, Hub.XRayButtonState.shape)
		end
	end,
})

Tabs.ESP:Dropdown({
	Title = "X光按钮形状",
	Flag = "ESP_XRayButtonShape",
	Values = { "方形", "矩形" },
	Value = YXOpt.zh(Hub.XRayButtonState.shape),
	Callback = function(tracerUI_param_1043)
		tracerUI_param_1043 = YXOpt.en(tracerUI_param_1043)
		Hub.XRayButtonState.shape = tracerUI_param_1043 == "Rectangle" and "Rectangle" or "Square"
		Hub.TouchButtons.ApplySize(Hub.XRayButtonState.button, Hub.XRayButtonState.size, Hub.XRayButtonState.shape)
		Hub.TouchButtons.UpdateHoldHint(Hub.XRayButtonState, Hub.XRayButtonState.button)
	end,
})

Tabs.ESP:Colorpicker({
	Title = "X光图标颜色",
	Flag = "ESP_XRayButtonColor",
	Default = Hub.XRayButtonState.outlineColor or Hub.TouchButtons.Theme.accentColor,
	Callback = function(outlineColor)
		Hub.XRayButtonState.outlineColor = outlineColor
		Hub.TouchButtons.ApplyAppearance(Hub.XRayButtonState.button, Hub.XRayButtonState)
	end,
})

Tabs.ESP:Toggle({
	Title = "X光按钮可拖动",
	Flag = "ESP_XRayButtonDraggable",
	Default = Hub.XRayButtonState.draggable,
	Callback = function(tracerUI_param_1044)
		Hub.XRayButtonState.draggable = tracerUI_param_1044 and true or false
	end,
})

do
	local fogColor = Lighting.FogColor

	if typeof(fogColor) == "Color3" and (fogColor.R + fogColor.G + fogColor.B < 0.3) then
		fogColor = Color3.fromRGB(188, 194, 204)
	end

	local worldVisuals = {
		preset = "Default",
		colorEffect = nil,
		bloomEffect = nil,
		sunRaysEffect = nil,
		depthEffect = nil,
		skybox = "Default",
		customSky = nil,
		hiddenSkies = {},
		snowEnabled = false,
		snowDensity = 600,
		snowPart = nil,
		snowEmitter = nil,
		snowConnection = nil,
		fogEnabled = false,
		fogColor = fogColor,
		fogDensity = "Medium",
		fogConnection = nil,
		applyingFog = false,
		original = {
			Ambient = Lighting.Ambient,
			OutdoorAmbient = Lighting.OutdoorAmbient,
			Brightness = Lighting.Brightness,
			ExposureCompensation = Lighting.ExposureCompensation,
			EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
			EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
			GlobalShadows = Lighting.GlobalShadows,
			ShadowSoftness = Lighting.ShadowSoftness,
			FogColor = Lighting.FogColor,
			FogStart = Lighting.FogStart,
			FogEnd = Lighting.FogEnd,
		},
	}

	Hub.WorldVisuals = worldVisuals

	local function createColorCorrectionEffect()
		if worldVisuals.colorEffect and worldVisuals.colorEffect.Parent then
			return worldVisuals.colorEffect
		end
		local tracerUI_textValue_1045 = Lighting:FindFirstChild("FoxnameWorldColor_" .. sessionId)

		if tracerUI_textValue_1045 then
			tracerUI_textValue_1045:Destroy()
		end

		local colorCorrectionEffect = Instance.new("ColorCorrectionEffect")
		colorCorrectionEffect.Name = "FoxnameWorldColor_" .. sessionId
		colorCorrectionEffect.Parent = Lighting
		worldVisuals.colorEffect = colorCorrectionEffect
		return colorCorrectionEffect
	end

	local function tracerUI_helperFunc_1046()
		if not (worldVisuals.bloomEffect and worldVisuals.bloomEffect.Parent) then
			local bloomEffect = Instance.new("BloomEffect")
			bloomEffect.Name = "FoxnameWorldBloom_" .. sessionId
			bloomEffect.Parent = Lighting
			worldVisuals.bloomEffect = bloomEffect
		end

		if not (worldVisuals.sunRaysEffect and worldVisuals.sunRaysEffect.Parent) then
			local sunRaysEffect = Instance.new("SunRaysEffect")
			sunRaysEffect.Name = "FoxnameWorldSunRays_" .. sessionId
			sunRaysEffect.Parent = Lighting
			worldVisuals.sunRaysEffect = sunRaysEffect
		end

		if not (worldVisuals.depthEffect and worldVisuals.depthEffect.Parent) then
			local depthOfFieldEffect = Instance.new("DepthOfFieldEffect")
			depthOfFieldEffect.Name = "FoxnameWorldDepth_" .. sessionId
			depthOfFieldEffect.Parent = Lighting
			worldVisuals.depthEffect = depthOfFieldEffect
		end

		return worldVisuals.bloomEffect, worldVisuals.sunRaysEffect, worldVisuals.depthEffect
	end

	local tracerUI_configTable_1047 = {
		["Purple Nebula"] = {
			Bk = "159454299",
			Dn = "159454296",
			Ft = "159454293",
			Lf = "159454286",
			Rt = "159454300",
			Up = "159454288",
		},
		["Dreamy Sunset"] = {
			Bk = "1417494030",
			Dn = "1417494146",
			Ft = "1417494253",
			Lf = "1417494402",
			Rt = "1417494499",
			Up = "1417494643",
		},
		Redshift = {
			Bk = "401664839",
			Dn = "401664862",
			Ft = "401664960",
			Lf = "401664881",
			Rt = "401664901",
			Up = "401664936",
		},
	}

	local tracerUI_optionalValue_1048 = nil

	local function tracerUI_helperFunc_1049()
		if worldVisuals.customSky then
			worldVisuals.customSky:Destroy()
			worldVisuals.customSky = nil
		end

		for _, hiddenSky in ipairs(worldVisuals.hiddenSkies) do
			if hiddenSky and hiddenSky.Parent == nil then
				hiddenSky.Parent = Lighting
			end
		end

		table.clear(worldVisuals.hiddenSkies)
	end

	local function tracerUI_helperFunc_1050(tracerUI_param_1051)
		local tracerUI_callResult_1052 = tostring(tracerUI_param_1051 or "Default")
		worldVisuals.skybox = tracerUI_configTable_1047[tracerUI_callResult_1052] and tracerUI_callResult_1052 or "Default"
		tracerUI_helperFunc_1049()

		for _, child in ipairs(Lighting:GetChildren()) do
			if child:IsA("Atmosphere") then
				pcall(function()
					child:Destroy()
				end)
			end
		end

		if worldVisuals.skybox == "Default" then
			if worldVisuals.fogEnabled and tracerUI_optionalValue_1048 then
				task.defer(tracerUI_optionalValue_1048)
			end

			return
		end

		for _, child in ipairs(Lighting:GetChildren()) do
			if child:IsA("Sky") then
				table.insert(worldVisuals.hiddenSkies, child)
				child.Parent = nil
			end
		end

		local tracerUI_localValue_1053 = tracerUI_configTable_1047[worldVisuals.skybox]
		if not tracerUI_localValue_1053 then
			return
		end
		local sky = Instance.new("Sky")
		sky.Name = "FoxnameWorldSky_" .. sessionId
		sky.SkyboxBk = "rbxassetid://" .. tracerUI_localValue_1053.Bk
		sky.SkyboxDn = "rbxassetid://" .. tracerUI_localValue_1053.Dn
		sky.SkyboxFt = "rbxassetid://" .. tracerUI_localValue_1053.Ft
		sky.SkyboxLf = "rbxassetid://" .. tracerUI_localValue_1053.Lf
		sky.SkyboxRt = "rbxassetid://" .. tracerUI_localValue_1053.Rt
		sky.SkyboxUp = "rbxassetid://" .. tracerUI_localValue_1053.Up
		sky.CelestialBodiesShown = true
		sky.SunAngularSize = 0
		sky.MoonAngularSize = 0
		sky.StarCount = 3000
		sky.Parent = Lighting
		worldVisuals.customSky = sky

		if worldVisuals.fogEnabled and tracerUI_optionalValue_1048 then
			task.defer(tracerUI_optionalValue_1048)
		end
	end

	local function tracerUI_helperFunc_1054()
		if worldVisuals.fogConnection then
			worldVisuals.fogConnection:Disconnect()
			worldVisuals.fogConnection = nil
		end
	end

	local function tracerUI_helperFunc_1055()
		if worldVisuals.snowConnection then
			worldVisuals.snowConnection:Disconnect()
			worldVisuals.snowConnection = nil
		end

		if worldVisuals.snowPart then
			worldVisuals.snowPart:Destroy()
			worldVisuals.snowPart = nil
			worldVisuals.snowEmitter = nil
		end
	end

	local function tracerUI_helperFunc_1056(tracerUI_param_1057)
		worldVisuals.snowEnabled = tracerUI_param_1057 and true or false
		tracerUI_helperFunc_1055()
		if not worldVisuals.snowEnabled then
			return
		end
		local part = Instance.new("Part")
		part.Name = "FoxnameSnowEmitter_" .. sessionId
		part.Anchored = true
		part.CanCollide = false
		part.CanQuery = false
		part.CanTouch = false
		part.CastShadow = false
		part.Transparency = 1
		part.Size = Vector3.new(96, 1, 96)
		part.Parent = workspace
		local particleEmitter = Instance.new("ParticleEmitter")
		particleEmitter.Name = "Snowflakes"
		particleEmitter.Texture = "rbxassetid://8158344433"
		particleEmitter.Rate = worldVisuals.snowDensity
		particleEmitter.Lifetime = NumberRange.new(3.6, 5.2)
		particleEmitter.Speed = NumberRange.new(12, 19)
		particleEmitter.Acceleration = Vector3.new(1.8, -4.2, 0.9)
		particleEmitter.Drag = 0.65
		particleEmitter.Rotation = NumberRange.new(0, 360)
		particleEmitter.RotSpeed = NumberRange.new(-55, 55)
		local numberSequence = NumberSequence.new
		local worldVisual_configTable_1058 = {}
		local worldVisual_localValue_1059 = NumberSequenceKeypoint.new(0, 0.38)
		local worldVisual_localValue_1060 = NumberSequenceKeypoint.new(0.7, 0.27)
		local new = NumberSequenceKeypoint.new
		worldVisual_configTable_1058[1] = worldVisual_localValue_1059
		worldVisual_configTable_1058[2] = worldVisual_localValue_1060

		do
			local values = table.pack(new(1, 0.08))
			table.move(values, 1, values.n, 3, worldVisual_configTable_1058)
		end

		particleEmitter.Size = numberSequence(worldVisual_configTable_1058)
		local numberSequence2 = NumberSequence.new
		local worldVisual_configTable_1061 = {}
		local worldVisual_localValue_1062 = NumberSequenceKeypoint.new(0, 0.02)
		local worldVisual_localValue_1063 = NumberSequenceKeypoint.new(0.82, 0.1)
		local new2 = NumberSequenceKeypoint.new
		worldVisual_configTable_1061[1] = worldVisual_localValue_1062
		worldVisual_configTable_1061[2] = worldVisual_localValue_1063

		do
			local values = table.pack(new2(1, 1))
			table.move(values, 1, values.n, 3, worldVisual_configTable_1061)
		end

		particleEmitter.Transparency = numberSequence2(worldVisual_configTable_1061)
		particleEmitter.LightInfluence = 0.25
		particleEmitter.LightEmission = 0.58
		particleEmitter.EmissionDirection = Enum.NormalId.Bottom
		particleEmitter.SpreadAngle = Vector2.new(12, 12)

		pcall(function()
			particleEmitter.Shape = Enum.ParticleEmitterShape.Box
			particleEmitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
			particleEmitter.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
		end)

		particleEmitter.Parent = part
		worldVisuals.snowPart = part
		worldVisuals.snowEmitter = particleEmitter
		local worldVisual_numericVar_1064 = 0

		worldVisuals.snowConnection = RunService.Heartbeat:Connect(function(deltaTime)
			worldVisual_numericVar_1064 += deltaTime
			if worldVisual_numericVar_1064 < 0.083333333333333329 then
				return
			end
			worldVisual_numericVar_1064 = 0
			local currentCamera2 = workspace.CurrentCamera
			if not currentCamera2 or not part.Parent then
				return
			end
			local position = currentCamera2.CFrame.Position
			part.CFrame = CFrame.new(position.X, position.Y + 30, position.Z)
		end)
	end

	local worldVisual_optionalValue_1065 = nil

	worldVisual_optionalValue_1065 = function(worldVisual_param_1066)
		if typeof(worldVisual_param_1066) == "Color3" then
			return worldVisual_param_1066
		end

		if type(worldVisual_param_1066) == "string" then
			local match = worldVisual_param_1066:match("^%s*#?([%x][%x][%x][%x][%x][%x])%s*$")
			if not match then
				return nil
			end
			local ok, result = pcall(Color3.fromHex, "#" .. match)
			return ok and result or nil
		end

		if type(worldVisual_param_1066) ~= "table" then
			return nil
		end
		local color = worldVisual_param_1066.Color or worldVisual_param_1066.color or worldVisual_param_1066.Value or worldVisual_param_1066.value

		if color ~= nil then
			local worldVisual_callResult_1067 = worldVisual_optionalValue_1065(color)
			if worldVisual_callResult_1067 then
				return worldVisual_callResult_1067
			end
		end

		local worldVisual_numericVar_1068 = tonumber(worldVisual_param_1066.R or worldVisual_param_1066.r or worldVisual_param_1066[1])
		local worldVisual_numericVar_1069 = tonumber(worldVisual_param_1066.G or worldVisual_param_1066.g or worldVisual_param_1066[2])
		local worldVisual_numericVar_1070 = tonumber(worldVisual_param_1066.B or worldVisual_param_1066.b or worldVisual_param_1066[3])
		if not worldVisual_numericVar_1068 or not worldVisual_numericVar_1069 or not worldVisual_numericVar_1070 then
			return nil
		end

		if worldVisual_numericVar_1068 > 1 or worldVisual_numericVar_1069 > 1 or worldVisual_numericVar_1070 > 1 then
			local clamp = math.clamp
			return Color3.fromRGB(math.clamp(worldVisual_numericVar_1068, 0, 255), math.clamp(worldVisual_numericVar_1069, 0, 255), clamp(worldVisual_numericVar_1070, 0, 255))
		end
		local clamp = math.clamp
		return Color3.new(math.clamp(worldVisual_numericVar_1068, 0, 1), math.clamp(worldVisual_numericVar_1069, 0, 1), clamp(worldVisual_numericVar_1070, 0, 1))
	end

	tracerUI_optionalValue_1048 = function()
		if worldVisuals.applyingFog then
			return
		end
		worldVisuals.applyingFog = true

		if not worldVisuals.fogEnabled then
			Lighting.FogColor = worldVisuals.original.FogColor
			Lighting.FogStart = worldVisuals.original.FogStart
			Lighting.FogEnd = worldVisuals.original.FogEnd
			worldVisuals.applyingFog = false
			return
		end

		local worldVisual_callResult_1071 = tostring(worldVisuals.fogDensity or "Medium")

		local worldVisual_configTable_1072 = {
			Low = { FogStart = 60, FogEnd = 500 },
			Medium = { FogStart = 25, FogEnd = 300 },
			High = { FogStart = 5, FogEnd = 150 },
		}

		local medium = worldVisual_configTable_1072[worldVisual_callResult_1071] or worldVisual_configTable_1072.Medium
		Lighting.FogColor = worldVisuals.fogColor
		Lighting.FogStart = medium.FogStart
		Lighting.FogEnd = medium.FogEnd
		worldVisuals.applyingFog = false
	end

	local function worldVisual_helperFunc_1073(worldVisual_param_1074)
		tracerUI_helperFunc_1054()
		worldVisuals.fogEnabled = worldVisual_param_1074 and true or false
		tracerUI_optionalValue_1048()

		if worldVisuals.fogEnabled then
			worldVisuals.fogConnection = Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
				if worldVisuals.fogEnabled and not worldVisuals.applyingFog then
					task.defer(tracerUI_optionalValue_1048)
				end
			end)
		end
	end

	local function worldVisual_helperFunc_1075(worldVisual_param_1076)
		worldVisuals.preset = tostring(worldVisual_param_1076 or "Default")
		local worldVisual_callResult_1077 = createColorCorrectionEffect()
		local worldVisual_callResult_1078, worldVisual_callResult_1079, worldVisual_callResult_1080 = tracerUI_helperFunc_1046()
		worldVisual_callResult_1077.Enabled = worldVisuals.preset ~= "Default"
		worldVisual_callResult_1077.Brightness = 0
		worldVisual_callResult_1077.Contrast = 0
		worldVisual_callResult_1077.Saturation = 0
		worldVisual_callResult_1077.TintColor = Color3.new(1, 1, 1)
		worldVisual_callResult_1078.Enabled = false
		worldVisual_callResult_1078.Intensity = 0
		worldVisual_callResult_1078.Size = 18
		worldVisual_callResult_1078.Threshold = 1.2
		worldVisual_callResult_1079.Enabled = false
		worldVisual_callResult_1079.Intensity = 0
		worldVisual_callResult_1079.Spread = 0.8
		worldVisual_callResult_1080.Enabled = false
		worldVisual_callResult_1080.FarIntensity = 0
		worldVisual_callResult_1080.FocusDistance = 55
		worldVisual_callResult_1080.InFocusRadius = 40
		worldVisual_callResult_1080.NearIntensity = 0
		Lighting.Ambient = worldVisuals.original.Ambient
		Lighting.OutdoorAmbient = worldVisuals.original.OutdoorAmbient
		Lighting.Brightness = worldVisuals.original.Brightness
		Lighting.ExposureCompensation = worldVisuals.original.ExposureCompensation
		Lighting.EnvironmentDiffuseScale = worldVisuals.original.EnvironmentDiffuseScale
		Lighting.EnvironmentSpecularScale = worldVisuals.original.EnvironmentSpecularScale
		Lighting.GlobalShadows = worldVisuals.original.GlobalShadows
		Lighting.ShadowSoftness = worldVisuals.original.ShadowSoftness

		if worldVisuals.preset == "RTX Reflection & Shaders" then
			worldVisual_callResult_1077.Contrast = 0.12
			worldVisual_callResult_1077.Saturation = 0.1
			worldVisual_callResult_1077.TintColor = Color3.fromRGB(255, 255, 255)
			Lighting.EnvironmentDiffuseScale = 1
			Lighting.EnvironmentSpecularScale = 1
			Lighting.GlobalShadows = true
			Lighting.ShadowSoftness = 0.12
			Lighting.ExposureCompensation = 0.1
			worldVisual_callResult_1078.Enabled = true
			worldVisual_callResult_1078.Intensity = 0.18
			worldVisual_callResult_1078.Size = 28
			worldVisual_callResult_1078.Threshold = 1.05
			worldVisual_callResult_1079.Enabled = true
			worldVisual_callResult_1079.Intensity = 0.045
			worldVisual_callResult_1079.Spread = 0.8
			worldVisual_callResult_1080.Enabled = true
			worldVisual_callResult_1080.FarIntensity = 0.02
			worldVisual_callResult_1080.FocusDistance = 55
			worldVisual_callResult_1080.InFocusRadius = 42
			worldVisual_callResult_1080.NearIntensity = 0.02

			if atmosphere then
				atmosphere.Density = 0.3
				atmosphere.Offset = 0.25
				atmosphere.Haze = 0.15
				atmosphere.Color = Color3.fromRGB(199, 218, 255)
				atmosphere.Decay = Color3.fromRGB(106, 122, 160)
			end
		elseif worldVisuals.preset == "Realistic Shader" then
			worldVisual_callResult_1077.Contrast = 0.09
			worldVisual_callResult_1077.Saturation = 0.06
			worldVisual_callResult_1077.TintColor = Color3.fromRGB(248, 251, 255)
			Lighting.EnvironmentDiffuseScale = 1
			Lighting.EnvironmentSpecularScale = 1
			Lighting.GlobalShadows = true
			Lighting.ShadowSoftness = 0.18
			worldVisual_callResult_1078.Enabled = true
			worldVisual_callResult_1078.Intensity = 0.12
			worldVisual_callResult_1078.Size = 24
			worldVisual_callResult_1078.Threshold = 1.15
			worldVisual_callResult_1079.Enabled = true
			worldVisual_callResult_1079.Intensity = 0.035
			worldVisual_callResult_1079.Spread = 0.76
			worldVisual_callResult_1080.Enabled = true
			worldVisual_callResult_1080.FarIntensity = 0.018
			worldVisual_callResult_1080.FocusDistance = 60
			worldVisual_callResult_1080.InFocusRadius = 46
			worldVisual_callResult_1080.NearIntensity = 0.025

			if atmosphere then
				atmosphere.Density = 0.25
				atmosphere.Offset = 0.1
				atmosphere.Haze = 0.1
			end
		elseif worldVisuals.preset == "Deep Shader" then
			worldVisual_callResult_1077.Contrast = 0.145
			worldVisual_callResult_1077.Saturation = 0.04
			worldVisual_callResult_1077.TintColor = Color3.fromRGB(241, 247, 255)
			Lighting.EnvironmentDiffuseScale = 0.95
			Lighting.EnvironmentSpecularScale = 1
			Lighting.GlobalShadows = true
			Lighting.ShadowSoftness = 0.1
			worldVisual_callResult_1078.Enabled = true
			worldVisual_callResult_1078.Intensity = 0.1
			worldVisual_callResult_1078.Size = 22
			worldVisual_callResult_1078.Threshold = 1.22
			worldVisual_callResult_1080.Enabled = true
			worldVisual_callResult_1080.FarIntensity = 0.025
			worldVisual_callResult_1080.FocusDistance = 52
			worldVisual_callResult_1080.InFocusRadius = 38
			worldVisual_callResult_1080.NearIntensity = 0.035

			if atmosphere then
				atmosphere.Density = 0.35
				atmosphere.Offset = 0.15
				atmosphere.Haze = 0.2
			end
		elseif worldVisuals.preset == "Cinematic" then
			worldVisual_callResult_1077.Contrast = 0.16
			worldVisual_callResult_1077.Saturation = -0.03
			worldVisual_callResult_1077.TintColor = Color3.fromRGB(235, 242, 255)
			Lighting.EnvironmentDiffuseScale = 0.9
			Lighting.EnvironmentSpecularScale = 0.98
			Lighting.GlobalShadows = true
			Lighting.ShadowSoftness = 0.14
			worldVisual_callResult_1078.Enabled = true
			worldVisual_callResult_1078.Intensity = 0.13
			worldVisual_callResult_1078.Size = 26
			worldVisual_callResult_1078.Threshold = 1.16
			worldVisual_callResult_1079.Enabled = true
			worldVisual_callResult_1079.Intensity = 0.028
			worldVisual_callResult_1079.Spread = 0.7
			worldVisual_callResult_1080.Enabled = true
			worldVisual_callResult_1080.FarIntensity = 0.04
			worldVisual_callResult_1080.FocusDistance = 48
			worldVisual_callResult_1080.InFocusRadius = 34
			worldVisual_callResult_1080.NearIntensity = 0.055

			if atmosphere then
				atmosphere.Density = 0.4
				atmosphere.Offset = 0.3
				atmosphere.Haze = 0.25
			end
		elseif worldVisuals.preset == "Soft Shader" then
			worldVisual_callResult_1077.Contrast = 0.055
			worldVisual_callResult_1077.Saturation = 0.03
			worldVisual_callResult_1077.TintColor = Color3.fromRGB(255, 248, 243)
			Lighting.EnvironmentDiffuseScale = 0.95
			Lighting.EnvironmentSpecularScale = 0.95
			Lighting.GlobalShadows = true
			Lighting.ShadowSoftness = 0.28
			worldVisual_callResult_1078.Enabled = true
			worldVisual_callResult_1078.Intensity = 0.09
			worldVisual_callResult_1078.Size = 20
			worldVisual_callResult_1078.Threshold = 1.28
			worldVisual_callResult_1080.Enabled = true
			worldVisual_callResult_1080.FarIntensity = 0.012
			worldVisual_callResult_1080.FocusDistance = 64
			worldVisual_callResult_1080.InFocusRadius = 52
			worldVisual_callResult_1080.NearIntensity = 0.018
		else
			worldVisuals.preset = "Default"
			worldVisual_callResult_1077.Enabled = false
		end
	end

	task.wait(UI_BUILD_DELAY)

	Tabs.ESP:Section({ Title = "光影与着色", TextXAlignment = "Center", TextSize = 17, Opened = true })

	Tabs.ESP:Dropdown({
		Title = "着色预设",
		Flag = "Visuals_WorldPreset",
		Values = {
			"默认",
			"RTX 反射与着色",
			"写实着色",
			"深度着色",
			"电影风格",
			"柔和着色",
		},
		Value = YXOpt.zh("Default"),
		Callback = function(v) worldVisual_helperFunc_1075(YXOpt.en(v)) end,
	})

	Tabs.ESP:Slider({
		Title = "反射高光强度",
		Flag = "Visuals_ReflectionScale",
		Value = { Min = 0, Max = 1, Default = 1 },
		Step = 0.05,
		Callback = function(worldVisual_param_1081)
			Lighting.EnvironmentSpecularScale = math.clamp(tonumber(worldVisual_param_1081) or 1, 0, 1)
			Lighting.EnvironmentDiffuseScale = math.clamp(tonumber(worldVisual_param_1081) or 1, 0, 1)
		end,
	})

	task.wait(UI_BUILD_DELAY)

	Tabs.ESP:Section({ Title = "天空盒 / 天气", TextXAlignment = "Center", TextSize = 17, Opened = true })

	Tabs.ESP:Dropdown({
		Title = "天空盒",
		Flag = "Visuals_Skybox",
		Values = { "默认", "紫色星云", "梦幻日落", "红移" },
		Value = YXOpt.zh("Default"),
		Callback = function(v) tracerUI_helperFunc_1050(YXOpt.en(v)) end,
	})

	Tabs.ESP:Toggle({ Title = "雪花", Flag = "Visuals_Snowflakes", Default = false, Callback = tracerUI_helperFunc_1056 })

	Tabs.ESP:Dropdown({
		Title = "雪花密度",
		Flag = "Visuals_SnowDensityLevel",
		Values = { "低", "中", "高" },
		Value = YXOpt.zh("Medium"),
		Callback = function(worldVisual_param_1082)
			worldVisual_param_1082 = YXOpt.en(worldVisual_param_1082)
			local worldVisual_configTable_1083 = { Low = 300, Medium = 600, High = 1000 }
			worldVisuals.snowDensity = worldVisual_configTable_1083[tostring(worldVisual_param_1082)] or worldVisual_configTable_1083.Medium

			if worldVisuals.snowEmitter then
				worldVisuals.snowEmitter.Rate = worldVisuals.snowDensity
			end
		end,
	})

	Tabs.ESP:Toggle({ Title = "雾效", Flag = "Visuals_Fog", Default = false, Callback = worldVisual_helperFunc_1073 })

	worldVisuals.fogColorControl = Tabs.ESP:Colorpicker({
		Title = "雾颜色",
		Flag = "Visuals_FogColor",
		Default = worldVisuals.fogColor,
		Callback = function(worldVisual_param_1084)
			local worldVisual_callResult_1085 = worldVisual_optionalValue_1065(worldVisual_param_1084)

			if worldVisual_callResult_1085 then
				worldVisuals.fogColor = worldVisual_callResult_1085

				if worldVisuals.fogEnabled then
					tracerUI_optionalValue_1048()
				end
			end
		end,
	})

	Hub.SyncConfigColorValues = function()
		local fogColorControl = worldVisuals.fogColorControl
		fogColorControl = fogColorControl and worldVisual_optionalValue_1065(fogColorControl.Default)

		if fogColorControl then
			worldVisuals.fogColor = fogColorControl
			tracerUI_optionalValue_1048()
		end
	end

	Tabs.ESP:Dropdown({
		Title = "雾浓度",
		Flag = "Visuals_FogDensityLevel",
		Values = { "低", "中", "高" },
		Value = YXOpt.zh("Medium"),
		Callback = function(worldVisual_param_1086)
			worldVisual_param_1086 = YXOpt.en(worldVisual_param_1086)
			local worldVisual_callResult_1087 = tostring(worldVisual_param_1086 or "Medium")
			worldVisuals.fogDensity = (worldVisual_callResult_1087 == "Low" or worldVisual_callResult_1087 == "High") and worldVisual_callResult_1087 or "Medium"

			if worldVisuals.fogEnabled then
				tracerUI_optionalValue_1048()
			end
		end,
	})

	Hub.CleanupWorldVisuals = function()
		tracerUI_helperFunc_1055()
		tracerUI_helperFunc_1054()
		tracerUI_helperFunc_1049()

		if worldVisuals.colorEffect then
			worldVisuals.colorEffect:Destroy()
		end

		if worldVisuals.bloomEffect then
			worldVisuals.bloomEffect:Destroy()
		end

		if worldVisuals.sunRaysEffect then
			worldVisuals.sunRaysEffect:Destroy()
		end

		if worldVisuals.depthEffect then
			worldVisuals.depthEffect:Destroy()
		end

		Lighting.Ambient = worldVisuals.original.Ambient
		Lighting.OutdoorAmbient = worldVisuals.original.OutdoorAmbient
		Lighting.Brightness = worldVisuals.original.Brightness
		Lighting.ExposureCompensation = worldVisuals.original.ExposureCompensation
		Lighting.EnvironmentDiffuseScale = worldVisuals.original.EnvironmentDiffuseScale
		Lighting.EnvironmentSpecularScale = worldVisuals.original.EnvironmentSpecularScale
		Lighting.GlobalShadows = worldVisuals.original.GlobalShadows
		Lighting.ShadowSoftness = worldVisuals.original.ShadowSoftness
		Lighting.FogColor = worldVisuals.original.FogColor
		Lighting.FogStart = worldVisuals.original.FogStart
		Lighting.FogEnd = worldVisuals.original.FogEnd
	end
end

task.wait(UI_BUILD_DELAY)

Tabs.Crosshair:Toggle({
	Title = "自定义准星",
	Flag = "Visuals_CrosshairEnabled",
	Default = false,
	Callback = function(aimUI_param_1088)
		Hub.Crosshair.SetEnabled(aimUI_param_1088)
	end,
})

Tabs.Crosshair:Dropdown({
	Title = "准星样式",
	Flag = "Visuals_CrosshairStyle",
	Values = { "星形", "心形", "圆形加号", "准星" },
	Value = YXOpt.zh(Hub.Crosshair.style),
	Callback = function(style)
		style = YXOpt.en(style)
		if style == "star" or style == "heart" or style == "circle-plus" or style == "crosshair" then
			Hub.Crosshair.style = style

			if Hub.Crosshair.enabled then
				Hub.Crosshair.Rebuild()
			end
		end
	end,
})

Tabs.Crosshair:Dropdown({
	Title = "准星可见性",
	Flag = "Visuals_CrosshairMode",
	Values = { "锁定视角 / 第一人称", "始终" },
	Value = YXOpt.zh(Hub.Crosshair.mode),
	Callback = function(mode)
		mode = YXOpt.en(mode)
		if mode == "Shiftlock / First Person" or mode == "Always" then
			Hub.Crosshair.mode = mode
		end
	end,
})

Tabs.Crosshair:Input({
	Title = "自定义光标名称",
	Desc = "输入 lucide.dev/icons 上的任意图标名",
	Type = "Input",
	Placeholder = "sparkles",
	Callback = function(aimUI_param_1089)
		Hub.Crosshair.SetCustomIcon(aimUI_param_1089)
	end,
})

Tabs.Crosshair:Slider({
	Title = "准星大小",
	Flag = "Visuals_CrosshairSize",
	Value = { Min = 16, Max = 64, Default = Hub.Crosshair.size },
	Step = 1,
	Callback = function(aimUI_param_1090)
		Hub.Crosshair.size = tonumber(aimUI_param_1090) or 30

		if Hub.Crosshair.enabled then
			Hub.Crosshair.Rebuild()
		end
	end,
})

Tabs.Crosshair:Toggle({
	Title = "RGB 准星",
	Flag = "Visuals_CrosshairRGB",
	Default = false,
	Callback = function(aimUI_param_1091)
		Hub.Crosshair.rgb = aimUI_param_1091 and true or false
		Hub.Crosshair.ApplyAppearance()
	end,
})

Hub.Crosshair.colorControl = Tabs.Crosshair:Colorpicker({
	Title = "准星颜色",
	Flag = "Visuals_CrosshairColor",
	Default = Hub.Crosshair.color,
	Callback = function(color)
		if typeof(color) == "Color3" then
			Hub.Crosshair.color = color
			Hub.Crosshair.ApplyAppearance()
		end
	end,
})

local syncConfigColorValues = Hub.SyncConfigColorValues

Hub.SyncConfigColorValues = function()
	if syncConfigColorValues then
		syncConfigColorValues()
	end

	local colorControl = Hub.Crosshair.colorControl
	colorControl = colorControl and colorControl.Default

	if typeof(colorControl) == "Color3" then
		Hub.Crosshair.color = colorControl
		Hub.Crosshair.ApplyAppearance()
	end
end

task.wait(UI_BUILD_DELAY)

Tabs.Combat:Section({ Title = "瞄准", TextXAlignment = "Center", TextSize = 17, Opened = true })

Hub.TouchButtons.AimToggleControl = Tabs.Aim:Toggle({
	Title = "瞄准",
	Flag = "Aim_Enabled",
	Callback = function(aimUI_param_1092)
		Hub.TouchButtons.SetAimEnabled(aimUI_param_1092, false)
	end,
})

Tabs.Aim:Slider({
	Title = "预判强度",
	Flag = "Aim_Prediction_Strength",
	Value = { Min = 1, Max = 15, Default = 5 },
	Step = 1,
	Suffix = "ms*10",
	Callback = function(predictionStrength)
		Hub.PredictionStrength = predictionStrength
	end,
})

Tabs.Aim:Dropdown({
	Title = "瞄准方式",
	Flag = "Aim_Style",
	Values = { "锁定瞄准", "静默瞄准" },
	Value = YXOpt.zh(Hub.AimStyle),
	Callback = function(aimStyle)
		aimStyle = YXOpt.en(aimStyle)
		if aimStyle == "Aimlock" or aimStyle == "Silent Aim" then
			Hub.AimStyle = aimStyle

			if aimStyle == "Silent Aim" and not silentAimSupported then
				WindUI:Notify({
					Title = "静默瞄准",
					Content = "此功能可能不可用！",
					Icon = "triangle-alert",
					Duration = 5,
				})
			end
		end
	end,
})

Tabs.Aim:Keybind({
	Title = "自瞄快捷键",
	Flag = "Aim_Keybind",
	Value = "Q",
	Callback = function()
		Hub.TouchButtons.SetAimEnabled(not Hub.AimEnabled, true)
	end,
})

Tabs.Aim:Toggle({
	Title = "自瞄按钮",
	Flag = "Aim_Button",
	Default = false,
	Callback = function(aimUI_param_1093)
		Hub.TouchButtons.ToggleAimlockButton(aimUI_param_1093)
	end,
})

Tabs.Aim:Dropdown({
	Title = "自瞄按钮大小",
	Flag = "Aim_ButtonSize",
	Values = { "小", "中", "大" },
	Value = YXOpt.zh(Hub.AimlockButtonState.size),
	Callback = function(size)
		size = YXOpt.en(size)
		if Hub.TouchButtons.Sizes[size] then
			Hub.AimlockButtonState.size = size
			Hub.TouchButtons.ApplySize(Hub.AimlockButtonState.button, size, Hub.AimlockButtonState.shape)
		end
	end,
})

Tabs.Aim:Dropdown({
	Title = "自瞄按钮形状",
	Flag = "Aim_ButtonShape",
	Values = { "方形", "矩形" },
	Value = YXOpt.zh(Hub.AimlockButtonState.shape),
	Callback = function(aimUI_param_1094)
		aimUI_param_1094 = YXOpt.en(aimUI_param_1094)
		Hub.AimlockButtonState.shape = aimUI_param_1094 == "Rectangle" and "Rectangle" or "Square"
		Hub.TouchButtons.ApplySize(Hub.AimlockButtonState.button, Hub.AimlockButtonState.size, Hub.AimlockButtonState.shape)
		Hub.TouchButtons.UpdateHoldHint(Hub.AimlockButtonState, Hub.AimlockButtonState.button)
	end,
})

Tabs.Aim:Colorpicker({
	Title = "自瞄图标颜色",
	Flag = "Aim_ButtonColor",
	Default = Hub.AimlockButtonState.outlineColor or Hub.TouchButtons.Theme.accentColor,
	Callback = function(outlineColor)
		Hub.AimlockButtonState.outlineColor = outlineColor
		Hub.TouchButtons.ApplyAppearance(Hub.AimlockButtonState.button, Hub.AimlockButtonState)
	end,
})

Tabs.Aim:Toggle({
	Title = "自瞄按钮可拖动",
	Flag = "Aim_ButtonDraggable",
	Default = Hub.AimlockButtonState.draggable,
	Callback = function(aimUI_param_1095)
		Hub.AimlockButtonState.draggable = aimUI_param_1095 and true or false
	end,
})

Tabs.Aim:Slider({
	Title = "FOV 范围",
	Flag = "Aim_FOVSize",
	Value = { Min = 50, Max = 400, Default = Hub.FOV },
	Step = 5,
	Callback = function(fov)
		Hub.FOV = fov
	end,
})

Tabs.Aim:Dropdown({
	Title = "自瞄部位",
	Flag = "Aim_AimlockPart",
	Values = { "头部", "人物根部件", "躯干" },
	Value = YXOpt.zh(Hub.AimlockPart),
	Callback = function(aimlockPart)
		aimlockPart = YXOpt.en(aimlockPart)
		if aimlockPart == "Head" or aimlockPart == "HumanoidRootPart" or aimlockPart == "Torso" then
			Hub.AimlockPart = aimlockPart
		end
	end,
})

Tabs.Aim:Toggle({
	Title = "隐藏 FOV",
	Flag = "Aim_HideFOV",
	Callback = function(hideFOV)
		Hub.HideFOV = hideFOV
	end,
})

Tabs.Aim:Toggle({
	Title = "仅在担任警长时瞄准",
	Flag = "Aim_OnlyWhileSheriff",
	Callback = function(aimUI_param_1096)
		Hub.OnlyAimWhileSheriff = aimUI_param_1096 and true or false
	end,
})

Tabs.Aim:Toggle({
	Title = "忽略墙体",
	Flag = "Aim_IgnoreWalls",
	Callback = function(ignoreWalls)
		Hub.IgnoreWalls = ignoreWalls
	end,
})

task.wait(UI_BUILD_DELAY)

Tabs.Combat:Section({ Title = "警长", TextXAlignment = "Center", TextSize = 17, Opened = true })

Hub.TouchButtons.AutoShootToggleControl = services_dataTable_0104.Sheriff:Toggle({
	Title = "自动射击按钮",
	Flag = "Sheriff_AutoShootButton",
	Desc = "需要持有枪才能使用",
	Default = Hub.AutoShootDragState.enabled,
	Callback = function(aimUI_param_1097)
		Hub.TouchButtons.ToggleAutoShootButton(aimUI_param_1097)
	end,
})

services_dataTable_0104.Sheriff:Dropdown({
	Title = "自动射击模式",
	Flag = "Sheriff_AutoShootMode",
	Values = { "普通", "穿墙" },
	Value = YXOpt.zh(Hub.AutoShootState.mode),
	Callback = function(mode)
		mode = YXOpt.en(mode)
		if mode == "Normal" or mode == "Behind Walls" then
			Hub.AutoShootState.mode = mode
		end
	end,
})

services_dataTable_0104.Sheriff:Dropdown({
	Title = "自动射击部位",
	Flag = "Sheriff_AutoShootPart",
	Values = { "上躯干", "人物根部件", "头部", "躯干" },
	Value = YXOpt.zh(Hub.AutoShootState.part),
	Callback = function(part)
		part = YXOpt.en(part)
		if part == "UpperTorso" or part == "HumanoidRootPart" or part == "Head" or part == "Torso" then
			Hub.AutoShootState.part = part
		end
	end,
})

services_dataTable_0104.Sheriff:Dropdown({
	Title = "射击按钮大小",
	Flag = "Sheriff_ShootButtonSize",
	Values = { "小", "中", "大" },
	Value = YXOpt.zh(Hub.AutoShootDragState.size),
	Callback = function(size)
		size = YXOpt.en(size)
		if Hub.TouchButtons.Sizes[size] then
			Hub.AutoShootDragState.size = size
			Hub.TouchButtons.ApplySize(Hub.AutoShootTouchButton, size, Hub.AutoShootDragState.shape)
		end
	end,
})

services_dataTable_0104.Sheriff:Dropdown({
	Title = "射击按钮形状",
	Flag = "Sheriff_ShootButtonShape",
	Values = { "方形", "矩形" },
	Value = YXOpt.zh(Hub.AutoShootDragState.shape),
	Callback = function(aimUI_param_1098)
		aimUI_param_1098 = YXOpt.en(aimUI_param_1098)
		Hub.AutoShootDragState.shape = aimUI_param_1098 == "Rectangle" and "Rectangle" or "Square"
		Hub.TouchButtons.ApplySize(Hub.AutoShootTouchButton, Hub.AutoShootDragState.size, Hub.AutoShootDragState.shape)
		Hub.TouchButtons.UpdateHoldHint(Hub.AutoShootDragState, Hub.AutoShootTouchButton)
	end,
})

services_dataTable_0104.Sheriff:Colorpicker({
	Title = "射击图标颜色",
	Flag = "Sheriff_ShootButtonColor",
	Default = Hub.AutoShootDragState.outlineColor,
	Callback = function(outlineColor)
		Hub.AutoShootDragState.outlineColor = outlineColor
		Hub.TouchButtons.ApplyAppearance(Hub.AutoShootTouchButton, Hub.AutoShootDragState)
	end,
})

services_dataTable_0104.Sheriff:Toggle({
	Title = "射击按钮可拖动",
	Flag = "Sheriff_ShootButtonDraggable",
	Default = Hub.AutoShootDragState.draggable == true,
	Callback = function(aimUI_param_1099)
		Hub.AutoShootDragState.draggable = aimUI_param_1099 and true or false
	end,
})

services_dataTable_0104.Sheriff:Keybind({
	Title = "自动射击快捷键",
	Flag = "Sheriff_AutoShootKeybind",
	Value = "X",
	Callback = function()
		if Hub.TriggerAutoShootInput then
			Hub.TriggerAutoShootInput()
		end
	end,
})

Tabs.Movement:Toggle({
	Title = "隐身",
	Flag = "General_Invisibility",
	Callback = function(aimUI_param_1100)
		quickMenu_helperFunc_0819(aimUI_param_1100)
	end,
})

Tabs.Farm:Section({ Title = "进度", TextXAlignment = "Center", TextSize = 17, Opened = true })

Hub.AutoPrestige.control = Tabs.Farm:Toggle({
	Title = "自动转生",
	Flag = "Farm_AutoPrestige",
	Default = false,
	Callback = function(farmUI_param_1101)
		Hub.AutoPrestige.SetEnabled(farmUI_param_1101)
	end,
})

Hub.AutoClaimReward.control = Tabs.Farm:Toggle({
	Title = "自动领取奖励",
	Desc = "自动领取随机糖果与道具奖励弹窗。",
	Flag = "Farm_AutoClaimRewards",
	Default = true,
	Callback = function(farmUI_param_1102)
		Hub.AutoClaimReward.SetEnabled(farmUI_param_1102)
	end,
})

Tabs.Farm:Section({ Title = "刷币", TextXAlignment = "Center", TextSize = 17, Opened = true })

Hub.CoinFarm.statsControl = Tabs.Farm:Paragraph({
	Title = "刷币统计",
	Desc = [[Status: Disabled
Total Collected Coins: 0
Total Earned XP: 0
Role: Unknown]],
	Icon = "coins",
})

Hub.CoinFarm.RefreshStats()

Hub.CoinFarm.toggleControl = Tabs.Farm:Toggle({
	Title = "刷币",
	Desc = "被踢出时自动换服并重新执行脚本。",
	Flag = "Farm_CoinFarm",
	Default = false,
	Callback = function(farmUI_param_1103)
		Hub.CoinFarm.SetEnabled(farmUI_param_1103)
	end,
})

Hub.CoinFarm.webhookInput = Tabs.Farm:Input({
	Title = "刷币 Webhook",
	Desc = "按回车保存；留空按回车可清除。",
	Type = "Input",
	Value = Hub.CoinFarm.webhookUrl,
	Placeholder = "https://discord.com/api/webhooks/...",
	ClearTextOnFocus = false,
	Callback = function(farmUI_param_1104)
		Hub.CoinFarm.webhookDraft = tostring(farmUI_param_1104 or "")
	end,
})

task.defer(function()
	local webhookInput = Hub.CoinFarm.webhookInput
	local inputFrame = webhookInput and typeof(webhookInput) == "table" and webhookInput.InputFrame
	local uiElements = inputFrame and typeof(inputFrame) == "table" and inputFrame.UIElements
	local main

	if uiElements and typeof(uiElements) == "table" then
		main = uiElements.Main or uiElements.Container
	else
		main = uiElements
	end

	main = main and typeof(main) == "Instance" and main:FindFirstChildWhichIsA("TextBox", true)
	if not main then
		return
	end

	trackConn(main.FocusLost:Connect(function(enterPressed)
		if not enterPressed then
			return
		end
		local farmUI_saveWebhookValue_1105, farmUI_saveWebhookValue_1106 = Hub.CoinFarm.SaveWebhook(main.Text)
		WindUI:Notify({ Title = "刷币 Webhook", Content = farmUI_saveWebhookValue_1106, Icon = farmUI_saveWebhookValue_1105 and "check" or "x", Duration = 3 })
	end))
end)

Tabs.Farm:Button({
	Title = "测试 Webhook",
	Icon = "send",
	Callback = function()
		if tostring(Hub.CoinFarm.webhookUrl or "") == "" then
			WindUI:Notify({ Title = "刷币 Webhook", Content = "请先保存 Webhook 地址。", Icon = "x", Duration = 3 })
			return
		end
		local Test = Hub.CoinFarm.SendWebhook("Test")

		WindUI:Notify({
			Title = "刷币 Webhook",
			Content = Test and "已发送 Webhook 测试请求。" or "Webhook 测试请求发送失败。",
			Icon = Test and "check" or "x",
			Duration = 3,
		})
	end,
})

task.wait(UI_BUILD_DELAY)

Hub.CoinFarm.blackScreenControl = Tabs.Farm:Toggle({
	Title = "黑屏遮罩",
	Flag = "Farm_BlackScreen",
	Default = false,
	Callback = function(farmUI_param_1107)
		Hub.CoinFarm.SetBlackScreen(farmUI_param_1107, false)
	end,
})

Hub.CoinFarm.renderingControl = Tabs.Farm:Toggle({
	Title = "关闭 3D 渲染",
	Flag = "Farm_Disable3DRendering",
	Default = false,
	Callback = function(farmUI_param_1108)
		if not Hub.CoinFarm.Set3DRenderingDisabled(farmUI_param_1108, false) and farmUI_param_1108 and Hub.CoinFarm.renderingControl and type(Hub.CoinFarm.renderingControl.Set) == "function" then
			task.defer(function()
				pcall(function()
					Hub.CoinFarm.renderingControl:Set(false)
				end)
			end)
		end
	end,
})

Hub.CoinFarm.xpFarmControl = Tabs.Farm:Toggle({
	Title = "刷币时同时刷经验",
	Desc = "保持平民/英雄存活，并让英雄在 10 秒时开枪",
	LockedTitle = "启用「钱袋已满或死亡时结束回合」后再开启刷经验。",
	Flag = "Farm_CoinFarmXP",
	Default = false,
	Callback = function(farmUI_param_1109)
		if farmUI_param_1109 and not Hub.CoinFarm.endRoundEnabled then
			Hub.CoinFarm.xpFarmEnabled = false

			if type(Hub.CoinFarm.UpdateXPFarmLock) == "function" then
				task.defer(Hub.CoinFarm.UpdateXPFarmLock)
			end

			return
		end

		Hub.CoinFarm.xpFarmEnabled = farmUI_param_1109 and true or false

		if not Hub.CoinFarm.xpFarmEnabled then
			Hub.CoinFarm.CancelXPFarmWait()

			if Hub.CoinFarm.enabled and Hub.CoinFarm.bagFull and Hub.CoinFarm.endRoundEnabled then
				Hub.CoinFarm.StartEndRoundAction()
			end
		elseif Hub.CoinFarm.enabled and Hub.CoinFarm.bagFull then
			Hub.CoinFarm.StartXPFarmWait()
		end
	end,
})

Hub.CoinFarm.endRoundControl = Tabs.Farm:Toggle({
	Title = "钱袋已满或死亡时结束回合",
	Flag = "Farm_EndRoundOnFullOrDied",
	Default = false,
	Callback = function(farmUI_param_1110)
		Hub.CoinFarm.endRoundEnabled = farmUI_param_1110 and true or false

		if type(Hub.CoinFarm.UpdateXPFarmLock) == "function" then
			Hub.CoinFarm.UpdateXPFarmLock()
		end

		if not Hub.CoinFarm.endRoundEnabled then
			local coinFarm = Hub.CoinFarm
			coinFarm.endRoundGeneration = coinFarm.endRoundGeneration + 1
			Hub.CoinFarm.endRoundRunning = false
			Hub.CoinFarm.sheriffFlingRunning = false
			Hub.CoinFarm.sheriffFlingBlocking = false
			Hub.CoinFarm.sheriffFlingCompleted = false
		elseif Hub.RoundState.active then
			if Hub.CoinFarm.bagFull then
				if not (Hub.CoinFarm.xpFarmEnabled and Hub.CoinFarm.StartXPFarmWait()) then
					Hub.CoinFarm.StartEndRoundAction()
				end

				return
			end

			local coinFarm = Hub.CoinFarm
			coinFarm.endRoundGeneration = coinFarm.endRoundGeneration + 1
			Hub.CoinFarm.endRoundRunning = false
			Hub.CoinFarm.sheriffFlingRunning = false
			Hub.CoinFarm.sheriffFlingBlocking = false
			Hub.CoinFarm.sheriffFlingCompleted = false
			Hub.CoinFarm.StartRoundSheriffFling()
		end
	end,
})

Hub.CoinFarm.serverHopControl = Tabs.Farm:Toggle({
	Title = "玩家过少时换服",
	Flag = "Farm_ServerHopLowPlayers",
	Default = false,
	Callback = function(farmUI_param_1111)
		Hub.CoinFarm.serverHopLowPlayers = farmUI_param_1111 and true or false
	end,
})

Hub.CoinFarm.serverHopThresholdControl = Tabs.Farm:Slider({
	Title = "换服人数阈值",
	Flag = "Farm_ServerHopPlayerThreshold",
	Value = { Min = 1, Max = 6, Default = Hub.CoinFarm.serverHopPlayerThreshold },
	Step = 1,
	Callback = function(farmUI_param_1112)
		Hub.CoinFarm.serverHopPlayerThreshold = math.clamp(math.floor(tonumber(farmUI_param_1112) or 4), 1, 6)
	end,
})

Hub.CoinFarm.serverHopTimerControl = Tabs.Farm:Slider({
	Title = "换服计时器",
	Flag = "Farm_ServerHopTimerMinutes",
	Value = { Min = 10, Max = 30, Default = Hub.CoinFarm.serverHopTimerMinutes },
	Step = 1,
	Callback = function(farmUI_param_1113)
		Hub.CoinFarm.serverHopTimerMinutes = math.clamp(math.floor(tonumber(farmUI_param_1113) or 15), 10, 30)
		Hub.CoinFarm.serverHopTimerStartedAt = Hub.CoinFarm.enabled and os.clock() or 0
	end,
})

Hub.CoinFarm.antiBotControl = Tabs.Farm:Toggle({
	Title = "反机器人换服",
	Desc = "检测到可疑机器人服务器时自动换服",
	Flag = "Farm_AntiBotServerHop",
	Default = false,
	Callback = function(farmUI_param_1114)
		Hub.CoinFarm.antiBotEnabled = farmUI_param_1114 and true or false

		if Hub.CoinFarm.antiBotEnabled and type(Hub.CoinFarm.StartAntiBotServerHop) == "function" then
			task.defer(Hub.CoinFarm.StartAntiBotServerHop)
		end
	end,
})

Hub.CoinFarm.UpdateXPFarmLock = function()
	local xpFarmControl = Hub.CoinFarm.xpFarmControl
	if not xpFarmControl then
		return
	end

	if Hub.CoinFarm.endRoundEnabled then
		pcall(function()
			xpFarmControl:Unlock()
		end)

		return
	end

	Hub.CoinFarm.xpFarmEnabled = false
	Hub.CoinFarm.CancelXPFarmWait()

	pcall(function()
		xpFarmControl:Unlock()
		xpFarmControl:Set(false, false, true)
		xpFarmControl:Lock()
	end)
end

Hub.CoinFarm.UpdateXPFarmLock()

Hub.CoinFarm.speedControl = Tabs.Farm:Slider({
	Title = "刷币速度",
	Desc = "收集金币的移动与补间速度",
	Flag = "Farm_CoinFarmSpeed",
	Value = { Min = 10, Max = 60, Default = Hub.CoinFarm.speed or 28 },
	Step = 1,
	Suffix = "studs/s",
	Callback = function(farmUI_param_1115)
		Hub.CoinFarm.speed = tonumber(farmUI_param_1115) or 28
	end,
})

Hub.CoinFarm.modeControl = Tabs.Farm:Dropdown({
	Title = "刷币模式",
	Flag = "Farm_CoinFarmMode",
	Values = { "坐标瞬移", "补间移动" },
	Value = YXOpt.zh(Hub.CoinFarm.mode),
	Callback = function(mode)
		mode = YXOpt.en(mode)
		if mode ~= "CFrame" and mode ~= "Tween" then
			return
		end
		Hub.CoinFarm.mode = mode
		Hub.CoinFarm.currentCoin = nil
		Hub.CoinFarm.CancelTween()

		if mode ~= "Tween" and Hub.CoinFarm.position ~= "Under" then
			Hub.CoinFarm.DisableUnder()
		end
	end,
})

Hub.CoinFarm.positionControl = Tabs.Farm:Dropdown({
	Title = "刷币位置",
	Flag = "Farm_CoinFarmPosition",
	Values = { "普通", "地图下方" },
	Value = YXOpt.zh(Hub.CoinFarm.position),
	Callback = function(position)
		position = YXOpt.en(position)
		if position ~= "Normal" and position ~= "Under" then
			return
		end
		Hub.CoinFarm.position = position
		Hub.CoinFarm.currentCoin = nil
		Hub.CoinFarm.CancelTween()

		if position ~= "Under" then
			Hub.CoinFarm.DisableUnder()
		end
	end,
})

do
	local eventBox = {
		selectedBox = nil,
		selectedCurrency = nil,
		autoBuy = false,
		busy = false,
		generation = 0,
		boxes = {},
		shopData = nil,
		profileData = nil,
		boxDropdown = nil,
		currencyDropdown = nil,
	}

	Hub.EventBox = eventBox

	local function farmUI_helperFunc_1116()
		if not eventBox.shopData then
			local database = ReplicatedStorage:FindFirstChild("Database")
			database = database and database:FindFirstChild("Sync")

			if database then
				local ok, result = pcall(require, database)

				if ok and type(result) == "table" then
					eventBox.shopData = result.NewShop
				end
			end
		end

		return eventBox.shopData
	end

	local function farmUI_helperFunc_1117()
		if not eventBox.profileData then
			local modules = ReplicatedStorage:FindFirstChild("Modules")
			modules = modules and modules:FindFirstChild("ProfileData")

			if modules then
				local ok, profileData = pcall(require, modules)

				if ok and type(profileData) == "table" then
					eventBox.profileData = profileData
				end
			end
		end

		return eventBox.profileData
	end

	local function farmUI_helperFunc_1118(farmUI_param_1119)
		local farmUI_localValue_1120 = pairs
		local farmUI_dataTable_1121 = farmUI_param_1119 or {}

		for k in farmUI_localValue_1120(farmUI_dataTable_1121) do
			if k ~= "Coins" and k ~= "Gems" and k ~= "Key" and k ~= "Robux" then
				return true
			end
		end

		return false
	end

	local function farmUI_helperFunc_1122()
		local farmUI_callResult_1123 = farmUI_helperFunc_1116()
		local farmUI_configTable_1124 = {}
		eventBox.boxes = {}
		local farmUI_localValue_1125 = pairs
		farmUI_callResult_1123 = type(farmUI_callResult_1123) == "table" and farmUI_callResult_1123 or {}

		for k, farmUI_loopVar_1126 in farmUI_localValue_1125(farmUI_callResult_1123) do
			if type(farmUI_loopVar_1126) == "table" and farmUI_loopVar_1126.Type == "MysteryBox" and farmUI_loopVar_1126.Hidden ~= true and type(farmUI_loopVar_1126.Price) == "table" then
				eventBox.boxes[k] = farmUI_loopVar_1126
				table.insert(farmUI_configTable_1124, k)
			end
		end

		table.sort(farmUI_configTable_1124, function(farmUI_param_1127, farmUI_param_1128)
			local farmUI_callResult_1129 = farmUI_helperFunc_1118(eventBox.boxes[farmUI_param_1127].Price)
			if farmUI_callResult_1129 ~= farmUI_helperFunc_1118(eventBox.boxes[farmUI_param_1128].Price) then
				return farmUI_callResult_1129
			end
			return string.lower(farmUI_param_1127) < string.lower(farmUI_param_1128)
		end)

		return farmUI_configTable_1124
	end

	local function farmUI_helperFunc_1130(farmUI_param_1131)
		local price = eventBox.boxes[farmUI_param_1131]
		local farmUI_configTable_1132 = {}
		local farmUI_localValue_1133 = pairs
		price = price and price.Price or {}

		for k in farmUI_localValue_1133(price) do
			if k ~= "Robux" then
				table.insert(farmUI_configTable_1132, k)
			end
		end

		table.sort(farmUI_configTable_1132, function(farmUI_param_1134, farmUI_param_1135)
			local farmUI_boolFlag_1136 = farmUI_param_1134 ~= "Coins" and farmUI_param_1134 ~= "Gems" and farmUI_param_1134 ~= "Key"
			if farmUI_boolFlag_1136 ~= (farmUI_param_1135 ~= "Coins" and farmUI_param_1135 ~= "Gems" and farmUI_param_1135 ~= "Key") then
				return farmUI_boolFlag_1136
			end
			local farmUI_configTable_1137 = { Coins = 1, Gems = 2, Key = 3 }
			return (farmUI_configTable_1137[farmUI_param_1134] or 10) < (farmUI_configTable_1137[farmUI_param_1135] or 10)
		end)

		return farmUI_configTable_1132
	end

	local function farmUI_helperFunc_1138(farmUI_param_1139)
		local farmUI_callResult_1140 = farmUI_helperFunc_1117()
		local owned = farmUI_callResult_1140 and farmUI_callResult_1140.Materials and farmUI_callResult_1140.Materials.Owned
		local owned2 = farmUI_callResult_1140 and farmUI_callResult_1140.Weapons and farmUI_callResult_1140.Weapons.Owned
		local farmUI_numericVar_1141 = tonumber(owned and owned[farmUI_param_1139])
		local farmUI_numericVar_1142

		if farmUI_numericVar_1141 then
			farmUI_numericVar_1142 = farmUI_numericVar_1141
		else
			farmUI_numericVar_1142 = tonumber(owned2 and owned2[farmUI_param_1139])
		end

		return farmUI_numericVar_1142 or 0
	end

	local function farmUI_helperFunc_1143(farmUI_param_1144, farmUI_param_1145)
		local farmUI_callResult_1146 = farmUI_helperFunc_1130(farmUI_param_1144)

		if #farmUI_callResult_1146 == 0 then
			farmUI_callResult_1146 = { "Unavailable" }
		end

		local farmUI_localValue_1147 = table.find(farmUI_callResult_1146, farmUI_param_1145) and farmUI_param_1145 or farmUI_callResult_1146[1]
		eventBox.selectedCurrency = farmUI_localValue_1147 ~= "Unavailable" and farmUI_localValue_1147 or nil
		local currencyDropdown = eventBox.currencyDropdown

		if currencyDropdown then
			local farmUI_boolFlag_1148 = false

			if currencyDropdown.SetValues then
				farmUI_boolFlag_1148 = pcall(function()
					currencyDropdown:SetValues(YXOpt.list(farmUI_callResult_1146))
				end)
			end

			if not farmUI_boolFlag_1148 and currencyDropdown.Refresh then
				pcall(function()
					currencyDropdown:Refresh(YXOpt.list(farmUI_callResult_1146))
				end)
			end

			pcall(function()
				currencyDropdown:Select(YXOpt.zh(farmUI_localValue_1147))
			end)
		end
	end

	local function farmUI_helperFunc_1149(farmUI_param_1150)
		if eventBox.busy then
			return false
		end
		local selectedBox = eventBox.selectedBox
		local selectedCurrency = eventBox.selectedCurrency
		local farmUI_localValue_1151 = selectedBox and eventBox.boxes[selectedBox]
		local price = farmUI_localValue_1151 and farmUI_localValue_1151.Price and farmUI_localValue_1151.Price[selectedCurrency]

		if not selectedBox or not selectedCurrency or type(price) ~= "number" then
			if not farmUI_param_1150 then
				WindUI:Notify({
					Title = "购买箱子",
					Content = "请选择有效的箱子与货币",
					Icon = "x",
					Duration = 2.5,
				})
			end

			return false
		end

		local farmUI_callResult_1152 = farmUI_helperFunc_1138(selectedCurrency)

		if farmUI_callResult_1152 < price then
			if not farmUI_param_1150 then
				WindUI:Notify({
					Title = "购买箱子",
					Content = string.format("%s 数量不足（%d/%d）", selectedCurrency, farmUI_callResult_1152, price),
					Icon = "x",
					Duration = 2.5,
				})
			end

			return false
		end

		local remotes = ReplicatedStorage:FindFirstChild("Remotes")
		remotes = remotes and remotes:FindFirstChild("Shop")
		local openCrate = remotes and remotes:FindFirstChild("OpenCrate")

		if not openCrate or not openCrate:IsA("RemoteFunction") then
			if not farmUI_param_1150 then
				WindUI:Notify({
					Title = "购买箱子",
					Content = "OpenCrate 远程事件不可用",
					Icon = "x",
					Duration = 2.5,
				})
			end

			return false
		end

		eventBox.busy = true

		local ok, result = pcall(function()
			return openCrate:InvokeServer(selectedBox, "MysteryBox", selectedCurrency)
		end)

		ok = ok and result ~= nil and result ~= false
		local farmUI_boolFlag_1153 = false

		if ok then
			local boxController = remotes:FindFirstChild("BoxController")

			if boxController and boxController:IsA("BindableEvent") then
				farmUI_boolFlag_1153 = pcall(function()
					boxController:Fire({ { MysteryBoxId = selectedBox, RewardedItemId = result } })
				end)
			end
		end

		if farmUI_boolFlag_1153 then
			task.delay(4.6, function()
				eventBox.busy = false
			end)
		else
			eventBox.busy = false
		end

		if not farmUI_param_1150 and (not ok or not farmUI_boolFlag_1153) then
			WindUI:Notify({
				Title = ok and "箱子已开启" or "箱子购买失败",
				Content = ok and "获得：" .. tostring(result) or "服务器拒绝了本次购买",
				Icon = ok and "gift" or "x",
				Duration = 3,
			})
		end

		return ok
	end

	local farmUI_callResult_1154 = farmUI_helperFunc_1122()

	if #farmUI_callResult_1154 == 0 then
		farmUI_callResult_1154 = { "Unavailable" }
	end

	eventBox.selectedBox = farmUI_callResult_1154[1] ~= "Unavailable" and farmUI_callResult_1154[1] or nil
	local selectedBox = eventBox.selectedBox and farmUI_helperFunc_1130(eventBox.selectedBox) or {}

	if #selectedBox == 0 then
		selectedBox = { "Unavailable" }
	end

	eventBox.selectedCurrency = selectedBox[1] ~= "Unavailable" and selectedBox[1] or nil
	task.wait(UI_BUILD_DELAY)

	Tabs.Farm:Section({ Title = "活动箱子", TextXAlignment = "Center", TextSize = 17, Opened = true })

	eventBox.boxDropdown = Tabs.Farm:Dropdown({
		Title = "箱子",
		Flag = "Farm_EventBox",
		Values = YXOpt.list(farmUI_callResult_1154),
		Value = YXOpt.zh(farmUI_callResult_1154[1]),
		Callback = function(selectedBox2)
			selectedBox2 = YXOpt.en(selectedBox2)
			if selectedBox2 == "Unavailable" or not eventBox.boxes[selectedBox2] then
				return
			end
			eventBox.selectedBox = selectedBox2
			farmUI_helperFunc_1143(selectedBox2, eventBox.selectedCurrency)
		end,
	})

	eventBox.currencyDropdown = Tabs.Farm:Dropdown({
		Title = "箱子货币",
		Flag = "Farm_EventBoxCurrency",
		Values = YXOpt.list(selectedBox),
		Value = YXOpt.zh(selectedBox[1]),
		Callback = function(selectedCurrency)
			selectedCurrency = YXOpt.en(selectedCurrency)
			if selectedCurrency ~= "Unavailable" then
				eventBox.selectedCurrency = selectedCurrency
			end
		end,
	})

	Tabs.Farm:Button({
		Title = "购买箱子",
		Callback = function()
			task.spawn(farmUI_helperFunc_1149, false)
		end,
	})

	eventBox.autoBuyControl = Tabs.Farm:Toggle({
		Title = "自动购买箱子",
		Flag = "Farm_AutoBuyBoxes",
		Default = false,
		Callback = function(farmUI_param_1155)
			eventBox.autoBuy = farmUI_param_1155 and true or false
			eventBox.generation = eventBox.generation + 1
			if not eventBox.autoBuy then
				return
			end
			local generation = eventBox.generation

			task.spawn(function()
				while foxnameMM2Runtime.alive and not isTerminated and eventBox.autoBuy and eventBox.generation == generation do
					task.wait(farmUI_helperFunc_1149(true) and 4.75 or 1.75)
				end
			end)
		end,
	})

	Hub.CleanupEventBox = function()
		eventBox.autoBuy = false
		eventBox.generation = eventBox.generation + 1
		eventBox.busy = false
	end
end

local function farmUI_helperFunc_1156(farmUI_param_1157)
	Hub.PlayerFOV = math.clamp(tonumber(farmUI_param_1157) or Hub.PlayerFOV or 70, 40, 120)
	local currentCamera2 = workspace.CurrentCamera

	if currentCamera2 then
		currentCamera2.FieldOfView = Hub.PlayerFOV
	end
end

task.wait(UI_BUILD_DELAY)

Tabs.LocalPlayer:Slider({
	Title = "视野范围 (FOV)",
	Flag = "LocalPlayer_FieldOfView",
	Value = { Min = 40, Max = 120, Default = Hub.PlayerFOV },
	Step = 1,
	Callback = farmUI_helperFunc_1156,
})

Tabs.LocalPlayer:Slider({
	Title = "移动速度",
	Flag = "LocalPlayer_WalkSpeed",
	Value = { Min = 16, Max = 500, Default = Hub.WalkSpeed },
	Step = 1,
	Callback = function(walkSpeed)
		Hub.WalkSpeed = walkSpeed

		if localChar.humanoid then
			localChar.humanoid.WalkSpeed = Hub.WalkSpeed
		end
	end,
})

Tabs.LocalPlayer:Toggle({
	Title = "加速漏洞（跳跃）",
	Flag = "LocalPlayer_SpeedGlitch",
	Default = false,
	Callback = function(speedGlitchEnabled)
		Hub.SpeedGlitchEnabled = speedGlitchEnabled
	end,
})

Tabs.LocalPlayer:Slider({
	Title = "加速强度",
	Flag = "LocalPlayer_SpeedGlitchPower",
	Value = { Min = 1, Max = 5, Default = Hub.SpeedGlitchPower },
	Step = 1,
	Callback = function(speedGlitchPower)
		Hub.SpeedGlitchPower = speedGlitchPower
	end,
})

trackConn(workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	currentCamera = workspace.CurrentCamera or currentCamera
	task.defer(farmUI_helperFunc_1156, Hub.PlayerFOV)
end))

Hub.TouchButtons.NoclipToggleControl = Tabs.LocalPlayer:Toggle({
	Title = "穿墙模式",
	Flag = "LocalPlayer_Noclip",
	Callback = function(movement_param_1158)
		Hub.TouchButtons.SetNoclipEnabled(movement_param_1158, false)
	end,
})

Tabs.LocalPlayer:Keybind({
	Title = "穿墙 快捷键",
	Flag = "LocalPlayer_NoclipKeybind",
	Value = "N",
	Callback = function()
		Hub.TouchButtons.SetNoclipEnabled(not Hub.NoclipEnabled, true)
	end,
})

Tabs.LocalPlayer:Toggle({
	Title = "穿墙 按钮",
	Flag = "LocalPlayer_NoclipButton",
	Default = false,
	Callback = function(movement_param_1159)
		Hub.TouchButtons.ToggleNoclipButton(movement_param_1159)
	end,
})

Tabs.LocalPlayer:Dropdown({
	Title = "穿墙 按钮大小",
	Flag = "LocalPlayer_NoclipButtonSize",
	Values = { "小", "中", "大" },
	Value = YXOpt.zh(Hub.NoclipButtonState.size),
	Callback = function(size)
		size = YXOpt.en(size)
		if Hub.TouchButtons.Sizes[size] then
			Hub.NoclipButtonState.size = size
			Hub.TouchButtons.ApplySize(Hub.NoclipButtonState.button, size, Hub.NoclipButtonState.shape)
		end
	end,
})

Tabs.LocalPlayer:Dropdown({
	Title = "穿墙 按钮形状",
	Flag = "LocalPlayer_NoclipButtonShape",
	Values = { "方形", "矩形" },
	Value = YXOpt.zh(Hub.NoclipButtonState.shape),
	Callback = function(movement_param_1160)
		movement_param_1160 = YXOpt.en(movement_param_1160)
		Hub.NoclipButtonState.shape = movement_param_1160 == "Rectangle" and "Rectangle" or "Square"
		Hub.TouchButtons.ApplySize(Hub.NoclipButtonState.button, Hub.NoclipButtonState.size, Hub.NoclipButtonState.shape)
	end,
})

Tabs.LocalPlayer:Colorpicker({
	Title = "穿墙 图标颜色",
	Flag = "LocalPlayer_NoclipButtonColor",
	Default = Hub.NoclipButtonState.outlineColor or Hub.TouchButtons.Theme.accentColor,
	Callback = function(outlineColor)
		Hub.NoclipButtonState.outlineColor = outlineColor
		Hub.TouchButtons.ApplyAppearance(Hub.NoclipButtonState.button, Hub.NoclipButtonState)
	end,
})

Tabs.LocalPlayer:Toggle({
	Title = "穿墙 按钮可拖动",
	Flag = "LocalPlayer_NoclipButtonDraggable",
	Default = Hub.NoclipButtonState.draggable,
	Callback = function(movement_param_1161)
		Hub.NoclipButtonState.draggable = movement_param_1161 and true or false
	end,
})

Hub.AntiFlingToggleControl = Tabs.Player:Toggle({
	Title = "防甩飞",
	Flag = "General_AntiFling",
	Default = false,
	LockedTitle = "刷币开启时自动启用并锁定。",
	Callback = function(movement_param_1162)
		Hub.SetAntiFlingSource("manual", movement_param_1162)
	end,
})

Hub.AntiFlingBeforeCoinFarm = false
Hub.AntiFlingForcedByCoinFarm = false

Hub.SetCoinFarmAntiFling = function(movement_param_1163)
	if movement_param_1163 then
		if not Hub.AntiFlingForcedByCoinFarm then
			Hub.AntiFlingBeforeCoinFarm = Hub.AntiFlingSources.manual == true
		end

		Hub.AntiFlingForcedByCoinFarm = true
		Hub.SetAntiFlingSource("manual", true)
		Hub.AntiFlingToggleControl:Unlock()
		Hub.AntiFlingToggleControl:Set(true, false, true)
		Hub.AntiFlingToggleControl:Lock()
	else
		Hub.AntiFlingToggleControl:Unlock()

		if Hub.AntiFlingForcedByCoinFarm then
			Hub.AntiFlingForcedByCoinFarm = false
			Hub.SetAntiFlingSource("manual", Hub.AntiFlingBeforeCoinFarm)
			Hub.AntiFlingToggleControl:Set(Hub.AntiFlingBeforeCoinFarm, false, true)
		end
	end
end

Hub.TouchButtons.FlyToggleControl = Tabs.LocalPlayer:Toggle({
	Title = "飞行",
	Flag = "LocalPlayer_Fly",
	Callback = function(movement_param_1164)
		Hub.TouchButtons.SetFlyEnabled(movement_param_1164, false)
	end,
})

Tabs.LocalPlayer:Keybind({
	Title = "飞行快捷键",
	Flag = "LocalPlayer_FlyKeybind",
	Value = "F",
	Callback = function()
		Hub.TouchButtons.SetFlyEnabled(not Hub.FlyEnabled, true)
	end,
})

Tabs.LocalPlayer:Toggle({
	Title = "飞行按钮",
	Flag = "LocalPlayer_FlyButton",
	Default = false,
	Callback = function(movement_param_1165)
		Hub.TouchButtons.ToggleFlyButton(movement_param_1165)
	end,
})

Tabs.LocalPlayer:Dropdown({
	Title = "飞行按钮大小",
	Flag = "LocalPlayer_FlyButtonSize",
	Values = { "小", "中", "大" },
	Value = YXOpt.zh(Hub.FlyButtonState.size),
	Callback = function(size)
		size = YXOpt.en(size)
		if Hub.TouchButtons.Sizes[size] then
			Hub.FlyButtonState.size = size
			Hub.TouchButtons.ApplySize(Hub.FlyButtonState.button, size, Hub.FlyButtonState.shape)
		end
	end,
})

Tabs.LocalPlayer:Dropdown({
	Title = "飞行按钮形状",
	Flag = "LocalPlayer_FlyButtonShape",
	Values = { "方形", "矩形" },
	Value = YXOpt.zh(Hub.FlyButtonState.shape),
	Callback = function(movement_param_1166)
		movement_param_1166 = YXOpt.en(movement_param_1166)
		Hub.FlyButtonState.shape = movement_param_1166 == "Rectangle" and "Rectangle" or "Square"
		Hub.TouchButtons.ApplySize(Hub.FlyButtonState.button, Hub.FlyButtonState.size, Hub.FlyButtonState.shape)
	end,
})

Tabs.LocalPlayer:Colorpicker({
	Title = "飞行图标颜色",
	Flag = "LocalPlayer_FlyButtonColor",
	Default = Hub.FlyButtonState.outlineColor or Hub.TouchButtons.Theme.accentColor,
	Callback = function(outlineColor)
		Hub.FlyButtonState.outlineColor = outlineColor
		Hub.TouchButtons.ApplyAppearance(Hub.FlyButtonState.button, Hub.FlyButtonState)
	end,
})

Tabs.LocalPlayer:Toggle({
	Title = "飞行按钮可拖动",
	Flag = "LocalPlayer_FlyButtonDraggable",
	Default = Hub.FlyButtonState.draggable,
	Callback = function(movement_param_1167)
		Hub.FlyButtonState.draggable = movement_param_1167 and true or false
	end,
})

Tabs.LocalPlayer:Slider({
	Title = "飞行速度",
	Flag = "LocalPlayer_FlySpeed",
	Value = { Min = 50, Max = 100, Default = Hub.FlySpeed },
	Step = 1,
	Callback = function(flySpeed)
		Hub.FlySpeed = flySpeed
	end,
})

Tabs.LocalPlayer:Toggle({
	Title = "无限跳跃",
	Flag = "LocalPlayer_InfiniteJump",
	Default = false,
	Callback = function(movement_param_1168)
		Hub.ToggleInfiniteJump(movement_param_1168)
	end,
})

Tabs.LocalPlayer:Slider({
	Title = "跳跃力度",
	Flag = "LocalPlayer_JumpPower",
	Value = { Min = 1, Max = 5, Default = Hub.JumpPower / 50 },
	Step = 1,
	Callback = function(movement_param_1169)
		Hub.JumpPower = movement_param_1169 * 50

		if localChar.humanoid then
			localChar.humanoid.JumpPower = Hub.JumpPower
		end
	end,
})

do
	local movement_configTable_1170 = { generation = 0, active = false, tool = nil, track = nil, connections = {} }

	local function movement_helperFunc_1171()
		movement_configTable_1170.active = false

		if movement_configTable_1170.track then
			pcall(function()
				movement_configTable_1170.track:Stop()
			end)

			movement_configTable_1170.track = nil
		end
	end

	local function cleanupJerk()
		movement_configTable_1170.generation = movement_configTable_1170.generation + 1
		movement_helperFunc_1171()

		for _, connection in ipairs(movement_configTable_1170.connections) do
			if connection and connection.Connected then
				connection:Disconnect()
			end
		end

		table.clear(movement_configTable_1170.connections)

		if movement_configTable_1170.tool then
			pcall(function()
				movement_configTable_1170.tool:Destroy()
			end)

			movement_configTable_1170.tool = nil
		end
	end

	Tabs.LocalPlayer:Button({
		Title = "导管😋",
		Callback = function()
			cleanupJerk()
			local character_ = localPlayer.Character
			local humanoid = character_ and character_:FindFirstChildWhichIsA("Humanoid")
			local backpack = localPlayer:FindFirstChildWhichIsA("Backpack")
			if not humanoid or not backpack then
				WindUI:Notify({ Title = "导管😋", Content = "角色尚未就绪", Icon = "x", Duration = 2 })
				return
			end
			local tool = Instance.new("Tool")
			tool.Name = "导管"
			tool.ToolTip = "装备这个工具才能播放动画"
			tool.RequiresHandle = false
			tool.Parent = backpack
			movement_configTable_1170.tool = tool
			local generation = movement_configTable_1170.generation

			table.insert(movement_configTable_1170.connections, tool.Equipped:Connect(function()
				movement_configTable_1170.active = true
			end))

			table.insert(movement_configTable_1170.connections, tool.Unequipped:Connect(movement_helperFunc_1171))
			table.insert(movement_configTable_1170.connections, humanoid.Died:Connect(movement_helperFunc_1171))

			task.spawn(function()
				while true do
					if foxnameMM2Runtime.alive and not isTerminated and movement_configTable_1170.generation == generation and tool.Parent then
						if not movement_configTable_1170.active then
							task.wait(0.1)
							continue
						else
							local movement_boolFlag_1172 = humanoid.RigType == Enum.HumanoidRigType.R15
							local track, movement_localValue_1173, adjustSpeed, movement_numericVar_1174, movement_boolFlag_1175

							if not movement_configTable_1170.track then
								local animation = Instance.new("Animation")
								animation.AnimationId = movement_boolFlag_1172 and "rbxassetid://698251653" or "rbxassetid://72042024"
								local ok, track2 = pcall(humanoid.LoadAnimation, humanoid, animation)
								animation:Destroy()

								if not (not ok or not track2) then
									movement_configTable_1170.track = track2
									track = movement_configTable_1170.track
									track:Play()
									movement_localValue_1173 = track
									adjustSpeed = movement_localValue_1173.AdjustSpeed
									movement_numericVar_1174 = movement_boolFlag_1172 and 0.7 or 0.65
									adjustSpeed(movement_localValue_1173, movement_numericVar_1174)
									track.TimePosition = 0.6
									task.wait(0.1)
									movement_boolFlag_1172 = movement_boolFlag_1172 and 0.7 or 0.65

									while true do
										movement_boolFlag_1175 = movement_configTable_1170.active and movement_configTable_1170.track == track and track.TimePosition < movement_boolFlag_1172
										if movement_boolFlag_1175 then
											task.wait(0.1)
											continue
										end
										break
									end

									if movement_configTable_1170.track == track then
										track:Stop()
										movement_configTable_1170.track = nil
									end

									continue
								end
							else
								track = movement_configTable_1170.track
								track:Play()
								movement_localValue_1173 = track
								adjustSpeed = movement_localValue_1173.AdjustSpeed
								movement_numericVar_1174 = movement_boolFlag_1172 and 0.7 or 0.65
								adjustSpeed(movement_localValue_1173, movement_numericVar_1174)
								track.TimePosition = 0.6
								task.wait(0.1)
								movement_boolFlag_1172 = movement_boolFlag_1172 and 0.7 or 0.65

								while true do
									movement_boolFlag_1175 = movement_configTable_1170.active and movement_configTable_1170.track == track and track.TimePosition < movement_boolFlag_1172
									if movement_boolFlag_1175 then
										task.wait(0.1)
										continue
									end
									break
								end

								if movement_configTable_1170.track == track then
									track:Stop()
									movement_configTable_1170.track = nil
								end

								continue
							end
						end
					end

					break
				end

				movement_helperFunc_1171()
			end)
		end,
	})

	Hub.CleanupJerk = cleanupJerk
end

Hub.ESPRenderCache = {
	nametagInterval = 0.4,
	roleInterval = UserInputService.TouchEnabled and 0.75 or 0.6,
	lineInterval = UserInputService.TouchEnabled and 0.041666666666666664 or 0.033333333333333333,
	passiveInterval = UserInputService.TouchEnabled and 0.083333333333333329 or 0.066666666666666666,
	lastFrameUpdate = 0,
	lastRoleUpdate = 0,
	wasActive = false,
	murderer = nil,
	sheriff = nil,
}

trackConn(RunService.RenderStepped:Connect(function()
	local playerESP = Hub.PlayerESP or Hub.LineESP or Hub.NametagESP or Hub.ESP360
	local gunESP = Hub.GunESP or Hub.ESP360
	local movement_boolFlag_1176 = not playerESP

	if movement_boolFlag_1176 and not gunESP then
		if Hub.ESPRenderCache.wasActive then
			Hub.ESPRenderCache.wasActive = false

			for _, movement_loopVar_1177 in pairs(Hub.ESPTable) do
				if movement_loopVar_1177.Highlight then
					movement_loopVar_1177.Highlight.Enabled = false
				end

				if movement_loopVar_1177.Billboard then
					movement_loopVar_1177.Billboard.Enabled = false
				end

				if movement_loopVar_1177.Line then
					movement_loopVar_1177.Line.Visible = false
				end

				crosshair_helperFunc_0389(movement_loopVar_1177.Arrow, movement_loopVar_1177.ArrowDistance)
			end

			for _, movement_loopVar_1178 in pairs(Hub.GunESPTable) do
				if movement_loopVar_1178.Line then
					movement_loopVar_1178.Line.Visible = false
				end

				if movement_loopVar_1178.Billboard then
					movement_loopVar_1178.Billboard.Enabled = false
				end

				crosshair_helperFunc_0389(movement_loopVar_1178.Arrow, movement_loopVar_1178.ArrowDistance)
			end
		end

		return
	end

	Hub.ESPRenderCache.wasActive = true
	local now = os.clock()
	if now - Hub.ESPRenderCache.lastFrameUpdate < ((Hub.LineESP or Hub.GunESP) and Hub.ESPRenderCache.lineInterval or Hub.ESP360 and Hub.ESPRenderCache.lineInterval or Hub.ESPRenderCache.passiveInterval) then
		return
	end
	Hub.ESPRenderCache.lastFrameUpdate = now
	local currentCamera2 = workspace.CurrentCamera
	if not currentCamera2 then
		return
	end
	currentCamera = currentCamera2
	local viewportSize = currentCamera2.ViewportSize
	local character_ = localPlayer.Character
	character_ = character_ and character_:FindFirstChild("HumanoidRootPart")

	if playerESP then
		if Hub.ESPRenderCache.roleInterval <= now - Hub.ESPRenderCache.lastRoleUpdate then
			Hub.ESPRenderCache.lastRoleUpdate = now
			Hub.ESPRenderCache.murderer = crosshair_helperFunc_0406()
			Hub.ESPRenderCache.sheriff = crosshair_helperFunc_0407()
		end
	end

	if movement_boolFlag_1176 then
		for _, movement_loopVar_1179 in pairs(Hub.ESPTable) do
			if movement_loopVar_1179.Highlight then
				movement_loopVar_1179.Highlight.Enabled = false
			end

			if movement_loopVar_1179.Billboard then
				movement_loopVar_1179.Billboard.Enabled = false
			end

			if movement_loopVar_1179.Line then
				movement_loopVar_1179.Line.Visible = false
			end
		end
	else
		for k, movement_loopVar_1180 in pairs(Hub.ESPTable) do
			local head = movement_loopVar_1180.Head
			local hrp = movement_loopVar_1180.HRP
			local movement_callResult_1181 = services_helperFunc_0106(k)
			local movement_callResult_1182 = services_helperFunc_0112(k)
			local movement_localValue_1183 = movement_callResult_1181 or movement_callResult_1182

			if not head or not hrp or not hrp.Parent then
				movement_loopVar_1180.Highlight.Enabled = false
				movement_loopVar_1180.Billboard.Enabled = false
				movement_loopVar_1180.Line.Visible = false
				crosshair_helperFunc_0389(movement_loopVar_1180.Arrow, movement_loopVar_1180.ArrowDistance)
			elseif crosshair_helperFunc_0401(k) and not movement_localValue_1183 then
				movement_loopVar_1180.Highlight.Enabled = false
				movement_loopVar_1180.Billboard.Enabled = false
				movement_loopVar_1180.Line.Visible = false
				crosshair_helperFunc_0389(movement_loopVar_1180.Arrow, movement_loopVar_1180.ArrowDistance)
			else
				local lastRole

				if k == Hub.ESPRenderCache.murderer then
					lastRole = "Murderer"
				else
					lastRole = "Innocent"

					if k == Hub.ESPRenderCache.sheriff then
						lastRole = "Sheriff"
					end
				end

				local color = movement_callResult_1181 and Hub.GetOwnerESPGradientColor(now) or movement_callResult_1182 and Color3.fromRGB(180, 85, 255) or Hub.ESPColors[lastRole]

				if Hub.ESP360 and (lastRole == "Murderer" or lastRole == "Sheriff") then
					crosshair_helperFunc_0390(movement_loopVar_1180.Arrow, movement_loopVar_1180.ArrowDistance, hrp.Position, Hub.ESPColors[lastRole], viewportSize, character_)
				else
					crosshair_helperFunc_0389(movement_loopVar_1180.Arrow, movement_loopVar_1180.ArrowDistance)
				end

				if Hub.PlayerESP then
					if movement_loopVar_1180.Highlight.Adornee ~= character then
						movement_loopVar_1180.Highlight.Adornee = character
					end

					movement_loopVar_1180.Highlight.Enabled = true

					if movement_localValue_1183 or movement_loopVar_1180._lastRole ~= lastRole or movement_loopVar_1180._lastStyle ~= Hub.PlayerESPStyle then
						movement_loopVar_1180.Highlight.FillColor = color
						movement_loopVar_1180.Highlight.OutlineColor = color
						movement_loopVar_1180.Highlight.FillTransparency = Hub.PlayerESPStyle == "Outline" and 1 or 0.3
						movement_loopVar_1180.Highlight.OutlineTransparency = 0
						movement_loopVar_1180._lastRole = lastRole
						movement_loopVar_1180._lastStyle = Hub.PlayerESPStyle
					end
				else
					movement_loopVar_1180.Highlight.Enabled = false
				end

				movement_loopVar_1180.Billboard.Enabled = Hub.NametagESP

				if Hub.NametagESP then
					if movement_loopVar_1180.OwnerGradient then
						movement_loopVar_1180.OwnerGradient.Enabled = movement_callResult_1181

						if movement_callResult_1181 then
							movement_loopVar_1180.OwnerGradient.Rotation = 90
							movement_loopVar_1180.OwnerGradient.Offset = Vector2.new(0, math.sin(now * 0.7) * 0.28)
							movement_loopVar_1180.Text.TextColor3 = Color3.new(1, 1, 1)
						elseif movement_localValue_1183 then
							movement_loopVar_1180.Text.TextColor3 = color
						end
					elseif movement_localValue_1183 then
						movement_loopVar_1180.Text.TextColor3 = color
					end

					if Hub.ESPRenderCache.nametagInterval <= now - (movement_loopVar_1180._lastNametagUpdate or 0) then
						movement_loopVar_1180._lastNametagUpdate = now
						local movement_textValue_1184 = ""

						if character_ then
							movement_textValue_1184 = " | " .. tostring(math.floor((hrp.Position - character_.Position).Magnitude + 0.5)) .. " studs"
						end

						movement_loopVar_1180.Text.TextSize = movement_localValue_1183 and 15 or 14
						movement_loopVar_1180.Text.Text = movement_callResult_1181 and k.Name .. " [Owner | " .. lastRole .. "]" .. movement_textValue_1184 or movement_callResult_1182 and k.Name .. " [Same Script | " .. lastRole .. "]" .. movement_textValue_1184 or k.Name .. " [" .. lastRole .. "]" .. movement_textValue_1184
						movement_loopVar_1180.Text.TextColor3 = movement_callResult_1181 and Color3.new(1, 1, 1) or color
					end
				end

				if Hub.LineESP then
					if Hub.ESPRenderCache.lineInterval <= now - (movement_loopVar_1180._lastLineUpdate or 0) then
						movement_loopVar_1180._lastLineUpdate = now
						local movement_localValue_1185, movement_localValue_1186 = currentCamera2:WorldToViewportPoint(head.Position)

						if movement_localValue_1186 and movement_localValue_1185.Z > 0 then
							local vector2 = Vector2.new
							local clamp = math.clamp
							local y = movement_localValue_1185.Y
							local y2 = viewportSize.Y
							crosshair_helperFunc_0392(movement_loopVar_1180.Line, Vector2.new(viewportSize.X * 0.5, 0), vector2(math.clamp(movement_localValue_1185.X, 0, viewportSize.X), clamp(y, 0, y2)), color)
						else
							movement_loopVar_1180.Line.Visible = false
						end
					end
				else
					movement_loopVar_1180.Line.Visible = false
				end
			end
		end
	end

	if not gunESP then
		for _, movement_loopVar_1187 in pairs(Hub.GunESPTable) do
			if movement_loopVar_1187.Line then
				movement_loopVar_1187.Line.Visible = false
			end

			if movement_loopVar_1187.Billboard then
				movement_loopVar_1187.Billboard.Enabled = false
			end

			crosshair_helperFunc_0389(movement_loopVar_1187.Arrow, movement_loopVar_1187.ArrowDistance)
		end
	else
		for k, movement_loopVar_1188 in pairs(Hub.GunESPTable) do
			movement_loopVar_1188.Billboard.Enabled = Hub.GunESP
			movement_loopVar_1188.Line.Visible = Hub.GunESP

			if Hub.ESP360 then
				crosshair_helperFunc_0390(movement_loopVar_1188.Arrow, movement_loopVar_1188.ArrowDistance, k.Position, Hub.ESPColors.Gun, viewportSize, character_)
			else
				crosshair_helperFunc_0389(movement_loopVar_1188.Arrow, movement_loopVar_1188.ArrowDistance)
			end

			if Hub.GunESP then
				local movement_localValue_1189, movement_localValue_1190 = currentCamera2:WorldToViewportPoint(k.Position)

				if movement_localValue_1190 and movement_localValue_1189.Z > 0 then
					local gun = Hub.ESPColors.Gun
					movement_loopVar_1188.TextLabel.TextColor3 = gun
					local vector2 = Vector2.new
					local clamp = math.clamp
					local y = movement_localValue_1189.Y
					local y2 = viewportSize.Y
					crosshair_helperFunc_0392(movement_loopVar_1188.Line, Vector2.new(viewportSize.X * 0.5, 0), vector2(math.clamp(movement_localValue_1189.X, 0, viewportSize.X), clamp(y, 0, y2)), gun)
					movement_loopVar_1188.Billboard.StudsOffset = Vector3.new(0, 3, 0)
				else
					movement_loopVar_1188.Line.Visible = false
				end
			end
		end
	end
end))

do
	local function movement_helperFunc_1191(movement_param_1192)
		local humanoid = movement_param_1192:WaitForChild("Humanoid")
		humanoid.WalkSpeed = Hub.WalkSpeed
		humanoid.JumpPower = Hub.JumpPower
	end

	local function movement_helperFunc_1193(movement_param_1194)
		if not movement_param_1194 then
			return
		end
		return movement_param_1194:FindFirstChild("HumanoidRootPart") or movement_param_1194:FindFirstChild("Torso") or movement_param_1194:FindFirstChild("UpperTorso")
	end

	local function movement_helperFunc_1195(movement_param_1196)
		for k, movement_loopVar_1197 in pairs(movement_param_1196) do
			if movement_loopVar_1197 and typeof(movement_loopVar_1197.Disconnect) == "function" then
				pcall(function()
					movement_loopVar_1197:Disconnect()
				end)
			end

			movement_param_1196[k] = nil
		end
	end

	local movement_configTable_1198 = {
		flying = false,
		conns = {},
		objects = {},
		gamepadAxis = Vector2.new(0, 0),
		control = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 },
	}

	Hub.StopFly = function()
		if not movement_configTable_1198.flying then
			return
		end
		movement_configTable_1198.flying = false
		movement_helperFunc_1195(movement_configTable_1198.conns)

		pcall(function()
			if movement_configTable_1198.objects.bv then
				movement_configTable_1198.objects.bv:Destroy()
			end

			if movement_configTable_1198.objects.bg then
				movement_configTable_1198.objects.bg:Destroy()
			end
		end)

		movement_configTable_1198.objects = {}
		movement_configTable_1198.gamepadAxis = Vector2.new(0, 0)
		movement_configTable_1198.control = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
		local character_ = localPlayer.Character
		character_ = character_ and character_:FindFirstChildOfClass("Humanoid")

		if character_ then
			character_.PlatformStand = false
		end
	end

	Hub.StartFly = function()
		if movement_configTable_1198.flying then
			return
		end
		local character_ = localPlayer.Character or localPlayer.CharacterAdded:Wait()
		local movement_callResult_1199 = movement_helperFunc_1193(character_)
		if not movement_callResult_1199 then
			return
		end
		movement_configTable_1198.flying = true
		movement_configTable_1198.control = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
		local humanoid = character_:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid.PlatformStand = true
		end

		local bodyGyro = Instance.new("BodyGyro")
		local bodyVelocity = Instance.new("BodyVelocity")
		bodyGyro.Name = "FlyBodyGyro"
		bodyGyro.P = 90000
		bodyGyro.D = 1000
		bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
		bodyGyro.CFrame = movement_callResult_1199.CFrame
		bodyGyro.Parent = movement_callResult_1199
		bodyVelocity.Name = "FlyBodyVelocity"
		bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
		bodyVelocity.Velocity = Vector3.zero
		bodyVelocity.Parent = movement_callResult_1199
		movement_configTable_1198.objects.bg = bodyGyro
		movement_configTable_1198.objects.bv = bodyVelocity

		movement_configTable_1198.conns.inputBegan = UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed or input.UserInputType ~= Enum.UserInputType.Keyboard then
				return
			end
			local keyCode = input.KeyCode

			if keyCode == Enum.KeyCode.W then
				movement_configTable_1198.control.F = 1
			end

			if keyCode == Enum.KeyCode.S then
				movement_configTable_1198.control.B = 1
			end

			if keyCode == Enum.KeyCode.A then
				movement_configTable_1198.control.L = -1
			end

			if keyCode == Enum.KeyCode.D then
				movement_configTable_1198.control.R = 1
			end

			if keyCode == Enum.KeyCode.E then
				movement_configTable_1198.control.E = 1
			end

			if keyCode == Enum.KeyCode.Q then
				movement_configTable_1198.control.Q = -1
			end
		end)

		movement_configTable_1198.conns.inputEnded = UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType ~= Enum.UserInputType.Keyboard then
				return
			end
			local keyCode = input.KeyCode

			if keyCode == Enum.KeyCode.W then
				movement_configTable_1198.control.F = 0
			end

			if keyCode == Enum.KeyCode.S then
				movement_configTable_1198.control.B = 0
			end

			if keyCode == Enum.KeyCode.A then
				movement_configTable_1198.control.L = 0
			end

			if keyCode == Enum.KeyCode.D then
				movement_configTable_1198.control.R = 0
			end

			if keyCode == Enum.KeyCode.E then
				movement_configTable_1198.control.E = 0
			end

			if keyCode == Enum.KeyCode.Q then
				movement_configTable_1198.control.Q = 0
			end
		end)

		movement_configTable_1198.conns.inputChanged = UserInputService.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.Thumbstick1 then
				movement_configTable_1198.gamepadAxis = input.Position or Vector2.new(0, 0)
			end
		end)

		movement_configTable_1198.conns.heartbeat = RunService.Heartbeat:Connect(function()
			if not movement_configTable_1198.flying then
				return
			end

			if not movement_callResult_1199 or not movement_callResult_1199.Parent then
				Hub.StopFly()
				return
			end
			local movement_flySpeedState_1200 = tonumber(Hub.FlySpeed) or 50
			local currentCamera2 = workspace.CurrentCamera
			local lookVector = currentCamera2 and currentCamera2.CFrame.LookVector or movement_callResult_1199.CFrame.LookVector
			local vector = Vector3.new(lookVector.X, 0, lookVector.Z)

			if vector.Magnitude <= 0.001 then
				vector = Vector3.new(movement_callResult_1199.CFrame.LookVector.X, 0, movement_callResult_1199.CFrame.LookVector.Z)
			end

			local unit = vector.Unit
			local vector2 = Vector3.new(-unit.Z, 0, unit.X)
			local movement_numericVar_1201

			if humanoid and humanoid.MoveDirection and humanoid.MoveDirection.Magnitude > 0.001 then
				movement_numericVar_1201 = humanoid.MoveDirection.Unit * movement_flySpeedState_1200
			elseif movement_configTable_1198.gamepadAxis.Magnitude > 0.01 then
				movement_numericVar_1201 = (unit * -movement_configTable_1198.gamepadAxis.Y + vector2 * movement_configTable_1198.gamepadAxis.X) * movement_flySpeedState_1200
			else
				local movement_numericVar_1202 = unit * (movement_configTable_1198.control.F - movement_configTable_1198.control.B) + vector2 * (movement_configTable_1198.control.R + movement_configTable_1198.control.L)
				movement_numericVar_1201 = Vector3.zero

				if movement_numericVar_1202.Magnitude > 0 then
					movement_numericVar_1201 = movement_numericVar_1202.Unit * movement_flySpeedState_1200 * 0.6
				end
			end

			local movement_numericVar_1203 = 0

			if movement_numericVar_1201.Magnitude > 0.05 then
				local vector3 = Vector3.new(movement_numericVar_1201.X, 0, movement_numericVar_1201.Z)
				local movement_numericVar_1204 = 0

				if vector3.Magnitude > 0.001 then
					movement_numericVar_1204 = vector3.Unit:Dot(unit)
				end

				movement_numericVar_1203 = lookVector.Y * movement_flySpeedState_1200 * movement_numericVar_1204
			end

			local movement_numericVar_1205 = 0

			if movement_numericVar_1201.Magnitude > 0.05 then
				movement_numericVar_1205 = (movement_configTable_1198.control.E + movement_configTable_1198.control.Q) * movement_flySpeedState_1200 * 0.5
			end

			local vector3 = Vector3.new(movement_numericVar_1201.X, movement_numericVar_1203 + movement_numericVar_1205, movement_numericVar_1201.Z)
			local movement_numericVar_1206 = math.max(movement_flySpeedState_1200 * 1.2, 50)

			if vector3.Y > movement_numericVar_1206 then
				vector3 = Vector3.new(vector3.X, movement_numericVar_1206, vector3.Z)
			end

			if vector3.Y < -movement_numericVar_1206 then
				vector3 = Vector3.new(vector3.X, -movement_numericVar_1206, vector3.Z)
			end

			movement_configTable_1198.objects.bv.Velocity = vector3

			if currentCamera2 then
				bodyGyro.CFrame = CFrame.new(movement_callResult_1199.Position, movement_callResult_1199.Position + lookVector)
			else
				bodyGyro.CFrame = movement_callResult_1199.CFrame
			end
		end)
	end

	local function movement_helperFunc_1207(character_)
		local blackScreenGui = Hub.CoinFarm.blackScreenGui

		if blackScreenGui and blackScreenGui.Parent then
			local coinFarm = Hub.CoinFarm
			coinFarm.blackScreenUpdateGeneration = coinFarm.blackScreenUpdateGeneration + 1

			pcall(function()
				blackScreenGui:Destroy()
			end)

			Hub.CoinFarm.blackScreenGui = nil
			table.clear(Hub.CoinFarm.blackScreenLabels)
		end

		localChar.character = character_
		localChar.humanoid = character_:WaitForChild("Humanoid")
		localChar.rootPart = character_:WaitForChild("HumanoidRootPart")
		movement_helperFunc_1191(character_)
		crosshair_helperFunc_0398()

		if Hub.FlyEnabled then
			Hub.StopFly()
			Hub.StartFly()
		end

		if Hub.NoclipEnabled then
			crosshair_helperFunc_0394()
			crosshair_helperFunc_0393()
		end

		if Hub.InvisibilityEnabled then
			task.defer(quickMenu_helperFunc_0818)
		end

		if Hub.WalkSpeedConn then
			Hub.WalkSpeedConn:Disconnect()
			Hub.WalkSpeedConn = nil
		end

		Hub.WalkSpeedConn = localChar.humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
			if localChar.humanoid.WalkSpeed ~= Hub.WalkSpeed then
				localChar.humanoid.WalkSpeed = Hub.WalkSpeed
			end
		end)
	end

	trackConn(localPlayer.CharacterAdded:Connect(movement_helperFunc_1207))

	if localPlayer.Character then
		task.spawn(function()
			movement_helperFunc_1207(localPlayer.Character)
		end)
	end
end

do
	local function movement_helperFunc_1208(movement_param_1209)
		local character_ = localPlayer.Character
		character_ = character_ and character_:FindFirstChild("HumanoidRootPart")
		if not character_ then
			return
		end
		local humanoidRootPart

		if movement_param_1209 == "Gun" then
			humanoidRootPart = nil

			for _, descendant in ipairs(workspace:GetDescendants()) do
				if crosshair_helperFunc_0400(descendant) then
					humanoidRootPart = descendant
					break
				else
					humanoidRootPart = nil
				end
			end
		else
			humanoidRootPart = nil

			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					local knife = movement_param_1209 == "Murderer" and (player.Character:FindFirstChild("Knife") or player:FindFirstChildOfClass("Backpack") and player.Backpack:FindFirstChild("Knife"))
					local teleport_textValue_1210 = ""

					if knife then
						teleport_textValue_1210 = "Murderer"
					end

					local teleport_boolFlag_1211 = movement_param_1209 == "Sheriff"
					local gun

					if teleport_boolFlag_1211 then
						local gun2 = player.Character:FindFirstChild("Gun")

						if gun2 then
							gun = gun2
						else
							gun = player:FindFirstChildOfClass("Backpack") and player.Backpack:FindFirstChild("Gun")
						end
					else
						gun = teleport_boolFlag_1211
					end

					if gun then
						teleport_textValue_1210 = "Sheriff"
					end

					if teleport_textValue_1210 == movement_param_1209 then
						humanoidRootPart = player.Character.HumanoidRootPart
						break
					else
						humanoidRootPart = nil
					end
				else
					humanoidRootPart = nil
				end
			end
		end

		if humanoidRootPart then
			if movement_param_1209 == "Murderer" and humanoidRootPart.Parent:FindFirstChild("HumanoidRootPart") then
				character_.CFrame = CFrame.new(humanoidRootPart.Position - humanoidRootPart.CFrame.LookVector * 15 + Vector3.new(0, 3, 0))
			else
				character_.CFrame = humanoidRootPart.CFrame + Vector3.new(0, 3, 0)
			end
		else
			WindUI:Notify({ Title = "错误", Content = movement_param_1209 .. " cannot be found", Icon = "x", Duration = 1.5 })
		end
	end

	local function teleport_helperFunc_1212(cFrame, teleport_param_1213)
		local character_ = localPlayer.Character
		local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = character_ and character_:FindFirstChild("HumanoidRootPart")
		if not character_ or not humanoid or humanoid.Health <= 0 or not humanoidRootPart then
			WindUI:Notify({ Title = "传送", Content = "你的角色已死亡。", Icon = "x", Duration = 2.5 })
			return false
		end

		pcall(function()
			humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
			humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
			character_:PivotTo(cFrame)
			humanoidRootPart.CFrame = cFrame
		end)

		WindUI:Notify({
			Title = "传送",
			Content = "已传送至 " .. (teleport_param_1213 or "location") .. "!",
			Icon = "check",
			Duration = 2,
		})

		return true
	end

	local function teleport_helperFunc_1214()
		local teleport_configTable_1215 = {}
		local summerLobby = workspace:FindFirstChild("SummerLobby")
		local lobby = workspace:FindFirstChild("Lobby")
		local normalLobby = workspace:FindFirstChild("NormalLobby")
		local halloweenLobby = workspace:FindFirstChild("HalloweenLobby")
		local christmasLobby = workspace:FindFirstChild("ChristmasLobby")
		local teleport_localValue_1216 = workspace
		local findFirstChild = teleport_localValue_1216.FindFirstChild
		teleport_configTable_1215[1] = summerLobby
		teleport_configTable_1215[2] = lobby
		teleport_configTable_1215[3] = normalLobby
		teleport_configTable_1215[4] = halloweenLobby
		teleport_configTable_1215[5] = christmasLobby

		do
			local values = table.pack(findFirstChild(teleport_localValue_1216, "EasterLobby"))
			table.move(values, 1, values.n, 6, teleport_configTable_1215)
		end

		for _, teleport_loopVar_1217 in ipairs(teleport_configTable_1215) do
			if teleport_loopVar_1217 then
				local spawns = teleport_loopVar_1217:FindFirstChild("Spawns")

				if spawns then
					local spawnLocation = spawns:FindFirstChildOfClass("SpawnLocation") or spawns:FindFirstChildWhichIsA("BasePart")
					if spawnLocation then
						return spawnLocation.CFrame + Vector3.new(0, 3.5, 0), "Lobby Spawns"
					end
				end

				local nikilis = teleport_loopVar_1217:FindFirstChild("Lobby") and teleport_loopVar_1217.Lobby:FindFirstChild("Nikilis")

				if nikilis and (nikilis:IsA("BasePart") or nikilis:IsA("Model")) then
					local pivot

					if nikilis:IsA("Model") then
						pivot = nikilis:GetPivot()
					else
						pivot = nikilis.CFrame
					end

					return pivot + Vector3.new(0, 3.5, 0), "Nikilis Lobby"
				end

				teleport_loopVar_1217 = teleport_loopVar_1217:FindFirstChild("Lobby") or teleport_loopVar_1217
				local basePart = teleport_loopVar_1217:FindFirstChildWhichIsA("BasePart", true)
				if basePart then
					return basePart.CFrame + Vector3.new(0, 5, 0), "Lobby"
				end
			end
		end

		for _, descendant in ipairs(workspace:GetDescendants()) do
			if descendant:IsA("SpawnLocation") and (descendant.Parent and string.find(string.lower(descendant.Parent.Name), "spawn") or descendant.Position.Y < -50) then
				return descendant.CFrame + Vector3.new(0, 3.5, 0), "Lobby Spawn"
			end
		end

		return nil, nil
	end

	local function teleport_helperFunc_1218()
		local teleport_configTable_1219 = {
			SummerLobby = true,
			Lobby = true,
			NormalLobby = true,
			HalloweenLobby = true,
			ChristmasLobby = true,
			EasterLobby = true,
			EffectLoader = true,
			ServerStatus = true,
			PetContainer = true,
			WeaponDisplays = true,
			RCCars = true,
			Terrain = true,
			Camera = true,
		}

		local function teleport_helperFunc_1220(teleport_param_1221)
			if not teleport_param_1221 then
				return false
			end
			local name = teleport_param_1221.Name
			if teleport_configTable_1219[name] then
				return true
			end

			if string.find(string.lower(name), "lobby") then
				return true
			end
			return false
		end

		local currentMapInstance = Hub.RoundState and Hub.RoundState.currentMapInstance
		local resolveMap

		if currentMapInstance then
			resolveMap = currentMapInstance
		else
			resolveMap = Hub.CoinFarm and Hub.CoinFarm.ResolveMap and Hub.CoinFarm.ResolveMap()
		end

		resolveMap = resolveMap or Hub.CoinFarm and Hub.CoinFarm.indexedMap

		if not (resolveMap and resolveMap.Parent and resolveMap:IsDescendantOf(workspace)) then
			resolveMap = nil

			for _, child in ipairs(workspace:GetChildren()) do
				if (child:IsA("Model") or child:IsA("Folder")) and not teleport_helperFunc_1220(child) and not Players:GetPlayerFromCharacter(child) then
					if child:FindFirstChild("CoinContainer", true) or child:FindFirstChild("Coin_Server", true) or child:FindFirstChild("CoinVisual", true) then
						resolveMap = child
						break
					else
						resolveMap = nil
					end
				else
					resolveMap = nil
				end
			end
		end

		if not (resolveMap and resolveMap.Parent and resolveMap:IsDescendantOf(workspace)) then
			for _, child in ipairs(workspace:GetChildren()) do
				if child:IsA("Model") and not teleport_helperFunc_1220(child) and not Players:GetPlayerFromCharacter(child) then
					local spawns = child:FindFirstChild("Spawns")
					if spawns and spawns:FindFirstChildWhichIsA("BasePart") then
						resolveMap = child
						break
					end
				end
			end
		end

		if resolveMap and resolveMap:IsDescendantOf(workspace) then
			local spawns = resolveMap:FindFirstChild("Spawns")

			if spawns then
				local teleport_configTable_1222 = {}

				for _, child in ipairs(spawns:GetChildren()) do
					if child:IsA("BasePart") then
						table.insert(teleport_configTable_1222, child)
					end
				end

				if #teleport_configTable_1222 > 0 then
					return teleport_configTable_1222[math.random(1, #teleport_configTable_1222)].CFrame + Vector3.new(0, 3.5, 0), "Arena Spawns (" .. resolveMap.Name .. ")"
				end
			end

			local coinContainer = resolveMap:FindFirstChild("CoinContainer") or resolveMap:FindFirstChild("CoinContainer", true)

			if coinContainer then
				local basePart = coinContainer:FindFirstChildWhichIsA("BasePart", true)
				if basePart then
					return basePart.CFrame + Vector3.new(0, 3, 0), "Arena (" .. resolveMap.Name .. ")"
				end
			end

			local primaryPart = resolveMap.PrimaryPart or resolveMap:FindFirstChildWhichIsA("BasePart", true)
			if primaryPart then
				return primaryPart.CFrame + Vector3.new(0, 5, 0), "Arena (" .. resolveMap.Name .. ")"
			end
		end

		local gunDrop = workspace:FindFirstChild("GunDrop", true)
		if gunDrop and gunDrop:IsA("BasePart") then
			return gunDrop.CFrame + Vector3.new(0, 3, 0), "Arena (GunDrop)"
		end
		local coinServer = workspace:FindFirstChild("Coin_Server", true) or workspace:FindFirstChild("CoinVisual", true)
		if coinServer and coinServer:IsA("BasePart") and not teleport_helperFunc_1220(coinServer.Parent) then
			return coinServer.CFrame + Vector3.new(0, 3, 0), "Arena (Coins)"
		end
		local teleport_callResult_1223 = typeof(crosshair_helperFunc_0406) == "function" and crosshair_helperFunc_0406()

		if teleport_callResult_1223 and teleport_callResult_1223 ~= localPlayer and teleport_callResult_1223.Character then
			local humanoidRootPart = teleport_callResult_1223.Character:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
				return humanoidRootPart.CFrame + Vector3.new(0, 3.5, 0), "Arena (Near Murderer)"
			end
		end

		local teleport_callResult_1224 = typeof(crosshair_helperFunc_0407) == "function" and crosshair_helperFunc_0407()

		if teleport_callResult_1224 and teleport_callResult_1224 ~= localPlayer and teleport_callResult_1224.Character then
			local humanoidRootPart = teleport_callResult_1224.Character:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
				return humanoidRootPart.CFrame + Vector3.new(0, 3.5, 0), "Arena (Near Sheriff)"
			end
		end

		return nil, nil
	end

	local function teleport_helperFunc_1225()
		local teleport_callResult_1226, teleport_callResult_1227 = teleport_helperFunc_1214()
		if teleport_callResult_1226 then
			return teleport_helperFunc_1212(teleport_callResult_1226, teleport_callResult_1227 or "Lobby")
		end
		WindUI:Notify({ Title = "错误", Content = "未找到大厅。", Icon = "x", Duration = 2 })
		return false
	end

	local function teleport_helperFunc_1228()
		local teleport_callResult_1229, teleport_callResult_1230 = teleport_helperFunc_1218()
		if teleport_callResult_1229 then
			return teleport_helperFunc_1212(teleport_callResult_1229, teleport_callResult_1230 or "Game Arena")
		end
		WindUI:Notify({ Title = "错误", Content = "未找到进行中的对局地图。", Icon = "x", Duration = 2 })
		return false
	end

	local function resolveVotePads()
		local lobbyNames = { "Lobby", "NormalLobby", "SummerLobby", "HalloweenLobby", "ChristmasLobby", "EasterLobby" }
		for _, name in ipairs(lobbyNames) do
			local lob = workspace:FindFirstChild(name)
			if lob then
				local vp = lob:FindFirstChild("VotePads")
				if vp then
					return vp
				end
			end
		end
		return workspace:FindFirstChild("VotePads", true)
	end

	local function resolveVotingPad(selection)
		local vp = resolveVotePads()
		if not vp then
			return nil
		end
		local teleport_callResult_1231 = tostring(selection or "1")
		local teleport_numericVar_1232 = teleport_callResult_1231:match("%d") or "1"
		return vp:FindFirstChild("VotePad" .. teleport_numericVar_1232)
	end

	local function getBoardCFrame(pad)
		if not pad then
			return nil
		end
		local padPart = pad:FindFirstChild("Pad")
		if not padPart or not padPart:IsA("BasePart") then
			return nil
		end
		local adornee = pad:FindFirstChild("MapInfoGui") and pad.MapInfoGui.Adornee
		local targetPos = padPart.Position + Vector3.new(0, 3, 0)
		if adornee and adornee:IsA("BasePart") then
			return CFrame.lookAt(targetPos, Vector3.new(adornee.Position.X, targetPos.Y, adornee.Position.Z))
		end
		return padPart.CFrame + Vector3.new(0, 3, 0)
	end

	local function getPadVotes(pad)
		if not pad then
			return 0
		end
		local vi = pad:FindFirstChild("VoteInfoGui")
		local container = vi and vi:FindFirstChild("Container")
		local votesLabel = container and container:FindFirstChild("Votes")
		if votesLabel and votesLabel:IsA("TextLabel") then
			local teleport_numericVar_1233 = tonumber(votesLabel.Text:match("%d+"))
			return teleport_numericVar_1233 or 0
		end
		return 0
	end

	local function isVotingActive()
		local vp = resolveVotePads()
		if not vp then
			return false
		end
		for _, pad in ipairs(vp:GetChildren()) do
			local vi = pad:FindFirstChild("VoteInfoGui")
			if vi and vi:IsA("SurfaceGui") and vi.Enabled then
				return true
			end
		end
		return false
	end

	local function teleportToVotePad(cf)
		local character_ = localPlayer.Character
		local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = character_ and character_:FindFirstChild("HumanoidRootPart")
		if not character_ or not humanoid or humanoid.Health <= 0 or not humanoidRootPart then
			return false
		end
		pcall(function()
			humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
			humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
			character_:PivotTo(cf)
			humanoidRootPart.CFrame = cf
		end)
		return true
	end

	local function resetCharacterForVote()
		local character_ = localPlayer.Character
		local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
		if humanoid and humanoid.Health > 0 then
			pcall(function()
				humanoid.Health = 0
			end)
			if humanoid.Health > 0 then
				pcall(function()
					character_:BreakJoints()
				end)
			end
		end
	end

	local function waitForRespawn(timeout)
		local deadline = os.clock() + (timeout or 6)
		while os.clock() < deadline and Hub.AutoMapVote.enabled do
			local character_ = localPlayer.Character
			local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
			local humanoidRootPart = character_ and character_:FindFirstChild("HumanoidRootPart")
			if character_ and humanoid and humanoidRootPart and humanoid.Health > 0 then
				task.wait(0.12)
				return character_
			end
			task.wait(0.05)
		end
		return localPlayer.Character
	end

	local function runAutoMapVoteCycle()
		while Hub.AutoMapVote.enabled do
			if not isVotingActive() then
				task.wait(0.5)
				continue
			end

			local pad = resolveVotingPad(Hub.AutoMapVote.board)
			if not pad then
				task.wait(0.5)
				continue
			end

			local cf = getBoardCFrame(pad)
			if not cf then
				task.wait(0.5)
				continue
			end

			local startVotes = getPadVotes(pad)
			teleportToVotePad(cf)

			local voteRose = false
			local waitStart = os.clock()
			while Hub.AutoMapVote.enabled and isVotingActive() and (os.clock() - waitStart < 3) do
				if getPadVotes(pad) > startVotes then
					voteRose = true
					break
				end
				if os.clock() - waitStart > 1.2 then
					teleportToVotePad(cf)
				end
				task.wait(0.05)
			end

			if voteRose and Hub.AutoMapVote.enabled and isVotingActive() then
				resetCharacterForVote()
				waitForRespawn(6)
			else
				task.wait(0.2)
			end
		end
	end

	local function teleportToVotingBoard()
		local pad = resolveVotingPad(Hub.AutoMapVote.board)
		local cf = getBoardCFrame(pad)
		if cf then
			local mapName = pad:FindFirstChild("VoteInfoGui") and pad.VoteInfoGui:FindFirstChild("Container") and pad.VoteInfoGui.Container:FindFirstChild("MapName") and pad.VoteInfoGui.Container.MapName.Text
			local label = Hub.AutoMapVote.board
			if mapName and mapName ~= "" then
				label ..= " (" .. mapName .. ")"
			end
			return teleport_helperFunc_1212(cf, label)
		end
		WindUI:Notify({ Title = "错误", Content = "未找到投票板。", Icon = "x", Duration = 2 })
		return false
	end

	local function teleport_helperFunc_1234(teleport_param_1235)
		local teleport_localValue_1236 = Players:FindFirstChild(teleport_param_1235)
		if not teleport_localValue_1236 or not teleport_localValue_1236.Character then
			WindUI:Notify({ Title = "错误", Content = "未找到玩家", Icon = "x", Duration = 1.5 })
			return
		end
		local humanoidRootPart = teleport_localValue_1236.Character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return
		end
		local character_ = localPlayer.Character
		character_ = character_ and character_:FindFirstChild("HumanoidRootPart")
		if not character_ then
			return
		end
		character_.CFrame = humanoidRootPart.CFrame + Vector3.new(0, 3, 0)
	end

	local function teleport_helperFunc_1237()
		local teleport_configTable_1238 = {}

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer then
				table.insert(teleport_configTable_1238, player.Name)
			end
		end

		table.sort(teleport_configTable_1238)
		return teleport_configTable_1238
	end

	local teleport_optionalValue_1239 = nil
	local teleport_optionalValue_1240 = nil
	local teleport_optionalValue_1241 = nil
	Hub.RefreshingPlayerDropdown = false

	local function teleport_helperFunc_1242(teleport_param_1243, teleport_param_1244)
		if not teleport_param_1243 then
			return
		end
		local teleport_boolFlag_1245 = false

		if teleport_param_1243.SetValues then
			teleport_boolFlag_1245 = pcall(function()
				teleport_param_1243:SetValues(YXOpt.list(teleport_param_1244))
			end)
		end

		if not teleport_boolFlag_1245 and teleport_param_1243.Refresh then
			teleport_boolFlag_1245 = pcall(function()
				teleport_param_1243:Refresh(YXOpt.list(teleport_param_1244))
			end)
		end

		if not teleport_boolFlag_1245 and teleport_param_1243.Update then
			pcall(function()
				teleport_param_1243:Update(YXOpt.list(teleport_param_1244))
			end)
		end
	end

	local function teleport_helperFunc_1246()
		Hub.RefreshingPlayerDropdown = true
		local teleport_callResult_1247 = teleport_helperFunc_1237()

		if #teleport_callResult_1247 == 0 then
			teleport_callResult_1247 = { "(No other players)" }
		end

		teleport_helperFunc_1242(teleport_optionalValue_1239, teleport_callResult_1247)
		teleport_helperFunc_1242(teleport_optionalValue_1240, teleport_callResult_1247)

		if teleport_optionalValue_1241 and not Players:FindFirstChild(teleport_optionalValue_1241) then
			teleport_optionalValue_1241 = nil
		end

		if Hub.SelectedFlingName and not Players:FindFirstChild(Hub.SelectedFlingName) then
			Hub.SelectedFlingName = nil
		end

		task.defer(function()
			Hub.RefreshingPlayerDropdown = false
		end)
	end

	local function teleport_helperFunc_1248()
		local teleport_configTable_1249 = {
			enabled = false,
			generation = 0,
			connections = {},
			restoreItems = {},
			processed = setmetatable({}, { __mode = "k" }),
			stats = { parts = 0, textures = 0, effects = 0 },
		}

		local function teleport_helperFunc_1250(teleport_param_1251, teleport_param_1252)
			local stats = teleport_configTable_1249.stats
			stats[teleport_param_1252] = stats[teleport_param_1252] + 1
		end

		local function teleport_helperFunc_1253(teleport_param_1254, teleport_param_1255, teleport_param_1256)
			if not teleport_param_1254 then
				return false
			end

			local ok, result = pcall(function()
				return teleport_param_1254[teleport_param_1255]
			end)

			if not ok then
				return false
			end

			if result == teleport_param_1256 then
				return true
			end
			table.insert(teleport_configTable_1249.restoreItems, teleport_param_1254)
			table.insert(teleport_configTable_1249.restoreItems, teleport_param_1255)
			table.insert(teleport_configTable_1249.restoreItems, result)

			return pcall(function()
				teleport_param_1254[teleport_param_1255] = teleport_param_1256
			end)
		end

		local function teleport_helperFunc_1257(teleport_param_1258)
			if not teleport_param_1258 then
				return false
			end

			while teleport_param_1258 and teleport_param_1258 ~= workspace do
				if teleport_param_1258:IsA("Model") then
					if Players:GetPlayerFromCharacter(teleport_param_1258) then
						return true
					end
					local teleport_localValue_1259 = Players:FindFirstChild(teleport_param_1258.Name)
					local teleport_boolFlag_1260

					if teleport_localValue_1259 then
						teleport_boolFlag_1260 = teleport_localValue_1259.Character == teleport_param_1258 or teleport_param_1258:FindFirstChildOfClass("Humanoid") ~= nil
					else
						teleport_boolFlag_1260 = teleport_localValue_1259
					end

					if teleport_boolFlag_1260 then
						return true
					end
				end

				teleport_param_1258 = teleport_param_1258.Parent
			end

			return false
		end

		local function teleport_helperFunc_1261(teleport_param_1262)
			if not teleport_configTable_1249.enabled or not teleport_param_1262 or teleport_helperFunc_1257(teleport_param_1262) or teleport_configTable_1249.processed[teleport_param_1262] then
				return
			end
			teleport_configTable_1249.processed[teleport_param_1262] = true

			if teleport_param_1262:IsA("BasePart") then
				teleport_helperFunc_1253(teleport_param_1262, "Material", Enum.Material.SmoothPlastic)
				teleport_helperFunc_1250(teleport_param_1262, "parts")

				if teleport_param_1262:IsA("MeshPart") then
					teleport_helperFunc_1253(teleport_param_1262, "TextureID", "")
					teleport_helperFunc_1250(teleport_param_1262, "textures")
				end
			elseif teleport_param_1262:IsA("Decal") or teleport_param_1262:IsA("Texture") then
				teleport_helperFunc_1253(teleport_param_1262, "Texture", "")
				teleport_helperFunc_1253(teleport_param_1262, "Transparency", 1)
				teleport_helperFunc_1250(teleport_param_1262, "textures")
			elseif teleport_param_1262:IsA("SurfaceAppearance") then
				teleport_helperFunc_1253(teleport_param_1262, "ColorMap", "")
				teleport_helperFunc_1253(teleport_param_1262, "MetalnessMap", "")
				teleport_helperFunc_1253(teleport_param_1262, "NormalMap", "")
				teleport_helperFunc_1253(teleport_param_1262, "RoughnessMap", "")
				teleport_helperFunc_1250(teleport_param_1262, "textures")
			elseif teleport_param_1262:IsA("ParticleEmitter") or teleport_param_1262:IsA("Smoke") or teleport_param_1262:IsA("Sparkles") or teleport_param_1262:IsA("Fire") or teleport_param_1262:IsA("Trail") or teleport_param_1262:IsA("Beam") then
				teleport_helperFunc_1253(teleport_param_1262, "Enabled", false)
				teleport_helperFunc_1250(teleport_param_1262, "effects")
			end
		end

		local function teleport_helperFunc_1263()
			local restoreItems = teleport_configTable_1249.restoreItems

			for i = #restoreItems - 2, 1, -3 do
				local teleport_localValue_1264 = restoreItems[i]
				local teleport_localValue_1265 = restoreItems[i + 1]
				local teleport_localValue_1266 = restoreItems[i + 2]

				if teleport_localValue_1264 and teleport_localValue_1264.Parent then
					pcall(function()
						teleport_localValue_1264[teleport_localValue_1265] = teleport_localValue_1266
					end)
				end
			end

			table.clear(restoreItems)
		end

		Hub.SetFPSBoost = function(enabled, teleport_param_1267)
			enabled = enabled and true or false
			if teleport_configTable_1249.enabled == enabled then
				return
			end
			teleport_configTable_1249.enabled = enabled
			teleport_configTable_1249.generation = teleport_configTable_1249.generation + 1
			local generation = teleport_configTable_1249.generation

			for i = #teleport_configTable_1249.connections, 1, -1 do
				local teleport_localValue_1268 = teleport_configTable_1249.connections[i]
				teleport_configTable_1249.connections[i] = nil

				if teleport_localValue_1268 and teleport_localValue_1268.Connected then
					pcall(function()
						teleport_localValue_1268:Disconnect()
					end)
				end
			end

			if not enabled then
				teleport_helperFunc_1263()
				teleport_configTable_1249.processed = setmetatable({}, { __mode = "k" })

				if not teleport_param_1267 then
					WindUI:Notify({
						Title = "优化卡顿",
						Content = "已还原原始材质、纹理与粒子效果。",
						Icon = "rotate-ccw",
						Duration = 2.5,
					})
				end

				return
			end

			table.clear(teleport_configTable_1249.restoreItems)
			teleport_configTable_1249.processed = setmetatable({}, { __mode = "k" })
			teleport_configTable_1249.stats = { parts = 0, textures = 0, effects = 0 }

			table.insert(teleport_configTable_1249.connections, workspace.DescendantAdded:Connect(function(descendant)
				task.defer(function()
					if teleport_configTable_1249.enabled and teleport_configTable_1249.generation == generation then
						teleport_helperFunc_1261(descendant)
					end
				end)
			end))

			task.spawn(function()
				local teleport_numericVar_1269 = 0

				local function teleport_helperFunc_1270(teleport_param_1271)
					for _, descendant in ipairs(teleport_param_1271:GetDescendants()) do
						if not teleport_configTable_1249.enabled or teleport_configTable_1249.generation ~= generation then
							return false
						end
						teleport_helperFunc_1261(descendant)
						teleport_numericVar_1269 += 1

						if teleport_numericVar_1269 % 200 == 0 then
							RunService.Heartbeat:Wait()
						end
					end

					return true
				end

				if teleport_helperFunc_1270(workspace) and teleport_configTable_1249.enabled and teleport_configTable_1249.generation == generation and not teleport_param_1267 then
					WindUI:Notify({
						Title = "优化卡顿",
						Content = string.format("已精简 %d 个部件、%d 个纹理与 %d 个粒子效果，光照保持不变。", teleport_configTable_1249.stats.parts, teleport_configTable_1249.stats.textures, teleport_configTable_1249.stats.effects),
						Icon = "gauge",
						Duration = 3,
					})
				end
			end)
		end
	end

	teleport_helperFunc_1248()

	local function teleport_helperFunc_1272()
		local character_ = localPlayer.Character
		character_ = character_ and character_:FindFirstChild("HumanoidRootPart")
		if not character_ then
			return nil
		end
		local huge = math.huge
		local teleport_optionalValue_1273 = nil

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer and player.Character and crosshair_helperFunc_0402(player) and not crosshair_helperFunc_0401(player) then
				local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")

				if humanoidRootPart then
					local magnitude = (character_.Position - humanoidRootPart.Position).Magnitude

					if magnitude < huge then
						huge = magnitude
						teleport_optionalValue_1273 = player
					end
				end
			end
		end

		if not teleport_optionalValue_1273 then
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= localPlayer and player.Character and crosshair_helperFunc_0402(player) then
					local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")

					if humanoidRootPart then
						local magnitude = (character_.Position - humanoidRootPart.Position).Magnitude

						if magnitude < huge then
							huge = magnitude
							teleport_optionalValue_1273 = player
						end
					end
				end
			end
		end

		return teleport_optionalValue_1273
	end

	local function teleport_helperFunc_1274(teleport_param_1275)
		local character_ = localPlayer.Character
		local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = character_ and character_:FindFirstChild("HumanoidRootPart")
		if not (character_ and humanoid and humanoidRootPart) then
			return false
		end
		local knife = character_:FindFirstChild("Knife")

		if not knife then
			local backpack = localPlayer:FindFirstChildOfClass("Backpack")
			backpack = backpack and backpack:FindFirstChild("Knife")

			if backpack then
				humanoid:EquipTool(backpack)
				task.wait(0.05)
				knife = character_:FindFirstChild("Knife") or backpack
			end
		end

		local isMurderer = crosshair_helperFunc_0404(localPlayer) == "Murderer" or knife ~= nil or (localPlayer:FindFirstChildOfClass("Backpack") and localPlayer.Backpack:FindFirstChild("Knife") ~= nil)
		if not isMurderer then
			if not teleport_param_1275 then
				WindUI:Notify({ Title = "错误", Content = "需要担任杀手才能使用", Icon = "x", Duration = 1.5 })
			end

			return false
		end

		if not knife then
			if not teleport_param_1275 then
				WindUI:Notify({ Title = "错误", Content = "未找到刀", Icon = "x", Duration = 1.5 })
			end

			return false
		end

		local teleport_callResult_1276 = teleport_helperFunc_1272()

		if not teleport_callResult_1276 or not teleport_callResult_1276.Character then
			if not teleport_param_1275 then
				WindUI:Notify({ Title = "错误", Content = "未找到目标", Icon = "x", Duration = 1.5 })
			end

			return false
		end

		local humanoidRootPart2 = teleport_callResult_1276.Character:FindFirstChild("HumanoidRootPart")
		local humanoid2 = teleport_callResult_1276.Character:FindFirstChildOfClass("Humanoid")
		if not humanoidRootPart2 then
			return false
		end
		local rightHand = character_:FindFirstChild("RightHand") or character_:FindFirstChild("Right Arm")
		local position = rightHand and rightHand.Position or humanoidRootPart.Position
		local moveDirection = humanoid2 and humanoid2.MoveDirection or Vector3.new()
		local teleport_offsetValue_1277 = (Hub.AutoShootState and Hub.AutoShootState.offset or 2.8) + 1
		local teleport_vectorValue_1278 = humanoidRootPart2.Position + humanoidRootPart2.AssemblyLinearVelocity * Vector3.new(0.75, 0.5, 0.75) * teleport_offsetValue_1277 / 15 + moveDirection * teleport_offsetValue_1277

		if Hub.ThrowKnifeButtonState.mode == "Behind Walls" then
			local unit

			if moveDirection.Magnitude <= 0.001 then
				local teleport_vectorValue_1279 = humanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1)
				unit = teleport_vectorValue_1279.Magnitude > 0.001 and teleport_vectorValue_1279.Unit or humanoidRootPart2.CFrame.LookVector
			else
				unit = moveDirection.Unit
			end

			position = teleport_vectorValue_1278 + unit * 1.35 + Vector3.new(0, 0.8, 0)
		end

		local events = knife:FindFirstChild("Events") or knife:WaitForChild("Events", 1)
		local knifeThrown

		if events then
			knifeThrown = events:FindFirstChild("KnifeThrown") or events:WaitForChild("KnifeThrown", 1)
		else
			knifeThrown = events
		end

		if not knifeThrown or not knifeThrown:IsA("RemoteEvent") then
			if not teleport_param_1275 then
				WindUI:Notify({ Title = "错误", Content = "未找到刀的远程事件", Icon = "x", Duration = 1.5 })
			end

			return false
		end

		local handle = knife:FindFirstChild("Handle")
		local originCFrame = handle and handle.CFrame or CFrame.new(position)

		local ok = pcall(function()
			knifeThrown:FireServer(originCFrame, CFrame.new(teleport_vectorValue_1278))
		end)

		if not ok and not teleport_param_1275 then
			WindUI:Notify({ Title = "错误", Content = "投掷失败", Icon = "x", Duration = 1.5 })
		end

		return ok
	end

	local function teleport_helperFunc_1280()
		Hub.TouchButtons.Destroy(Hub.ThrowKnifeButtonState)
	end

	local function teleport_helperFunc_1281()
		Hub.TouchButtons.ToggleThrowKnifeButton(true)
	end

	Hub.TriggerThrowKnifeInput = function()
		local throwKnifeButtonState = Hub.ThrowKnifeButtonState
		local now = tick()
		if throwKnifeButtonState.inputBusy or now < throwKnifeButtonState.nextInputAt then
			return false
		end
		throwKnifeButtonState.inputBusy = true
		throwKnifeButtonState.nextInputAt = now + throwKnifeButtonState.inputCooldown

		task.spawn(function()
			pcall(teleport_helperFunc_1274, false)
			throwKnifeButtonState.inputBusy = false
		end)

		return true
	end

	Hub.ToggleThrowKnifeButton = function(teleport_param_1282)
		Hub.TouchButtons.ToggleThrowKnifeButton(teleport_param_1282)
	end

	task.wait(UI_BUILD_DELAY)

	Tabs.Teleports:Button({
		Title = "传送到杀手",
		Callback = function()
			movement_helperFunc_1208("Murderer")
		end,
	})

	Tabs.Teleports:Button({
		Title = "传送到警长",
		Callback = function()
			movement_helperFunc_1208("Sheriff")
		end,
	})

	Tabs.Teleports:Button({
		Title = "传送到枪",
		Callback = function()
			movement_helperFunc_1208("Gun")
		end,
	})

	Tabs.Teleports:Button({
		Title = "传送到安全区",
		Callback = function()
			crosshair_helperFunc_0399()
		end,
	})

	Tabs.Teleports:Button({
		Title = "传送到大厅",
		Callback = function()
			teleport_helperFunc_1225()
		end,
	})

	Tabs.Teleports:Button({
		Title = "传送到对局场地",
		Callback = function()
			teleport_helperFunc_1228()
		end,
	})

	Tabs.Teleports:Button({
		Title = "传送到投票板",
		Callback = function()
			teleportToVotingBoard()
		end,
	})

	Tabs.Teleports:Divider()

	Hub.AutoMapVote.control = Tabs.Teleports:Toggle({
		Title = "自动地图投票",
		Flag = "Teleports_AutoMapVote",
		Default = false,
		Callback = function(teleport_param_1283)
			Hub.AutoMapVote.enabled = teleport_param_1283 and true or false
			if Hub.AutoMapVote.enabled then
				if not Hub.AutoMapVote.thread then
					Hub.AutoMapVote.thread = task.spawn(function()
						runAutoMapVoteCycle()
						Hub.AutoMapVote.thread = nil
					end)
				end
			else
				Hub.AutoMapVote.thread = nil
			end
		end,
	})

	Hub.AutoMapVote.boardControl = Tabs.Teleports:Dropdown({
		Title = "投票板",
		Flag = "Teleports_VotingBoard",
		Values = { "投票板 1", "投票板 2", "投票板 3" },
		Value = YXOpt.zh(Hub.AutoMapVote.board),
		Callback = function(teleport_param_1284)
			teleport_param_1284 = YXOpt.en(teleport_param_1284)
			Hub.AutoMapVote.board = teleport_param_1284 or "Board 1"
		end,
	})

	Tabs.Teleports:Divider()

	local function teleport_helperFunc_1285()
		local teleport_callResult_1286 = teleport_helperFunc_1237()
		if #teleport_callResult_1286 == 0 then
			return { "(No other players)" }
		end
		return teleport_callResult_1286
	end

	teleport_optionalValue_1239 = Tabs.Teleports:Dropdown({
		Title = "传送到玩家",
		Values = YXOpt.list(teleport_helperFunc_1285()),
		Value = YXOpt.zh(nil),
		Callback = function(teleport_param_1287)
			teleport_param_1287 = YXOpt.en(teleport_param_1287)
			if Hub.RefreshingPlayerDropdown then
				return
			end

			if not teleport_param_1287 or teleport_param_1287 == "(No other players)" then
				return
			end
			teleport_optionalValue_1241 = teleport_param_1287
			teleport_helperFunc_1234(teleport_param_1287)
		end,
	})

	Tabs.Teleports:Button({
		Title = "刷新玩家列表",
		Callback = function()
			teleport_helperFunc_1246()
		end,
	})

	trackConn(Players.PlayerAdded:Connect(function()
		task.defer(teleport_helperFunc_1246)
	end))

	trackConn(Players.PlayerRemoving:Connect(function(player)
		if Hub.SelectedFlingName and player and player.Name == Hub.SelectedFlingName then
			Hub.SelectedFlingName = nil
			crosshair_helperFunc_0397()
		end
	end))

	Hub.FrozenPlayers = {}
	Hub.FrozenPlayerReleaseIds = {}
	Hub.KnifeAuraFrozenPlayers = {}
	Hub.KnifeAuraReleaseId = 0

	Hub.CoinFarm.runKnifeAura = function(teleport_param_1288)
		local teleport_getCachedRoleValue_1289 = Hub.CoinFarm.GetCachedRole(localPlayer)
		local character_ = localPlayer.Character
		local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = character_ and character_:FindFirstChild("HumanoidRootPart")
		local backpack = localPlayer:FindFirstChildOfClass("Backpack")
		local knife = character_ and character_:FindFirstChild("Knife")
		backpack = backpack and backpack:FindFirstChild("Knife")
		local teleport_boolFlag_1290 = teleport_getCachedRoleValue_1289 ~= "Murderer"

		if teleport_boolFlag_1290 then
			teleport_boolFlag_1290 = not (knife or backpack)
		end

		if teleport_boolFlag_1290 then
			return false
		end
		local teleport_boolFlag_1291 = not character_ or not humanoid or humanoid.Health <= 0 or not humanoidRootPart

		if not teleport_boolFlag_1291 then
			teleport_boolFlag_1291 = not (knife or backpack)
		end

		if teleport_boolFlag_1291 then
			return false
		end

		if not crosshair_helperFunc_0399() then
			return false
		end
		task.wait(0.15)
		local character_2 = localPlayer.Character
		local humanoid2 = character_2 and character_2:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart2 = character_2 and character_2:FindFirstChild("HumanoidRootPart")
		local backpack2 = localPlayer:FindFirstChildOfClass("Backpack")
		local knife2 = character_2 and character_2:FindFirstChild("Knife")
		backpack2 = backpack2 and backpack2:FindFirstChild("Knife")
		local teleport_boolFlag_1292 = not character_2 or not humanoid2 or humanoid2.Health <= 0 or not humanoidRootPart2
		local teleport_boolFlag_1293

		if teleport_boolFlag_1292 then
			teleport_boolFlag_1293 = teleport_boolFlag_1292
		else
			teleport_boolFlag_1293 = not (knife2 or backpack2)
		end

		if teleport_boolFlag_1293 then
			return false
		end

		if not knife2 then
			humanoid2:EquipTool(backpack2)
			task.wait(0.15)
			knife2 = character_2:FindFirstChild("Knife")
		end

		if not knife2 or not knife2:IsA("Tool") then
			return false
		end
		local stab = knife2:FindFirstChild("Stab")
		local events = knife2:FindFirstChild("Events") or knife2:WaitForChild("Events", 0.5)
		local knifeStabbed = events and events:FindFirstChild("KnifeStabbed")
		local teleport_callResult_1294 = not (stab and stab:IsA("RemoteEvent"))

		if teleport_callResult_1294 then
			teleport_callResult_1294 = not (knifeStabbed and knifeStabbed:IsA("RemoteEvent"))
		end

		if teleport_callResult_1294 then
			return false
		end

		local function teleport_helperFunc_1295(teleport_param_1296)
			if not teleport_param_1296 or teleport_param_1296 == localPlayer then
				return false
			end

			if services_helperFunc_0106(teleport_param_1296) and not isOwner then
				services_helperFunc_0108("kill")
				return false
			end
			local teleport_cacheValue_1297 = Hub.RoleState.cache[teleport_param_1296.Name] or Hub.RoleState.cache[tostring(teleport_param_1296.UserId)] or Hub.RoleState.cache[teleport_param_1296.UserId]
			if type(teleport_cacheValue_1297) == "table" then
				return teleport_cacheValue_1297.Dead ~= true and teleport_cacheValue_1297.Role ~= "Murderer"
			end
			return not crosshair_helperFunc_0401(teleport_param_1296)
		end

		local teleport_configTable_1298 = {}
		local cFrame = humanoidRootPart2.CFrame + humanoidRootPart2.CFrame.LookVector * 2

		for _, player in ipairs(Players:GetPlayers()) do
			local character_3 = player.Character
			local humanoid3 = character_3 and character_3:FindFirstChildOfClass("Humanoid")
			local humanoidRootPart3 = character_3 and character_3:FindFirstChild("HumanoidRootPart")

			if teleport_helperFunc_1295(player) and humanoid3 and humanoid3.Health > 0 and humanoidRootPart3 and character_3:IsDescendantOf(workspace) then
				table.insert(teleport_configTable_1298, { root = humanoidRootPart3, anchored = humanoidRootPart3.Anchored })
				humanoidRootPart3.Anchored = true
				humanoidRootPart3.CFrame = cFrame
			end
		end

		local teleport_numericVar_1299 = #teleport_configTable_1298 > 0
		local teleport_boolFlag_1300 = false

		if teleport_numericVar_1299 then
			task.wait(0.15)

			if Hub.CoinFarm.endRoundGeneration == teleport_param_1288 and Hub.CoinFarm.enabled and Hub.CoinFarm.endRoundEnabled and Hub.CoinFarm.bagFull and knife2.Parent and humanoid2.Health > 0 then
				for i = 1, 3 do
					if not (Hub.CoinFarm.endRoundGeneration ~= teleport_param_1288 or not Hub.RoundState.active) then
						local cFrame2 = humanoidRootPart2.CFrame + humanoidRootPart2.CFrame.LookVector * 2

						for _, teleport_loopVar_1301 in ipairs(teleport_configTable_1298) do
							if teleport_loopVar_1301.root and teleport_loopVar_1301.root.Parent then
								teleport_loopVar_1301.root.Anchored = true
								teleport_loopVar_1301.root.CFrame = cFrame2
							end
						end

						local ok = pcall(function()
							knife2:Activate()

							if stab and stab:IsA("RemoteEvent") then
								stab:FireServer("Slash")
							else
								knifeStabbed:FireServer()
							end
						end)

						teleport_boolFlag_1300 = teleport_boolFlag_1300 or ok
						task.wait(0.1)
						continue
					end

					break
				end

				task.wait(0.25)
			end
		end

		for _, combatUI_loopVar_1302 in ipairs(teleport_configTable_1298) do
			if combatUI_loopVar_1302.root and combatUI_loopVar_1302.root.Parent then
				combatUI_loopVar_1302.root.Anchored = combatUI_loopVar_1302.anchored == true
			end
		end

		local combatUI_numericVar_1303 = 0

		for _, player in ipairs(Players:GetPlayers()) do
			if teleport_helperFunc_1295(player) then
				local character_3 = player.Character
				character_3 = character_3 and character_3:FindFirstChildOfClass("Humanoid")

				if character_3 and character_3.Health > 0 then
					combatUI_numericVar_1303 += 1
				end
			end
		end

		return teleport_numericVar_1299 and teleport_boolFlag_1300 and combatUI_numericVar_1303 == 0
	end

	local function combatUI_helperFunc_1304(combatUI_param_1305)
		local combatUI_boolFlag_1306 = combatUI_param_1305 == "Murderer" and crosshair_helperFunc_0406() or crosshair_helperFunc_0407()
		if not combatUI_boolFlag_1306 or combatUI_boolFlag_1306 == localPlayer then
			return
		end
		local character_ = localPlayer.Character
		character_ = character_ and character_:FindFirstChild("HumanoidRootPart")
		if not character_ then
			return
		end
		local character_2 = combatUI_boolFlag_1306.Character
		character_2 = character_2 and character_2:FindFirstChild("HumanoidRootPart")
		if not character_2 then
			return
		end
		character_2.Anchored = true
		character_2.CFrame = character_.CFrame + character_.CFrame.LookVector * 5
		Hub.FrozenPlayers[combatUI_boolFlag_1306] = character_2
		local combatUI_frozenPlayerReleaseIdsState_1307 = (Hub.FrozenPlayerReleaseIds[combatUI_boolFlag_1306] or 0) + 1
		Hub.FrozenPlayerReleaseIds[combatUI_boolFlag_1306] = combatUI_frozenPlayerReleaseIdsState_1307

		task.delay(15, function()
			if Hub.FrozenPlayerReleaseIds[combatUI_boolFlag_1306] ~= combatUI_frozenPlayerReleaseIdsState_1307 then
				return
			end
			local combatUI_frozenPlayersState_1308 = Hub.FrozenPlayers[combatUI_boolFlag_1306]

			if combatUI_frozenPlayersState_1308 and combatUI_frozenPlayersState_1308.Parent then
				combatUI_frozenPlayersState_1308.Anchored = false
			end

			Hub.FrozenPlayers[combatUI_boolFlag_1306] = nil
			Hub.FrozenPlayerReleaseIds[combatUI_boolFlag_1306] = nil
		end)
	end

	task.wait(UI_BUILD_DELAY)

	Tabs.Combat:Section({ Title = "杀手", TextXAlignment = "Center", TextSize = 17, Opened = true })

	services_dataTable_0104.Murderer:Button({
		Title = "拉来并冻结警长",
		Desc = "15 秒后自动解冻",
		Callback = function()
			combatUI_helperFunc_1304("Sheriff")
		end,
	})

	Tabs.Player:Toggle({
		Title = "旋转",
		Flag = "Misc_Spinbot",
		Default = false,
		Callback = function(combatUI_param_1309)
			Hub.Spinbot.SetEnabled(combatUI_param_1309)
		end,
	})

	Tabs.Player:Slider({
		Title = "旋转速度",
		Flag = "Misc_SpinbotSpeed",
		Value = { Min = 1, Max = 3, Default = Hub.Spinbot.speed },
		Step = 1,
		Callback = function(combatUI_param_1310)
			Hub.Spinbot.speed = math.clamp(tonumber(combatUI_param_1310) or 1, 1, 3)
		end,
	})

	services_dataTable_0104.Murderer:Toggle({
		Title = "判定框放大",
		Desc = "在刀刺时生效",
		Flag = "Misc_HitboxExpander",
		Default = false,
		Callback = function(combatUI_param_1311)
			Hub.HitboxExpander.SetEnabled(combatUI_param_1311)
		end,
	})

	services_dataTable_0104.Murderer:Slider({
		Title = "判定框大小",
		Flag = "Misc_HitboxSize",
		Value = { Min = 2, Max = 50, Default = Hub.HitboxExpander.size },
		Step = 1,
		Callback = function(combatUI_param_1312)
			Hub.HitboxExpander.size = math.clamp(tonumber(combatUI_param_1312) or 6, 2, 50)

			if Hub.HitboxExpander.stabActive then
				Hub.HitboxExpander.ApplyAll()
			end
		end,
	})

	services_dataTable_0104.Murderer:Toggle({
		Title = "显示判定框",
		Flag = "Misc_ShowHitboxes",
		Default = false,
		Callback = function(combatUI_param_1313)
			Hub.HitboxExpander.visible = combatUI_param_1313 and true or false

			if Hub.HitboxExpander.stabActive then
				Hub.HitboxExpander.ApplyAll()
			end
		end,
	})

	services_dataTable_0104.General:Toggle({
		Title = "躲避杀手",
		Flag = "General_AvoidMurderer",
		Default = false,
		Callback = function(combatUI_param_1314)
			local avoidMurderer = Hub.AvoidMurderer
			avoidMurderer.enabled = combatUI_param_1314 and true or false
			avoidMurderer.nextTeleportAt = 0
			avoidMurderer.accumulator = 0

			if avoidMurderer.connection then
				avoidMurderer.connection:Disconnect()
				avoidMurderer.connection = nil
			end

			if not avoidMurderer.enabled then
				return
			end

			avoidMurderer.connection = RunService.Heartbeat:Connect(function(deltaTime)
				avoidMurderer.accumulator = avoidMurderer.accumulator + deltaTime
				if avoidMurderer.accumulator < 0.15 then
					return
				end
				avoidMurderer.accumulator = 0
				local combatUI_activeValue_1315 = not Hub.RoundState.active or Hub.CoinFarm.GetCachedRole(localPlayer) == "Murderer"

				if not combatUI_activeValue_1315 then
					local nextTeleportAt = avoidMurderer.nextTeleportAt
					combatUI_activeValue_1315 = os.clock() < nextTeleportAt
				end

				if combatUI_activeValue_1315 then
					return
				end
				local character_ = localPlayer.Character
				local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
				character_ = character_ and character_:FindFirstChild("HumanoidRootPart")
				local combatUI_getMurdererRootValue_1316 = Hub.CoinFarm.GetMurdererRoot()
				if not humanoid or humanoid.Health <= 0 or not character_ or not combatUI_getMurdererRootValue_1316 or (combatUI_getMurdererRootValue_1316.Position - character_.Position).Magnitude > avoidMurderer.distance then
					return
				end
				local combatUI_resolveMapValue_1317 = Hub.CoinFarm.ResolveMap()
				if not combatUI_resolveMapValue_1317 then
					return
				end
				local combatUI_numericVar_1318 = -math.huge
				local combatUI_optionalValue_1319 = nil

				for _, descendant in ipairs(combatUI_resolveMapValue_1317:GetDescendants()) do
					if descendant:IsA("BasePart") and descendant.Name == "Spawn" then
						local magnitude = (descendant.Position - combatUI_getMurdererRootValue_1316.Position).Magnitude

						if combatUI_numericVar_1318 < magnitude then
							combatUI_numericVar_1318 = magnitude
							combatUI_optionalValue_1319 = descendant
						end
					end
				end

				if not combatUI_optionalValue_1319 then
					return
				end
				avoidMurderer.nextTeleportAt = os.clock() + 1
				Hub.CoinFarm.CancelTween()
				Hub.CoinFarm.currentCoin = nil
				Hub.CoinFarm.DisableUnder()
				character_.AssemblyLinearVelocity = Vector3.zero
				character_.AssemblyAngularVelocity = Vector3.zero
				character_.CFrame = combatUI_optionalValue_1319.CFrame + Vector3.new(0, combatUI_optionalValue_1319.Size.Y * 0.5 + character_.Size.Y * 0.5 + 0.15, 0)
			end)
		end,
	})

	services_dataTable_0104.General:Slider({
		Title = "躲避杀手距离",
		Flag = "General_AvoidMurdererDistance",
		Value = { Min = 10, Max = 150, Default = 35 },
		Step = 1,
		Callback = function(combatUI_param_1320)
			Hub.AvoidMurderer.distance = math.clamp(tonumber(combatUI_param_1320) or 35, 10, 150)
		end,
	})

	Hub.ShowTimerControl = Tabs.Misc:Toggle({
		Title = "显示计时器",
		Flag = "Misc_ShowTimer",
		Default = false,
		LockedTitle = "刷币开启时自动启用并锁定。",
		Callback = function(combatUI_param_1321)
			Hub.ShowRoundTimer = combatUI_param_1321 and true or false

			if type(Hub.UpdateRoundTimer) == "function" then
				task.defer(Hub.UpdateRoundTimer)
			end
		end,
	})

	Hub.SetXPFarmTimerForced = function(combatUI_param_1322)
		if combatUI_param_1322 then
			if not Hub.ShowTimerForcedByXPFarm then
				Hub.ShowTimerBeforeXPFarm = Hub.ShowRoundTimer
			end

			Hub.ShowTimerForcedByXPFarm = true
			Hub.ShowRoundTimer = true
			Hub.ShowTimerControl:Unlock()
			Hub.ShowTimerControl:Set(true, false, true)
			Hub.ShowTimerControl:Lock()
		else
			Hub.ShowTimerControl:Unlock()

			if Hub.ShowTimerForcedByXPFarm then
				Hub.ShowTimerForcedByXPFarm = false
				Hub.ShowRoundTimer = Hub.ShowTimerBeforeXPFarm
				Hub.ShowTimerControl:Set(Hub.ShowTimerBeforeXPFarm, false, true)
			end
		end

		if type(Hub.UpdateRoundTimer) == "function" then
			task.defer(Hub.UpdateRoundTimer)
		end
	end

	services_dataTable_0104.General:Toggle({
		Title = "移动端快捷菜单",
		Desc = "一个紧凑按钮，集成射击、投掷、拿枪、炸弹跳、X光、自瞄与穿墙。",
		Flag = "General_MobileQuickMenu",
		Default = false,
		Callback = function(combatUI_param_1323)
			Hub.TouchButtons.ToggleQuickMenu(combatUI_param_1323)
		end,
	})

	services_dataTable_0104.General:Toggle({
		Title = "拿枪按钮",
		Flag = "General_GetGunButton",
		Default = false,
		Callback = function(combatUI_param_1324)
			Hub.TouchButtons.ToggleGetGunButton(combatUI_param_1324)
		end,
	})

	services_dataTable_0104.General:Dropdown({
		Title = "拿枪按钮大小",
		Flag = "General_GetGunButtonSize",
		Values = { "小", "中", "大" },
		Value = YXOpt.zh(Hub.GetGunButtonState.size),
		Callback = function(size)
			size = YXOpt.en(size)
			if Hub.TouchButtons.Sizes[size] then
				Hub.GetGunButtonState.size = size
				Hub.TouchButtons.ApplySize(Hub.GetGunButtonState.button, size, Hub.GetGunButtonState.shape)
			end
		end,
	})

	services_dataTable_0104.General:Dropdown({
		Title = "拿枪按钮形状",
		Flag = "General_GetGunButtonShape",
		Values = { "方形", "矩形" },
		Value = YXOpt.zh(Hub.GetGunButtonState.shape),
		Callback = function(combatUI_param_1325)
			combatUI_param_1325 = YXOpt.en(combatUI_param_1325)
			Hub.GetGunButtonState.shape = combatUI_param_1325 == "Rectangle" and "Rectangle" or "Square"
			Hub.TouchButtons.ApplySize(Hub.GetGunButtonState.button, Hub.GetGunButtonState.size, Hub.GetGunButtonState.shape)
			Hub.TouchButtons.UpdateHoldHint(Hub.GetGunButtonState, Hub.GetGunButtonState.button)
		end,
	})

	services_dataTable_0104.General:Colorpicker({
		Title = "拿枪图标颜色",
		Flag = "General_GetGunButtonColor",
		Default = Hub.GetGunButtonState.outlineColor or Hub.TouchButtons.Theme.accentColor,
		Callback = function(outlineColor)
			Hub.GetGunButtonState.outlineColor = outlineColor
			Hub.TouchButtons.ApplyAppearance(Hub.GetGunButtonState.button, Hub.GetGunButtonState)
		end,
	})

	services_dataTable_0104.General:Toggle({
		Title = "拿枪按钮可拖动",
		Flag = "General_GetGunButtonDraggable",
		Default = Hub.GetGunButtonState.draggable,
		Callback = function(combatUI_param_1326)
			Hub.GetGunButtonState.draggable = combatUI_param_1326 and true or false
		end,
	})

	services_dataTable_0104.General:Keybind({
		Title = "拿枪快捷键",
		Flag = "General_GetGunKeybind",
		Value = "J",
		Callback = function()
			if Hub.TakeDroppedGunOnce then
				Hub.TakeDroppedGunOnce()
			end
		end,
	})

	services_dataTable_0104.General:Toggle({
		Title = "炸弹跳按钮",
		Desc = "起跳后在空中点击炸弹跳。",
		Flag = "General_BombJumpButton",
		Default = false,
		Callback = function(combatUI_param_1327)
			Hub.TouchButtons.ToggleBombJumpButton(combatUI_param_1327)
		end,
	})

	services_dataTable_0104.General:Dropdown({
		Title = "炸弹跳按钮大小",
		Flag = "General_BombJumpButtonSize",
		Values = { "小", "中", "大" },
		Value = YXOpt.zh(Hub.BombJumpButtonState.size),
		Callback = function(size)
			size = YXOpt.en(size)
			if Hub.TouchButtons.Sizes[size] then
				Hub.BombJumpButtonState.size = size
				Hub.TouchButtons.ApplySize(Hub.BombJumpButtonState.button, size, Hub.BombJumpButtonState.shape)
			end
		end,
	})

	services_dataTable_0104.General:Dropdown({
		Title = "炸弹跳按钮形状",
		Flag = "General_BombJumpButtonShape",
		Values = { "方形", "矩形" },
		Value = YXOpt.zh(Hub.BombJumpButtonState.shape),
		Callback = function(combatUI_param_1328)
			combatUI_param_1328 = YXOpt.en(combatUI_param_1328)
			Hub.BombJumpButtonState.shape = combatUI_param_1328 == "Rectangle" and "Rectangle" or "Square"
			Hub.TouchButtons.ApplySize(Hub.BombJumpButtonState.button, Hub.BombJumpButtonState.size, Hub.BombJumpButtonState.shape)
			Hub.TouchButtons.UpdateHoldHint(Hub.BombJumpButtonState, Hub.BombJumpButtonState.button)
		end,
	})

	services_dataTable_0104.General:Colorpicker({
		Title = "炸弹跳图标颜色",
		Flag = "General_BombJumpButtonColor",
		Default = Hub.BombJumpButtonState.outlineColor or Hub.TouchButtons.Theme.accentColor,
		Callback = function(outlineColor)
			Hub.BombJumpButtonState.outlineColor = outlineColor
			Hub.TouchButtons.ApplyAppearance(Hub.BombJumpButtonState.button, Hub.BombJumpButtonState)
		end,
	})

	services_dataTable_0104.General:Toggle({
		Title = "炸弹跳按钮可拖动",
		Flag = "General_BombJumpButtonDraggable",
		Default = Hub.BombJumpButtonState.draggable,
		Callback = function(combatUI_param_1329)
			Hub.BombJumpButtonState.draggable = combatUI_param_1329 and true or false
		end,
	})

	services_dataTable_0104.General:Keybind({
		Title = "炸弹跳快捷键",
		Flag = "General_BombJumpKeybind",
		Value = "B",
		Callback = function()
			if Hub.RunBombJump then
				Hub.RunBombJump()
			end
		end,
	})

	local function combatUI_helperFunc_1330()
		local combatUI_callResult_1331 = teleport_helperFunc_1237()
		if #combatUI_callResult_1331 == 0 then
			return { "(No other players)" }
		end
		return combatUI_callResult_1331
	end

	teleport_optionalValue_1240 = services_dataTable_0104.General:Dropdown({
		Title = "甩飞目标",
		Values = YXOpt.list(combatUI_helperFunc_1330()),
		Value = YXOpt.zh(nil),
		Callback = function(selectedFlingName)
			selectedFlingName = YXOpt.en(selectedFlingName)
			if Hub.RefreshingPlayerDropdown then
				return
			end

			if not selectedFlingName or selectedFlingName == "(No other players)" then
				return
			end
			Hub.SelectedFlingName = selectedFlingName

			task.spawn(function()
				crosshair_helperFunc_0396(selectedFlingName)
			end)
		end,
	})
end

services_dataTable_0104.General:Button({
	Title = "甩飞警长",
	Callback = function()
		local Sheriff = crosshair_helperFunc_0405("Sheriff")
		if not Sheriff then
			crosshair_helperFunc_0395("未找到警长")
			return
		end

		task.spawn(function()
			crosshair_helperFunc_0396(Sheriff.Name)
		end)
	end,
})

services_dataTable_0104.General:Button({
	Title = "甩飞杀手",
	Callback = function()
		local Murderer = crosshair_helperFunc_0405("Murderer")
		if not Murderer then
			crosshair_helperFunc_0395("未找到杀手")
			return
		end

		task.spawn(function()
			crosshair_helperFunc_0396(Murderer.Name)
		end)
	end,
})

services_dataTable_0104.General:Button({
	Title = "甩飞所有玩家",
	Callback = function()
		if Hub.FlingActive or Hub.FlingAllRunning then
			WindUI:Notify({ Title = "全部甩飞", Content = "已有甩飞正在进行", Icon = "loader", Duration = 2 })
			return
		end
		Hub.FlingAllRunning = true

		task.spawn(function()
			local players = Players:GetPlayers()
			local combatUI_numericVar_1332 = 0
			local combatUI_numericVar_1333 = 0

			for _, player in ipairs(players) do
				if not (not foxnameMM2Runtime.alive or false) then
					if player ~= localPlayer and player.Parent and (isOwner or not services_helperFunc_0106(player)) then
						combatUI_numericVar_1332 += 1

						if crosshair_helperFunc_0396(player.Name, nil, 1, true) then
							combatUI_numericVar_1333 += 1
						end

						task.wait(0.1)
					end

					continue
				end

				break
			end

			Hub.FlingAllRunning = false

			WindUI:Notify({
				Title = "全部甩飞",
				Content = string.format("已尝试 %d 名玩家，甩飞 %d 名", combatUI_numericVar_1332, combatUI_numericVar_1333),
				Icon = "check",
				Duration = 3,
			})
		end)
	end,
})

services_dataTable_0104.General:Toggle({
	Title = "优化卡顿",
	Flag = "General_FPSBoost",
	Default = false,
	Callback = function(combatUI_param_1334)
		Hub.SetFPSBoost(combatUI_param_1334)
	end,
})

services_dataTable_0104.General:Divider()

services_dataTable_0104.Murderer:Button({
	Title = "刀光环",
	Callback = function()
		if crosshair_helperFunc_0404(localPlayer) ~= "Murderer" then
			WindUI:Notify({ Title = "错误", Content = "需要担任杀手才能使用", Icon = "x", Duration = 1.5 })
			return
		end
		local character_ = localPlayer.Character
		character_ = character_ and character_:FindFirstChild("HumanoidRootPart")
		if not character_ then
			return
		end
		Hub.KnifeAuraReleaseId = Hub.KnifeAuraReleaseId + 1
		local knifeAuraReleaseId = Hub.KnifeAuraReleaseId
		local combatUI_numericVar_1335 = 0

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer and services_helperFunc_0106(player) and not isOwner and not crosshair_helperFunc_0401(player) then
				services_helperFunc_0108("kill")
			end

			local combatUI_boolFlag_1336 = player ~= localPlayer and not crosshair_helperFunc_0401(player)
			local combatUI_boolFlag_1337

			if combatUI_boolFlag_1336 then
				local combatUI_localValue_1338 = isOwner

				if isOwner then
					combatUI_boolFlag_1337 = combatUI_localValue_1338
				else
					combatUI_boolFlag_1337 = not services_helperFunc_0106(player)
				end
			else
				combatUI_boolFlag_1337 = combatUI_boolFlag_1336
			end

			if combatUI_boolFlag_1337 then
				local character_2 = player.Character
				character_2 = character_2 and character_2:FindFirstChild("HumanoidRootPart")

				if character_2 then
					character_2.Anchored = true
					character_2.CFrame = character_.CFrame + character_.CFrame.LookVector * 5
					Hub.KnifeAuraFrozenPlayers[player] = character_2
					combatUI_numericVar_1335 += 1
				end
			end
		end

		task.delay(30, function()
			if knifeAuraReleaseId ~= Hub.KnifeAuraReleaseId then
				return
			end
			local combatUI_numericVar_1339 = 0

			for k, knifeAuraFrozenPlayer in pairs(Hub.KnifeAuraFrozenPlayers) do
				if knifeAuraFrozenPlayer and knifeAuraFrozenPlayer.Parent then
					knifeAuraFrozenPlayer.Anchored = false
					combatUI_numericVar_1339 += 1
				end

				Hub.KnifeAuraFrozenPlayers[k] = nil
			end

			WindUI:Notify({
				Title = "刀光环",
				Content = "已释放 " .. tostring(combatUI_numericVar_1339) .. " player(s)",
				Icon = "check",
				Duration = 2,
			})
		end)

		WindUI:Notify({
			Title = "完成",
			Content = "已对人质生效：" .. tostring(combatUI_numericVar_1335) .. " player(s)",
			Icon = "check",
			Duration = 2,
		})
	end,
})

Hub.TouchButtons.ThrowKnifeToggleControl = services_dataTable_0104.Murderer:Toggle({
	Title = "投刀按钮",
	Flag = "Murderer_ThrowKnifeButton",
	Default = Hub.ThrowKnifeButtonState.enabled,
	Callback = function(combatUI_param_1340)
		Hub.TouchButtons.ToggleThrowKnifeButton(combatUI_param_1340)
	end,
})

services_dataTable_0104.Murderer:Dropdown({
	Title = "投刀模式",
	Flag = "Murderer_ThrowKnifeMode",
	Values = { "普通", "穿墙" },
	Value = YXOpt.zh(Hub.ThrowKnifeButtonState.mode),
	Callback = function(mode)
		mode = YXOpt.en(mode)
		if mode == "Normal" or mode == "Behind Walls" then
			Hub.ThrowKnifeButtonState.mode = mode
		end
	end,
})

services_dataTable_0104.Murderer:Dropdown({
	Title = "投刀按钮大小",
	Flag = "Murderer_ThrowKnifeButtonSize",
	Values = { "小", "中", "大" },
	Value = YXOpt.zh(Hub.ThrowKnifeButtonState.size),
	Callback = function(size)
		size = YXOpt.en(size)
		if Hub.TouchButtons.Sizes[size] then
			Hub.ThrowKnifeButtonState.size = size
			Hub.TouchButtons.ApplySize(Hub.ThrowKnifeButtonState.button, size, Hub.ThrowKnifeButtonState.shape)
		end
	end,
})

services_dataTable_0104.Murderer:Dropdown({
	Title = "投刀按钮形状",
	Flag = "Murderer_ThrowKnifeButtonShape",
	Values = { "方形", "矩形" },
	Value = YXOpt.zh(Hub.ThrowKnifeButtonState.shape),
	Callback = function(combatUI_param_1341)
		combatUI_param_1341 = YXOpt.en(combatUI_param_1341)
		Hub.ThrowKnifeButtonState.shape = combatUI_param_1341 == "Rectangle" and "Rectangle" or "Square"
		Hub.TouchButtons.ApplySize(Hub.ThrowKnifeButtonState.button, Hub.ThrowKnifeButtonState.size, Hub.ThrowKnifeButtonState.shape)
		Hub.TouchButtons.UpdateHoldHint(Hub.ThrowKnifeButtonState, Hub.ThrowKnifeButtonState.button)
	end,
})

services_dataTable_0104.Murderer:Colorpicker({
	Title = "投刀图标颜色",
	Flag = "Murderer_ThrowKnifeButtonColor",
	Default = Hub.ThrowKnifeButtonState.outlineColor,
	Callback = function(outlineColor)
		Hub.ThrowKnifeButtonState.outlineColor = outlineColor
		Hub.TouchButtons.ApplyAppearance(Hub.ThrowKnifeButtonState.button, Hub.ThrowKnifeButtonState)
	end,
})

services_dataTable_0104.Murderer:Toggle({
	Title = "投刀按钮可拖动",
	Flag = "Murderer_ThrowKnifeButtonDraggable",
	Default = Hub.ThrowKnifeButtonState.draggable,
	Callback = function(combatUI_param_1342)
		Hub.ThrowKnifeButtonState.draggable = combatUI_param_1342 and true or false
	end,
})

services_dataTable_0104.Murderer:Keybind({
	Title = "投刀快捷键",
	Flag = "Murderer_ThrowKnifeKeybind",
	Value = "Z",
	Callback = function()
		if Hub.TriggerThrowKnifeInput then
			Hub.TriggerThrowKnifeInput()
		end
	end,
})

services_dataTable_0104.Murderer:Divider()

local function combatUI_helperFunc_1343()
	Tabs.Settings:Section({ Title = "移动端按钮样式", TextXAlignment = "Center", TextSize = 17, Opened = true })

	Tabs.Settings:Colorpicker({
		Title = "移动端按钮图标颜色",
		Desc = "修改所有动作按钮的图标、分隔线与外描边颜色。",
		Flag = "Settings_MobileButtonAccent",
		Default = Hub.TouchButtons.Theme.accentColor,
		Callback = function(settings_param_1344)
			Hub.TouchButtons.SetThemeColor("outlineColor", settings_param_1344)
		end,
	})

	Tabs.Settings:Divider()

	local settings = Tabs.Settings
	local ALLOWED_THEMES    = _G.ALLOWED_THEMES
	local isAllowedTheme    = _G.isAllowedTheme
	local ThemeMemory       = _G.ThemeMemory

	local function currentThemeName()
	    local ok, name = pcall(function()
	        local creator = WindUI.Creator
	        if creator and type(creator.Theme) == "table" and type(creator.Theme.Name) == "string" then
	            return creator.Theme.Name
	        end
	        if type(WindUI.Theme) == "table" and type(WindUI.Theme.Name) == "string" then
	            return WindUI.Theme.Name
	        end
	        return WindUI:GetCurrentTheme()
	    end)
	    if ok and isAllowedTheme(name) then
	        return name
	    end
	    return "YX-Wind"
	end

	local initialTheme = currentThemeName()

	local themeDropdown = settings:Dropdown({
	    Title = "选择主题",
	    Values = ALLOWED_THEMES,
	    Value = table.find(ALLOWED_THEMES, initialTheme) or 1,
	    Flag = "ui_theme",
	    Callback = function(themeName)
	        if not isAllowedTheme(themeName) then
	            return
	        end
	        WindUI:SetTheme(themeName)
	        ThemeMemory.save(themeName)
	        WindUI:Notify({
	            Title = "主题已切换",
	            Content = "当前主题: " .. themeName,
	            Duration = 2,
	        })
	    end,
	})

	task.spawn(function()
	    task.wait(0.35)
	    local ok, saved = pcall(function()
	        return themeDropdown.Value
	    end)
	    local value = (ok and type(saved) == "string") and saved or ""
	    if not isAllowedTheme(value) then
	        value = initialTheme
	        pcall(function() themeDropdown:Select(value) end)
	    end
	    task.wait(0.1)
	    if currentThemeName() ~= value then
	        WindUI:SetTheme(value)
	    end
	end)

	local fontOptions = {
	    { Name = "默认 (Inter)", Id = "rbxassetid://12187365364" },
	    { Name = "Akronim",       Id = "rbxassetid://12187368317" },
	    { Name = "Are You Serious", Id = "rbxassetid://12187363616" },
	    { Name = "Arimo",         Id = "rbxassetid://16658254058" },
	    { Name = "Audiowide",     Id = "rbxassetid://12187360881" },
	    { Name = "Font #5",       Id = "rbxassetid://12187371991" },
	    { Name = "Blaka",         Id = "rbxassetid://12187365104" },
	    { Name = "Builder Extended", Id = "rbxassetid://16658237174" },
	    { Name = "Builder Mono",  Id = "rbxassetid://16658246179" },
	    { Name = "Builder Sans",  Id = "rbxassetid://16658221428" },
	    { Name = "Bungee Inline", Id = "rbxassetid://12187370000" },
	    { Name = "Bungee Shade",  Id = "rbxassetid://12187367666" },
	    { Name = "Caesar Dressing", Id = "rbxassetid://12187368843" },
	    { Name = "Cairo",         Id = "rbxassetid://12187377099" },
	    { Name = "Caveat",        Id = "rbxassetid://12187369802" },
	    { Name = "Codystar",      Id = "rbxassetid://12187363887" },
	}

	local fontNames = {}
	local fontIdMap = {}
	for _, f in ipairs(fontOptions) do
	    table.insert(fontNames, f.Name)
	    fontIdMap[f.Name] = f.Id
	end

	settings:Divider()

	settings:Dropdown({
	    Title = "界面字体",
	    Values = fontNames,
	    Value = 1,
	    Flag = "ui_font",
	    Callback = function(fontName)
	        local id = fontIdMap[fontName]
	        if id then
	            WindUI:SetFont(id)
	            WindUI:Notify({
	                Title = "字体已切换",
	                Content = fontName,
	                Duration = 2,
	            })
	        end
	    end,
	})

	info:Select()

	_G.Window = Window

	loadstring(game:HttpGet("https://raw.githubusercontent.com/YirdeX-Dev/Miscs/refs/heads/main/YX-Wind%E6%A8%A1%E5%9D%97.lua"))()

	task.wait(UI_BUILD_DELAY)

	Tabs.Settings:Section({ Title = "快捷键", TextXAlignment = "Center", TextSize = 17, Opened = true })

	Tabs.Settings:Keybind({
		Title = "快捷键",
		Flag = "Settings_MenuKeybind",
		Value = "H",
		Callback = function()
			Window:Toggle()
		end,
	})

end

task.wait(UI_BUILD_DELAY)
combatUI_helperFunc_1343()

local function settings_helperFunc_1478()
	local settings_optionalValue_1479 = nil
	local settings_optionalValue_1480 = nil

	local settings_configTable_1481 = {
		target = nil,
		player = nil,
		character = nil,
		lastFOV = nil,
		lastFOVColorAt = 0,
		rayParams = RaycastParams.new(),
		rayFilterCharacter = nil,
	}

	local settings_textValue_1482 = "Foxname_MM2_Aim_" .. sessionId
	local settings_boolFlag_1483 = false

	local function settings_helperFunc_1484()
		if settings_optionalValue_1479 and settings_optionalValue_1479.Parent then
			return
		end
		local frame = Instance.new("Frame")
		frame.Name = "FOVCircle"
		frame.BackgroundTransparency = 1
		frame.BorderSizePixel = 0
		frame.AnchorPoint = Vector2.new(0.5, 0.5)
		frame.Position = UDim2.fromScale(0.5, 0.5)
		frame.Visible = false
		frame.ZIndex = 20
		frame.Parent = createScreenGui()
		local uiAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
		uiAspectRatioConstraint.AspectRatio = 1
		uiAspectRatioConstraint.Parent = frame
		local uiCorner = Instance.new("UICorner")
		uiCorner.CornerRadius = UDim.new(1, 0)
		uiCorner.Parent = frame
		local uiStroke = Instance.new("UIStroke")
		uiStroke.Thickness = 2
		uiStroke.Color = Color3.fromRGB(255, 255, 255)
		uiStroke.Parent = frame
		settings_optionalValue_1479 = frame
		settings_optionalValue_1480 = uiStroke
	end

	local function settings_helperFunc_1485()
		if not Hub.AimEnabled then
			return false
		end
		local character_ = localPlayer.Character
		local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = character_ and character_:FindFirstChild("HumanoidRootPart")
		if not (character_ and humanoid and humanoid.Health > 0 and humanoidRootPart and humanoidRootPart.Parent) then
			return false
		end

		if Hub.OnlyAimWhileSheriff then
			local backpack = localPlayer:FindFirstChildOfClass("Backpack")
			if not (character_:FindFirstChild("Gun") ~= nil or backpack and backpack:FindFirstChild("Gun") ~= nil) and crosshair_helperFunc_0403(localPlayer) ~= "Sheriff" then
				return false
			end
		end

		return true
	end

	local function settings_helperFunc_1486(settings_param_1487)
		if not settings_param_1487 then
			return nil
		end
		local aimlockPart = Hub.AimlockPart or "Head"
		if aimlockPart == "HumanoidRootPart" then
			return settings_param_1487:FindFirstChild("HumanoidRootPart") or settings_param_1487:FindFirstChild("UpperTorso") or settings_param_1487:FindFirstChild("Torso") or settings_param_1487:FindFirstChild("Head")
		end

		if aimlockPart == "Torso" then
			return settings_param_1487:FindFirstChild("UpperTorso") or settings_param_1487:FindFirstChild("Torso") or settings_param_1487:FindFirstChild("HumanoidRootPart") or settings_param_1487:FindFirstChild("Head")
		end
		return settings_param_1487:FindFirstChild("Head") or settings_param_1487:FindFirstChild("UpperTorso") or settings_param_1487:FindFirstChild("HumanoidRootPart")
	end

	local function settings_helperFunc_1488(rayFilterCharacter, settings_param_1489, settings_param_1490)
		if Hub.IgnoreWalls then
			return true
		end
		local position = currentCamera.CFrame.Position
		local rayParams = settings_configTable_1481.rayParams

		if settings_configTable_1481.rayFilterCharacter ~= rayFilterCharacter then
			settings_configTable_1481.rayFilterCharacter = rayFilterCharacter
			rayParams.FilterDescendantsInstances = { rayFilterCharacter }
			rayParams.FilterType = Enum.RaycastFilterType.Exclude
		end

		local hit = workspace:Raycast(position, settings_param_1490 - position, rayParams)
		return not hit or hit.Instance:IsDescendantOf(settings_param_1489)
	end

	local function settings_helperFunc_1491()
		settings_configTable_1481.target = nil
		settings_configTable_1481.player = nil
		settings_configTable_1481.character = nil
	end

	local function settings_helperFunc_1492()
		if not settings_helperFunc_1485() then
			settings_helperFunc_1491()
			return nil
		end
		local settings_callResult_1493 = crosshair_helperFunc_0406()
		if not settings_callResult_1493 or settings_callResult_1493 == localPlayer then
			settings_helperFunc_1491()
			return nil
		end
		local character_ = settings_callResult_1493.Character
		local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = character_ and character_:FindFirstChild("HumanoidRootPart")
		if not (character_ and humanoid and humanoid.Health > 0 and humanoidRootPart and humanoidRootPart.Parent) then
			settings_helperFunc_1491()
			return nil
		end
		local autoShoot_callResult_1494 = settings_helperFunc_1486(character_)
		if not (autoShoot_callResult_1494 and autoShoot_callResult_1494:IsA("BasePart")) then
			settings_helperFunc_1491()
			return nil
		end
		local autoShoot_localValue_1495, autoShoot_localValue_1496 = currentCamera:WorldToViewportPoint(autoShoot_callResult_1494.Position)
		if not autoShoot_localValue_1496 or autoShoot_localValue_1495.Z <= 0 then
			settings_helperFunc_1491()
			return nil
		end
		local autoShoot_numericVar_1497 = currentCamera.ViewportSize / 2
		local autoShoot_fOVState_1498 = tonumber(Hub.FOV) or 100

		if settings_configTable_1481.target == autoShoot_callResult_1494 then
			autoShoot_fOVState_1498 *= 1.7
		end

		if autoShoot_fOVState_1498 < (Vector2.new(autoShoot_localValue_1495.X, autoShoot_localValue_1495.Y) - autoShoot_numericVar_1497).Magnitude then
			settings_helperFunc_1491()
			return nil
		end
		local character_2 = localPlayer.Character
		if not (character_2 and settings_helperFunc_1488(character_2, character_, autoShoot_callResult_1494.Position)) then
			settings_helperFunc_1491()
			return nil
		end
		settings_configTable_1481.target = autoShoot_callResult_1494
		settings_configTable_1481.player = settings_callResult_1493
		settings_configTable_1481.character = character_
		return autoShoot_callResult_1494
	end

	local function autoShoot_helperFunc_1499()
		settings_helperFunc_1484()
		local visible = Hub.AimEnabled and not Hub.HideFOV
		settings_optionalValue_1479.Visible = visible

		if visible then
			local now = os.clock()

			if (UserInputService.TouchEnabled and 0.05 or 0.033333333333333333) <= now - settings_configTable_1481.lastFOVColorAt then
				settings_configTable_1481.lastFOVColorAt = now
				settings_optionalValue_1480.Color = Color3.fromHSV(now * 0.35 % 1, 1, 1)
			end

			if Hub.FOV ~= settings_configTable_1481.lastFOV then
				settings_configTable_1481.lastFOV = Hub.FOV
				settings_optionalValue_1479.Size = UDim2.new(0, Hub.FOV * 2, 0, Hub.FOV * 2)
				settings_optionalValue_1479.Position = UDim2.fromScale(0.5, 0.5)
			end
		end

		if Hub.AimEnabled then
			local autoShoot_callResult_1500 = settings_helperFunc_1492()

			if autoShoot_callResult_1500 and autoShoot_callResult_1500:IsA("BasePart") then
				if Hub.AimStyle == "Aimlock" then
					currentCamera.CFrame = CFrame.lookAt(currentCamera.CFrame.Position, autoShoot_callResult_1500.Position, Vector3.new(0, 1, 0))
				end
			end
		else
			settings_helperFunc_1491()
		end
	end

	Hub.UpdateAimBinding = function()
		if Hub.AimEnabled then
			if settings_boolFlag_1483 then
				return
			end

			pcall(function()
				RunService:UnbindFromRenderStep(settings_textValue_1482)
			end)

			RunService:BindToRenderStep(settings_textValue_1482, Enum.RenderPriority.Camera.Value + 1, autoShoot_helperFunc_1499)
			settings_boolFlag_1483 = true
			return
		end

		if settings_boolFlag_1483 then
			pcall(function()
				RunService:UnbindFromRenderStep(settings_textValue_1482)
			end)

			settings_boolFlag_1483 = false
		end

		settings_helperFunc_1491()

		if settings_optionalValue_1479 then
			settings_optionalValue_1479.Visible = false
		end
	end

	local autoShoot_optionalValue_1501 = nil
	local autoShoot_boolFlag_1502 = true

	if silentAimSupported then
		autoShoot_boolFlag_1502 = pcall(function()
			local function autoShoot_helperFunc_1503(autoShoot_param_1504, ...)
				local autoShoot_textValue_1505 = table.pack(...)
				local autoShoot_callResult_1506 = getnamecallmethod()
				local autoShoot_configTable_1507 = { ... }
				local autoShoot_callResult_1508 = not (type(checkcaller) == "function" and checkcaller() or false)
				local autoShoot_boolFlag_1509

				if autoShoot_callResult_1508 then
					autoShoot_boolFlag_1509 = autoShoot_callResult_1506 == "FireServer" or autoShoot_callResult_1506 == "fireServer"
				else
					autoShoot_boolFlag_1509 = autoShoot_callResult_1508
				end

				if autoShoot_boolFlag_1509 and typeof(autoShoot_param_1504) == "Instance" and autoShoot_param_1504.Name == "Shoot" then
					if Hub.AimEnabled and (Hub.AimStyle == "Silent Aim" or Hub.AimStyle == "Aimlock") then
						local autoShoot_callResult_1510 = settings_helperFunc_1492()

						if autoShoot_callResult_1510 and autoShoot_callResult_1510:IsA("BasePart") then
							local parent = autoShoot_callResult_1510.Parent
							local humanoid = parent and parent:FindFirstChildOfClass("Humanoid")
							parent = parent and (parent:FindFirstChild("HumanoidRootPart") or autoShoot_callResult_1510)
							local autoShoot_numericVar_1511 = math.clamp(localPlayer:GetNetworkPing(), 0.02, 0.22)
							parent = parent and parent.AssemblyLinearVelocity or autoShoot_callResult_1510.AssemblyLinearVelocity or Vector3.zero

							if parent.Magnitude > 65 then
								parent = parent.Unit * 65
							end

							local moveDirection = humanoid and humanoid.MoveDirection or Vector3.zero
							local walkSpeed

							if humanoid and humanoid.WalkSpeed > 0 then
								walkSpeed = humanoid.WalkSpeed
							else
								walkSpeed = 16
							end

							if moveDirection.Magnitude > 0.1 then
								parent = Vector3.new(moveDirection.X * walkSpeed, parent.Y * 0.65, moveDirection.Z * walkSpeed)
							end

							local autoShoot_predictionStrengthState_1512 = autoShoot_callResult_1510.Position + parent * (autoShoot_numericVar_1511 * 0.9 + (Hub.PredictionStrength or 5) * 10 / 1000)

							if Hub.AutoShootState.mode == "Behind Walls" or Hub.AutoShootState.mode == "Wallbang" then
								autoShoot_configTable_1507[1] = CFrame.new(autoShoot_predictionStrengthState_1512 + Vector3.new(0, 1.2, 0))
							end

							autoShoot_configTable_1507[2] = CFrame.new(autoShoot_predictionStrengthState_1512)
							return autoShoot_optionalValue_1501(autoShoot_param_1504, unpack(autoShoot_configTable_1507))
						end
					end
				end

				return autoShoot_optionalValue_1501(autoShoot_param_1504, table.unpack(autoShoot_textValue_1505, 1, autoShoot_textValue_1505.n))
			end

			if typeof(newcclosure) == "function" then
				autoShoot_optionalValue_1501 = hookmetamethod(game, "__namecall", newcclosure(autoShoot_helperFunc_1503))
			else
				autoShoot_optionalValue_1501 = hookmetamethod(game, "__namecall", autoShoot_helperFunc_1503)
			end
		end)
	end

	if silentAimSupported and (not autoShoot_boolFlag_1502 or type(autoShoot_optionalValue_1501) ~= "function") then
		silentAimSupported = false
	end

	local autoShoot_numericVar_1513 = 0

	local function autoShoot_helperFunc_1514(child)
		if child:IsA("Tool") and child.Name == "Gun" then
			child.Activated:Connect(function()
				if Hub.AimEnabled then
					local now = os.clock()

					if now - autoShoot_numericVar_1513 > 0.25 then
						autoShoot_numericVar_1513 = now

						if Hub.TriggerAutoShootInput then
							Hub.TriggerAutoShootInput()
						elseif Hub.UpdateAutoShoot then
							Hub.UpdateAutoShoot()
						end
					end
				end
			end)
		end
	end

	localPlayer.CharacterAdded:Connect(function(character_)
		character_.ChildAdded:Connect(autoShoot_helperFunc_1514)
		local backpack = localPlayer:FindFirstChildOfClass("Backpack")

		if backpack then
			for _, autoShoot_loopVar_1515 in backpack:GetChildren() do
				autoShoot_helperFunc_1514(autoShoot_loopVar_1515)
			end

			backpack.ChildAdded:Connect(autoShoot_helperFunc_1514)
		end
	end)

	if localPlayer.Character then
		localPlayer.Character.ChildAdded:Connect(autoShoot_helperFunc_1514)
	end

	local backpack = localPlayer:FindFirstChildOfClass("Backpack")

	if backpack then
		for _, autoShoot_loopVar_1516 in backpack:GetChildren() do
			autoShoot_helperFunc_1514(autoShoot_loopVar_1516)
		end

		backpack.ChildAdded:Connect(autoShoot_helperFunc_1514)
	end

	Hub.UpdateAimBinding()
end

settings_helperFunc_1478()

do
	local function autoShoot_helperFunc_1517()
		local character_ = localPlayer.Character
		if not character_ then
			return nil
		end
		local gun = character_:FindFirstChild("Gun")
		if gun and gun:IsA("Tool") then
			return gun
		end
		local humanoid = character_:FindFirstChildOfClass("Humanoid")
		local backpack = localPlayer:FindFirstChildOfClass("Backpack")
		local gun2 = backpack and backpack:FindFirstChild("Gun")
		if not (humanoid and gun2 and gun2:IsA("Tool")) then
			return nil
		end

		pcall(function()
			humanoid:EquipTool(gun2)
		end)

		for i = 1, 6 do
			local gun3 = character_:FindFirstChild("Gun")
			if gun3 and gun3:IsA("Tool") then
				return gun3
			end
			task.wait(0.02)
		end

		return character_:FindFirstChild("Gun") or gun2
	end

	local function autoShoot_helperFunc_1518(autoShoot_param_1519, autoShoot_param_1520)
		local rightHand = autoShoot_param_1519:FindFirstChild("RightHand") or autoShoot_param_1519:FindFirstChild("Right Arm")
		if rightHand and rightHand:IsA("BasePart") then
			return rightHand.CFrame
		end
		local gunRaycastAttachment = autoShoot_param_1520:FindFirstChild("GunRaycastAttachment") or autoShoot_param_1520:FindFirstChild("GunRaycastAttachment", true)
		if gunRaycastAttachment and gunRaycastAttachment:IsA("Attachment") then
			return gunRaycastAttachment.WorldCFrame
		end
		return CFrame.new(autoShoot_param_1520.Position + Vector3.new(0, 0.5, 0))
	end

	local function autoShoot_helperFunc_1521(autoShoot_param_1522, autoShoot_param_1523)
		local character_ = localPlayer.Character
		if not character_ or typeof(autoShoot_param_1522) ~= "Vector3" then
			return false
		end
		local gun = autoShoot_helperFunc_1517()
		if not gun then
			return false
		end
		local humanoid = character_:FindFirstChildOfClass("Humanoid")

		if gun.Parent ~= character_ and humanoid then
			pcall(function()
				humanoid:EquipTool(gun)
			end)

			task.wait(0.05)
			gun = character_:FindFirstChild("Gun") or gun
		end

		local shoot = gun:FindFirstChild("Shoot") or gun:FindFirstChild("Shoot", true)
		if not shoot or not shoot:IsA("RemoteEvent") then
			return false
		end
		local lastShotAt = Hub.AutoShootState.lastShotAt
		if os.clock() - lastShotAt < Hub.AutoShootState.cooldown then
			return false
		end
		local humanoidRootPart = character_:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return false
		end
		autoShoot_param_1523 = autoShoot_param_1523 or Hub.AutoShootState.mode
		local cframe

		if autoShoot_param_1523 == "Behind Walls" or autoShoot_param_1523 == "Wallbang" or autoShoot_param_1523 == "Behind Walls(inaccurate)" then
			cframe = CFrame.new(autoShoot_param_1522 + Vector3.new(0, 1.2, 0))
		else
			cframe = autoShoot_helperFunc_1518(character_, humanoidRootPart)
		end

		local autoShoot_localValue_1524 = cframe
		local cframe2 = CFrame.new(autoShoot_param_1522)
		if not pcall(function()
			shoot:FireServer(autoShoot_localValue_1524, cframe2)
		end) then
			return false
		end
		Hub.AutoShootState.lastShotAt = os.clock()
		return true
	end

	Hub.UpdateAutoShoot = function(autoShoot_param_1525, autoShoot_param_1526)
		local character_ = localPlayer.Character
		if not character_ then
			return false
		end
		local autoShoot_boolFlag_1527 = character_:FindFirstChild("Gun") ~= nil
		local autoShoot_boolFlag_1528

		if autoShoot_boolFlag_1527 then
			autoShoot_boolFlag_1528 = autoShoot_boolFlag_1527
		else
			autoShoot_boolFlag_1528 = localPlayer:FindFirstChildOfClass("Backpack") and localPlayer.Backpack:FindFirstChild("Gun") ~= nil
		end

		if not autoShoot_boolFlag_1528 then
			local autoShoot_callResult_1529 = crosshair_helperFunc_0407()
			if autoShoot_callResult_1529 and autoShoot_callResult_1529 ~= localPlayer then
				return false
			end

			if crosshair_helperFunc_0404(localPlayer) ~= "Sheriff" then
				return false
			end
		end

		autoShoot_param_1526 = autoShoot_param_1526 or crosshair_helperFunc_0406()
		if not autoShoot_param_1526 or not autoShoot_param_1526.Character then
			return false
		end

		local character_2 = autoShoot_param_1526.Character
		local humanoid = character_2:FindFirstChildOfClass("Humanoid")
		if humanoid and humanoid.Health <= 0 then
			return false
		end
		local humanoidRootPart = character_2:FindFirstChild("HumanoidRootPart")
		local aimlockPart = Hub.AimlockPart or Hub.AutoShootState.part or "Head"
		local torso = character_2:FindFirstChild(aimlockPart)

		if not torso and aimlockPart == "UpperTorso" then
			torso = character_2:FindFirstChild("Torso")
		elseif not torso and aimlockPart == "Torso" then
			torso = character_2:FindFirstChild("UpperTorso")
		end

		local head = torso or humanoidRootPart or character_2:FindFirstChild("Head")
		if not (humanoidRootPart and head and head:IsA("BasePart")) then
			return false
		end
		autoShoot_param_1525 = autoShoot_param_1525 or Hub.AutoShootState.mode
		local autoShoot_numericVar_1530 = math.clamp(localPlayer:GetNetworkPing(), 0.02, 0.22)
		local assemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity or head.AssemblyLinearVelocity or Vector3.zero

		if assemblyLinearVelocity.Magnitude > 65 then
			assemblyLinearVelocity = assemblyLinearVelocity.Unit * 65
		end

		local moveDirection = humanoid and humanoid.MoveDirection or Vector3.zero
		local walkSpeed

		if humanoid and humanoid.WalkSpeed > 0 then
			walkSpeed = humanoid.WalkSpeed
		else
			walkSpeed = 16
		end

		if moveDirection.Magnitude > 0.1 then
			assemblyLinearVelocity = Vector3.new(moveDirection.X * walkSpeed, assemblyLinearVelocity.Y * 0.65, moveDirection.Z * walkSpeed)
		end

		return autoShoot_helperFunc_1521(head.Position + assemblyLinearVelocity * (autoShoot_numericVar_1530 * 0.9 + (Hub.PredictionStrength or 5) * 10 / 1000), autoShoot_param_1525)
	end

	Hub.TriggerAutoShootInput = function()
		local autoShootState = Hub.AutoShootState
		local now = os.clock()
		if now < autoShootState.nextInputAt then
			return false
		end
		autoShootState.nextInputAt = now + 0.15
		if Hub.UpdateAutoShoot then
			return Hub.UpdateAutoShoot()
		end
		return false
	end

	Hub.ToggleAutoShoot = function(autoShoot_param_1531)
		Hub.TouchButtons.ToggleAutoShootButton(autoShoot_param_1531)
	end

	Hub.CoinFarm.shootMurderer = function(autoShoot_param_1532)
		if autoShoot_param_1532 and Hub.CoinFarm.endRoundGeneration ~= autoShoot_param_1532 then
			return false
		end
		local autoShoot_getCachedRoleValue_1533 = Hub.CoinFarm.GetCachedRole(localPlayer)
		if Hub.CoinFarm.endRoundDeathRequested or autoShoot_getCachedRoleValue_1533 ~= "Sheriff" then
			return false
		end

		if not autoShoot_helperFunc_1517() then
			return false
		end
		return Hub.UpdateAutoShoot and Hub.UpdateAutoShoot("Behind Walls")
	end
end

Hub.SetupInfiniteJump = function()
	if Hub.JumpConnection then
		Hub.JumpConnection:Disconnect()
	end

	Hub.JumpConnection = UserInputService.JumpRequest:Connect(function()
		if not Hub.InfiniteJumpEnabled then
			return
		end
		local character_ = localPlayer.Character
		if not character_ then
			return
		end
		local humanoid = character_:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)
end

Hub.ToggleInfiniteJump = function(infiniteJumpEnabled)
	Hub.InfiniteJumpEnabled = infiniteJumpEnabled

	if infiniteJumpEnabled then
		Hub.SetupInfiniteJump()
	elseif Hub.JumpConnection then
		Hub.JumpConnection:Disconnect()
		Hub.JumpConnection = nil
	end
end

task.spawn(function()
	RunService.Heartbeat:Wait()

	if foxnameMM2Runtime.alive and not isTerminated then
		Hub.CoinFarm.ApplyResume()
	end
end)

task.spawn(function()
	while true do
		if foxnameMM2Runtime.alive and not isTerminated then
			task.wait(30)

			if not (not foxnameMM2Runtime.alive or false) then
				cleanupDeadConns()

				for k in pairs(Hub.NoclipParts) do
					if not k or not k.Parent then
						Hub.NoclipParts[k] = nil
					end
				end

				for k, partConnection in pairs(Hub.HitboxExpander.partConnections) do
					if not k or not k.Parent then
						if type(partConnection) == "table" then
							for _, autoShoot_loopVar_1534 in pairs(partConnection) do
								if autoShoot_loopVar_1534 and autoShoot_loopVar_1534.Connected then
									autoShoot_loopVar_1534:Disconnect()
								end
							end
						elseif partConnection and partConnection.Connected then
							partConnection:Disconnect()
						end

						Hub.HitboxExpander.partConnections[k] = nil
						Hub.HitboxExpander.originals[k] = nil
					end
				end

				for k in pairs(Hub.HitboxExpander.originals) do
					if not k or not k.Parent then
						Hub.HitboxExpander.originals[k] = nil
					end
				end

				for k in pairs(Hub.AutoGunTouchPending) do
					if not k or not k.Parent then
						Hub.AutoGunTouchPending[k] = nil
					end
				end

				for k in pairs(Hub.CoinFarm.retryUntil) do
					if not k or not k.Parent then
						Hub.CoinFarm.retryUntil[k] = nil
						Hub.CoinFarm.contactAttempts[k] = nil
						Hub.CoinFarm.coins[k] = nil
					end
				end

				for k, autoShoot_loopVar_1535 in pairs(Hub.GunESPTable) do
					if not k or not k.Parent then
						if autoShoot_loopVar_1535.TouchedConnection and autoShoot_loopVar_1535.TouchedConnection.Connected then
							autoShoot_loopVar_1535.TouchedConnection:Disconnect()
						end

						crosshair_helperFunc_0391(autoShoot_loopVar_1535.Line)

						if autoShoot_loopVar_1535.Billboard then
							autoShoot_loopVar_1535.Billboard:Destroy()
						end

						if autoShoot_loopVar_1535.Arrow then
							autoShoot_loopVar_1535.Arrow:Destroy()
						end

						if autoShoot_loopVar_1535.ArrowDistance then
							autoShoot_loopVar_1535.ArrowDistance:Destroy()
						end

						Hub.GunESPTable[k] = nil
					end
				end

				for k in pairs(Hub.ESPTable) do
					if not k or not k.Parent then
						crosshair_helperFunc_0408(k)
						local autoShoot_eSPPlayerConnectionsState_1536 = Hub.ESPPlayerConnections[k]

						if autoShoot_eSPPlayerConnectionsState_1536 then
							autoShoot_eSPPlayerConnectionsState_1536:Disconnect()
						end

						Hub.ESPPlayerConnections[k] = nil
					end
				end

				for k, frozenPlayer in pairs(Hub.FrozenPlayers) do
					if not k or k.Parent ~= Players or not frozenPlayer or not frozenPlayer.Parent then
						Hub.FrozenPlayers[k] = nil
						Hub.FrozenPlayerReleaseIds[k] = nil
					end
				end

				for k, knifeAuraFrozenPlayer in pairs(Hub.KnifeAuraFrozenPlayers) do
					if not k or k.Parent ~= Players or not knifeAuraFrozenPlayer or not knifeAuraFrozenPlayer.Parent then
						Hub.KnifeAuraFrozenPlayers[k] = nil
					end
				end

				continue
			end
		end

		break
	end
end)
