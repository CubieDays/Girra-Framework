local Framework = require(game.ReplicatedStorage.Girra):GetServer()

Framework.OnStart(function()
	print("[ Girra Server ]: Started Successfully!")
	print("==============================================")
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
