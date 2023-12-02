--> Moonwave:
--> Class
--[=[
	@class GirraServer
	@server
	The Server-Side Of Girra Let's you Create Server Networks and Signals and Jobs.

	Getting Girra Server:
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetServer()

	--> Starting Girra:
	Girra.Start(0) {
		Debugging = {
			InGameDebugging = {
				JobDebugging = false,
				NetworkDebugging = false,
				SignalDebugging = false
			};	
			InStudioDebugging = {
				JobDebugging = true,
				NetworkDebugging = true,
				SignalDebugging = true,
			}
		}
	}
	
	--> 0 Means The Default Jobs Folder Location: game.ServerScriptService.Jobs
	```
]=]

--> Types:
--[=[ 
	@type Debugging {InGameDebugging: {JobDebugging: boolean, SignalDebugging: boolean, NetworkDebugging: boolean}, InStudioDebugging: {JobDebugging: boolean, SignalDebugging: boolean, NetworkDebugging: boolean}}
	@within GirraServer
	Debugging Settings
]=]

--[=[
	@type Settings {Debugging: Debugging}
	:::note Used by Girra.Start()
	This Type Is used for Girra.Start() Function
	:::

	@within GirraServer
		
]=]

--> Interfaces:
--[=[
	@interface Job
	@within GirraServer
	.Name string; 
	.OnInit () -> ()
	.OnStart () -> ()
	.OnStep (deltaTime: number) -> ()
	.Heartbeat (deltaTime: number) -> () 
	.Fire (Name: string) -> ()
	.Hire (Name: string) -> HiredEmploy
	.Employes { [any]: { Work: () } }

	Class Job of GirraServer Which Is Module.
]=]

--[=[
	@interface HiredEmploy
	@within GirraServer
	.Job: Job
	.Work ()

	Class Employ of GirraServer Which Is Module.
]=]

--[=[
	@interface Employ
	@within GirraServer
	.Name string; 
	.OnWork (self: any) 
	.OnHire (self: any)

	Class Employ of GirraServer Which Is Module.
]=]

--[=[
	@interface Network
	@within GirraServer
	.Fire (Player, any) -> ()
	.FireAll (any: any) -> ()
	.Listen (Player: Player, any) -> ()
	.Connect (Player: Player, any) -> ()
	.Once (Player: Player, any) -> ()
	.Invoke (timeout: number, Player: Player, any) -> ()
	.InvokeAll (timeout: number, any) -> ()
	.InvokeExcept (Players: {Player: Player}, timeout: number, any) -> ()
	.FireExcept (Players: {Player: Player}, any) -> ()
	.IsListening () -> boolean,
	.Connected: boolean
	.Disconnect () -> ()
	.Destroy () -> ()

	Type Network of GirraServer Which IsA Network Object.
]=]

--[=[
	@interface Signal
	@within GirraServer
	.IsActive () -> boolean,
	.Connect (Callback: (...any) -> ()) -> RBXScriptConnection,
	.Listen (Callback: (...any) -> ()) -> RBXScriptConnection,
	.Once (Callback: (...any) -> ()) -> RBXScriptConnection,
	.Wait () -> (...any),
	.Fire (...any) -> (),
	.DisconnectAll () -> (),
	.Destroy () -> (),
	.Disconnect () -> ()
	
	Type Signal of GirraServer Which IsA Signal Object: Signal.new().
]=]

--[=[
	@interface Services
	@within GirraServer
	.Players Players 
	.UserInputService UserInputService 
	.RunService RunService 
	.ReplicatedStorage ReplicatedStorage
	.Workspace Workspace 

	Type Services of GirraServer Which IsA Table Contains Game-Services.
]=]

--> Properties:
--[=[
	@prop Services Services
	@within GirraServer
	@readonly

	Refrence to Used Game Services example:
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetServer()
	local Services = Girra.Services

	--> InputBegan Function:
	Services.UserInputService.InputBegan:Connect(function()

	end)
	```
]=]
--!strict
local GirraServer = {}

type GirraServer = typeof(GirraServer)

--> Types:
type Job = {
	Name: string, --> Job Name
	OnInit: (self: any) -> (), --> Job Function OnInit
	OnStart: (self: any) -> (), --> Job Function OnStart
	OnStep: (self: any, ...any) -> (), --> Job Function OnStep
	Heartbeat: (self: any, ...any) -> (), --> Job Function Heartbeat
} --> Default Job

