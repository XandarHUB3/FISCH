
loadstring(game:HttpGet("https://raw.githubusercontent.com/XandarHUB3/Ui/refs/heads/main/Ui.lua"))()

local Window = Library:CreateWindow({
	Title = '<font color="#00C3C3">Razer</font><font color="#FFFFFF"> Hub</font>',
	Icon = 82496531647577,
	ColorWindowMain = Color3.fromRGB(0,180,210),
	Keybind = Enum.KeyCode.LeftControl
})

do 
	Config = {

	}
	_G.Config = Config
	AllFuncs = {}
	Threads = getgenv().Threads
	Players = game.Players
	LocalPlayer = game.Players.LocalPlayer
	Client = game.Players.LocalPlayer


	-- \\ Module GetService // --

	ReplicatedStorage = game:GetService('ReplicatedStorage')
	RunService = game:GetService("RunService")
	VirtualInputManager = game:GetService('VirtualInputManager')
	CollectionService = game:GetService("CollectionService")
	CoreGui = game:GetService("CoreGui")
	HttpService = game:GetService("HttpService")
	TeleportService = game:GetService("TeleportService")
	VirtualUser = game:GetService("VirtualUser")
	VirtualInputManager = game:GetService("VirtualInputManager")
	UserInputService = game:GetService("UserInputService")


	-- \\ Normal Module // --

	PlayerGui = LocalPlayer.PlayerGui
	Backpack = LocalPlayer.Backpack
	request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

	Char = Client.Character
	Character = Client.Character
	if not Threads then getgenv().Threads = {} end

	repeat 
		LocalPlayer = Players.LocalPlayer
		wait()
	until LocalPlayer
end

function Notify(Des, Time, title)
	Window:Notify({
		Title = title,
		Desc = Des,
		Time = Time
	})
end

do -- Settings Initializer
	local path = "Razer Hub Fisch"
	if not isfolder(path) then makefolder(path) end
	DefaultConfigName = path.."/OriConfibg.json"
	ConfigName = path.."/"..Client.UserId.."Config.json"
	Config = isfile(ConfigName) and readfile(ConfigName)
	DefaultConfig = isfile(DefaultConfigName) and readfile(DefaultConfigName)
	if DefaultConfig then
		if type(DefaultConfig) == "string" and DefaultConfig:find"{" then
			local Success,Result
			Success,Result = pcall(function()
				return game:GetService("HttpService"):JSONDecode(DefaultConfig)
			end)
			wait(0.1)
			if Success then
				DefaultConfig = Result
			else
				DefaultConfig = nil
			end
		end
	end
	if isfile(tostring(Client.UserId).."ALC.txt") then
		if readfile(tostring(Client.UserId).."ALC.txt") == "true"  then
			if Config then
				if type(Config) == "string" and Config:find"{" then
					local Success,Result
					Success,Result = pcall(function()
						return game:GetService("HttpService"):JSONDecode(Config)
					end)
					wait(0.1)
					if Success then
						Config = Result
					else
						Config = {}
					end
				else
					Config = {}
				end
			else
				Config = {}
			end
		else
			Config = {}
		end
	else
		writefile(tostring(Client.UserId).."ALC.txt", "true")
		Config = {}
	end
	if getgenv().Config then
		Config = getgenv().Config
	end
end

do -- Config Function
	save = function()
		if not isfolder('Raer Hub') then
			makefolder('Razer Hub')
		end
		writefile(ConfigName,game:GetService("HttpService"):JSONEncode(Config))
	end
	setDefaultConfig = function()
		if not isfolder('Razer Hub') then
			makefolder('Razer Hub')
		end
		writefile(DefaultConfigName,game:GetService("HttpService"):JSONEncode(Config))
	end
end

local Tap = {
	Main = Window:CreateTab({Title = "Main", Icon = "box"}),
	Shop = Window:CreateTab({ Title = "Shop", Icon = "shopping-bag"}),
	Teleport = Window:CreateTab({Title = "Teleport", Icon = "asterisk"}),
	Settings = Window:CreateTab({Title = "Settings", Icon = "settings"})
}

