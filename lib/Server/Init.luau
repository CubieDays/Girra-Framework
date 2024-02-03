--  							 MIT License ↓								  --
--[[

	Copyright (c) 2023 Cubie

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
]]

--> Moonwave ↓

--> Class ↓
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

--> Types ↓
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

--> Interfaces ↓
--[=[
	@interface Job
	@within GirraServer
	.Name string
	.OnInit () -> ()
	.OnStart () -> ()
	.OnStep (deltaTime: number) -> ()
	.Heartbeat (deltaTime: number) -> ()
	.Fire (Name: string) -> ()
	.Hire (Name: string) -> HiredEmployee
	.Employees { [any]: { Work: () } }

	Class Job of GirraServer Which Is Module.
]=]

--[=[
	@interface HiredEmployee
	@within GirraServer
	.Job Job
	.Work ()

	Class Employee of GirraServer Which Is Module.
]=]

--[=[
	@interface Employee
	@within GirraServer
	.Name string,
	.OnWork (self: any),
	.OnHire (self: any)

	Class Employee of GirraServer Which Is Module.
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

--> Properties ↓
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

--[=[
	@prop CplAccess { number }
	@within GirraServer

	Used to refrence who can access and view serverJobs in ControlPanel by opening it ( Control + G )
]=]

local GirraServer = {}
type GirraServer = typeof(GirraServer)

--> Exported Types ↓
export type Promise<T...> = {
	Then: (self: any, OnResolve: ((T...) -> T...)?, OnReject: ((T...) -> T...)?) -> Promise<T...>,
	Await: (self: any) -> T...,
	Finally: (self: any, (Finally: "Pending" | "Rejected" | "Resolved") -> ()) -> Promise<T...>,
	StatusAwait: (self: any) -> "Pending" | "Rejected" | "Resolved",
	Catch: (self: any, Callback: (Error: string) -> ()) -> (),
}

--> Types ↓
type Job = {
	Name: string, --> Job Name
	OnInit: (self: Job) -> (), --> Job Function OnInit
	OnStart: (self: Job) -> (), --> Job Function OnStart
	OnStep: (self: Job, DeltaTime: number) -> (), --> Job Function OnStep
	Heartbeat: (self: Job, DeltaTime: number) -> (), --> Job Function Heartbeat
} --> Default Job

type JobPrivateDef = {
	Name: string, --> Job Name
	Employees: { --> Employees
		[any]: { --> Any EmployeeType
			Cleanup: () -> (), --> Cleanup Function
			Work: () -> (), --> Work Function
		},
	}, --> Private Employees
	Hire: (Name: string) -> InternalEmployeeDef?, --> Private Function Hire
	Fire: (Name: string) -> (), --> Fires The Job
	OnInit: (self: JobPrivateDef) -> (), --> On Initallize
	OnStart: (self: JobPrivateDef) -> (), --> Job Function OnStart
	OnStep: (self: JobPrivateDef, DeltaTime: number) -> (), --> Job Function OnStep
	Heartbeat: (self: JobPrivateDef, DeltaTime: number) -> (), --> Job Function Heartbeat
	OnRender: (self: JobPrivateDef, DeltaTime: number) -> (), --> Job function OnRender
	[any]: (self: JobPrivateDef) -> () | any, --> For any object
} --> Default Job

type Employee = {
	Name: string, --> Employee Name
	OnWork: (self: Employee) -> ()?, --> Employee OnWork Function
	OnHire: (self: Employee) -> ()?, --> Employee OnHire Function
}

type PrivateEmployeeDef = {
	Name: string, -- Employee Name
	Hired: any, --> Hired Event
	Worked: any, -- Worked Event
	Job: Job, --> Employee Job Work AT
	OnWork: (self: PrivateEmployeeDef) -> (), --> OnWork Function
	OnHire: (self: PrivateEmployeeDef) -> () -> (), --> OnHire Function
	Work: () -> (), --> Work Function
}

type InternalEmployeeDef = {
	Job: Job, --> Work At
	Work: () -> (), --> Work Function
}

type Settings = {
	Debugging: {
		InGameDebugging: {
			JobDebugging: boolean?, --> Debugging Job Initallize and Start
			SignalDebugging: boolean?, --> Network Debugging Fire and Disconnect and Destroy
			NetworkDebugging: boolean?, --> Signal Debugging Fire And Disconnect and Destroy
			OutputDebugging: boolean?, --> OutputDebugging for uninternal use if Developer wants to use Girra's Debugger Library.
		},
		InStudioDebugging: {
			JobDebugging: boolean?, --> Debugging Job Initallize and Start
			SignalDebugging: boolean?, --> Network Debugging Fire and Disconnect and Destroy
			NetworkDebugging: boolean?, --> Signal Debugging Fire And Disconnect and Destroy
			OutputDebugging: boolean?, --> OutputDebugging for uninternal use if Developer wants to use Girra's Debugger Library.
		},
	}, --> Debugging
} --> Settings for Girra Framework

type Services = {
	Players: Players, --> Players: Game.Players
	UserInputService: UserInputService, --> UserInputService: Game.UserInputService
	RunService: RunService, --> RunService: Game.RunService
	ReplicatedStorage: ReplicatedStorage, --> ReplicatedStorage: Game.ReplicatedStorage
	ServerStorage: ServerStorage, --> ServerStorage: Game.ServerStorage
	Workspace: Workspace, --> Workspace: Game.Workspace
} --> Services Type

--> Services ↓
local ServerScriptService = game:GetService("ServerScriptService")

--> Class ↓

--> Properties ↓
GirraServer.Services = {
	Players = game:GetService("Players"), --> Players: Game.Players
	UserInputService = game:GetService("UserInputService"), --> UserInputService: Game.UserInputService
	RunService = game:GetService("RunService"), --> RunService: Game.RunService
	ReplicatedStorage = game:GetService("ReplicatedStorage"), --> ReplicatedStorage: Game.ReplicatedStorage
	ServerStorage = game:GetService("ServerStorage"), --> ServerStorage: Game.ServerStorage
	Workspace = game:GetService("Workspace"), --> Workspace: Game.Workspace
} :: Services --> Game Services

GirraServer.CplAccess = {
	game.CreatorId, --> Creator id
} :: { number } --> Owners of Game

--> Tables ↓
local Locations = {
	DefaultLocation = ServerScriptService, --> Default Location
} --> Locations for Girra

local Debugging = {} --> Storing Debug Info about Jobs
local Settings: Settings = {
	Debugging = {
		InGameDebugging = {
			JobDebugging = false,
			SignalDebugging = false,
			NetworkDebugging = false,
			OutputDebugging = true,
		},
		InStudioDebugging = {
			JobDebugging = true,
			SignalDebugging = true,
			NetworkDebugging = true,
			OutputDebugging = true,
		},
	},
}

--> Data ↓
local Jobs: { [string]: Job } = {}
local Employees: { [string]: InternalEmployeeDef } = {}

--> Local Properties ↓
local Started = false

--> Getting Folders ↓
local Framework = script.Parent
local Utilities = Framework.Utils

--> Packages ↓
local Packages = Framework.Parent
local Signal = require(Framework.Signal)
local Promise = require(Packages.Promise)
local Network = require(Framework.Network)
local Messages = require(Framework.Strings).Server

--> Utilities ↓
local Context = require(Utilities.Runtime.Context)
local Debugger = require(Utilities.Debugger)
local Runtime = require(Utilities.Runtime.Settings)

--> Runtime Actions ↓
Runtime.RuntimeSettings = Settings

--> Modules ↓
local Modules = script.Modules

--> Requiring Modules ↓
local Initter = {
	Employee = require(Modules.EmpInit),
	Job = require(Modules.JobInit),
}

--> Signals ↓
local Start = Signal()

--> Library ↓
GirraServer.Libs = {
	["Promise"] = Promise :: typeof(Promise),
	["Debugger"] = Debugger :: typeof(Debugger),
	["Signal"] = Signal :: typeof(Signal),
	["Network"] = Network :: typeof(Network),
}

--> Local Functions ↓
local function InitJobs() --> Job Initter Method
	for _, Job: Job in Jobs do --> Looping Through Jobs
		if Job.OnInit then --> Checking if The OnInit Function Exists
			task.spawn(Job.OnInit, Job) --> Running OnInit Function
		else
			Debugging[Job.Name] = {} --> Making Debug Table
			Debugging[Job.Name].NoInit = true --> Setting No Init To True
		end
	end
end

--> Job Stepped Connection ↓
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
--> Job Heartbeat Connection ↓
local function HeartbeatJobs() --> Job Heartbeat Connection:
	task.wait()

	for _, Job in Jobs do --> Looping Through Jobs
		if Job.Heartbeat then --> Checking If Heartbeat Function Exists
			GirraServer.Services.RunService.Heartbeat:Connect(
				function(...) --> Running The Connection: RunService.Heartbeat With (any)
					Job:Heartbeat(...) --> Spawning Heartbeat(...) Function
				end
			)
		elseif Job.OnHeart then
			GirraServer.Services.RunService.Heartbeat:Connect(
				function(...) --> Running The Connection: RunService.Heartbeat With (any)
					Job:OnHeart(...) --> Spawning Heartbeat(...) Function
				end
			)
		else
			Debugging[Job.Name] = { NoHeart = true } :: any --> Making Debug Table Setting NoHeart To: True
		end
	end
end

--> Default Error Catcher Output Message ↓
local function catchError(err) --> Default Catching
	Debugger.InternalDebug(warn, "Strict", "Girra Server", "\n", err) --> Warning
end

--> Job Start Function ↓
local function StartJob(Job: Job) --> Job Start Function
	--> Starting Job:
	Job:OnStart()
end

--> Start All Jobs Function ↓
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

--> Debug Function ↓
local function DebugCheck(Job: Job, First: number, Last: number) --> Debug Function
	Debugger.InternalDebug(
		print,
		"Default",
		Job.Name,
		Messages.InitallizeSuccess,
		string.format("%.2f", (Last - First) * 1000),
		"ms"
	) --> Debug and prints that the Job Exists

	if Debugging[Job.Name] and Debugging[Job.Name].NoInit and Debugging[Job.Name].NoStart then --> Checks if the debug is not used by the GirraServer
		warn("[", Job.Name, "]", Messages.NoStartupJob) --> Only Useable Job
	end
end

local function Debug(Job: any, T)
	task.wait()

	--> Settings ↓
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

--> Create Functions ↓
local function CreateJob(Job): JobPrivateDef?
	local FirstInit = tick()

	TableCheck(Job)

	--> Setup Hidden Functions ↓
	Job.Employees = {} :: { [any]: { Cleanup: () -> (), Work: () -> () } }

	--[[
	Hires an employ to a job.
	```lua
	local  Job = GirraServer.CreateJob() ({
		Name = "Test",
	})
	
	local Employee = Job.Hire("TestEmployee")
	Employee.Work()
	```
	]]
	function Job.Hire(EmployeeName: string): InternalEmployeeDef? --> Hire Employees Function
		local Employee = Employees[EmployeeName] --> Gets Employee

		if not Started then
			Debugger.InternalDebug(warn, "Strict", "Girra Server", "Cannot Hire Jobs while Girra is not started")
			return
		end

		if Employee.Job then
			Debugger.InternalDebug(warn, "Strict", Job.Name, `{Employee.Name} Is Already Hired`)
			return nil
		end

		if Employee then
			Employee.Hired:Fire({ Job }) --> Fire
			Employee.Job = Job --> Adds Job to Employee

			Job.Employees[Employee.Name] = Employee --> Adds To Job Employees
		else
			Debugger.InternalDebug(warn, "Strict", Job.Name, `{EmployeeName} Is nil or does not exist!`)
		end

		return Job.Employees[EmployeeName] :: InternalEmployeeDef
	end

	--[[
	Fires an employ from a job.
	```lua
	local  Job = GirraServer.CreateJob() ({
		Name = "Test",
	})
	
	local Employee = Job.Hire("TestEmployee")
	Employee.Work()

	Job.Fire("TestEmployee")
	```
	]]
	function Job.Fire(EmployeeName: string): () --> Fires Employee Function
		local Employee = Job.Employees[EmployeeName] --> Gets Employee

		if Employee then --> If Employee Exists
			Employee.Cleanup() --> Cleans up the Employee
			Job.Employees[EmployeeName] = nil --> Removes the Employee
		else --> Else
			local name = Job.Name :: string --> Gives name
			Debugger.InternalDebug(warn, "Strict", name, `{EmployeeName} is nil or does not exist`) --> Debugs
		end
	end

	--> setup Job ↓
	if Job.Name == nil then --> Checks if job is equal to nil
		Debugger.InternalDebug(warn, "Strict", `Girra Server`, "Job Name Does Not Exist!") --> Debug
		return nil --> Returns Job
	end --> Checks if name is not nil and if it's then return

	if Jobs[Job.Name] then --> Checks If Job Exists
		Debugger.InternalDebug(warn, "Strict", `Girra Server`, `Job: {Job.Name} Already Exists!`) --> Warns GirraServer Already Exists
		return Job --> Returns the table
	end

	Jobs[Job.Name] = Job --> Adds the Job
	task.spawn(Debug, Job, FirstInit) --> Debug Feature

	return Job --> Returns the Jobs
end

local function CleanupEmployeeable(
	Job: JobPrivateDef,
	Employee: Employee,
	Cleanup: () -> ()
): () --> CREATES EMPLOY CLEANUP FUNCTION
	repeat
		task.wait()
	until Job.Employees[Employee.Name] --> REPEATS UNTIL EMPLOY EXISTS

	Job.Employees[Employee.Name].Cleanup = Cleanup --> ADDS THE CLEANUP FUNCTION
end

local function CreateEmployeeableObject(Employee: PrivateEmployeeDef): () --> CREATES EMPLOY CLEANUP FUNCTION
	repeat
		task.wait()
	until Employee.OnWork -->  REPEATS UNTIL EMPLOY EXISTS

	function Employee.Work() -->  WORK FUNCTION
		Employee.Worked:Fire() --> FIRES THE Worked EVENT
	end

	Employee.Hired:Listen(function(Job) -->  HIRED EVENT
		local Cleanup = Employee:OnHire() -->  GETS THE CLEANUP FUNCTION
		task.spawn(CleanupEmployeeable, Job, Employee, Cleanup) -->  SPAWNS THE CLEANUP FUNCTION
	end)

	Employee.Worked:Listen(Employee.OnWork) -->  WORKED EVENT
end

local function CleanupEmployeeableObject(Employee: PrivateEmployeeDef): ()
	repeat
		task.wait()
	until Employee.OnWork

	for Index, Func in pairs(Employee) do
		if typeof(Func) == "function" and Index ~= "OnWork" then
			if Index ~= "OnHire" then
				if Index ~= "Work" then
					Employee[Index] = nil
				end
			end
		end
	end
end

local function CreateEmployee(Employee: PrivateEmployeeDef): Employee --> Creates Employee
	TableCheck(Employee) --> Checks if table is correct

	--> Setup Hidden Functions, Varibles:
	Employee.Hired = Signal() --> Creates Hired Signal
	Employee.Worked = Signal() --> Creates Worked Signal

	--> Setup Employee
	if Employee.Name then -->  If Name Exists
		if Employees[Employee.Name] == nil then --> If Employee Didn't got created
			Employees[Employee.Name] = Employee -->  Adds Employee
			task.spawn(CreateEmployeeableObject, Employee) -->  Creates the Object
			task.spawn(CleanupEmployeeableObject, Employee) --> Cleans up the employ
		else --> Else
			Debugger.InternalDebug(warn, "Strict", "Girra Server", `{Employee.Name} Already Exists!`) --> Warns GirraServer Already Exists
		end
	else --> Else
		Debugger.InternalDebug(warn, "Strict", "Girra Server", "An Employee's Name Does Not Exist!") --> Warns Name Does Not Exist!
	end

	return Employee :: Employee
end

local function StartAlert()
	Start:Fire({ Settings }) --> Fire the signal Start and give Settings varible
end

local function UpdateSettings(t: Settings) --> Getting The Settings
	if type(t) == "table" then --> Checking If Settings is table
		Settings = t --> Making the settings to T
		Runtime.RuntimeSettings = t --> Makes RuntimeSettings Globally

		return t --> Returning it
	end

	return Settings :: Settings --> Returns The Settings!
end

local function Init(Instance: any) --> Initallize Job
	return function() --> Returns function so promise uses it
		if not Instance then
			return
		end
		local Job = nil --> Job to wait for
		local Employee = nil --> Employee to wait for

		if Instance:FindFirstChild("Employees") then --> If Employees Folder Exists
			Employee = Initter.Employee(Instance:WaitForChild("Employees"), Employees) --> Loads the Employees
		end

		if Instance:FindFirstChild("Jobs") then --> If Jobs Folder Exist
			Job = Initter.Job(Instance:WaitForChild("Jobs"), Jobs) --> Loads The Jobs
		end

		if Employee then
			Employee.Wait()
		end --> Wait For Employees
		if Job then
			Job.Wait()
		end --> Wait For Jobs

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

local function StartServer(
	GameLocation: Instance | number
): (Settings: Settings) -> Promise<any> --> Main Function Start The Module Refrence to GirraClient.Start() ({})
	if Started then --> Checks if The Framework is started
		return Promise.Reject(Messages.Started) --> Rejects a promise
	end

	GetLocation(GameLocation) --> Gets Location

	return function(UndefinedSettings: Settings) --> Returns a Function for the Settings Proccess
		UpdateSettings(UndefinedSettings) --> Gets and Setupis Settings

		return Promise
			.new(function(Resolve: (any) -> ()) --> Create Promise
				Init(GameLocation)() --> Initallize Jobs

				Resolve()
			end)
			:Then(function() --> Synchorize Operation Step by step
				StartJobs() --> Starts The Jobs
			end) --> Start Jobs
			:Then(function()
				StartAlert() --> Starts Signal
				StepJobs() --> Setup :Step() Function
			end) --> Runs Job:Step()
			:Finally(function()
				HeartbeatJobs() --> Do Heartbeats

				--GirraServer.LoadTime = tonumber(string.format("%.2f", (os.clock() - StartTime) * 1000)) --> LoadTime
			end) --> Runs Job:Heartbeat()
			:Catch(function(Err: string) --> Catching Errors
				Debugger.InternalDebug(warn, "Strict", "Girra Server", Messages.InternalError, Err) --> Debug
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
	GameLocation: Instance
): (Settings: Settings) -> Promise<any> --> Main Function Start The Module Refrence to GirraClient.Start() ({})
	return function(UndefinedSettings: Settings) --> Returns Function (Settings)
		local Run = StartServer(GameLocation) :: (Settings: Settings) -> ()

		if UndefinedSettings then --> Checks if Settings exists
			return Run(UndefinedSettings) --> Making and starting and executing the GirraServer
		else --> If Settings does not exist
			return Run({
				Debugging = {
					InStudioDebugging = {
						JobDebugging = true,
						NetworkDebugging = true,
						SignalDebugging = true,
						OutputDebugging = true,
					},
					InGameDebugging = {
						JobDebugging = true,
						NetworkDebugging = true,
						SignalDebugging = true,
						OutputDebugging = true,
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
function GirraServer.OnStart<T...>(callback: (T...) -> ()): RBXScriptConnection --> Fires when Starting the GirraServer
	return Start:Listen(function(...)
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
	assert(Started, "Cannot Get Jobs While The Framework isn't started yet!") --> Assertation
	return Jobs[Name] :: Job --> Returning The Job from the Jobs Table
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
function GirraServer.CreateSignal(Name: string): Signal.Signal?
	assert(Started, "Cannot Create Signal Before The Framework Starts!") --> If The Framework Started

	if Name then --> If Name Exists
		return Signal(Name, "Create") :: Signal.Signal --> Returns Signal Class
	else
		return Signal() :: Signal.Signal --> Returns Signal Class
	end
end
--[=[
	@return Signal?

	Gets a Signal that is refrenced by Name
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetServer()

	local Job = {} --> Example

	Signal = Girra.GetSignal("MySignal")
	Signal:Listen(function(Msg) 
		print("Got A Message:", Msg)
	end)
	```
]=]
function GirraServer.GetSignal(Name: string): Signal.Signal?
	if Name then --> If Name Exists
		local SignalClass = Signal(Name, "Get")
		assert(SignalClass ~= nil, `Failed to get signal make sure signal is created!`)

		return SignalClass :: Signal.Signal --> Returns Signal Class
	else
		Debugger.InternalDebug(warn, "Strict", "Girra Server", `Cannot Get Signal while the name is nil!`) --> Warns a fail and error
	end

	return nil --> returns nil
end --> Gets Signal

--[=[
	@return Network
	Creates a network that communicate between Server-Job and Client-Job
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetServer()

	local Network = Girra.CreateNetwork("MyNetwork")
	Network:Fire([Player], "Hello From Server-Job!")
	```
]=]
function GirraServer.CreateNetwork(Name: string, AutoIdentifier: boolean?): Network.Server<any>?
	if Started then --> If The Framework Started
		return Network.Server(Name, AutoIdentifier or false) :: Network.Server<any> --> Returns a Network Signal Class (Nsc)
	else
		Debugger.InternalDebug(
			warn,
			"Strict",
			"Girra Server",
			`Cannot Create network: {Name} Before The Framework Starts!`
		) --> Warns a fail and error
	end

	return nil --> Fails and returns nil
end

--[=[
	@return (Job) -> ()
	Creates Job
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetServer()

	local MyJob = Girra.CreateJob() {
		Name = "MyJob"
	}
	```

	:::tip requiring() 
	You can create an empty table as a module and then return it and use the CreateJob function putting inside the callback the function
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetServer()

	local MyJob = {
		Name = "MyJob"
	}
	Girra.CreateJob() (MyJob)

	return MyJob --> Can get required and used without .GetJob require(MyJob):DoSomething()
	```
	:::
]=]

function GirraServer.CreateJob(): (Job) -> JobPrivateDef
	return function(Job: any) --> Returns function with table varible
		return CreateJob(Job) :: JobPrivateDef --> Creates the Job
	end
end

--[=[
	@return (Employee) -> ()
	Creates Employee
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetServer()

	local MyEmployee = Girra.CreateEmployee() ({
		Name = "MyEmployee"
	})
	```
]=]
function GirraServer.CreateEmployee(): (Employee) -> Employee
	return function(Employee)
		return CreateEmployee(Employee) :: Employee
	end
end

return table.freeze(GirraServer)
