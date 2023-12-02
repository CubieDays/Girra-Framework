--> Runtime
local Runtime = {}

--> Properties
Runtime.RuntimeSettings = {
	Debugging = {
		InStudioDebugging = {
			JobDebugging = true,
			NetworkDebugging = false,
			SignalDebugging = false,
		},
		InGameDebugging = {
			JobDebugging = false,
			NetworkDebugging = false,
			SignalDebugging = false,
		},
	},
}

return Runtime
