--> Moonwave:
--> Class
--[=[
	@class Client
	@client
	The Network Client Index for NetworkClass

	Getting Network Client Class
	```lua
	Network.Client("NetworkClass")
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

local Client = {}
Client.__index = Client

--[=[
	@param Content any
	Fires the network class
]=]
function Client:Fire(Content: any)
	local TableContent = Content
	Debugger.InternalDebug(
		print,
		"Network",
		"Girra Client",
		`Fired Network: {self._name} on client to server with data:`,
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

	return self._class:Fire(Content)
end

--[=[
	@param Callback (Content: any)
	Listens to a callback
]=]
function Client:Listen(Callback: (Content: any) -> ())
	return self._class:Connect(Callback)
end

--[=[
	@param Callback (Content: any)
	Listens once to the callback
]=]
function Client:Once(Callback: (Content: any) -> ())
	return self._class:Once(Callback)
end

--[=[
	@param Content Content: any
	Invokes to a OnServerInvoke function
	:::tip
	To make a serverinvoke funciton do:
	ServerIndex.OnServerInvoke = function(content) end)
	:::
]=]
function Client:Invoke(Content: any)
	Debugger.InternalDebug(
		print,
		"Network",
		"Girra Client",
		`Invoked Network: {self._name} on client to server with data: \n`,
		Content
	)

	return self._class:InvokeServerAsync(Content)
end

--[=[
	Waits for the next fire
]=]
function Client:Wait()
	return self._class:Wait()
end

return Client