type JobPrivateDef = {
	Name: string, --> Job Name
	Employes: { --> Employes
		[any]: { --> Any EmployType
			Cleanup: () -> (), --> Cleanup Function
			Work: () -> (), --> Work Function
		},
	}, --> Private Employes
	Hire: (Name: string) -> InternalEmployDef?, --> Private Function Hire
	Fire: (Name: string) -> (), --> Fires The Job
	OnInit: (self: GirraServer) -> (),
} --> Default Job

type Employ = {
	Name: string, --> Employ Name
	OnWork: (self: any) -> (), --> Employ OnWork Function
	OnHire: (self: any) -> (), --> Employ OnHire Function
}

type PrivateEmployDef = {
	Name: string, -- Employ Name
	Hired: any, --> Hired Event
	Worked: any, -- Worked Event
	Job: Job, --> Employ Job Work AT
	OnWork: (any) -> (), --> OnWork Function
	OnHire: (any) -> () -> (), --> OnHire Function
	Work: () -> (), --> Work Function
}

type InternalEmployDef = {
	Job: Job, --> Work At
	Work: () -> (), --> Work Function
}

type Settings = {
	Debugging: {
		InGameDebugging: {
			JobDebugging: boolean, --> Debugging Job Initallize and Start
			SignalDebugging: boolean, --> Network Debugging Fire and Disconnect and Destroy
			NetworkDebugging: boolean, --> Signal Debugging Fire And Disconnect and Destroy
		},
		InStudioDebugging: {
			JobDebugging: boolean, --> Debugging Job Initallize and Start
			SignalDebugging: boolean, --> Network Debugging Fire and Disconnect and Destroy
			NetworkDebugging: boolean, --> Signal Debugging Fire And Disconnect and Destroy
		},
	}, --> Debugging
} --> Settings for Girra Framework

type Network = {
	Fire: (self: any, Player, any) -> (), --> Fire Function Fires to Specific Player
	FireAll: (self: any, any) -> (), --> FireAll Function Fires to All Players
	Listen: (self: any, callback: (Player: Player, ...any) -> ()) -> (), --> Listen to the network
	Connect: (self: any, callback: (Player: Player, ...any) -> ()) -> (), --> Listen to the Network ( Alias )
	Once: (self: any, callback: (Player: Player, ...any) -> ()) -> (), --> Listen to the network 1 time and disconnect
	Invoke: (self: any, timeout: number, Player: Player, any: any) -> (), --> Invoke Function Invokes to client
	InvokeAll: (self: any, timeout: number, any: any) -> (), --> Invokes to all
	InvokeExcept: (self: any, { Player: Player }, timeout: number, any: any) -> (), --> Invokes to All Except one player
	FireExcept: (self: any, { Player: Player }, any: any) -> (), --> FireExcept Fire to all players except one
	IsListening: (self: any) -> boolean,
	Connected: boolean,
	Disconnect: (self: any) -> (),
	Destroy: (self: any) -> (),
} --> Network

type Signal = {
	IsActive: (self: any) -> boolean, --> Returns if the signal is active
	Connect: (self: any, Callback: (...any) -> ()) -> RBXScriptConnection, --> Allias for Listen
	Listen: (self: any, Callback: (...any) -> ()) -> RBXScriptConnection, --> Connects to a function
	Once: (self: any, Callback: (...any) -> ()) -> RBXScriptConnection, --> Connects 1 time and then disconnects itself
	Wait: (self: any) -> ...any, --> Wait until the Signal Fires
	Fire: (self: any, ...any) -> (), --> Fires the Signal to all Connections
	DisconnectAll: (self: any) -> (), --> Disconnect All Signal Connections
	Destroy: (self: any) -> (), --> Destroys the Signal
} --> Signal Connection

type Services = {
	Players: Players, --> Players: Game.Players
	UserInputService: UserInputService, --> UserInputService: Game.UserInputService
	RunService: RunService, --> RunService: Game.RunService
	ReplicatedStorage: ReplicatedStorage, --> ReplicatedStorage: Game.ReplicatedStorage
	ServerStorage: ServerStorage, --> ServerStorage: Game.ServerStorage
	Workspace: Workspace, --> Workspace: Game.Workspace
} --> Services Type

--> Services:
local ServerScriptService = game:GetService("ServerScriptService")

--> Class:

--> Properties:
GirraServer.Services = {
	Players = game:GetService("Players"), --> Players: Game.Players
	UserInputService = game:GetService("UserInputService"), --> UserInputService: Game.UserInputService
	RunService = game:GetService("RunService"), --> RunService: Game.RunService
	ReplicatedStorage = game:GetService("ReplicatedStorage"), --> ReplicatedStorage: Game.ReplicatedStorage
	ServerStorage = game:GetService("ServerStorage"), --> ServerStorage: Game.ServerStorage
	Workspace = game:GetService("Workspace"), --> Workspace: Game.Workspace
} :: Services --> Game Services

