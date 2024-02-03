--> Moonwave:
--> Class
--[=[
	@class Network
	The NetworkClass Container for GirraFramework
	It uses BridgeNet2 Network System whichis effecient and cool.

	Creating NetworkClass on Server
	```lua
	Network.Server("NetworkClass")
	```
	Getting NetworkClass on Client
	```lua
	Network.Client("NetworkClass")
	```
]=]

export type Server<T> = {
	Fire: (self: Server<T>, Receiver: Player | Players, Content: { T } | T) -> (), --> Fire Function Fires to Specific Player
	FireAll: (self: Server<T>, Content: { T } | T) -> (), --> FireAll Function Fires to All Players
	Listen: (self: Server<T>, Callback: (Receiver: Player?, Content: { T } | T) -> ()) -> { Disconnect: () -> () }, --> Listen to the network
	Once: (self: Server<T>, Callback: (Receiver: Player?, Content: { T } | T) -> ()) -> (), --> Listen to the network 1 time and disconnect
	FireExcept: (self: Server<T>, Players: Players, Content: { T } | T) -> (), --> FireExcept Fire to all players except one
	Wait: (self: Server<T>) -> (), --> Waiting Network fire signal
	OnServerInvoke: ((player: Player, Content: { T } | T) -> ...any)?,
	RateLimitActive: boolean,
} --> Network

export type Client<T> = {
	Fire: (self: Client<T>, Content: { T } | T) -> (), --> Fire Function Fires to server
	Listen: (self: Client<T>, Callback: (Content: { T } | T) -> ()) -> { Disconnect: () -> () }, --> Listen to the network
	Once: (self: Client<T>, Callback: (Content: { T } | T) -> ()) -> (), --> Listen to the network 1 time and disconnect
	Invoke: (self: Client<T>, Timeout: number, Content: { T } | T) -> (), --> Invoke Function Invokes to server
	Wait: (self: Client<T>) -> (), --> Waits amount of time
} --> Network

type Players = {
	[any]: Player,
}

--> Local Tables:
local Network = {}

--> Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--> Folders
local Framework = script.Parent
local Packages = ReplicatedStorage:FindFirstChild("Packages") or ReplicatedStorage.Girra.Packages
local WallyIndex = Packages._Index

--> Disable Debugging on Output:
local Output = require(WallyIndex["ffrostflame_bridgenet2@1.0.0"].bridgenet2.Utilities.Output)

Output.silent = function() end

Output.log = function() end

--> Packages:
local BridgeNet2 = require(Framework.Parent.Bridge)
local Debugger = require(Framework.Utils.Debugger)

--> Indexes
local ServerIndex = require(script.Server)
local ClientIndex = require(script.Client)

--> Local Functions:

--[=[
	@return Identifier
	Returns an Identifier.
]=]
function Network.ReferenceIdentifier(Name: string): string
	return BridgeNet2.ReferenceIdentifier(Name) :: string
end

--[=[
	@return ServerIndex
	Returns a server network class.
]=]
function Network.Server(Name: string, AutoIdentifier: boolean): Server<any>
	local Bridge = BridgeNet2.ServerBridge(Name)
	Debugger.InternalDebug(print, "Network", "Girra Server", `Created Network: {Name} On Server!`)

	return setmetatable({
		_class = Bridge,
		_name = Name,
		_identifier = AutoIdentifier,
		OnServerInvoke = Bridge.OnServerInvoke,
		RateLimitActive = Bridge.RateLimitActive,
	}, ServerIndex)
end

--[=[
	@return ClientIndex
	Returns a client network class.
]=]
function Network.Client(Name: string, AutoIdentifier: boolean): Client<any>?
	local Bridge = BridgeNet2.ClientBridge(Name)
	Debugger.InternalDebug(print, "Network", "Girra Client", `Got Network: {Name} On Client!`)

	return setmetatable({
		_class = Bridge,
		_name = Name,
		_identifier = AutoIdentifier,
	}, ClientIndex)
end

return Network