game:GetService("Players").LocalPlayer.PlayerGui.hud.safezone.menu.menu_safezone.ChangeSetting:FireServer("nametag",false)

AllFuncs['Sell Fish'] = function()
	while Config['Sell Fish'] and task.wait() do
		pcall(function()
			wait(10)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(464, 151, 232)
			workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Marc Merchant"):WaitForChild("merchant"):WaitForChild("sellall"):InvokeServer()
		end)
	end
end

GetPlayerProfile = function()
	local Respone = game:HttpGet("https://thumbnails.roblox.com/v1/users/avatar-bust?userIds="..LocalPlayer.UserId.."&size=420x420&format=Png&isCircular=false")
	return HttpService:JSONDecode(Respone)['data'][1]['imageUrl']
end

comma_value = function(Value)
	local Calculated = Value
	while true do
		local Text, Amount = string.gsub(Calculated, "^(-?%d+)(%d%d%d)", "%1,%2")
		Calculated = Text
		if Amount == 0 then break end
	end
	return Calculated
end

GetPosition = function()
	if not game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		return {
			Vector3.new(0,0,0),
			Vector3.new(0,0,0),
			Vector3.new(0,0,0)
		}
	end
	return {
		game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.X,
		game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.Y,
		game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.Z
	}
end

ExportValue = function(arg1, arg2)
	return tonumber(string.format("%."..(arg2 or 1)..'f', arg1))
end

Main = Tap.Main:CreateSection({Title = "Main",Side = "Left"}) do
	SelectPosition = Main:CreateLabel({        
		Title = "Position : "
	})
	Main:CreateToggle({
		Title = "Auto Farm Fish",
		Value = false,
		Callback = function(value)
			Config['Farm Fish'] = value
			save()
			while Config['Farm Fish'] and task.wait() do
				local RodName = ReplicatedStorage.playerstats[LocalPlayer.Name].Stats.rod.Value
				if Backpack:FindFirstChild(RodName) then
					LocalPlayer.Character.Humanoid:EquipTool(Backpack:FindFirstChild(RodName))
				end
				if LocalPlayer.Character:FindFirstChild(RodName) and LocalPlayer.Character:FindFirstChild(RodName):FindFirstChild("bobber") then
					local XyzClone = game:GetService("ReplicatedStorage").resources.items.items.GPS.GPS.gpsMain.xyz:Clone()
					XyzClone.Parent = game.Players.LocalPlayer.PlayerGui:WaitForChild("hud"):WaitForChild("safezone"):WaitForChild("backpack")
					XyzClone.Name = "Lure"
					XyzClone.Text = "<font color='#ff4949'>Lure </font>: 0%"
					repeat
						pcall(function()
							PlayerGui:FindFirstChild("shakeui").safezone:FindFirstChild("button").Size = UDim2.new(1001, 0, 1001, 0)
							game:GetService("VirtualUser"):Button1Down(Vector2.new(1, 1))
							game:GetService("VirtualUser"):Button1Up(Vector2.new(1, 1))
						end)
						XyzClone.Text = "<font color='#ff4949'>Lure </font>: "..tostring(ExportValue(tostring(LocalPlayer.Character:FindFirstChild(RodName).values.lure.Value), 2)).."%"
						RunService.Heartbeat:Wait()
					until not LocalPlayer.Character:FindFirstChild(RodName) or LocalPlayer.Character:FindFirstChild(RodName).values.bite.Value or not Config['Farm Fish']
					XyzClone.Text = "<font color='#ff4949'>FISHING!</font>"
					delay(1.5, function()
						XyzClone:Destroy()
					end)
					repeat
						ReplicatedStorage.events.reelfinished:FireServer(1000000000000000000000000, true)
						task.wait(.5)
					until not LocalPlayer.Character:FindFirstChild(RodName) or not LocalPlayer.Character:FindFirstChild(RodName).values.bite.Value or not Config['Farm Fish']
				else
					LocalPlayer.Character:FindFirstChild(RodName).events.cast:FireServer(1000000000000000000000000)
					task.wait(2)
				end
			end
		end
	})
	Main:CreateToggle({
		Title = "Teleport To Select Position",
		Value = false,
		Callback = function(value)
			Config['To Pos Stand'] = value
			save()
			while Config['To Pos Stand'] and task.wait() do
				if not Config['SelectPositionStand'] then
					Notify("Pls Select Position")
					Config['To Pos Stand'] = false
					return
				end
				pcall(function()
					wait()
					LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = Config['SelectPositionStand']
				end)
			end
		end
	})
	Main:CreateButton({
		Title = "Set Position",
		Callback = function()
			Config['SelectPositionStand'] = LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
			SelectPosition:Set("Position : "..tostring(math.floor(LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.X)).." X "..tostring(math.floor(LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.Y)).." Y "..tostring(math.floor(LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.Z)).." Z")
		end
	})
