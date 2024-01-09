--> RunService
local RunService = game:GetService("RunService")

--> Properties:
return table.freeze({
	RuntimeContext = {
		Studio = RunService:IsStudio(),
		Server = RunService:IsServer(),
		Client = RunService:IsClient(),
		StudioPlay = RunService:IsStudio() and RunService:IsRunning(),
	},
})
