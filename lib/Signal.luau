--> Class
--[=[
	@class Signal
	The Signal Implementation for Girra

	Getting Girra Signal Class
	```lua
	local Signal = Girra.Libs.Signal
	local signalClass = Signal()
	```
]=]

--> Signal Types:
export type Signal = {
	Fire: (self: any, Content: any) -> (), --> Fire function
	DisconnectAll: (self: any) -> (), --> Disconnect function
	Listen: (self: any, Callback: (Content: any) -> ()) -> { Disconnect: () -> () }, --> Connect function
	ListenOnce: (self: any, Callback: (Content: any) -> { Disconnect: () -> () }) -> (), --> Connect once function
} --> Signal Type Exportation

local Framework = script.Parent --> Framework Varible
local Packages = Framework.Parent --> Packages which isa descendantof replicatedStorage

local Debugger = require(Framework.Utils.Debugger)
local Context = require(Framework.Utils.Runtime.Context).RuntimeContext
local signal = require(Packages.Signal) --> Signal Implemntation ( Good Signal )

local Signal = {} --> Index
local Signals = {}
Signal.__index = Signal --> Index Metatable

--> Signal Functions:
--[=[
	Fires Signal Class
]=]
function Signal:Fire(Content: any) --> Fire Function
	if self.Name then
		if Context.Client then
			Debugger.InternalDebug(print, "Signal", "Girra Client", `Fired Signal: {self.Name} With Data: \n`, Content)
		elseif Context.Server then
			Debugger.InternalDebug(print, "Signal", "Girra Server", `Fired Signal: {self.Name} With Data: \n`, Content)
		end
	end

	return self._signal:Fire(if typeof(Content) == "table" then table.unpack(Content) else Content) --> Fires to signal
end
--[=[
	@param ... any
	Fires signal Class but with tuples not tables
]=]
function Signal:FireTuple(...: any) --> Fire Function
	return self._signal:Fire(...) --> Fires to signal
end
--[=[
	Destroys and disconnects signal Class 
]=]
function Signal:DisconnectAll() --> Disconnects all
	if self.Name then
		if Context.Client then
			Debugger.InternalDebug(
				print,
				"Signal",
				"Girra Client",
				`Signal: {self.Name} Disconnected From All Connections`
			)
		elseif Context.Server then
			Debugger.InternalDebug(
				print,
				"Signal",
				"Girra Server",
				`Signal: {self.Name} Disconnected From All Connections`
			)
		end
	end

	return self._signal:DisconnectAll() --> Disconnect all to signature
end
--[=[
	Listens to a function callback
]=]
function Signal:Listen(Callback: (Content: any, ...any) -> ()) --> Listen to a callback
	if self.Name then
		if Context.Client then
			Debugger.InternalDebug(print, "Signal", "Girra Client", `Signal: {self.Name} Listened To Function`)
		elseif Context.Server then
			Debugger.InternalDebug(print, "Signal", "Girra Server", `Signal: {self.Name} Listened To Function`)
		end
	end

	return self._signal:Connect(Callback) --> Connects to it
end
--[=[
	Listens to a function callback andThen disconnects
]=]
function Signal:ListenOnce(Callback: (Content: any) -> ()) --> Listen only once for callback
	if self.Name then
		if Context.Client then
			Debugger.InternalDebug(print, "Signal", "Girra Client", `Signal: {self.Name} Listened Once To Function`)
		elseif Context.Server then
			Debugger.InternalDebug(print, "Signal", "Girra Server", `Signal: {self.Name} Listened Once To Function`)
		end
	end

	return self._signal:Once(Callback) --> Returns once function
end

return function(Name: string?, Type: string?) --> Return function
	if Type == "Get" then --> Get Signal method
		return Signals[Name] :: Signal --> Returns Signal
	end

	local self = setmetatable({}, Signal) --> Sets self؛
	self._signal = signal.new() --> Adds metatable

	if Type == "Create" then --> Creates Signal
		if Name then
			assert(not Signals[Name], "Signal " .. Name .. " Already Exists!")
			Signals[Name] = self --> CreateSignl Method
			self.Name = Name
		end
	end

	return self :: Signal --> Returns self
end