--> Tables:
local Messages = {
	Started = "[ Girra Server ]: Framework Already Started!",
	NilFolder = "Forgot Argument 1 of Function: GirraServer.Start(), Must be an Instance!",
	ErrorPrefix = "GirraServer Error",
	InitallizeSuccess = "Successfully Initiallized Job In:",
	NoStartupJob = "Is only used by other Jobs or nothing!",
	CreateJobDiag = "AddJobs Is For Intellisense, Regular .Start() and manual use of .CreateJob is flexable but AddJobs is good for intellisense and code function triggering",
	LoadFunctionMessage = "An Error occoured ErrorMsg: \n",
	InternalError = "An Internal Error Happend Contact With The Developer Send Him This Code: \n",
	InitMsg = "Unable to Continue [ Given Location Is Nil or Does not contain Folders: [ Jobs, Employes ]",
}
local Locations = {
	DefaultLocation = ServerScriptService,
}

local Debugging = {}
local Settings: Settings = {
	Debugging = {
		InGameDebugging = {
			JobDebugging = false,
			SignalDebugging = false,
			NetworkDebugging = false,
		},
		InStudioDebugging = {
			JobDebugging = true,
			SignalDebugging = true,
			NetworkDebugging = true,
		},
	},
}

--> Data:
local Jobs: { [any]: any } = {}
local Employes = {}

--> Local Properties:
local Started = false

--> Getting Folders:
local Framework = script.Parent.Parent.Parent
local Libraries = Framework.Libraries
local Utilities = script.Parent.Parent.Utils

--> Packages:
local Packages = Framework.Parent
local Signal = require(Packages.Signal)
local Promise = require(Packages.Promise)
local Network = require(Packages.Network)

--> Utilities:
local Context = require(Utilities.Runtime.Context)
local Debugger = require(Utilities.Debugger)
local Runtime = require(Utilities.Runtime.Settings)

--> Runtime Actions:
Runtime.RuntimeSettings = Settings

--> Modules:
local Modules = script.Modules

--> Requiring Modules
local Initter = {
	Employ = require(Modules.EmpInit),
	Job = require(Modules.JobInit),
}

--> Signals:
local Start = Signal.new()

--> Library
GirraServer.Libs = {
	["Signal"] = Signal,
	["Promise"] = Promise,
}

--> Local Functions:
local function InitJobs() --> Job Initter Method
	for _, Job: Job in Jobs do --> Looping Through Jobs
		if Job.OnInit then --> Checking if The OnInit Function Exists
			task.spawn(function() --> Asynchoraize
				Job:OnInit() --> Spawning OnInit() Function.
			end)
		else
			Debugging[Job.Name] = {} --> Making Debug Table
			Debugging[Job.Name].NoInit = true --> Setting No Init To True
		end
	end
end

--> FireExcept:
local function FireExcept(NetClass: Network, Except: { User: Player }, ...: any) --> Fires to all players except one
	for _, Player in GirraServer.Services.Players:GetPlayers() do --> Loops through Player
		if Except[Player] == nil then --> Checks if player is not in the blacklist table
			NetClass:Fire(Player, ...) --> Fires Network
		end
	end
end

--> Job Stepped Connection:
local function StepJobs() --> Job Stepped Connection:
	task.wait()

	for _, Job: Job in Jobs do --> Looping Through Jobs
		if Job.OnStep then --> Checking If OnStep Function Exists
			GirraServer.Services.RunService.Stepped:Connect(
				function(...) --> Running The Connection: RunService.Stepped With (any)
					Job:OnStep(...) --> Spawning OnStep(...) Function
				end
			)
		else
			Debugging[Job.Name] = {} :: any --> Making Debug Table
			Debugging[Job.Name].NoStep = true --> Setting No Init To True
		end
	end
end
--> Job Heartbeat Connection:
local function HeartbeatJobs() --> Job Heartbeat Connection:
	task.wait()

	for _, Job in Jobs do --> Looping Through Jobs
		if Job.Heartbeat then --> Checking If Heartbeat Function Exists
			GirraServer.Services.RunService.Heartbeat:Connect(
				function(...) --> Running The Connection: RunService.Heartbeat With (any)
					Job:Heartbeat(...) --> Spawning Heartbeat(...) Function
				end
			)
		else
			Debugging[Job.Name] = { NoHeart = true } :: any --> Making Debug Table Setting NoHeart To: True
		end
	end