end

IngredientList = {}
for i,v in pairs(workspace.active:GetDescendants()) do
	if v.ClassName == "TextLabel" and v.Text == "Ingredient" then
		local Path = nil
		GetRealPart = function(V)
			if V.ClassName == "Model" then
				Path = V
			else
				GetRealPart(V.Parent)
			end
		end
		GetRealPart(v)
		local OldName = Path.Name
		if Path:FindFirstChildOfClass("MeshPart") then
			if Path:FindFirstChildOfClass("MeshPart").Position.X > 500 then
			end
		end
		if Path:FindFirstChild("PickupPrompt") then
			Path:FindFirstChild("PickupPrompt").HoldDuration = 0
		end
		table.insert(IngredientList, OldName)
	end
end

_hasItem = function(name)
	if Backpack:FindFirstChild(name) then return true end
	if LocalPlayer.Character:FindFirstChild(name) then return true end
end

task.spawn(function()
	while wait(.75) do
		table.clear(IngredientList)
		for i,v in pairs(workspace.active:GetDescendants()) do
			if v.ClassName == "TextLabel" and v.Text == "Ingredient" then
				local Path = nil
				GetRealPart = function(V)
					if V.ClassName == "Model" then
						Path = V
					else
						GetRealPart(V.Parent)
					end
				end
				GetRealPart(v)
				local OldName = Path.Name
				if Path:FindFirstChildOfClass("MeshPart") then
					if Path:FindFirstChildOfClass("MeshPart").Position.X > 500 then
					end
				end
				if Path:FindFirstChild("PickupPrompt") then
					Path:FindFirstChild("PickupPrompt").HoldDuration = 0
				end
				table.insert(IngredientList, OldName)
			end
		end
	end
end)

Seller = Tap.Main:CreateSection({Title = "Seller",Side = "Left"})

Seller:CreateButton({
	Title = "Sell All Fish",
	Callback = function()
		wait()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(464, 151, 232)
		wait(0.5)
		workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Marc Merchant"):WaitForChild("merchant"):WaitForChild("sellall"):InvokeServer()
	end
})

Z = Tap.Main:CreateSection({Title = "Zone",Side = "Right"})

Z:CreateButton({
	Title = "Ancient lsle V1",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(6035.86767578125, 197.25686645507812, 312.6982116699219)
	end
})

Z:CreateButton({
	Title = "Ancient lsle V2",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5797.8154296875, 135.30149841308594, 405.2602233886719)
	end
})

Z:CreateButton({
	Title = "Farm Money/Level V1",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2706.31591796875, 167.25001525878906, 1763.4146728515625)
	end
})

Z:CreateButton({
	Title = "Farm Money/Level V2",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(934.91064453125, -737.0133056640625, 1433.936767578125)
	end
})

Z:CreateButton({
	Title = "Merchant Boat",
	Callback = function()
		local Players = game:GetService("Players")
		local LocalPlayer = Players.LocalPlayer
		local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

		local targetObject = workspace.active:FindFirstChild("Merchant Boat") and workspace.active["Merchant Boat"]:FindFirstChild("1")

		if targetObject then
			HumanoidRootPart.CFrame = targetObject.CFrame 
			Notify("Teleported to Merchant Boat!")
		else
			Notify("Merchant Boat has not spawned yet!")
		end
	end
})

