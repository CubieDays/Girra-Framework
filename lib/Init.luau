--> Varibles
local Framework = script --> Framework Folder
local Utilities = Framework.Utils --> Utilities Folder

local Runtime = Utilities.Runtime --> Runtime Folder
local Context = require(Runtime.Context) --> Context Module Contains RunServer Runtimes

--> Tables:
--[=[
	@class GirraFramework
	The Main Framework contains both ( Replicated, Server, Client ) Sides
]=]

local GirraFramework = {} --> Framework

if not Context.RuntimeContext.StudioPlay and Context.RuntimeContext.Client then --> Checking if the Runtime is client
	if Framework:FindFirstChild("Server") then
		Framework.Server:Destroy() --> Destroying Secured Folder
	end
end

--[=[
	@return GirraClient
	@client
	```lua
	local Gira = require(game.ReplicatedStorage.Gira):GetClient()
	```
]=]
function GirraFramework:GetClient() --> Gets The Client-Side of The Framework for Intellisense purposes
	if Context.RuntimeContext.Client then
		return require(Framework.Client) --> Returns the Client-Side Framework
	else
		error("[ Girra ]: Current runtime is Server!", 0) --> Errors and fails
	end
end

--[=[
	@return GirraServer
	@server
	```lua
	local Gira = require(game.ReplicatedStorage.Gira):GetServer()
	```
]=]
function GirraFramework:GetServer() --> Gets The Server-Side Of The Framework
	if Context.RuntimeContext.Server then --> Returns the Server-Side of The Framework for Intellisense purposes.
		return require(Framework.Server)
	else
		error("[ Girra ]: Current runtime is Client!", 0) --> Errors and fails
	end
end

function GirraFramework:GetReplicated() --> Gets The Replicated-Side Of The Framework
	return {} --> Returns the Replicated-Side Of The Framework
end
--[=[
	@return GirraServer
	@server

	Allias for Girra:GetServer()
]=]
function GirraFramework:GetFrameworkServer() --> Allias to GetServer()
	return GirraFramework:GetServer() --> Returns the Server-Side of The Framework for Intellisense purposes.
end

--[=[
	@return GirraClient
	@client
	
	Allias for Girra:GetClient()
]=]
function GirraFramework:GetFrameworkClient() --> Allias to GetClient()
	return GirraFramework:GetClient() --> Returns the Client-Side Framework
end

function GirraFramework:GetFrameworkReplicated() --> Allias to GetReplicated()
	return GirraFramework:GetReplicated() --> Returns the Replicated-Side Of The Framework
end

return table.freeze(GirraFramework) --> Returns secured frozen table of the Framework