end

--> Default Error Catcher Output Message:
local function catchError(err) --> Default Catching
	Debugger.Debug(warn, { "\n", err }, Messages.ErrorPrefix) --> Warning
end

--> Job Start Function:
local function StartJob(Job: Job) --> Job Start Function
	--> Creating The Promise:
	Promise
		.new(function()
			Job:OnStart() --> Starting The Job
		end)
		--> Catching:
		:Catch(catchError) --> Catchs Errors
end

--> Start All Jobs Function:
local function StartJobs() --> Start All Jobs Function
	task.wait()

	for _, Job in Jobs do --> Looping Through
		if Job.OnStart then --> Checking If OnStart Function Exists
			StartJob(Job) --> Spawning OnStart() Function
		else
			Debugging[Job.Name] = {} :: any --> Making Debug Table
			Debugging[Job.Name].NoStart = true --> Setting NoStart To: True
		end
	end
end

--> Debug Function
local function DebugCheck(Job: Job, First: number, Last: number) --> Debug Function
	Debugger.Debug(print, { Messages.InitallizeSuccess, tostring(math.ceil(Last - First)) .. "ms" }, Job.Name) --> Debug and prints that the Job Exists

	if Debugging[Job.Name] and Debugging[Job.Name].NoInit and Debugging[Job.Name].NoStart then --> Checks if the debug is not used by the GirraServer
		Debugger.Debug(warn, { Messages.NoStartupJob }, Job.Name) --> Only Useable GirraServer
	end
end

local function Debug(Job: any, T)
	task.wait()

	--> Settings:
	if Settings.Debugging then --> If Debugging is enabled
		if Settings.Debugging.InGameDebugging and Context.RuntimeContext.Server then --> If InGameDebugging Is Enabled
			if Settings.Debugging.InGameDebugging.JobDebugging then --> If JobDebugging Is true.
				DebugCheck(Job, T, tick()) --> Spawn Debugging Function
			end
		end

		if Settings.Debugging.InStudioDebugging and Context.RuntimeContext.Studio then
			if
				Settings.Debugging.InStudioDebugging.JobDebugging
				and (not Settings.Debugging.InGameDebugging or not Settings.Debugging.InGameDebugging.JobDebugging)
			then --> If JobDebugging is enabled
				DebugCheck(Job, T, tick()) --> Spawns Debugging Function
			end
		end
		--> Settings
	end
end

local function TableCheck(Tab)
	if typeof(Tab) ~= "table" then --> Checks if the table is a really table
		catchError(Messages.CreateJobDiag) --> Catch Error
	end
end

--> Create Functions:
local function CreateJob(Job): JobPrivateDef?
	local FirstInit = tick()

	TableCheck(Job)

	--> Setup Hidden Functions:
	Job.Employes = {} :: { [any]: { Cleanup: () -> (), Work: () -> () } }

	--[[
	Hires an employ to a job.
	```lua
	local  Job = GirraServer.CreateJob() ({
		Name = "Test",
	})
	
	local Employ = Job.Hire("TestEmploy")
	Employ.Work()
	```
	]]
	function Job.Hire(EmployName: string): InternalEmployDef? --> Hire Employes Function
		local Employ = Employes[EmployName] --> Gets Employ

		if not Started then
			Debugger.Debug(warn, { "Cannot Hire Jobs while Girra is not started" }, "Girra Server")
			return
		end

		if Employ.Job then
			Debugger.Debug(warn, { Employ.Name .. " Is Already Hired" }, Job.Name)
			return nil
		end

		if Employ then
			Employ.Hired:Fire(Job) --> Fire
			Employ.Job = Job --> Adds Job to Employ

			Job.Employes[Employ.Name] = Employ --> Adds To Job Employes
		else
			Debugger.Debug(warn, {
				EmployName .. " Is nil or does not exist!",
			}, Job.Name)
		end

		return Employ :: InternalEmployDef
	end

	--[[
	Fires an employ from a job.
	```lua
	local  Job = GirraServer.CreateJob() ({
		Name = "Test",
	})
	
	local Employ = Job.Hire("TestEmploy")
	Employ.Work()

	Job.Fire("TestEmploy")
	```
	]]
	function Job.Fire(EmployName: string): () --> Fires Employ Function
		local Employ = Job.Employes[EmployName] --> Gets Employ

		if Employ then --> If Employ Exists
			Employ.Cleanup() --> Cleans up the Employ
			Job.Employes[EmployName] = nil --> Removes the Employ
		else --> Else
			local name = Job.Name :: string --> Gives name
			Debugger.Debug(warn, { EmployName .. " is nil or does not exist" }, name) --> Debugs
		end
	end

	--> setup Job:
	if Job.Name == nil then --> Checks if job is equal to nil
		Debugger.Debug(warn, { "Job Name Does Not Exist!" }, "Girra Server") --> Debug
		return nil --> Returns Job
	end --> Checks if name is not nil and if it's then return

	if Jobs[Job.Name] then --> Checks If Job Exists
		Debugger.Debug(warn, { "Job", Job.Name, "Already Exists!" }, "Girra Server") --> Warns GirraServer Already Exists
		return Job --> Returns the table
	end

	Jobs[Job.Name] = Job --> Adds the Job
	task.spawn(Debug, Job, FirstInit) --> Debug Feature

	return Job --> Returns the Jobs
