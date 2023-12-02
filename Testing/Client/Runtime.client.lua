local Framework = require(game.ReplicatedStorage.Girra):GetClient()

Framework.OnStart(function()
	print("[ Girra Server ]: Started Successfully!")
end)

Framework.Start(script.Parent)({
	Debugging = {
		InStudioDebugging = {
			JobDebugging = true,
			NetworkDebugging = true,
			SignalDebugging = true,
		},
		InGameDebugging = {
			JobDebugging = false,
			NetworkDebugging = true,
			SignalDebugging = true,
		},
	},
}):Await()
