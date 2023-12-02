--> Moonwave:
--> Class
--[=[
	@class GirraClient
	@client
	The Client-Side Of Girra Let's you Create Signals and Jobs.

	Getting Girra Client:
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()

	--> Starting Girra:
	Girra.Start(0) {
		Debugging = {
			InGameDebugging = {
				JobDebugging = false, 			
			    NetworkDebugging = true,
			    SignalDebugging = true,
			},
			InStudioDebugging = {
				JobDebugging = true, 			
				NetworkDebugging = true,
				SignalDebugging = true,
			}
		};
	}
	
	--> 0 Means The Default Jobs Folder Location: game.StarterPlayer.StarterPlayerScripts
	```
]=]

--> Types:
--[=[ 
	@type Debugging {InGameDebugging: {JobDebugging: boolean, SignalDebugging: boolean, NetworkDebugging: boolean}, InStudioDebugging: {JobDebugging: boolean, SignalDebugging: boolean, NetworkDebugging: boolean}}
	@within GirraClient
	Debugging Settings
]=]

--[=[
	@type Settings { Debugging: Debugging }

	:::note Used by Girra.Start()
	This Type Is used for Girra.Start() Function
	:::

	@within GirraClient
]=]

--> Interfaces:
--[=[
	@interface Job
	@within GirraClient
	.Name string; 
	.OnInit () -> ()
	.OnStart () -> ()
	.OnStep (deltaTime: number) -> ()
	.Heartbeat (deltaTime: number) -> ()
	.OnRender (deltaTime: number)  -> ()
	.Fire (Name: string) -> ()
	.Hire (Name: string) -> HiredEmploy

	Class Job of GirraClient Which Is Module.
]=]

--[=[
	@interface HiredEmploy
	@within GirraClient
	.Job: Job
	.Work ()

	Class Employ of GirraClient Which Is Module.
]=]

--[=[
	@interface Employ
	@within GirraClient
	.Name string; 
	.OnWork (self: any) 
	.OnHire (self: any)

	Class Employ of GirraClient Which Is Module.
]=]

--[=[
	@interface Signal
	@within GirraClient
	.IsActive () -> boolean,
	.Connect (Callback: (...any) -> ()) -> RBXScriptConnection,
	.Listen (Callback: (...any) -> ()) -> RBXScriptConnection,
	.Once (Callback: (...any) -> ()) -> RBXScriptConnection,
	.Wait () -> (...any),
	.Fire (...any) -> (),
	.DisconnectAll () -> (),
	.Destroy () -> (),
	.Disconnect () -> ()

	Type Signal of GirraClient Which IsA Signal Object: Signal.new().
]=]

--[=[
	@interface Network
	@within GirraClient
	.Listen (Callback: (...any) -> ()) -> ()
	.Once (Callback: (...any) -> ()) -> ()
	.Fire (...: any) -> ()
	.Invoke (...: any) -> ()
	.Disconnect() -> ()
	.Destroy() -> ()
	.Wait(Time: number) -> ()
	.IsListening = () -> boolean

	Type Network of GirraClient Which IsA Network Object.
]=]

--[=[
	@interface Services
	@within GirraClient
	.Players Players 
	.UserInputService UserInputService 
	.RunService RunService 
	.ReplicatedStorage ReplicatedStorage
	.Workspace Workspace 

	Type Services of GirraClient Which IsA Table Contains Game-Services.
]=]

--> Properties:
--[=[
	@prop Services Services
	@within GirraClient
	@readonly

	Refrence to Used Game Services example:
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()
	local Services = Girra.Services

	--> InputBegan Function:
	Services.UserInputService.InputBegan:Connect(function()

	end)
	```
]=]

