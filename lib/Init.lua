--> Varibles
local Resources = script.Resources --> Resources Folder
local Utilities = Resources.Utils --> Utilities Folder

local Runtime = Utilities.Runtime --> Runtime Folder
local Context = require(Runtime.Context) --> Context Module Contains RunServer Runtimes

--> Tables:
--[=[
	@class GirraFramework
	The Main Framework contains both ( Replicated, Server, Client ) Sides
]=]

local GirraFramework = {} --> Framework

if Context.RuntimeContext.Client and not Context.RuntimeContext.IsStudio then --> Checking if the Runtime is client
	if Resources:FindFirstChild("Secure") then
		Resources.Secure:Destroy() --> Destroying Secured Folder
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
		return require(Resources.Client) --> --> Returns the Client-Side Framework
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
		return require(Resources.Secure.Server)
	end
end

function GirraFramework:GetReplicated() --> Gets The Replicated-Side Of The Framework
	return {} --> Returns the Replicated-Side Of The Framework for Intellisense purposes.
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
	return GirraFramework:GetReplicated() --> Returns the Replicated-Side Of The Framework for Intellisense purposes.
end

return table.freeze(GirraFramework) --> Returns secured frozen table of the Framework