do
	local NC = game:GetService("Workspace"):FindFirstChild("Noclip")
	if NC then
		NC:Destroy()
	end
end
local Noclip = Instance.new("Part",workspace)
Noclip.Name = "Noclip"
Noclip.CanCollide = true
Noclip.Anchored = true
Noclip.Transparency = 0
Noclip.BrickColor = BrickColor.new(0,255,127)
Noclip.Size = Vector3.new(10,-5,10)

function Noclip()
	game:GetService("Workspace"):FindFirstChild("Noclip").CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-2,0)
end

Z:CreateButton({
	Title = "Isonade",
	Callback = function()
		local Players = game:GetService("Players")
		local player = Players.LocalPlayer 
		local character = player.Character or player.CharacterAdded:Wait() 
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

		local targetPathway = workspace.zones.fishing.Isonade
		if targetPathway then 

			local targetPosition = targetPathway.Position
			humanoidRootPart.CFrame = CFrame.new(targetPosition.X, 140, targetPosition.Z) 
			Noclip()
			Notify("Teleported to Isonade!")
		else
			Notify("Isonade has not spawned yet!")
		end
	end
})

Z:CreateButton({
	Title = "The Depths Serpent ",
	Callback = function()
		local Players = game:GetService("Players")
		local LocalPlayer = Players.LocalPlayer
		local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

		local zonePath = workspace.zones.fishing:FindFirstChild("The Depths - Serpent")
		
		if zonePath then
			HumanoidRootPart.CFrame = zonePath.CFrame 
			Noclip()
			Notify("Teleported to The Depths - Serpent!")
		else
			Notify("The Depths - Serpent has not spawned yet!")
		end
	end
})

CM = Z:CreateLabel({        
	Title = "Timing Server"
})

Z:CreateButton({
	Title = "Megalodon Default",
	Callback = function()
		local player = game.Players.LocalPlayer
		local targetPath = workspace.zones.fishing:WaitForChild("Megalodon Default")
		local yOffset = 10
		local baseplateOffset = -10

		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local rootPart = player.Character.HumanoidRootPart
			rootPart.CFrame = targetPath.CFrame + Vector3.new(0, yOffset, 0)
			local baseplate = Instance.new("Part")
			baseplate.Size = Vector3.new(10, 1, 10)
			baseplate.Position = rootPart.Position + Vector3.new(0, baseplateOffset, 0)
			baseplate.Anchored = true
			baseplate.BrickColor = BrickColor.new("Bright green")
			baseplate.Parent = workspace
		end
	end
})

i = Tap.Shop:CreateSection({Title ='item',Side = "Left"})

i:CreateToggle({
	Title = "Auto Buy Luck",
	Value = false,
	Callback = function(value)
		Config['Luck'] = value
		save()
		while Config['Luck'] and task.wait() do
			pcall(function()
				wait(1)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-930.2783203125, 223.78355407714844, -988.0430908203125)
				workspace.world.npcs.Merlin.Merlin.luck:InvokeServer()
			end)
		end
	end
})

i:CreateToggle({
	Title = "Auto Buy Enchant Relic",
	Value = false,
	Callback = function(value)
		Config['Relic'] = value
		save()
		while Config['Relic'] and task.wait() do
			pcall(function()
				wait(1)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-930.2783203125, 223.78355407714844, -988.0430908203125)
				workspace.world.npcs.Merlin.Merlin.power:InvokeServer()
			end)
		end
	end
})

i:CreateButton({
	Title = "Sundial Totem",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1148, 135, -1075)
	end
})

i:CreateButton({
	Title = "Eclipse Totem (New)",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5965.21142578125, 269.6245422363281, 848.4652099609375)
	end
})


i:CreateButton({
	Title = "Aurora Totem",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1811, -137, -3282)
	end
})

i:CreateButton({
	Title = "Windset Totem",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2849, 179, 2702)
	end
})

i:CreateButton({
	Title = "Smokescreen Totem",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2789, 140, -625)
	end
})