end

local function CleanupEmployable(
	Job: JobPrivateDef,
	Employ: Employ,
	Cleanup: () -> ()
): () --> CREATES EMPLOY CLEANUP FUNCTION
	repeat
		task.wait()
	until Job.Employes[Employ.Name] --> REPEATS UNTIL EMPLOY EXISTS

	Job.Employes[Employ.Name].Cleanup = Cleanup --> ADDS THE CLEANUP FUNCTION
end

local function CreateEmployableObject(Employ: PrivateEmployDef): () --> CREATES EMPLOY CLEANUP FUNCTION
	repeat
		task.wait()
	until Employ.OnWork -->  REPEATS UNTIL EMPLOY EXISTS

	function Employ.Work() -->  WORK FUNCTION
		Employ.Worked:Fire() --> FIRES THE Worked EVENT
	end

	Employ.Hired:Listen(function(Job) -->  HIRED EVENT
		local Cleanup = Employ:OnHire() -->  GETS THE CLEANUP FUNCTION
		task.spawn(CleanupEmployable, Job, Employ, Cleanup) -->  SPAWNS THE CLEANUP FUNCTION
	end)

	Employ.Worked:Listen(Employ.OnWork) -->  WORKED EVENT
end

local function CreateEmploy(Employ: PrivateEmployDef): Employ --> Creates Employ
	TableCheck(Employ) --> Checks if table is correct

	--> Setup Hidden Functions, Varibles:
	Employ.Hired = Signal.new() --> Creates Hired Signal
	Employ.Worked = Signal.new() --> Creates Worked Signal

	--> Setup Employ
	if Employ.Name then -->  If Name Exists
		if Employes[Employ.Name] == nil then --> If Employ Didn't got created
			Employes[Employ.Name] = Employ -->  Adds Employ
			task.spawn(CreateEmployableObject, Employ) -->  Creates the Object
		else --> Else
			Debugger.Debug(warn, { Employ.Name .. " Already Exists!" }, "GirraServer") --> Warns GirraServer Already Exists
		end
	else --> Else
		Debugger.Debug(warn, { "An Employ's Name Does Not Exist!" }, "GirraServer") --> Warns Name Does Not Exist!
	end

	return Employ :: Employ
end

local function StartAlert()
	Start:Fire(Settings) --> Fire the signal Start and give Settings varible
end

local function UpdateSettings(t: Settings) --> Getting The Settings
	if type(t) == "table" then --> Checking If Settings is table
		Settings = t --> Making the settings to T
		Runtime.RuntimeSettings = t --> Makes RuntimeSettings Globally

		return t --> Returning it
	end

	return Settings :: Settings --> Returns The Settings!
end

local function Init(__Main__: any) --> Initallize Job
	return function() --> Returns function so promise uses it
		if not __Main__ or not __Main__:FindFirstChild("Employes") or not __Main__:FindFirstChild("Jobs") then
			Debugger.Debug(warn, { Messages.InitMsg }, "Girra Server")
		end

		local LoadedEmployes = Initter.Employ(__Main__:WaitForChild("Employes"), Employes)
		local LoadedJobs = Initter.Job(__Main__:WaitForChild("Jobs"), Jobs) --> Loads The Jobs

		LoadedEmployes:Wait() --> Waits For Employes ( yields)
		LoadedJobs:Wait() --> Waits for Jobs (yields)

		Started = true --> Sets Started To True
		InitJobs() --> Initallize Jobs
	end
end