--[=[
	@prop Client Player
	@within GirraClient
	@readonly

	Refrence to Players.LocalPlayer
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()

	print(Girra.Client.Name) --> Prints Player Name
	```

]=]

--[=[
	@prop Gui PlayerGui
	@within GirraClient
	@readonly

	Refrence to Client.PlayerGui
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()

	print(Girra.Gui.Name) --> Prints PlayerGui
	```

]=]
--!strict
--> Types:
export type Job = {
	Name: string, --> Job Name
	OnInit: (self: any) -> (), --> Job Function OnInit
	OnStart: (self: any) -> (), --> Job Function OnStart
	OnStep: (self: any, ...any) -> (), --> Job Function OnStep
	Heartbeat: (self: any, ...any) -> (), --> Job Function Heartbeat
	OnRender: (self: any, ...any) -> (), --> Job function OnRender
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

export type Settings = {
	Debugging: {
		InGameDebugging: {
			JobDebugging: boolean, --> Debugging Job Require Initallize and Start
			NetworkDebugging: boolean, --> Network Debugging Fire and Disconnect and Destroy
			SignalDebugging: boolean, --> Signal Debugging Fire And Disconnect and Destroy
		},
		InStudioDebugging: {
			JobDebugging: boolean, --> Debugging Job Initallize and Start
			NetworkDebugging: boolean, --> Network Debugging Fire and Disconnect and Destroy
			SignalDebugging: boolean, --> Signal Debugging Fire And Disconnect and Destroy
		},
	}, --> Debugging
} --> Settings for Girra Framework

export type Signal = {
	IsActive: (self: any) -> boolean, --> Returns if the signal is active
	Connect: (self: any, Callback: (...any) -> ()) -> RBXScriptConnection, --> Connects to Function
	Once: (self: any, Callback: (...any) -> ()) -> RBXScriptConnection, --> Connects 1 time and then disconnects itself
	Wait: (self: any) -> ...any, --> Wait until the Signal Fires
	Fire: (self: any, ...any) -> (), --> Fires the Signal to all Connections
	DisconnectAll: (self: any) -> (), --> Disconnect All Signal Connections
	Destroy: (self: any) -> (), --> Destroys the Signal
} --> Signal Connection

export type Network = {
	Fire: (self: any, any: any) -> (), --> Fire Function Fires to server
	Listen: (self: any, callback: (...any) -> ()) -> (), --> Listen to the network
	Connect: (self: any, callback: (...any) -> ()) -> (), --> Listen to the Network ( Alias )
	Once: (self: any, callback: (...any) -> ()) -> (), --> Listen to the network 1 time and disconnect
	Invoke: (self: any, timeout: number, any: any) -> (), --> Invoke Function Invokes to server
	Disconnect: (self: any) -> (), --> Disconnects the Network Connection
	Destroy: (self: any) -> (), --> Destroys the Network
	Wait: () -> (), --> Waits amount of time
	IsListening: (self: any) -> boolean, --> Checks if the Network Is Listening
	Connected: boolean, --> Returns boolean: Status of Network Connection
} --> Network

export type Services = {
	Players: Players, --> Players: Game.Players
	UserInputService: UserInputService, --> UserInputService: Game.UserInputService
	RunService: RunService, --> RunService: Game.RunService
	ReplicatedStorage: ReplicatedStorage, --> ReplicatedStorage: Game.ReplicatedStorage
	Workspace: Workspace, --> Workspace: Game.Workspace
	TweenService: TweenService, --> TweenService: Game.TweenService
	ReplicatedFirst: ReplicatedFirst, --> Game.ReplicatedFirst
} --> Services Type

--> Services:
local ReplicatedFirst = game:GetService("ReplicatedFirst")

--> Class:
local GirraClient = {}

--> Properties:
GirraClient.Services = {
	Players = game:GetService("Players"), --> Players: Game.Players
	UserInputService = game:GetService("UserInputService"), --> UserInputService: Game.UserInputService
	RunService = game:GetService("RunService"), --> RunService: Game.RunService
	ReplicatedStorage = game:GetService("ReplicatedStorage"), --> ReplicatedStorage: Game.ReplicatedStorage
	Workspace = game:GetService("Workspace"), --> Workspace: Game.Workspace
	ReplicatedFirst = game:GetService("ReplicatedFirst"), --> ReplicatedFirst: Game.ReplicatedFirst
	TweenService = game:GetService("TweenService"), --> TweenService: Game.TweenService
} :: Services --> Game Services

GirraClient.Client = GirraClient.Services.Players.LocalPlayer :: Player
GirraClient.Gui = GirraClient.Client:WaitForChild("PlayerGui") :: StarterGui

local Messages = {
	Started = "[ Girra Client ]: Framework Already Started!",
	NilFolder = "Forgot Argument 1 of Function: GirraClient.Start(), Must be an Instance!",
	CreateJobDiag = "AddJobs Is For Intellisense, Regular .Start() and manual use of .CreateJob is flexable but AddJobs is good for intellisense and code function triggering",
	ErrorPrefix = "[ GirraClient Error ]",
	InitallizeSuccess = "Successfully Initiallized Job In:",
	NoStartupJob = "Is only used by other Jobs or nothing!",
	LoadFunctionMessage = "[ GirraClient ]: AddJobs Is For Intellisense, Regular .Start() and manual use of .CreateJob is flexable but AddJobs is good for intellisense and code function triggering",
	InternalError = "An Error Occour ErrorMsg: \n",
	InitMsg = "Unable to Continue [ Given Location Is Nil or Does not contain Folders: [ Jobs, Employes ]",
}

local Locations = {
	DefaultLocation = GirraClient.Client:WaitForChild("PlayerScripts"),
}

--> Tables:
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

--> Requiring Libraries
local Framework = script.Parent.Parent
local Libraries = Framework.Libraries
local Utilities = script.Parent.Utils

--> Packages:
local Packages = Framework.Parent
local Signal = require(Packages.Signal)
local Promise = require(Packages.Promise)
local Network = require(Packages.Network)

--> Utilities
local Context = require(Utilities.Runtime.Context)
local Debugger = require(Utilities.Debugger)
local Runtime = require(Utilities.Runtime.Settings)

--> Runtime Actions:
Runtime.RuntimeSettings = Settings

--> Modules:
local Modules = script.Modules

--> Requiring Modules
local Initter = {
	Job = require(Modules.JobInit),
	Employ = require(Modules.EmpInit),
}

--> Signals:
local Start = Signal.new()

--> Library
GirraClient.Libs = {
	["Signal"] = Signal,
	["Promise"] = Promise,
}

--> Girra Client Function Utilities:
function GirraClient.Home() --> Runs the Home Scripts
	local Home = Instance.new("Folder")
	local Girra = Instance.new("Folder")

	Home.Parent = ReplicatedFirst
	Home.Name = "Home"

	Girra.Name = "Girra"
	Girra.Parent = Home

	for _, Resource in Framework.Home:GetChildren() do
		local Clone = Resource:Clone()

		Clone.Parent = Girra
	end
end

function GirraClient:GetInterface() --> Gets Interface Library
	return require(Libraries.Interface) --> Returns Interface Library
end

--> Local Functions:
local function InitJobs() --> Job Initter Method
	for _, Job: Job in Jobs do --> Looping Through Jobs
		if Job.OnInit then --> Checking if The OnInit Function Exists
			Job:OnInit() --> Spawning OnInit() Function.
		else
			Debugging[Job.Name] = {} --> Making Debug Table
			Debugging[Job.Name].NoInit = true --> Setting No Init To True
		end
	end
end

--> Job Stepped Connection:
local function StepJobs() --> Job Stepped Connection:
	task.wait()

	for _, Job: Job in Jobs do --> Looping Through Jobs
		if Job.OnStep then --> Checking If OnStep Function Exists
			GirraClient.Services.RunService.Stepped:Connect(
				function(...) --> Running The Connection: RunService.Stepped With (any)
					Job:OnStep(...) --> Spawning OnStep(...) Function
				end
			)
		else
			Debugging[Job.Name] = {} :: any --> Making Debug Table
			Debugging[Job.Name].NoStep = true --> Setting NoStep To True
		end
	end
end

--> Job Render Connection:
local function RenderJobs() --> Job Stepped Connection:
	task.wait()

	for _, Job: Job in Jobs do --> Looping Through Jobs
		if Job.OnRender then --> Checking If OnStep Function Exists
			GirraClient.Services.RunService.RenderStepped:Connect(
				function(...) --> Running The Connection: RunService.Stepped With (any)
					Job:OnRender(...) --> Spawning OnStep(...) Function
				end
			)
		else
			Debugging[Job.Name] = {} :: any --> Making Debug Table
			Debugging[Job.Name].NoRender = true --> Setting NoStep To True
		end
	end
end

--> Job Heartbeat Connection:
local function HeartbeatJobs() --> Job Heartbeat Connection:
	task.wait()

	for _, Job in Jobs do --> Looping Through Jobs
		if Job.Heartbeat then --> Checking If Heartbeat Function Exists
			GirraClient.Services.RunService.Heartbeat:Connect(
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
	--> Creating A Promise:
	Promise
		.new(function()
			Job:OnStart() --> Starting The Job
		end)
		--> Catching:
		:Catch(catchError)
end

--> Start All Jobs Function:
local function StartJobs() --> Start All Jobs Function ( OnStart )
	task.wait()

	for _, Job: Job in Jobs do --> Looping Through Jobs
		if Job.OnStart then --> Checking If OnStart Function Exists on Jobs
			StartJob(Job) --> Spawning OnStart() Function
		else
			Debugging[Job.Name] = {} :: any --> Making Debug Table
			Debugging[Job.Name].NoStart = true --> Setting NoStart To: True
		end
	end
end

--> Debug Function
local function DebugCheck(Job: Job, First: number, Last: number) --> Debug Function
	Debugger.Debug(print, { Messages.InitallizeSuccess, tostring(math.ceil(Last - First)) .. "ms" }, Job.Name) --> Debug and prints that the Job Exists and Initallized

	if Debugging[Job.Name] and Debugging[Job.Name].NoInit and Debugging[Job.Name].NoStart then --> Checks if the debug is not used by the GirraClient
		warn("[", Job.Name, "]", Messages.NoStartupJob) --> Only Useable Job
	end
end

local function Debug(Job: any, T)
	task.wait()

	--> Settings:
	if Settings.Debugging then --> If Debugging is enabled
		if Settings.Debugging.InGameDebugging and Context.RuntimeContext.Client then --> If InGameDebugging Is Enabled
			if Settings.Debugging.InGameDebugging.JobDebugging then --> If JobDebugging Is true.
				DebugCheck(Job, T, tick()) --> Spawn Debugging Function
			end
		end

		if Settings.Debugging.InStudioDebugging and Context.RuntimeContext.Studio then --> If StudioDebugging Is Enabled
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

local function TableCheck(Tab) --> Checks The Job
	if typeof(Tab) ~= "table" then --> Checks if the table is a really table
		catchError(Messages.CreateJobDiag) --> Catch Error
	end
end
--> CreateJob Function:
local function CreateJob(Job): JobPrivateDef
	local FirstInit = tick()

	TableCheck(Job)

	--> Setup Hidden Functions:
	Job.Employes = {} :: { [any]: { Cleanup: () -> (), Work: () -> () } }

	--[[
		Hires an employ to a job.
		```lua
		local  Job = GirraClient.CreateJob() ({
			Name = "Test",
		})
		
		local Employ = Job.Hire("TestEmploy")
		Employ.Work()
		```
		]]
	function Job.Hire(EmployName: string): InternalEmployDef? --> Hire Employes Function
		local Employ = Employes[EmployName] --> Gets Employ

		if not Started then
			Debugger.Debug(warn, { "Cannot Hire Jobs while Girra is not started" }, "Girra Client")
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
		local  Job = GirraClient.CreateJob() ({
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

	--> Diagnostatics
	if Job.Name == nil then
		Debugger.Debug(warn, { "Job Name Does Not Exist!" }, "Girra Client") --> Debug
		return Job --> Returns Job
	end --> Checks if name is not nil and if it's then return

	if Jobs[Job.Name] then --> Checks If Job Exists
		Debugger.Debug(warn, { "Job", Job.Name, "Already Exists!" }, "Girra Client") --> Warns GirraClient Already Exists
		return Job --> Returns the table
	end

	Jobs[Job.Name] = Job --> Adds the Job
	task.spawn(Debug, Job, FirstInit) --> Debug Feature

	return Job --> Returns the Job
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

local function CreateEmploy(Employ: PrivateEmployDef): Employ
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
			Debugger.Debug(warn, { Employ.Name .. " Already Exists!" }, "Girra Client") --> Warns GirraClient Already Exists
		end
	else --> Else
		Debugger.Debug(warn, { "An Employ's Name Does Not Exist!" }, "Girra Client") --> Warns Name Does Not Exist!
	end

	return Employ :: Employ
end

--> SpawnSettings Function:
local function StartAlert() --> Spawn Settings Function
	Start:Fire(Settings) --> Fire the signal Start and give Settings varible
end

local function UpdateSettings(t: Settings) --> Getting The Settings
	if type(t) == "table" then --> Checking If Settings is table
		Settings = t --> Making the settings to T
		Runtime.RuntimeSettings = t --> Makes RuntimeSettings Globally

		return t --> Returning it
	end

	return Settings :: Settings --> Return The Settings!
end

local function Init(__Main__: any) --> Initallize Jobs
	return function() --> Returns function so promise uses it
		if not __Main__ or not __Main__:FindFirstChild("Employes") or not __Main__:FindFirstChild("Jobs") then
			Debugger.Debug(warn, { Messages.InitMsg }, "Girra Client")
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
	for _, Job in JobsFolder:GetDescendants() do --> Looping Through Jobs Folder
		if typeof(require(Job) :: any) ~= "number" then --> Checking If Job is not Private and dosen't run externally
			local createJob = GirraClient.CreateJob() --> Creates the Job

			createJob(require(Job) :: any) --> Adds The Settings and The Table
		else --> Warns and returns a failure
			Debugger.Debug(warn, { Messages.LoadFunctionMessage }, "Girra Client")
		end
	end
end

function StartClient(
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

	return function(UndefinedSettings: Settings)
		UpdateSettings(UndefinedSettings) --> Update Settings

		return Promise
			.new(function(Resolve: (any) -> ())
				StartAlert() --> Fires Start Signal
				Init(GameLocation)() --> Initallize Jobs

				Resolve()
			end)
			:Then(function(Fn) --> Starts JObs
				StartJobs() --> Spawn Function
				return Fn --> Return Resolve
			end)
			:Then(function(Fn) --> Render Jobs
				RenderJobs() --> Spawn Function
				return Fn --> Returns Resolve()
			end)
			:Then(function() --> Step Jobs
				StepJobs() --> Setup :Step() Function
			end) --> Runs Job:Step()
			:Finally(function() --> Heartbeat Jobs
				HeartbeatJobs()
			end) --> Runs Job:Heartbeat()
			:Catch(function(Err: string) --> Catching Errors
				Debugger.Debug(warn, { Messages.InternalError, Err }, "Girra Client") --> Debug
			end)
	end --> And Finally Return Function GetSettings for user to use and input with
end

--> GirraClient Functions:

--[=[
	@yields
	@return () -> (Settings)

	Starts Girra on the Client-Side!
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()

	Girra.Start(0) {
		Debugging = {
			InGameDebugging = { SignalDebugging = false }
			InStudioDebugging = { SignalDebugging = true }
		}
	}

	--> 0 Means default GameLocation Location which is playerscripts
	```
]=]
function GirraClient.Start(GameLocation: any): (
	Settings: Settings
) -> {
	Then: (self: any, OnResolve: ((...any) -> ...any)?, OnReject: ((...any) -> ...any)?) -> (),
	Await: (self: any) -> ...any,
	Finally: (self: any, (Finally: "Pending" | "Rejected" | "Resolved") -> ()) -> (),
	StatusAwait: (self: any) -> "Pending" | "Rejected" | "Resolved",
} --> Main Function Start The Module Refrence to GirraClient.Start() ({})
	return function(UndefinedSettings: Settings) --> Returns Function (Settings)
		local Run: any = StartClient(GameLocation) --> Starts Girra On The Client

		if Settings then --> Checks if Settings is not equal to nil
			return Run(UndefinedSettings) --> Making and starting and executing the GirraClient
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
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()

	Girra.OnStart(function()
		print("Started!")
	end)
	```
	Runs when Girra Framework Starts on Client!
	:::caution
	This function should be on top of .Start() function
	:::
]=]
function GirraClient.OnStart(Callback: (...any) -> ()): RBXScriptConnection --> Fires when Starting the Girra Client
	return Start:Connect(function(...)
		Callback(...)
	end)
end

--[=[
	@return Job
	Gets a Job From the Jobs Folder.
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()

	Girra.GetJob("MyJob"):DoSomething()
	```
]=]
function GirraClient.GetJob(Name: string): Job --> Getting The Job
	return Jobs[Name] --> Returning The Job from the Jobs Folder
end

--[=[
	@param JobsFolder Folder | number
	Another Way to Start Girra, It's recommended for intellisense.
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()

	Girra.Begin(0) {
		Debugging = {
			InStudioDebugging = { NetworkDebugging = false, }
		}
	}
	```
]=]
function GirraClient.Begin(JobsFolder: any | number): (Settings: Settings) -> ()
	if Started then --> Checks if The Framework is started
		return Promise.Reject(Messages.Started) --> Rejects a promise
	end

	Started = true --> Sets Started to True so we can't start twice

	GetLocation(JobsFolder) --> Gets Location
	LoadJobsV2(JobsFolder) --> Loads Jobs

	Promise.new(function() --> Create Promise
		task.wait()

		InitJobs() --> Initallize Jobs

		task.spawn(StartJobs) --> Start Jobs

		task.spawn(RenderJobs) --> Runs Job:Render()
		task.spawn(StepJobs) --> Runs Job:Step()
		task.spawn(HeartbeatJobs) --> Runs Job:Heartbeat()
	end)

	return function(UndefinedSettings: Settings) --> Returns Settings
		UpdateSettings(UndefinedSettings) --> UpdateSettings
		StartAlert() --> Spawns Things that runs after Settings OnStart

		return Settings
	end
end

--[=[
	@return Signal


	Creates a Signal that can be used to intract with Job to Job
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()

	local Job = {} --> Example

	Job.Signal = Girra.CreateSignal()
	Job.Signal:Fire("Hello Other Job!")
	```
	:::note Debugging
	Currently Debugging will not work in Signal we will work on updates to make signal debugging
	:::
]=]
function GirraClient.CreateSignal(): Signal --> Creates Signal
	return Signal.new() :: Signal | any --> Returns Signal from: Signal()
end

--[=[
	@return Network

	Gets a network that's created in server-side
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()

	local Network = Girra.GetNetwork("MyNetwork")
	Network:Fire("Hello From Client-Job!")
	```
]=]
function GirraClient.GetNetwork(Name: string) --> Gets the Network
	repeat --> Repeats until Framework is started
		task.wait() --> Delays a bit
	until Started --> Repeats until this is equal to true

	local NetContainer = {} --> Network Container

	--> Properties
	local NetClass = Network.new(Name) --> Gets a new network

	--> Statements:
	if not NetClass then
		Debugger.Debug(
			warn,
			{ "Got a nil network make sure to create network on server before Getting it!" },
			"[ " .. Name .. " ]"
		)
	end

	--> Functions:
	function NetContainer:Fire(...: any): () --> Fires to specific Player
		local FirstInit = tick() --> First Initallize Time
		NetClass:Fire(...) --> Returns Network Fire Function()

		Debugger.DebugNetwork(Name, FirstInit, tick(), "Girra Client", "Fire") --> Debug
	end

	function NetContainer:Invoke(Timeout: number, ...: any) --> Invokes function to specific Player
		local FirstInit = tick() --> First Initallize Time
		NetClass:Invoke(Timeout, ...) --> Returns Network Invoke Function()

		Debugger.DebugNetworkInvoke(Name, FirstInit, tick(), "Girra Client", "Invoke") --> Debug
	end

	function NetContainer:Listen(callback: (any) -> ()): (any) -> () --> Listens to Connection
		return NetClass:Listen(function(...: any) --> Returns Network Listen Function()
			callback(...) --> Spawns callback function
		end)
	end

	function NetContainer:Connect(callback: (any) -> ()): (any) -> () --> Listens to Connection Allias
		return NetClass:Connect(function(...: any) --> Returns Network Connect ( allias ) Function()
			callback(...) --> Spawns callback function
		end)
	end

	function NetClass:Once(callback: (any) -> ()): (any) -> () --> Listens to Connection 1 Time
		repeat
			task.wait()

		until NetClass

		return NetClass:Once(function(...: any) --> Returns Network Once Function()
			callback(...) --> Spawns callback function
		end)
	end

	function NetClass:Disconnect() --> Disconnects Network
		local FirstInit = tick() --> First Initallize Time
		NetClass:Disconnect() --> Disconnects The Network Connection

		Debugger.DebugDisconnection(Name, FirstInit, tick(), "Girra Client", "Disconnect", "Disconnected") --> Debug Disconnection
	end

	function NetContainer:Destroy() --> Destroys Network
		local FirstInit = tick() --> First Initallize Time
		NetClass:Destroy() --> Destroys The Network

		Debugger.DebugDisconnection(Name, FirstInit, tick(), "Girra Client", "Destroy", "Destroyed") --> Debugs: Disconnection
	end

	function NetContainer:Wait() --> Waits Amount Of time
		local FirstInit = tick() --> First Initallize
		NetClass:Wait() --> Spawns Network:Wait(Time)

		Debugger.YieldNetwork(Name, FirstInit, tick(), "Girra Client", "Wait") --> Debug: Yield
	end

	function NetContainer:IsListening(): boolean --> Checks if Job is listening
		return NetClass.Connected :: boolean --> Returns Connected Varible
	end

	NetContainer.Connected = NetClass.Connected --> Connection

	return NetContainer --> Network
end

--[=[
	@return (Job) -> ()

	Main Function used for .Start() and not .Begin() For Creating Jobs.
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()

	local MyJob = Girra.CreateJob() {
		Name = "MyJob"
	}
	```
]=]
function GirraClient.CreateJob(): (Job) -> JobPrivateDef --> Creates Job
	return function(Job: any) --> Returns function with table varible
		return CreateJob(Job) :: JobPrivateDef --> Creates the Job
	end
end

--[=[
	@return (Employ) -> ()
	Creates Employ
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()

	local MyEmploy = Girra.CreateEmploy() ({
		Name = "MyEmploy"
	})
	```
]=]
function GirraClient.CreateEmploy(): (Employ) -> Employ
	return function(Employ: any)
		return CreateEmploy(Employ) :: Employ
	end
end

return table.freeze(GirraClient)