i:CreateButton({
	Title = "Tempest Totem",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(35, 132.5, 1943)
	end
})

Shoppy = Tap.Shop:CreateSection({Title = 'Rod',Side = "Right"})

Shoppy:CreateButton({
	Title = "Candy Cane Rod (new)",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-185.5498046875, 366.8877868652344, -9441.859375)
	end
})

Shoppy:CreateButton({
	Title = "Arctic Rod (New)",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(19577.20703125, 132.67010498046875, 5301.73095703125)
	end
})

Shoppy:CreateButton({
	Title = "Avalanche Rod (New)",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(19770.69921875, 415.43707275390625, 5411.7998046875)
	end
})

Shoppy:CreateButton({
	Title = "Summit Rod (New)",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(20212.5, 736.6688232421875, 5708.5)
	end
})

Shoppy:CreateButton({
	Title = "Heaven's Rod (New)",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(20042.443359375, -464.0634765625, 7144.2470703125)
	end
})

Shoppy:CreateButton({
	Title = "Basic Rod",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(454, 151, 239)
	end
})

Shoppy:CreateButton({
	Title = "Phoenix Rod",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5965.21142578125, 269.6245422363281, 848.4652099609375)
	end
})

Shoppy:CreateButton({
	Title = "Stone Rod",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5497.60498046875, 143.49661254882812, -313.205322265625)
	end
})

Shoppy:CreateButton({
	Title = "Long Rod",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(486, 175, 151)
	end
})

Shoppy:CreateButton({
	Title = "Rapid & Steady Rod",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1510, 142, 761)
	end
})

Shoppy:CreateButton({
	Title = "Fortune Rod",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1523, 142, 770)
	end
})

Shoppy:CreateButton({
	Title = "Magnet Rod",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-200, 133, 1930)
	end
})

Shoppy:CreateButton({
	Title = "Trident Rod",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1484, -226, -2201)
	end
})

Shoppy:CreateButton({
	Title = "Aurora Rod",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-141, -512, 1145)
	end
})

Shoppy:CreateButton({
	Title = "Nocturnal Rod",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-141, -512, 1145)
	end
})

Shoppy:CreateButton({
	Title = "Kings Rod",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1381, -808, -302)
	end
})

Shoppy:CreateButton({
	Title = "Reinforced Rod",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-989, -243, -2693)
	end
})

Shoppy:CreateButton({
	Title = "Scurvy Rod",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2825, 215, 1512)
	end
})

Shoppy:CreateButton({
	Title = "Rod Of The Depths",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1703, -903, 1443)
	end})


local TableZum = {}
GetCount = function(NameFish)
	local ReturnCound = 0
	for i,v in pairs(PlayerGui.hud.safezone.backpack.hotbar:GetChildren()) do
		if v:FindFirstChild("tool") and tostring(v.tool.value) == NameFish then
			ReturnCound = 1
		end
	end
	for i,v in pairs(PlayerGui.hud.safezone.backpack.inventory.scroll.safezone:GetChildren()) do
		if v.Name == NameFish then
			ReturnCound = 1
		end
	end

	return ReturnCound
end

function GetFishInInventory()
	local TableReturn = {}
	for i,v in pairs(PlayerGui.hud.safezone.backpack.hotbar:GetChildren()) do
		if v:FindFirstChild("tool") and table.find(FishList, tostring(v.tool.value)) then
			local Count = v.stack.Text:match("%d+") or "1"
			TableReturn[tostring(v.itemname.Text:gsub("<.->", "")).." X"..Count] = {
				v.weight.Text,
				((FISHDATA[tostring(v.tool.value)] and FISHDATA[tostring(v.tool.value)].Price) or "0").."$"
			}
		end
	end

	for i,v in pairs(PlayerGui.hud.safezone.backpack.inventory.scroll.safezone:GetChildren()) do
		if table.find(FishList, v.Name) then
			local Count = v.stack.Text:match("%d+") or "1"
			TableReturn[tostring(v.itemname.Text:gsub("<.->", "")).." X"..Count] = {
				v.weight.Text,
				((FISHDATA[v.Name] and FISHDATA[v.Name].Price) or "0").."$"
			}
		end
	end
	return TableReturn
