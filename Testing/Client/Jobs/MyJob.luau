--@typecheck mode strict
local Framework = require(game.ReplicatedStorage.Girra):GetClient()

--[[ AI Note: [[
	This is a framework uses job and employ structure job runs like a service employ does one operation
]]

--> Creating Job On Framework
local MyJob = Framework.CreateJob()({
	Name = "MyJob",
})

--> Employes:

--> Job Functions
function MyJob:OnStep() end

function MyJob:OnInit()
	print("===========Job Signal Communication===========")
	local MySignal = Framework.CreateSignal("MySignal")
	MySignal:Listen(function(Data)
		print(Data)
	end)

	print("==========Job Function Communication==========")
	local Job2 = Framework.GetJob("MyJob2")
	Job2:DoSomething()
	print("==============Employ Work & Hire==============")
	local Employee = MyJob.Hire("Employee")
	Employee.Work()
	print("================Client Network================")
	local Network = Framework.GetNetwork("MyNetwork")

	Network:Fire({
		DataSend = "Success",
	})

	print("==============================================")
end

function MyJob:OnStart() end

function MyJob:Print(T: { any })
	print(table.unpack(T))
end

return MyJob
