local Framework = require(game.ReplicatedStorage.Girra):GetClient()

Framework.OnStart(function()
	print("[ Girra Client ]: Started Successfully!")
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
	Admins = { game.CreatorId },
}):Await()