end

Teleporting = Tap.Teleport:CreateSection({Title = 'Teleport',Side = "Left"}) do
	-- Teleport
	Teleporting:CreateButton({
		Title = "Moosewood",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(380, 135, 223)
		end
	})

	Teleporting:CreateButton({
		Title = "Rod Crafting",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3160.3095703125, -745.4639892578125, 1682.7935791015625)
		end
	})

	Teleporting:CreateButton({
		Title = "Ancient Isle",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(6059,195,280)
		end
	})

	Teleporting:CreateButton({
		Title = "Roslit Bay",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1485, 133, 720)
		end
	})

	Teleporting:CreateButton({
		Title = "Roslit Volcano",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1910, 165, 317)
		end
	})

	Teleporting:CreateButton({
		Title = "Mushgrove Swamp",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2500, 131, -720)
		end
	})

	Teleporting:CreateButton({
		Title = "Terrapin Island",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-18, 156, 1975)
		end
	})

	Teleporting:CreateButton({
		Title = "Snowcap Island",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2624, 142, 2471)
		end
	})

	Teleporting:CreateButton({
		Title = "Sunstone Island",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-933, 132, -1118)
		end
	})

	Teleporting:CreateButton({
		Title = "Forsaken Shores",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2500, 134, 1540)
		end
	})

	Teleporting:CreateButton({
		Title = "Statue Of Sovereignty",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(50, 132, -1009)
		end
	})

	Teleporting:CreateButton({
		Title = "Keepers Altar",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1307, -805, -96)
		end
	})

	Teleporting:CreateButton({
		Title = "Vertigo",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108, -515, 1065)
		end
	})

	Teleporting:CreateButton({
		Title = "Desolate Deep",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1000, -245, -2725)
		end
	})

	Teleporting:CreateButton({
		Title = "Desolate Pocket",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1500, -235, -2856)
		end
	})

	Teleporting:CreateButton({
		Title = "The Depths",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(502, -707, 1234)
		end
	})

	Teleporting:CreateButton({
		Title = "Brine Pool",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1800, -143, -3404)
		end
	})

	Teleporting:CreateButton({
		Title = "Earmark Isle",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1230, 125, 575)
		end
	})

	Teleporting:CreateButton({
		Title = "Haddock Rock",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-570, 182, -413)
		end
	})

	Teleporting:CreateButton({
		Title = "The Arch",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1000, 125, -1250)
		end
	})

	Teleporting:CreateButton({
		Title = "Birch Cay",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1700, 125, -2500)
		end
	})

	Teleporting:CreateButton({
		Title = "Harvesters Spike",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1257, 139, 1550)
		end
	})

	Teleporting:CreateButton({
		Title = "Winter Village (New)",
		Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(20, 364, -9577)
		end
	})

	-- Teleporting button for "Terrapin Island"
	Teleporting:CreateButton({
		Title = "Best Spot",
		Callback = function()
			local forceFieldPart = Instance.new("Part") -- Create a new part
			forceFieldPart.Size = Vector3.new(10, 1, 10) -- Set the size of the part (10x1x10)
			forceFieldPart.Position = Vector3.new(1447.8507080078125, 131.49998474121094, -7649.64501953125) -- Adjusted position (2 units lower)
			forceFieldPart.Anchored = true -- Make sure the part does not fall
			forceFieldPart.BrickColor = BrickColor.new("White") -- Set the color of the part to white
			forceFieldPart.Material = Enum.Material.SmoothPlastic -- Set the material of the part
			forceFieldPart.Parent = game.Workspace -- Parent the part to the Workspace

			-- Create a ForceField
			local forceField = Instance.new("ForceField") -- Create a new ForceField object
			forceField.Parent = forceFieldPart -- Parent the ForceField to the part
			wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1447.8507080078125, 133.49998474121094, -7649.64501953125)
		end
	})
end

