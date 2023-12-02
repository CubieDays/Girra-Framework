---selene:strict
local Framework = require(game.ReplicatedStorage.Girra):GetServer()

--[[ AI Note: [[
	This is a framework uses job and employ structure job runs like a service employ does one operation
]]

--> Creating Job On Framework
local MyJob = Framework.CreateJob()({
	Name = "MyJob",
})

--> Employes:
local Employ

--> Job Functions
function MyJob:OnStep() end

function MyJob:OnInit()
	Employ = MyJob.Hire("Employ")
end

function MyJob:OnStart()
	--> Actions
	Employ.Work()

	print(MyJob.Employes)

	task.wait(4)

	MyJob.Fire("Employ")

	print(MyJob.Employes)
end

return MyJob