local function GetLocation(Location: any | number) --> Get Location Function Checks if Girra Sets to default or custom Job Location
	if typeof(Location) == "number" or Location == nil then --> Checks if the Location is default
		return Locations.DefaultLocation --> Returns the Default Location
	else
		return Location --> Returns Original Location
	end
end

local function LoadJobsV2(JobsFolder: any)
	for _, Job: any in JobsFolder:GetDescendants() do --> Looping Through Jobs Folder
		if typeof(require(Job) :: any) ~= "number" then --> Checking If Job is not Private and dosen't run externally
			local createJob = GirraServer.CreateJob() --> Creates the Job

			createJob(require(Job) :: any) --> Adds The Settings and The Table
		else --> Warns and returns a failure
			Debugger.Debug(warn, { Messages.LoadFunctionMessage }, "Girra Server")
		end
	end
end

local function StartServer(
	GameLocation: Instance | number
): (
	Settings: Settings
) -> {
	Then: (self: any, OnResolve: ((...any) -> ...any)?, OnReject: ((...any) -> ...any)?) -> (),
	Await: (self: any) -> ...any,
	Finally: (self: any, (Finally: "Pending" | "Rejected" | "Resolved") -> ()) -> (),
	StatusAwait: (self: any) -> "Pending" | "Rejected" | "Resolved",
} --> Main Function Start The Module Refrence to GirraClient.Start() ({})
	if Started then --> Checks if The Framework is started
		return Promise.Reject(Messages.Started) --> Rejects a promise
	end

	GetLocation(GameLocation) --> Gets Location

	return function(UndefinedSettings: Settings) --> Returns a Function for the Settings Proccess
		UpdateSettings(UndefinedSettings) --> Gets and Setupis Settings

		return Promise
			.new(function(Resolve: (any) -> ()) --> Create Promise
				StartAlert() --> Starts Signal
				Init(GameLocation)() --> Initallize Jobs

				Resolve()
			end)
			:Then(function() --> Synchorize Operation Step by step
				StartJobs() --> Starts The Jobs
			end) --> Start Jobs
			:Then(function()
				StepJobs() --> Setup :Step() Function
			end) --> Runs Job:Step()
			:Finally(function()
				HeartbeatJobs()
			end) --> Runs Job:Heartbeat()
			:Catch(function(Err: string) --> Catching Errors
				Debugger.Debug(warn, { Messages.InternalError, Err }, "Girra Server") --> Debug
			end)
		--> Catchs Warns
	end --> And Finally Return Function GetSettings for user to use and input with
end

--> GirraServer Functions:

--[=[
	@yields
	@return () -> (Settings)

	Starts Girra on the Server-Side!
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetServer()

	Girra.Start(0) {
		Debugging = {
			InGameDebugging = { SignalDebugging = false }
			InStudioDebugging = { SignalDebugging = true }
		}
	}

	--> 0 Means default GameLocation Location which is playerscripts
	```
]=]
function GirraServer.Start(
	GameLocation: Instance | number
): (
	Settings: Settings
) -> {
	Then: (self: any, OnResolve: ((...any) -> ...any)?, OnReject: ((...any) -> ...any)?) -> (),
	Await: (self: any) -> ...any,
	Finally: (self: any, (Finally: "Pending" | "Rejected" | "Resolved") -> ()) -> (),
	StatusAwait: (self: any) -> "Pending" | "Rejected" | "Resolved",
} --> Main Function Start The Module Refrence to GirraClient.Start() ({})
	return function(UndefinedSettings: Settings) --> Returns Function (Settings)
		local Run: any = StartServer(GameLocation)

		if UndefinedSettings then --> Checks if Settings exists
			return Run(UndefinedSettings) --> Making and starting and executing the GirraServer
		else --> If Settings does not exist
			return Run({
				Debugging = {
					InStudioDebugging = {
						JobDebugging = true,
						NetworkDebugging = true,
						SignalDebugging = true,
					},
					InGameDebugging = {
						JobDebugging = true,
						NetworkDebugging = true,
						SignalDebugging = true,
					},
				},
			}) --> Makes Default Settings
		end
	end
end

--[=[
	@return RBXScriptConnection
	Returns an RBXScriptConnection.
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetServer()

	Girra.OnStart(function()
		print("Started!")
	end)
	```
	Runs when Girra Framework Starts on Server!
	:::caution
	This function should be on top of .Start() function
	:::
]=]
function GirraServer.OnStart(callback: (...any) -> ()): RBXScriptConnection --> Fires when Starting the GirraServer
	return Start:Connect(function(...)
		callback(...)
	end)