local Old = os.time()
task.spawn(function(InitializeService)
	warn("ANTI AFK STARTING")
	pcall(function()
		for i,v in pairs(getconnections(Client.Idled)) do
			v:Disable() 
		end
		Client.Idled:connect(function()
			game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
			wait(1)
			game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)
		while wait(300) do
			game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
			wait(1)
			game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end
	end)
end)

do
	Settings_M = Tap.Settings:CreateSection({Title = "Misc",Side = "Left"}) do
		Timeing = Settings_M:CreateLabel({        
			Title = "Timeing Server"
		})
		Settings_M:CreateToggle({
			Title = "Save Configs",
			Value = false,
			Callback = function(value)
				writefile(tostring(LocalPlayer.UserId).."ALC.txt", tostring(value))
			end})

	end

	Settings_M:CreateButton({
		Title = "Hop Server",
		Description = "",
		Callback = function()
			AllFuncs.HopServer(false)
		end
	})

	Settings_M:CreateButton({
		Title = "Fps Boots",
		Callback = function()
			loadstring(game:HttpGet('https://pastefy.app/SfmfixDi/raw'))()
			loadstring(game:HttpGet('https://pastebin.com/raw/uuLUmqAT'))()(false)


			function change(v) pcall(function() if v.Material ~= Enum.Material.Neon and v.Material ~= Enum.Material.Plastic and v.Material ~= Enum.Material.ForceField then pcall(function() v.Reflectance = 0 end) pcall(function() v.Material = Enum.Material.Plastic end) pcall(function() v.TopSurface = "Smooth" end) end end) end

			game.DescendantAdded:Connect(function(v) pcall(function() if v:IsA"Part" then change(v) elseif v:IsA"MeshPart" then change(v) elseif v:IsA"TrussPart" then change(v) elseif v:IsA"UnionOperation" then change(v) elseif v:IsA"CornerWedgePart" then change(v) elseif v:IsA"WedgePart" then change(v) end end) end) for i, v in pairs(game:GetDescendants()) do pcall(function() if v:IsA"Part" then change(v) elseif v:IsA"MeshPart" then change(v) elseif v:IsA"TrussPart" then change(v) elseif v:IsA"UnionOperation" then change(v) elseif v:IsA"CornerWedgePart" then change(v) elseif v:IsA"WedgePart" then change(v) end end) end
		end
	})


	AllFuncs.HopServer = function(FullServer) -- Hop Server (Low)
		local FullServer = FullServer or false

		local Http = game:GetService("HttpService")
		local Api = "https://games.roblox.com/v1/games/"

		local _place = game.PlaceId
		local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
		local ListServers = function (cursor)
			local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
			return Http:JSONDecode(Raw)
		end

		local Server, Next; repeat
			local Servers = ListServers(Next)
			Server = Servers.data[1]
			Next = Servers.nextPageCursor
		until Server
		repeat
			if not FullServer then
				game:GetService("TeleportService"):TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
			else
				if request then
					local servers = {}
					local req = request(
						{
							Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", game.PlaceId)
						}
					).Body;
					local body = game:GetService("HttpService"):JSONDecode(req)
					if body and body.data then
						for i, v in next, body.data do
							if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
								table.insert(servers, 1, v.id)
							end
						end
					end
					if #servers > 0 then
						game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], game.Players.LocalPlayer)
					else
						return "Couldn't find a server."
					end
				end
			end
			wait()
		until game.PlaceId ~= game.PlaceId
	end

	RunService.Heartbeat:Connect(function() -- All RunService
		local TimeSinceLastPlay = os.time() - Old
		local hours = tostring(math.floor(TimeSinceLastPlay / 3600))
		local minutes = tostring(math.floor((TimeSinceLastPlay % 3600) / 60))
		local seconds = tostring(TimeSinceLastPlay % 60)
		Timeing:Set("Server Time "..hours.." H "..minutes.." M "..seconds.." S ")
	end)

	setfflag("TaskSchedulerTargetFps", "1000")
	setfpscap(120)
	while true do
		if (game:GetService("Workspace").DistributedGameTime % 1 * 60) > 30 then
			setfpscap(120)
		end
		wait(0)
	end
end
 
