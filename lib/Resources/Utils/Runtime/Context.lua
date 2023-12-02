--> RunService
local RunService = game:GetService("RunService")

--> Runtime
local Runtime = {}

--> Properties
Runtime.RuntimeContext = {
	Studio = RunService:IsStudio(),
	Server = RunService:IsServer(),
	Client = RunService:IsClient(),
	StudioPlay = RunService:IsStudio() and RunService:IsRunning(),
}

return table.freeze(Runtime)