end

--[=[
	@return Job
	Gets a Job From the Jobs Folder.
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetServer()

	Girra.GetJob("MyJob"):DoSomething()
	```
]=]
function GirraServer.GetJob(Name: string): Job --> Getting The Job
	return Jobs[Name] :: Job --> Returning The Job from the Jobs Table
end

--[=[
	@param JobsFolder Folder | number
	Another Way to Start Girra, It's recommended for Job intellisense.
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetServer()

	Girra.Begin(0) {
		Debugging = {
			InStudioDebugging = { NetworkDebugging = false, }
		}
	}
	```
]=]
function GirraServer.Begin(JobsFolder: Instance | number): (Settings: Settings) -> ()
	if Started then --> Checks if The Framework is started
		return Promise.Reject(Messages.Started) --> Rejects a promise
	end

	Started = true --> Makes Started Varible Started So we can't Start the Framework twice
	GetLocation(JobsFolder)

	LoadJobsV2(JobsFolder) --> Loads Jobs

	Promise.new(function() --> Create Promise
		task.wait()

		InitJobs() --> Initallize Jobs

		task.spawn(StartJobs) --> Start Jobs

		task.spawn(StepJobs) --> Runs Step Function every step
		task.spawn(HeartbeatJobs) --> Runs HeartBeat Function every heartbeat
	end)

	ServerScriptService:SetAttribute("ServerLoaded", true) --> Adds attribute

	return function(UndefinedSettings: Settings)
		UpdateSettings(Settings) --> Updates Settings
		StartAlert() --> Spawns things that runs after settings on start

		return UndefinedSettings
	end
end

--[=[
	@return Data
	Returns Data Library
]=]
function GirraServer.GetData() --> Returns Data Library
	return require(Libraries.Data) --> Returns Data Library
end

