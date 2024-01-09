--> Local Varibles:
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

--> Library:
local Library = {}
Library.Tree = {}

--> Local Functions:

--> Library Functions
function Library:TweenGradient(Gradient, colour1, colour2)
	local frames = 3
	local speed = 0.01

	local originalColour1 = Gradient.Color.Keypoints[1].Value
	local originalColour2 = Gradient.Color.Keypoints[2].Value
	local sequence
	for i = frames, 0, -1 do
		wait(speed)

		local x = math.sqrt((i - frames) ^ 2) / frames

		sequence = ColorSequence.new({
			ColorSequenceKeypoint.new(0, originalColour1:Lerp(colour1, x)),
			ColorSequenceKeypoint.new(1, originalColour2:Lerp(colour2, x)),
		})

		Gradient.Color = sequence
	end
end

function Library:validate()
	return function(defaults, options)
		for num, option in defaults do
			if options[num] == nil then
				options[num] = option
			end
		end

		return options
	end
end

function Library.new(options)
	Library:validate()({
		Name = "Girra",
	}, options or {})

	--> UI:
	local Gui = {
		Destroy = function()
			Library.Tree["ProtectionSecure"]:Destroy()
		end,
	}
	--> Functions:
	function Gui:ChangeSection(Section: string)
		assert(Section == "Server" or Section == "Client", "Section is nil or does not exist")

		if Library.Tree["26"].Name == Section then
			task.spawn(function()
				Library:TweenGradient(Library.Tree["Grad"], Color3.fromRGB(255, 147, 36), Color3.fromRGB(255, 76, 51))
			end)

			task.spawn(function()
				Library:TweenGradient(Library.Tree["21"], Color3.fromRGB(39, 39, 39), Color3.fromRGB(39, 39, 39))
				Library.Tree["6"].Visible = false
				Library.Tree["26"].Visible = true
			end)

			task.wait()

			TweenService
				:Create(Library.Tree["26"], TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
					Position = UDim2.new(0, 0, 0.1829884946346283, 0),
				})
				:Play()

			Library.Tree["6"].Position = UDim2.new(1, 0, 0.1829884946346283, 0)
		end

		if Library.Tree["6"].Name == Section then
			task.spawn(function()
				Library:TweenGradient(Library.Tree["21"], Color3.fromRGB(255, 147, 36), Color3.fromRGB(255, 76, 51))
			end)

			task.spawn(function()
				Library:TweenGradient(Library.Tree["Grad"], Color3.fromRGB(39, 39, 39), Color3.fromRGB(39, 39, 39))
			end)

			Library.Tree["6"].Visible = true
			Library.Tree["26"].Visible = false

			task.wait()

			TweenService
				:Create(Library.Tree["6"], TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
					Position = UDim2.new(0, 0, 0.1829884946346283, 0),
				})
				:Play()

			Library.Tree["26"].Position = UDim2.new(-1, 0, 0.1829884946346283, 0)
		end
	end

	function Gui:PopupEmployee(Runtime, Name)
		do
			-- StarterGui.GirraUI.Main.Server.JobCount.ScrollingFrame.MyJob
			Library.Tree[Name] =
				Instance.new("TextLabel", if Runtime == "Server" then Library.Tree["38"] else Library.Tree["18"])
			Library.Tree[Name]["TextWrapped"] = true
			Library.Tree[Name]["BorderSizePixel"] = 0
			Library.Tree[Name]["TextScaled"] = true
			Library.Tree[Name]["TextTransparency"] = 1
			Library.Tree[Name]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
			Library.Tree[Name]["TextSize"] = 25
			Library.Tree[Name]["FontFace"] =
				Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			Library.Tree[Name]["TextColor3"] = Color3.fromRGB(255, 255, 255)
			Library.Tree[Name]["Size"] = UDim2.new(0.8999999761581421, 0, 0.15000000596046448, 0)
			Library.Tree[Name]["Name"] = Name
			Library.Tree[Name]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
			Library.Tree[Name]["Text"] = Name
			Library.Tree[Name]["Position"] = UDim2.new(0.03125, 0, 0.054054055362939835, 0)

			-- StarterGui.GirraUI.Main.Runtime.Switch2
			Library.Tree[Name .. "2"] = Instance.new("TextLabel", Library.Tree[Name])
			Library.Tree[Name .. "2"]["TextWrapped"] = true
			Library.Tree[Name .. "2"]["BorderSizePixel"] = 0
			Library.Tree[Name .. "2"]["TextScaled"] = true
			Library.Tree[Name .. "2"]["BackgroundTransparency"] = 1
			Library.Tree[Name .. "2"]["TextSize"] = 25
			Library.Tree[Name .. "2"]["FontFace"] =
				Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			Library.Tree[Name .. "2"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
			Library.Tree[Name .. "2"]["Size"] = UDim2.new(1, 0, 1, 0)
			Library.Tree[Name .. "2"]["Name"] = Name
			Library.Tree[Name .. "2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
			Library.Tree[Name .. "2"]["Text"] = Name
			Library.Tree[Name .. "2"]["Position"] = UDim2.new(0, 0, 0, 0)

			Library.Tree[Name .. "3"] = Instance.new("UITextSizeConstraint", Library.Tree[Name .. "2"])
			Library.Tree[Name .. "3"]["MaxTextSize"] = 25
			-- Attributes
			Library.Tree[Name .. "2"]:SetAttribute(Name, false)

			-- StarterGui.GirraUI.Main.Runtime.Switch1.UIGradient
			Library.Tree[Name .. "5"] = Instance.new("UIGradient", Library.Tree[Name])
			Library.Tree[Name .. "5"]["Color"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 148, 37)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(255, 77, 52)),
			})

			-- StarterGui.GirraUI.Main.Server.JobCount.ScrollingFrame.MyJob.UICorner
			Library.Tree[Name .. "7"] = Instance.new("UICorner", Library.Tree[Name])
			Library.Tree[Name .. "7"]["CornerRadius"] = UDim.new(0.20000000298023224, 0)

			-- StarterGui.GirraUI.Main.Server.JobCount.ScrollingFrame.MyJob.UITextSizeConstraint
			Library.Tree[Name .. "10"] = Instance.new("UITextSizeConstraint", Library.Tree[Name])
			Library.Tree[Name .. "10"]["MaxTextSize"] = 25
		end
	end

	function Gui:PopupJob(Runtime, Name)
		do
			-- StarterGui.GirraUI.Main.Server.JobCount.ScrollingFrame.MyJob
			Library.Tree[Name] =
				Instance.new("TextLabel", if Runtime == "Server" then Library.Tree["2d"] else Library.Tree["d"])
			Library.Tree[Name]["TextWrapped"] = true
			Library.Tree[Name]["BorderSizePixel"] = 0
			Library.Tree[Name]["TextScaled"] = true
			Library.Tree[Name]["TextTransparency"] = 1
			Library.Tree[Name]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
			Library.Tree[Name]["TextSize"] = 25
			Library.Tree[Name]["FontFace"] =
				Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			Library.Tree[Name]["TextColor3"] = Color3.fromRGB(255, 255, 255)
			Library.Tree[Name]["Size"] = UDim2.new(0.8999999761581421, 0, 0.15000000596046448, 0)
			Library.Tree[Name]["Name"] = Name
			Library.Tree[Name]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
			Library.Tree[Name]["Text"] = Name
			Library.Tree[Name]["Position"] = UDim2.new(0.03125, 0, 0.054054055362939835, 0)

			-- StarterGui.GirraUI.Main.Runtime.Switch2
			Library.Tree[Name .. "2"] = Instance.new("TextLabel", Library.Tree[Name])
			Library.Tree[Name .. "2"]["TextWrapped"] = true
			Library.Tree[Name .. "2"]["BorderSizePixel"] = 0
			Library.Tree[Name .. "2"]["TextScaled"] = true
			Library.Tree[Name .. "2"]["BackgroundTransparency"] = 1
			Library.Tree[Name .. "2"]["TextSize"] = 25
			Library.Tree[Name .. "2"]["FontFace"] =
				Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			Library.Tree[Name .. "2"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
			Library.Tree[Name .. "2"]["Size"] = UDim2.new(1, 0, 1, 0)
			Library.Tree[Name .. "2"]["Name"] = Name
			Library.Tree[Name .. "2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
			Library.Tree[Name .. "2"]["Text"] = Name
			Library.Tree[Name .. "2"]["Position"] = UDim2.new(0, 0, 0, 0)

			Library.Tree[Name .. "3"] = Instance.new("UITextSizeConstraint", Library.Tree[Name .. "2"])
			Library.Tree[Name .. "3"]["MaxTextSize"] = 25
			-- Attributes
			Library.Tree[Name .. "2"]:SetAttribute(Name, false)

			-- StarterGui.GirraUI.Main.Runtime.Switch1.UIGradient
			Library.Tree[Name .. "5"] = Instance.new("UIGradient", Library.Tree[Name])
			Library.Tree[Name .. "5"]["Color"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 148, 37)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(255, 77, 52)),
			})

			-- StarterGui.GirraUI.Main.Server.JobCount.ScrollingFrame.MyJob.UICorner
			Library.Tree[Name .. "7"] = Instance.new("UICorner", Library.Tree[Name])
			Library.Tree[Name .. "7"]["CornerRadius"] = UDim.new(0.20000000298023224, 0)

			-- StarterGui.GirraUI.Main.Server.JobCount.ScrollingFrame.MyJob.UITextSizeConstraint
			Library.Tree[Name .. "10"] = Instance.new("UITextSizeConstraint", Library.Tree[Name])
			Library.Tree[Name .. "10"]["MaxTextSize"] = 25
		end
	end

	--> Testez:
	Gui.ServerHover = false
	Gui.ClientHover = false

	--> Events:
	RunService.Heartbeat:Connect(function()
		if Library.Tree["1"].Enabled == true then
			game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
			TweenService
				:Create(Library.Tree["2"], TweenInfo.new(0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
					Position = UDim2.new(0.7839999794960022, 0, 0, 0),
				})
				:Play()
			Library.Tree["1"].Parent = Player.PlayerGui
		else
			game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
			Library.Tree["2"].Position = UDim2.new(1, 0, 0, 0)
			Library.Tree["1"].Parent = game:GetService("GroupService")
		end

		local ServerNumber = 0
		local ClientNumber = 0

		local ServerNumberEmployee = 0
		local ClientNumberEmployee = 0

		for _, Num in Library.Tree["2d"]:GetChildren() do
			if Num:IsA("TextLabel") then
				ServerNumber += 1
			end
		end

		for _, Num in Library.Tree["d"]:GetChildren() do
			if Num:IsA("TextLabel") then
				ClientNumber += 1
			end
		end

		for _, Num in Library.Tree["18"]:GetChildren() do
			if Num:IsA("TextLabel") then
				ClientNumberEmployee += 1
			end
		end

		for _, Num in Library.Tree["38"]:GetChildren() do
			if Num:IsA("TextLabel") then
				ServerNumberEmployee += 1
			end
		end

		Library.Tree["c"].Text = ClientNumber .. " Jobs Running!"
		Library.Tree["2c"].Text = ServerNumber .. " Jobs Running!"

		Library.Tree["16"].Text = ClientNumberEmployee .. " Employees Running!"
		Library.Tree["36"].Text = ServerNumberEmployee .. " Employees Running!"
	end)

	--> Girra UI:
	do
		Library.Tree["1"] = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
		Library.Tree["1"]["Name"] = options.Name
		Library.Tree["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
		Library.Tree["1"]["IgnoreGuiInset"] = true
		Library.Tree["1"]["Enabled"] = false
		Library.Tree["1"]["ResetOnSpawn"] = false
	end

	--> Girra UI => Main:
	do
		Library.Tree["2"] = Instance.new("Frame", Library.Tree["1"])
		Library.Tree["2"]["BorderSizePixel"] = 0
		Library.Tree["2"]["BackgroundColor3"] = Color3.fromRGB(47, 47, 47)
		Library.Tree["2"]["Size"] = UDim2.new(0.22200000286102295, 0, 1, 0)
		Library.Tree["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["2"]["Position"] = UDim2.new(0.7839999794960022, 0, 0, 0)
		Library.Tree["2"]["Name"] = [[Main]]
		Library.Tree["2"]["ClipsDescendants"] = true

		-- StarterGui.GirraUI.Main.UmbraShadow
		Library.Tree["3"] = Instance.new("ImageLabel", Library.Tree["2"])
		Library.Tree["3"]["ZIndex"] = 0
		Library.Tree["3"]["SliceCenter"] = Rect.new(10, 10, 118, 118)
		Library.Tree["3"]["ScaleType"] = Enum.ScaleType.Slice
		Library.Tree["3"]["ImageColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["3"]["ImageTransparency"] = 0.8600000143051147
		Library.Tree["3"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
		Library.Tree["3"]["Image"] = [[rbxassetid://1316045217]]
		Library.Tree["3"]["Size"] = UDim2.new(1, 10, 1, 10)
		Library.Tree["3"]["Name"] = [[UmbraShadow]]
		Library.Tree["3"]["BackgroundTransparency"] = 1
		Library.Tree["3"]["Position"] = UDim2.new(0.5, 0, 0.5, 6)

		-- StarterGui.GirraUI.Main.PenumbraShadow
		Library.Tree["4"] = Instance.new("ImageLabel", Library.Tree["2"])
		Library.Tree["4"]["ZIndex"] = 0
		Library.Tree["4"]["SliceCenter"] = Rect.new(10, 10, 118, 118)
		Library.Tree["4"]["ScaleType"] = Enum.ScaleType.Slice
		Library.Tree["4"]["ImageColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["4"]["ImageTransparency"] = 0.8799999952316284
		Library.Tree["4"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
		Library.Tree["4"]["Image"] = [[rbxassetid://1316045217]]
		Library.Tree["4"]["Size"] = UDim2.new(1, 18, 1, 18)
		Library.Tree["4"]["Name"] = [[PenumbraShadow]]
		Library.Tree["4"]["BackgroundTransparency"] = 1
		Library.Tree["4"]["Position"] = UDim2.new(0.5, 0, 0.5, 1)

		-- StarterGui.GirraUI.Main.AmbientShadow
		Library.Tree["5"] = Instance.new("ImageLabel", Library.Tree["2"])
		Library.Tree["5"]["ZIndex"] = 0
		Library.Tree["5"]["SliceCenter"] = Rect.new(10, 10, 118, 118)
		Library.Tree["5"]["ScaleType"] = Enum.ScaleType.Slice
		Library.Tree["5"]["ImageColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["5"]["ImageTransparency"] = 0.800000011920929
		Library.Tree["5"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
		Library.Tree["5"]["Image"] = [[rbxassetid://1316045217]]
		Library.Tree["5"]["Size"] = UDim2.new(1, 5, 1, 5)
		Library.Tree["5"]["Name"] = [[AmbientShadow]]
		Library.Tree["5"]["BackgroundTransparency"] = 1
		Library.Tree["5"]["Position"] = UDim2.new(0.5, 0, 0.5, 3)
	end

	--> Girra UI => Main => Client
	do
		Library.Tree["6"] = Instance.new("Frame", Library.Tree["2"])
		Library.Tree["6"]["BorderSizePixel"] = 0
		Library.Tree["6"]["BackgroundColor3"] = Color3.fromRGB(47, 47, 47)
		Library.Tree["6"]["BackgroundTransparency"] = 1
		Library.Tree["6"]["Size"] = UDim2.new(1, 0, 0.8170115351676941, 0)
		Library.Tree["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["6"]["Position"] = UDim2.new(1, 0, 0.1829884946346283, 0)
		Library.Tree["6"]["Visible"] = false
		Library.Tree["6"]["Name"] = [[Client]]

		-- StarterGui.GirraUI.Main.Client.TextLabel
		Library.Tree["7"] = Instance.new("TextLabel", Library.Tree["6"])
		Library.Tree["7"]["TextWrapped"] = true
		Library.Tree["7"]["BorderSizePixel"] = 0
		Library.Tree["7"]["TextScaled"] = true
		Library.Tree["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["7"]["TextXAlignment"] = Enum.TextXAlignment.Left
		Library.Tree["7"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Library.Tree["7"]["TextTransparency"] = 0.4000000059604645
		Library.Tree["7"]["TextSize"] = 14
		Library.Tree["7"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["7"]["Size"] = UDim2.new(0.8698884844779968, 0, 0.03740648552775383, 0)
		Library.Tree["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["7"]["Text"] = [[Jobs]]
		Library.Tree["7"]["BackgroundTransparency"] = 1
		Library.Tree["7"]["Position"] = UDim2.new(0.06505576521158218, 0, 0.10099750757217407, 0)

		-- StarterGui.GirraUI.Main.Client.TextLabel.UITextSizeConstraint
		Library.Tree["8"] = Instance.new("UITextSizeConstraint", Library.Tree["7"])
		Library.Tree["8"]["MaxTextSize"] = 40

		-- StarterGui.GirraUI.Main.Client.UIListLayout
		Library.Tree["9"] = Instance.new("UIListLayout", Library.Tree["6"])
		Library.Tree["9"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center
		Library.Tree["9"]["Padding"] = UDim.new(0.009999999776482582, 0)
		Library.Tree["9"]["SortOrder"] = Enum.SortOrder.LayoutOrder

		-- StarterGui.GirraUI.Main.Client.JobCount
		Library.Tree["a"] = Instance.new("CanvasGroup", Library.Tree["6"])
		Library.Tree["a"]["BorderSizePixel"] = 0
		Library.Tree["a"]["BackgroundColor3"] = Color3.fromRGB(35, 35, 35)
		Library.Tree["a"]["Size"] = UDim2.new(0.832713782787323, 0, 0.34344813227653503, 0)
		Library.Tree["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["a"]["Position"] = UDim2.new(0.08364296704530716, 0, 0.04740648344159126, 0)
		Library.Tree["a"]["Name"] = [[JobCount]]

		-- StarterGui.GirraUI.Main.Client.JobCount.UICorner
		Library.Tree["b"] = Instance.new("UICorner", Library.Tree["a"])

		-- StarterGui.GirraUI.Main.Client.JobCount.TextLabel
		Library.Tree["c"] = Instance.new("TextLabel", Library.Tree["a"])
		Library.Tree["c"]["TextWrapped"] = true
		Library.Tree["c"]["BorderSizePixel"] = 0
		Library.Tree["c"]["TextScaled"] = true
		Library.Tree["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["c"]["TextXAlignment"] = Enum.TextXAlignment.Left
		Library.Tree["c"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Library.Tree["c"]["TextTransparency"] = 0.4000000059604645
		Library.Tree["c"]["TextSize"] = 14
		Library.Tree["c"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["c"]["Size"] = UDim2.new(0.6339285969734192, 0, 0.1082959920167923, 0)
		Library.Tree["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["c"]["Text"] = [[14 Jobs Running]]
		Library.Tree["c"]["BackgroundTransparency"] = 1
		Library.Tree["c"]["Position"] = UDim2.new(0.06952042132616043, 0, 0.04751328378915787, 0)

		-- StarterGui.GirraUI.Main.Client.JobCount.ScrollingFrame
		Library.Tree["d"] = Instance.new("ScrollingFrame", Library.Tree["a"])
		Library.Tree["d"]["Active"] = true
		Library.Tree["d"]["BorderSizePixel"] = 0
		Library.Tree["d"]["BackgroundColor3"] = Color3.fromRGB(35, 35, 35)
		Library.Tree["d"]["AutomaticCanvasSize"] = Enum.AutomaticSize.XY
		Library.Tree["d"]["Size"] = UDim2.new(1, 0, 0.7625570893287659, 0)
		Library.Tree["d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["d"]["ScrollBarThickness"] = 2
		Library.Tree["d"]["Position"] = UDim2.new(0, 0, 0.23498116433620453, 0)

		-- StarterGui.GirraUI.Main.Client.JobCount.ScrollingFrame.UIListLayout
		Library.Tree["11"] = Instance.new("UIListLayout", Library.Tree["d"])
		Library.Tree["11"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center
		Library.Tree["11"]["SortOrder"] = Enum.SortOrder.LayoutOrder
		Library.Tree["11"]["Padding"] = UDim.new(0.05, 0)

		-- StarterGui.GirraUI.Main.Client.TextLabel
		Library.Tree["12"] = Instance.new("TextLabel", Library.Tree["6"])
		Library.Tree["12"]["TextWrapped"] = true
		Library.Tree["12"]["BorderSizePixel"] = 0
		Library.Tree["12"]["TextScaled"] = true
		Library.Tree["12"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["12"]["TextXAlignment"] = Enum.TextXAlignment.Left
		Library.Tree["12"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Library.Tree["12"]["TextTransparency"] = 0.4000000059604645
		Library.Tree["12"]["TextSize"] = 14
		Library.Tree["12"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["12"]["Size"] = UDim2.new(0.8698884844779968, 0, 0.03740648552775383, 0)
		Library.Tree["12"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["12"]["Text"] = [[Employees]]
		Library.Tree["12"]["BackgroundTransparency"] = 1
		Library.Tree["12"]["Position"] = UDim2.new(0.06505576521158218, 0, 0.10099750757217407, 0)

		-- StarterGui.GirraUI.Main.Client.TextLabel.UITextSizeConstraint
		Library.Tree["13"] = Instance.new("UITextSizeConstraint", Library.Tree["12"])
		Library.Tree["13"]["MaxTextSize"] = 40

		-- StarterGui.GirraUI.Main.Client.Employee
		Library.Tree["14"] = Instance.new("CanvasGroup", Library.Tree["6"])
		Library.Tree["14"]["BorderSizePixel"] = 0
		Library.Tree["14"]["BackgroundColor3"] = Color3.fromRGB(35, 35, 35)
		Library.Tree["14"]["Size"] = UDim2.new(0.832713782787323, 0, 0.3817569613456726, 0)
		Library.Tree["14"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["14"]["Position"] = UDim2.new(0.08364296704530716, 0, 0.4482610821723938, 0)
		Library.Tree["14"]["Name"] = [[Employee]]

		-- StarterGui.GirraUI.Main.Client.Employee.UICorner
		Library.Tree["15"] = Instance.new("UICorner", Library.Tree["14"])

		-- StarterGui.GirraUI.Main.Client.Employee.TextLabel
		Library.Tree["16"] = Instance.new("TextLabel", Library.Tree["14"])
		Library.Tree["16"]["TextWrapped"] = true
		Library.Tree["16"]["BorderSizePixel"] = 0
		Library.Tree["16"]["TextScaled"] = true
		Library.Tree["16"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["16"]["TextXAlignment"] = Enum.TextXAlignment.Left
		Library.Tree["16"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Library.Tree["16"]["TextTransparency"] = 0.4000000059604645
		Library.Tree["16"]["TextSize"] = 30
		Library.Tree["16"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["16"]["Size"] = UDim2.new(0.7991071343421936, 0, 0.13242009282112122, 0)
		Library.Tree["16"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["16"]["Text"] = [[14 Employees Running]]
		Library.Tree["16"]["BackgroundTransparency"] = 1
		Library.Tree["16"]["Position"] = UDim2.new(0.06952013075351715, 0, 0.047513220459222794, 0)

		-- StarterGui.GirraUI.Main.Client.Employee.TextLabel.UITextSizeConstraint
		Library.Tree["17"] = Instance.new("UITextSizeConstraint", Library.Tree["16"])
		Library.Tree["17"]["MaxTextSize"] = 30

		-- StarterGui.GirraUI.Main.Client.Employee.ScrollingFrame
		Library.Tree["18"] = Instance.new("ScrollingFrame", Library.Tree["14"])
		Library.Tree["18"]["Active"] = true
		Library.Tree["18"]["BorderSizePixel"] = 0
		Library.Tree["18"]["BackgroundColor3"] = Color3.fromRGB(35, 35, 35)
		Library.Tree["18"]["AutomaticCanvasSize"] = Enum.AutomaticSize.XY
		Library.Tree["18"]["Size"] = UDim2.new(1, 0, 0.7625570893287659, 0)
		Library.Tree["18"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["18"]["ScrollBarThickness"] = 2
		Library.Tree["18"]["Position"] = UDim2.new(0, 0, 0.23498116433620453, 0)

		-- StarterGui.GirraUI.Main.Client.Employee.ScrollingFrame.UIListLayout
		Library.Tree["1c"] = Instance.new("UIListLayout", Library.Tree["18"])
		Library.Tree["1c"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center
		Library.Tree["1c"]["SortOrder"] = Enum.SortOrder.LayoutOrder
		Library.Tree["1c"].Padding = UDim.new(0.05, 0)
	end
	--> Girra UI => Main => Watermark
	do
		Library.Tree["1d"] = Instance.new("ImageLabel", Library.Tree["2"])
		Library.Tree["1d"]["BorderSizePixel"] = 0
		Library.Tree["1d"]["BackgroundColor3"] = Color3.fromRGB(35, 35, 35)
		Library.Tree["1d"]["Image"] = [[rbxassetid://15458580887]]
		Library.Tree["1d"]["Size"] = UDim2.new(1, 0, 0.11830828338861465, 0)
		Library.Tree["1d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["1d"]["Name"] = [[Watermark]]
	end
	--> Girra UI => Main => Runtime
	do
		Library.Tree["1e"] = Instance.new("CanvasGroup", Library.Tree["2"])
		Library.Tree["1e"]["BorderSizePixel"] = 0
		Library.Tree["1e"]["BackgroundColor3"] = Color3.fromRGB(40, 40, 40)
		Library.Tree["1e"]["Size"] = UDim2.new(0.8327137231826782, 0, 0.03777357563376427, 0)
		Library.Tree["1e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["1e"]["Position"] = UDim2.new(0.08364320546388626, 0, 0.1283082664012909, 0)
		Library.Tree["1e"]["Name"] = [[Runtime]]

		-- StarterGui.GirraUI.Main.Runtime.UICorner
		Library.Tree["1f"] = Instance.new("UICorner", Library.Tree["1e"])

		-- StarterGui.GirraUI.Main.Runtime.Switch1
		Library.Tree["20"] = Instance.new("TextLabel", Library.Tree["1e"])
		Library.Tree["20"]["TextWrapped"] = true
		Library.Tree["20"]["BorderSizePixel"] = 0
		Library.Tree["20"]["TextScaled"] = true
		Library.Tree["20"]["BackgroundColor3"] = Color3.fromRGB(254, 254, 254)
		Library.Tree["20"]["TextSize"] = 25
		Library.Tree["20"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Library.Tree["20"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["20"]["Size"] = UDim2.new(0.5, 0, 1, 0)
		Library.Tree["20"]["Name"] = [[Switch1]]
		Library.Tree["20"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["20"]["Text"] = [[Client]]
		Library.Tree["20"]["TextTransparency"] = 1

		-- Attributes
		Library.Tree["20"]:SetAttribute([[Toggle]], false)

		-- StarterGui.GirraUI.Main.Runtime.Switch1.UIGradient
		Library.Tree["21"] = Instance.new("UIGradient", Library.Tree["20"])
		Library.Tree["21"]["Color"] = ColorSequence.new({
			ColorSequenceKeypoint.new(0.000, Color3.fromRGB(39, 39, 39)),
			ColorSequenceKeypoint.new(1.000, Color3.fromRGB(39, 39, 39)),
		})

		-- StarterGui.GirraUI.Main.Runtime.Switch1.TextLabel
		Library.Tree["22"] = Instance.new("TextLabel", Library.Tree["20"])
		Library.Tree["22"]["TextWrapped"] = true
		Library.Tree["22"]["BorderSizePixel"] = 0
		Library.Tree["22"]["TextScaled"] = true
		Library.Tree["22"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["22"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Library.Tree["22"]["TextSize"] = 14
		Library.Tree["22"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["22"]["Size"] = UDim2.new(1, 0, 1, 0)
		Library.Tree["22"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["22"]["Text"] = [[Client]]
		Library.Tree["22"]["BackgroundTransparency"] = 1

		-- StarterGui.GirraUI.Main.Runtime.Switch1.TextLabel.UITextSizeConstraint
		Library.Tree["23"] = Instance.new("UITextSizeConstraint", Library.Tree["22"])
		Library.Tree["23"]["MaxTextSize"] = 25

		-- StarterGui.GirraUI.Main.Runtime.Switch2
		Library.Tree["24"] = Instance.new("TextLabel", Library.Tree["1e"])
		Library.Tree["24"]["TextWrapped"] = true
		Library.Tree["24"]["BorderSizePixel"] = 0
		Library.Tree["24"]["TextScaled"] = true
		Library.Tree["24"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["24"]["TextSize"] = 25
		Library.Tree["24"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Library.Tree["24"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["24"]["Size"] = UDim2.new(0.5, 0, 1, 0)
		Library.Tree["24"]["Name"] = [[Switch2]]
		Library.Tree["24"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["24"]["Text"] = [[Server]]
		Library.Tree["24"]["Position"] = UDim2.new(0.5, 0, 0, 0)
		Library.Tree["24"]["TextTransparency"] = 1
		-- Attributes
		Library.Tree["24"]:SetAttribute([[Toggle]], false)

		-- StarterGui.GirraUI.Main.Runtime.Switch1.UIGradient
		Library.Tree["Grad"] = Instance.new("UIGradient", Library.Tree["24"])
		Library.Tree["Grad"]["Color"] = ColorSequence.new({
			ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 148, 37)),
			ColorSequenceKeypoint.new(1.000, Color3.fromRGB(255, 77, 52)),
		})

		-- StarterGui.GirraUI.Main.Runtime.Switch1.TextLabel
		Library.Tree["22"] = Instance.new("TextLabel", Library.Tree["24"])
		Library.Tree["22"]["TextWrapped"] = true
		Library.Tree["22"]["BorderSizePixel"] = 0
		Library.Tree["22"]["TextScaled"] = true
		Library.Tree["22"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["22"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Library.Tree["22"]["TextSize"] = 14
		Library.Tree["22"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["22"]["Size"] = UDim2.new(1, 0, 1, 0)
		Library.Tree["22"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["22"]["Text"] = [[Server]]
		Library.Tree["22"]["BackgroundTransparency"] = 1

		-- StarterGui.GirraUI.Main.Runtime.Switch1.UITextSizeConstraint
		Library.Tree["25"] = Instance.new("UITextSizeConstraint", Library.Tree["22"])
		Library.Tree["25"]["MaxTextSize"] = 25
	end

	--> Girra UI => Main => Server
	do
		Library.Tree["26"] = Instance.new("Frame", Library.Tree["2"])
		Library.Tree["26"]["BorderSizePixel"] = 0
		Library.Tree["26"]["BackgroundColor3"] = Color3.fromRGB(47, 47, 47)
		Library.Tree["26"]["BackgroundTransparency"] = 1
		Library.Tree["26"]["Size"] = UDim2.new(1, 0, 0.8170115351676941, 0)
		Library.Tree["26"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["26"]["Position"] = UDim2.new(0, 0, 0.1829884946346283, 0)
		Library.Tree["26"]["Name"] = [[Server]]

		-- StarterGui.GirraUI.Main.Server.TextLabel
		Library.Tree["27"] = Instance.new("TextLabel", Library.Tree["26"])
		Library.Tree["27"]["TextWrapped"] = true
		Library.Tree["27"]["BorderSizePixel"] = 0
		Library.Tree["27"]["TextScaled"] = true
		Library.Tree["27"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["27"]["TextXAlignment"] = Enum.TextXAlignment.Left
		Library.Tree["27"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Library.Tree["27"]["TextTransparency"] = 0.4000000059604645
		Library.Tree["27"]["TextSize"] = 14
		Library.Tree["27"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["27"]["Size"] = UDim2.new(0.8698884844779968, 0, 0.03740648552775383, 0)
		Library.Tree["27"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["27"]["Text"] = [[Jobs]]
		Library.Tree["27"]["BackgroundTransparency"] = 1
		Library.Tree["27"]["Position"] = UDim2.new(0.06505576521158218, 0, 0.10099750757217407, 0)

		-- StarterGui.GirraUI.Main.Server.TextLabel.UITextSizeConstraint
		Library.Tree["28"] = Instance.new("UITextSizeConstraint", Library.Tree["27"])
		Library.Tree["28"]["MaxTextSize"] = 40

		-- StarterGui.GirraUI.Main.Server.UIListLayout
		Library.Tree["29"] = Instance.new("UIListLayout", Library.Tree["26"])
		Library.Tree["29"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center
		Library.Tree["29"]["Padding"] = UDim.new(0.009999999776482582, 0)
		Library.Tree["29"]["SortOrder"] = Enum.SortOrder.LayoutOrder

		-- StarterGui.GirraUI.Main.Server.JobCount
		Library.Tree["2a"] = Instance.new("CanvasGroup", Library.Tree["26"])
		Library.Tree["2a"]["BorderSizePixel"] = 0
		Library.Tree["2a"]["BackgroundColor3"] = Color3.fromRGB(35, 35, 35)
		Library.Tree["2a"]["Size"] = UDim2.new(0.832713782787323, 0, 0.34344813227653503, 0)
		Library.Tree["2a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["2a"]["Position"] = UDim2.new(0.08364296704530716, 0, 0.04740648344159126, 0)
		Library.Tree["2a"]["Name"] = [[JobCount]]

		-- StarterGui.GirraUI.Main.Server.JobCount.UICorner
		Library.Tree["2b"] = Instance.new("UICorner", Library.Tree["2a"])

		-- StarterGui.GirraUI.Main.Server.JobCount.TextLabel
		Library.Tree["2c"] = Instance.new("TextLabel", Library.Tree["2a"])
		Library.Tree["2c"]["TextWrapped"] = true
		Library.Tree["2c"]["BorderSizePixel"] = 0
		Library.Tree["2c"]["TextScaled"] = true
		Library.Tree["2c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["2c"]["TextXAlignment"] = Enum.TextXAlignment.Left
		Library.Tree["2c"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Library.Tree["2c"]["TextTransparency"] = 0.4000000059604645
		Library.Tree["2c"]["TextSize"] = 14
		Library.Tree["2c"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["2c"]["Size"] = UDim2.new(0.6339285969734192, 0, 0.1082959920167923, 0)
		Library.Tree["2c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["2c"]["Text"] = [[14 Jobs Running]]
		Library.Tree["2c"]["BackgroundTransparency"] = 1
		Library.Tree["2c"]["Position"] = UDim2.new(0.06952042132616043, 0, 0.04751328378915787, 0)

		-- StarterGui.GirraUI.Main.Server.JobCount.ScrollingFrame
		Library.Tree["2d"] = Instance.new("ScrollingFrame", Library.Tree["2a"])
		Library.Tree["2d"]["Active"] = true
		Library.Tree["2d"]["BorderSizePixel"] = 0
		Library.Tree["2d"]["BackgroundColor3"] = Color3.fromRGB(35, 35, 35)
		Library.Tree["2d"]["AutomaticCanvasSize"] = Enum.AutomaticSize.XY
		Library.Tree["2d"]["Size"] = UDim2.new(1, 0, 0.7625570893287659, 0)
		Library.Tree["2d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["2d"]["ScrollBarThickness"] = 2
		Library.Tree["2d"]["Position"] = UDim2.new(0, 0, 0.23498116433620453, 0)

		-- StarterGui.GirraUI.Main.Server.JobCount.ScrollingFrame.UIListLayout
		Library.Tree["31"] = Instance.new("UIListLayout", Library.Tree["2d"])
		Library.Tree["31"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center
		Library.Tree["31"]["SortOrder"] = Enum.SortOrder.LayoutOrder
		Library.Tree["31"]["Padding"] = UDim.new(0.05, 0)

		-- StarterGui.GirraUI.Main.Server.TextLabel
		Library.Tree["32"] = Instance.new("TextLabel", Library.Tree["26"])
		Library.Tree["32"]["TextWrapped"] = true
		Library.Tree["32"]["BorderSizePixel"] = 0
		Library.Tree["32"]["TextScaled"] = true
		Library.Tree["32"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["32"]["TextXAlignment"] = Enum.TextXAlignment.Left
		Library.Tree["32"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Library.Tree["32"]["TextTransparency"] = 0.4000000059604645
		Library.Tree["32"]["TextSize"] = 14
		Library.Tree["32"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["32"]["Size"] = UDim2.new(0.8698884844779968, 0, 0.03740648552775383, 0)
		Library.Tree["32"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["32"]["Text"] = [[Employees]]
		Library.Tree["32"]["BackgroundTransparency"] = 1
		Library.Tree["32"]["Position"] = UDim2.new(0.06505576521158218, 0, 0.10099750757217407, 0)

		-- StarterGui.GirraUI.Main.Server.TextLabel.UITextSizeConstraint
		Library.Tree["33"] = Instance.new("UITextSizeConstraint", Library.Tree["32"])
		Library.Tree["33"]["MaxTextSize"] = 40

		-- StarterGui.GirraUI.Main.Server.Employee
		Library.Tree["34"] = Instance.new("CanvasGroup", Library.Tree["26"])
		Library.Tree["34"]["BorderSizePixel"] = 0
		Library.Tree["34"]["BackgroundColor3"] = Color3.fromRGB(35, 35, 35)
		Library.Tree["34"]["Size"] = UDim2.new(0.832713782787323, 0, 0.3817569613456726, 0)
		Library.Tree["34"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["34"]["Position"] = UDim2.new(0.08364296704530716, 0, 0.4482610821723938, 0)
		Library.Tree["34"]["Name"] = [[Employee]]

		-- StarterGui.GirraUI.Main.Server.Employee.UICorner
		Library.Tree["35"] = Instance.new("UICorner", Library.Tree["34"])

		-- StarterGui.GirraUI.Main.Server.Employee.TextLabel
		Library.Tree["36"] = Instance.new("TextLabel", Library.Tree["34"])
		Library.Tree["36"]["TextWrapped"] = true
		Library.Tree["36"]["BorderSizePixel"] = 0
		Library.Tree["36"]["TextScaled"] = true
		Library.Tree["36"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["36"]["TextXAlignment"] = Enum.TextXAlignment.Left
		Library.Tree["36"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Library.Tree["36"]["TextTransparency"] = 0.4000000059604645
		Library.Tree["36"]["TextSize"] = 30
		Library.Tree["36"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Library.Tree["36"]["Size"] = UDim2.new(0.7991071343421936, 0, 0.13242009282112122, 0)
		Library.Tree["36"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["36"]["Text"] = [[14 Employees Running]]
		Library.Tree["36"]["BackgroundTransparency"] = 1
		Library.Tree["36"]["Position"] = UDim2.new(0.06952013075351715, 0, 0.047513220459222794, 0)

		-- StarterGui.GirraUI.Main.Server.Employee.TextLabel.UITextSizeConstraint
		Library.Tree["37"] = Instance.new("UITextSizeConstraint", Library.Tree["36"])
		Library.Tree["37"]["MaxTextSize"] = 30

		-- StarterGui.GirraUI.Main.Server.Employee.ScrollingFrame
		Library.Tree["38"] = Instance.new("ScrollingFrame", Library.Tree["34"])
		Library.Tree["38"]["Active"] = true
		Library.Tree["38"]["BorderSizePixel"] = 0
		Library.Tree["38"]["BackgroundColor3"] = Color3.fromRGB(35, 35, 35)
		Library.Tree["38"]["AutomaticCanvasSize"] = Enum.AutomaticSize.XY
		Library.Tree["38"]["Size"] = UDim2.new(1, 0, 0.7625570893287659, 0)
		Library.Tree["38"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library.Tree["38"]["ScrollBarThickness"] = 2
		Library.Tree["38"]["Position"] = UDim2.new(0, 0, 0.23498116433620453, 0)

		-- StarterGui.GirraUI.Main.Server.Employee.ScrollingFrame.UIListLayout
		Library.Tree["3c"] = Instance.new("UIListLayout", Library.Tree["38"])
		Library.Tree["3c"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center
		Library.Tree["3c"]["SortOrder"] = Enum.SortOrder.LayoutOrder
		Library.Tree["3c"]["Padding"] = UDim.new(0.05, 0)
	end

	Library.Tree["24"].MouseEnter:Connect(function()
		Library.ServerHover = true
	end)

	Library.Tree["24"].MouseLeave:Connect(function()
		Library.ServerHover = false
	end)

	Library.Tree["20"].MouseEnter:Connect(function()
		Library.ClientHover = true
	end)

	Library.Tree["20"].MouseLeave:Connect(function()
		Library.ClientHover = false
	end)

	UserInputService.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			if Library.ServerHover then
				Gui:ChangeSection("Server")
			elseif Library.ClientHover then
				Gui:ChangeSection("Client")
			end
		end

		if
			UserInputService:IsKeyDown(Enum.KeyCode[options.Keycode[1]])
			and UserInputService:IsKeyDown(options.Keycode[2])
		then
			if Library.Tree["1"].Enabled then
				Library.Tree["1"].Enabled = false
			elseif Library.Tree["1"].Enabled == false then
				Library.Tree["1"].Enabled = true
			end
		end
	end)

	return Gui
end

return Library
