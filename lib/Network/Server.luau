--> Moonwave:
--> Class
--[=[
	@class Server
	@server
	The Network Server Index for NetworkClass

	Getting Network Server Class
	```lua
	Network.Server("NetworkClass")
	```
]=]

--> Folders
local Framework = script.Parent.Parent

--> Packages:
local BridgeNet2 = require(script.Parent.Network.bridgenet2)
local Debugger = require(Framework.Utils.Debugger)

type Players = {
	[any]: Player,
}

local Server = {}
Server.__index = Server

--[=[
	@param Player Player | {Player}
	@param Content any
	Fires the network class
]=]

function Server:Fire(Player: Player | Players, Content: any)
	local TableContent = Content
	Debugger.InternalDebug(
		print,
		"Network",
		"Girra Server",
		`Fired Network: {self._name} on server to player: {Player} with data:`,
		Content
	)

	if typeof(Content) == "table" then
		TableContent = {}
		for Index, Value in Content do
			if self._identifier then
				TableContent[BridgeNet2.ReferenceIdentifier(Index)] = Value
			else
				TableContent[Index] = Value
			end
		end
	end

	if typeof(Player) == "Instance" then
		self._class:Fire(Player, TableContent)
	else
		self._class:Fire(BridgeNet2.Players(Player), TableContent)
	end
end

--[=[
	@param Content any
	Fires the network class to all players
]=]
function Server:FireAll(Content: any)
	local TableContent = Content
	Debugger.InternalDebug(
		print,
		"Network",
		"Girra Server",
		`Fired Network: {self._name} on server to All Players with data:`,
		Content
	)

	if typeof(Content) == "table" then
		TableContent = {}
		for Index, Value in Content do
			if self._identifier then
				TableContent[BridgeNet2.ReferenceIdentifier(Index)] = Value
			else
				TableContent[Index] = Value
			end
		end
	end

	return self._class:Fire(BridgeNet2.AllPlayers(), TableContent)
end

--[=[
	@param Players {Player}
	@param Content any
	Fires the network class to players except the ones in the table
]=]
function Server:FireExcept(Players: Players, Content: any)
	local TableContent = Content
	Debugger.InternalDebug(
		print,
		"Network",
		"Girra Server",
		`Fired Network: {self._name} on server to all players except: {Players} with data:`,
		Content
	)

	if typeof(Content) == "table" then
		TableContent = {}
		for Index, Value in Content do
			if self._identifier then
				TableContent[BridgeNet2.ReferenceIdentifier(Index)] = Value
			else
				TableContent[Index] = Value
			end
		end
	end

	return self._class:Fire(BridgeNet2.PlayersExcept(Players), TableContent)
end

--[=[
	Waits for the next fire
]=]
function Server:Wait()
	return self._class:Wait()
end

--[=[
	@param Callback (Content: any)
	Listens to a callback
]=]
function Server:Listen(Callback: (Receiver: Player, Content: any) -> ())
	return self._class:Connect(Callback)
end

--[=[
	@param Callback (Content: any)
	Listens once to the callback
]=]
function Server:Once(Callback: (Receiver: Player, Content: any) -> ())
	return self._class:Once(Callback)
end

return Server
