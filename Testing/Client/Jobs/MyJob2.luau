--@typecheck mode strict
local Framework = require(game.ReplicatedStorage.Girra):GetClient()

--[[ AI Note: [[
	This is a framework uses job and employ structure job runs like a service employ does one operation
]]

--> Creating Job On Framework
local MyJob2 = Framework.CreateJob()({
	Name = "MyJob2",
})

--> Employes:

--> Job Functions
function MyJob2:OnStep() end

function MyJob2:OnInit() end

function MyJob2:OnStart()
	local Signal = Framework.GetSignal("MySignal")
	local Job1 = Framework.GetJob("MyJob")

	print("==========Job2 Signal Communication===========")
	Signal:Fire("Signal Says: Hello World!")
	print("=========Job2 Function Communication==========")
	Job1:Print({ "Hello", "World!" })
	print("==============================================")
end

function MyJob2:DoSomething()
	print("Hello Job1 you are nice!")
end

return MyJob2