--[=[
	@return Signal


	Creates a Signal that can be used to intract with Job to Job
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetServer()

	local Job = {} --> Example

	Job.Signal = Girra.CreateSignal()
	Job.Signal:Fire("Hello Other Job!")
	```
	:::note Debugging
	Currently Debugging will not work in Signal we will work on updates to make signal debugging
	:::
]=]
function GirraServer.CreateSignal(): Signal --> Creates Signal
	return Signal.new() :: Signal | any --> Returns Signal from: Signal.new()
end

--[=[
	@return Network
	Creates a network that communicate between Server-Job and Client-Job
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetServer()

	local Network = Girra.CreateNetwork("MyNetwork")
	Network:Fire([Player], "Hello From Job To Job!")
	```
]=]
function GirraServer.CreateNetwork(Name: string) --> Creates Network:
	repeat --> Repeats until Framework is started
		task.wait() --> Delays a bit
	until Started --> Repeats until this is equal to true

	local NetContainer = {} --> Network Container

	--> Properties
	local NetClass = Network.new(Name) --> Creates a new network

	--> Functions:
	function NetContainer:Fire(Player: Player, ...: any): () --> Fires to specific Player
		local FirstInit = tick() --> First Initallize
		NetClass:Fire(Player, ...) --> Returns Network Fire Function()

		Debugger.DebugNetwork(Name, FirstInit, tick(), "Server GirraServer", "Fire") --> Debugs Network
	end

	function NetContainer:Invoke(Timeout: number, Player: Player, ...: any) --> Invokes function to specific Player
		local FirstInit = tick() --> First Initallize
		NetClass:Invoke(Timeout, Player, ...) --> Returns Network Invoke Function()

		Debugger.DebugNetworkInvoke(Name, FirstInit, tick(), "Server GirraServer", "Invoke") --> Debugs Network Invoke
	end

	function NetContainer:FireAll(...: any) --> Fires to all Players
		local FirstInit = tick() --> First Initallize
		NetClass:Fires(...) --> Returns Network Fire Function()

		Debugger.DebugNetwork(Name, FirstInit, tick(), "Server GirraServer", "FireAll") --> Debugs Network Invoke
	end

	function NetContainer:Listen(callback: (Player: Player, any) -> ()) --> Listens to Connection
		return NetClass:Listen(function(Player: Player, ...: any) --> Returns Network Listen Function()
			callback(Player, ...) --> Spawns callback function
		end)
	end

	function NetContainer:Connect(callback: (Player: Player, any) -> ()): any --> Listens to Connection Allias
		return NetClass:Connect(function(Player: Player, ...: any) --> Returns Network Connect ( allias ) Function()
			callback(Player, ...) --> Spawns callback function
		end)
	end

	function NetContainer:Once(callback: (Player: Player, any) -> ()) --> Listens to Connection 1 Time
		return NetClass:Once(function(Player: Player, ...: any) --> Returns Network Once Function()
			callback(Player, ...) --> Spawns callback function
		end)
	end

	function NetContainer:FireAllExcept(Except: { User: Player }, ...: any) --> Fires to All Players except
		local FirstInit = tick() --> First Initallize
		FireExcept(NetClass, Except, ...) --> Returns Network Fire Function()

		Debugger.DebugNetwork(Name, FirstInit, tick(), "Server GirraServer", "FireExcept") --> Debugs Invoke
	end

	function NetContainer:FireExcept(Except: { User: Player }, ...: any) --> Fires to All Players except Allias
		return NetContainer:FireAllExcept(Except, ...) -- Returns Network FireAllExcept Function()
	end

	function NetContainer:InvokeAll(Timeout: number, ...: any) --> Invokes Function To All Players
		local FirstInit = tick() --> First Initallize

		for _, Player in GirraServer.Services.Players:GetPlayers() do --> Loops Through Players
			NetContainer:Invoke(Timeout, Player, ...) -- Returns Network Invoke Function()
		end

		Debugger.DebugNetworkInvoke(Name, FirstInit, tick(), "Server GirraServer", "InvokeAll") --> Debugs Invoke
	end

	function NetContainer:InvokeAllExcept(Except: { User: Player }, Timeout: number, ...: any) --> Invokes Function to All players except one player
		local FirstInit = tick() --> First Initallize

		for _, Player in GirraServer.Services.Players:GetPlayers() do --> Loops through table
			if Except[Player] == nil then --> Checks if excepted Player is equal to nil
				NetContainer:Invoke(Timeout, Player, ...) -- Returns Network Invoke Function()
			end
		end

		Debugger.DebugNetworkInvoke(Name, FirstInit, tick(), "Server GirraServer", "InvokeExcept") --> Debugs Invoke
	end

	function NetContainer:InvokeExcept(Except: { User: Player }, Timeout: number, ...: any) --> Invokes Function to All players except one player Allias
		local FirstInit = tick() --> First Initallize

		NetContainer:InvokeAllExcept(Except, Timeout, ...) -- Returns Network InvokeAllExcept Function()
		Debugger.DebugNetworkInvoke(Name, FirstInit, tick(), "Server GirraServer", "InvokeExcept") --> Debugs Invoke
	end

	function NetContainer:IsListening(): boolean --> Checks if Network Is Listening to Function
		return Network.Connected :: boolean --> Returns Connected Boolean which is read only
	end

	function NetContainer:Disconnect() --> Disconnects Network
		local FirstInit = tick() --> First Initallize

		NetClass:Disconnect() --> Disconnects
		Debugger.DebugDisconnection(Name, FirstInit, tick(), "Girra Client", "Disconnect", "Disconnected") --> Debugs Disconnection
	end

	function NetContainer:Wait() --> Waits Amount Of time
		local FirstInit = tick() --> First Initallize
		NetClass:Wait() --> Spawns Network:Wait(Time)

		Debugger.YieldNetwork(Name, FirstInit, tick(), "Girra Client", "Wait") --> Debug: Yield
	end

	function NetContainer:Destroy() --> Destroys the Network
		local FirstInit = tick() --> First Initallize

		NetClass:Destroy() --> Spawns Destroy function of fastnet2 Network library
		Debugger.DebugDisconnection(Name, FirstInit, tick(), "Girra Client", "Destroy", "Destroyed") --> Debugs Disconnection
	end

	NetContainer.Connected = Network.Connected --> Freezed Property Refrence to IsListening()

	return NetContainer --> Network
end

--[=[
	@return (Job) -> ()
	Main Function used for .Start() and not .Begin().
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetServer()

	local MyJob = Girra.CreateJob() {
		Name = "MyJob"
	}
	```
]=]

function GirraServer.CreateJob(): (Job) -> JobPrivateDef
	return function(Job: any) --> Returns function with table varible
		return CreateJob(Job) :: JobPrivateDef --> Creates the Job
	end
end

--[=[
	@return (Employ) -> ()
	Creates Employ
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetServer()

	local MyEmploy = Girra.CreateEmploy() ({
		Name = "MyEmploy"
	})
	```
]=]
function GirraServer.CreateEmploy(): (Employ) -> Employ
	return function(Employ: any)
		return CreateEmploy(Employ) :: Employ
	end
end

return table.freeze(GirraServer)
