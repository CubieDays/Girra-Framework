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

--> Types ↓
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

--> Interfaces ↓
--[=[
	@interface Job
	@within GirraClient
	.Name string
	.OnInit () -> ()
	.OnStart () -> ()
	.OnStep (deltaTime: number) -> ()
	.Heartbeat (deltaTime: number) -> ()
	.OnRender (deltaTime: number)  -> ()
	.Fire (Name: string) -> ()
	.Hire (Name: string) -> HiredEmployee,

	Class Job of GirraClient Which Is Module.
]=]

--[=[
	@interface HiredEmployee
	@within GirraClient
	.Job Job
	.Work ()

	Class Employee of GirraClient Which Is Module.
]=]

--[=[
	@interface Employee
	@within GirraClient
	.Name string
	.OnWork (self: any)
	.OnHire (self: any)

	Class Employee of GirraClient Which Is Module.
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

--> Properties ↓
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

--> Class ↓
local GirraClient = {}
type GirraClient = typeof(GirraClient)

--> Exported Types ↓
export type Promise<T...> = {
	Then: (self: any, OnResolve: ((T...) -> T...)?, OnReject: ((T...) -> T...)?) -> Promise<T...>,
	Await: (self: any) -> T...,
	Finally: (self: any, (Finally: "Pending" | "Rejected" | "Resolved") -> ()) -> Promise<T...>,
	StatusAwait: (self: any) -> "Pending" | "Rejected" | "Resolved",
	Catch: (self: any, Callback: (Error: string) -> ()) -> (),
} --> Type For Promise

--> Types ↓
type Job = {
	Name: string, --> Job Name
	OnInit: (self: Job) -> (), --> Job Function OnInit
	OnStart: (self: Job) -> (), --> Job Function OnStart
	OnStep: (self: Job, DeltaTime: number) -> (), --> Job Function OnStep
	Heartbeat: (self: Job, DeltaTime: number) -> (), --> Job Function Heartbeat
	OnRender: (self: Job, DeltaTime: number) -> (), --> Job function OnRender
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
	OnInit: (self: JobPrivateDef) -> (),
	OnStart: (self: JobPrivateDef) -> (), --> Job Function OnStart
	OnStep: (self: JobPrivateDef, DeltaTime: number) -> (), --> Job Function OnStep
	Heartbeat: (self: JobPrivateDef, DeltaTime: number) -> (), --> Job Function Heartbeat
	OnRender: (self: JobPrivateDef, DeltaTime: number) -> (), --> Job function OnRender
	[any]: (self: JobPrivateDef) -> () | any, --> For any object
} --> Default Job

type Employee = {
	Name: string, --> Employee Name
	OnWork: (self: Employee) -> (), --> Employee OnWork Function
	OnHire: (self: Employee) -> (), --> Employee OnHire Function
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
			JobDebugging: boolean?, --> Debugging Job Require Initallize and Start
			NetworkDebugging: boolean?, --> Network Debugging Fire and Disconnect and Destroy
			SignalDebugging: boolean?, --> Signal Debugging Fire And Disconnect and Destroy
			OutputDebugging: boolean?, --> OutputDebugging for uninternal use if Developer wants to use Girra's Debugger Library.
		},
		InStudioDebugging: {
			JobDebugging: boolean?, --> Debugging Job Initallize and Start
			NetworkDebugging: boolean?, --> Network Debugging Fire and Disconnect and Destroy
			SignalDebugging: boolean?, --> Signal Debugging Fire And Disconnect and Destroy
			OutputDebugging: boolean?, --> OutputDebugging for uninternal use if Developer wants to use Girra's Debugger Library.
		},
	}, --> Debugging
} --> Settings for Girra Framework

type Services = {
	Players: Players, --> Players: Game.Players
	UserInputService: UserInputService, --> UserInputService: Game.UserInputService
	RunService: RunService, --> RunService: Game.RunService
	ReplicatedStorage: ReplicatedStorage, --> ReplicatedStorage: Game.ReplicatedStorage
	Workspace: Workspace, --> Workspace: Game.Workspace
	TweenService: TweenService, --> TweenService: Game.TweenService
	ReplicatedFirst: ReplicatedFirst, --> Game.ReplicatedFirst
} --> Services Type

--> Properties ↓
GirraClient.Services = {
	Players = game:GetService("Players"), --> Players: Game.Players
	UserInputService = game:GetService("UserInputService"), --> UserInputService: Game.UserInputService
	RunService = game:GetService("RunService"), --> RunService: Game.RunService
	ReplicatedStorage = game:GetService("ReplicatedStorage"), --> ReplicatedStorage: Game.ReplicatedStorage
	Workspace = game:GetService("Workspace"), --> Workspace: Game.Workspace
	ReplicatedFirst = game:GetService("ReplicatedFirst"), --> ReplicatedFirst: Game.ReplicatedFirst
	TweenService = game:GetService("TweenService"), --> TweenService: Game.TweenService
} :: Services --> Game Services

GirraClient.Client = GirraClient.Services.Players.LocalPlayer :: Player --> Client Refrence to Player
GirraClient.Gui = GirraClient.Client:WaitForChild("PlayerGui") :: StarterGui --> Refrence to PlayerGui

local Locations = {
	DefaultLocation = GirraClient.Client:WaitForChild("PlayerScripts"),
}

--> Tables ↓
local Debugging = {}
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

--> Requiring Libraries ↓
local Framework = script.Parent
local Utilities = Framework.Utils

--> Packages ↓
local Packages = Framework.Parent
local Promise = require(Packages.Promise)

--> Resources ↓
local Signal = require(Framework.Signal)
local Network = require(Framework.Network)
local Messages = require(Framework.Strings).Client

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
	Job = require(Modules.JobInit),
	Employee = require(Modules.EmpInit),
}

--> Signals ↓
local Start = Signal()

--> Library ↓
GirraClient.Libs = {
	["Promise"] = Promise,
	["Debugger"] = Debugger,
	["Signal"] = Signal,
	["Network"] = Network,
}

--> Girra Client Function Utilities ↓

--> Local Functions ↓
local function InitJobs() --> Job Initter Method
	for _, Job: Job in Jobs do --> Looping Through Jobs
		if Job.OnInit then --> Checking If OnInit Function Exists
			task.spawn(Job.OnInit, Job) --> Running OnInit Function
		else
			Debugging[Job.Name] = {} :: any --> Making Debug Table
			Debugging[Job.Name].NoInit = true --> Setting NoInit To True
		end
	end
end

--> Job Stepped Connection ↓
local function StepJobs()
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

--> Job Render Connection ↓
local function RenderJobs()
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

--> Job Heartbeat Connection ↓
local function HeartbeatJobs()
	task.wait()

	for _, Job in Jobs do --> Looping Through Jobs
		if Job.Heartbeat then --> Checking If Heartbeat Function Exists
			GirraClient.Services.RunService.Heartbeat:Connect(
				function(...) --> Running The Connection: RunService.Heartbeat With (any)
					Job:Heartbeat(...) --> Spawning Heartbeat(...) Function
				end
			)
		elseif Job.OnHeart then
			GirraClient.Services.RunService.Heartbeat:Connect(
				function(...) --> Running The Connection: RunService.Heartbeat With (any)
					Job:OnHeart(...) --> Spawning Heartbeat(...) Function
				end
			)
		else
			Debugging[Job.Name] = { NoHeart = true } :: any --> Making Debug Table Setting NoHeart To: True
		end
	end
end

--> Default Error Catcher Function ↓
local function catchError(err)
	Debugger.InternalDebug(warn, "Strict", Messages.ErrorPrefix, "\n", err) --> Warning
end

--> Job Start Function ↓
local function StartJob(Job: Job)
	--> Starting Job:
	Job:OnStart()
end

--> Start All Jobs Function ↓
local function StartJobs()
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

	if Debugging[Job.Name] and Debugging[Job.Name].NoInit and Debugging[Job.Name].NoStart then --> Checks if the debug is not used by the GirraClient
		warn("[", Job.Name, "]", Messages.NoStartupJob) --> Only Useable Job
	end
end

local function Debug(Job: any, T)
	task.wait()

	--> Settings ↓
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
--> CreateJob Function ↓
local function CreateJob(Job: JobPrivateDef & Job): JobPrivateDef
	local FirstInit = tick()

	TableCheck(Job)

	--> Setup Hidden Functions:
	Job.Employees = {} :: { [any]: { Cleanup: () -> (), Work: () -> () } }

	--[[
		Hires an Employee to a job.
		```lua
		local  Job = GirraClient.CreateJob() ({
			Name = "Test",
		})
		
		local Employee = Job.Hire("TestEmployee")
		Employee.Work()
		```
		]]
	function Job.Hire(EmployeeName: string): InternalEmployeeDef? --> Hire Employees Function
		local Employee = Employees[EmployeeName] --> Gets Employee

		if not Started then
			Debugger.InternalDebug(warn, "Strict", "Girra Client", "Cannot Hire Employees while Girra is not started")
			return
		end

		if Employee.Job then
			Debugger.InternalDebug(warn, `Strict`, Job.Name, `{Employee.Name} Is Already Hired`)
			return nil
		end

		if Employee then
			Employee.Hired:Fire({ Job }) --> Fire
			Employee.Job = Job --> Adds Job to Employee

			Job.Employees[Employee.Name] = Employee --> Adds To Job Employees
		else
			Debugger.InternalDebug(warn, "Strict", Job.Name, `{EmployeeName} Is nil or does not exist!`)
		end

		return Employee :: InternalEmployeeDef
	end

	--[[
		Fires an Employee from a job.
		```lua
		local  Job = GirraClient.CreateJob() ({
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

	--> Diagnostatics
	if Job.Name == nil then
		Debugger.InternalDebug(warn, "Strict", "Girra Client", "Job Name Does Not Exist!") --> Debug
		return Job --> Returns Job
	end --> Checks if name is not nil and if it's then return

	if Jobs[Job.Name] then --> Checks If Job Exists
		Debugger.InternalDebug(warn, `Strict`, "Girra Client", `Job {Job.Name} Already Exists!`) --> Warns GirraClient Already Exists
		return Job --> Returns the table
	end

	Jobs[Job.Name] = Job --> Adds the Job
	task.spawn(Debug, Job, FirstInit) --> Debug Feature

	return Job --> Returns the Job
end

local function CleanupEmployeeable(
	Job: JobPrivateDef,
	Employee: Employee,
	Cleanup: () -> ()
): () --> CREATES Employee CLEANUP FUNCTION
	repeat
		task.wait()
	until Job.Employees[Employee.Name] --> REPEATS UNTIL Employee EXISTS

	Job.Employees[Employee.Name].Cleanup = Cleanup --> ADDS THE CLEANUP FUNCTION
end

local function CreateEmployeeableObject(Employee: PrivateEmployeeDef): () --> CREATES Employee CLEANUP FUNCTION
	repeat
		task.wait()
	until Employee.OnWork -->  REPEATS UNTIL Employee EXISTS

	function Employee.Work(Content: any) -->  WORK FUNCTION
		Employee.Worked:Fire(Content) --> FIRES THE Worked EVENT
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

local function CreateEmployee(Employee: PrivateEmployeeDef): Employee
	TableCheck(Employee) --> Checks if table is correct

	--> Setup Hidden Functions, Varibles:
	Employee.Hired = Signal() --> Creates Hired Signal
	Employee.Worked = Signal() --> Creates Worked Signal

	--> Setup Employee
	if Employee.Name then -->  If Name Exists
		if Employees[Employee.Name] == nil then --> If Employee Didn't got created
			Employees[Employee.Name] = Employee -->  Adds Employee
			task.spawn(CreateEmployeeableObject, Employee) -->  Creates the Object
			task.spawn(CleanupEmployeeableObject, Employee) --> Cleans up the object
		else --> Else
			Debugger.InternalDebug(warn, "Strict", "Girra Client", Employee.Name .. " Already Exists!") --> Warns GirraClient Already Exists
		end
	else --> Else
		Debugger.InternalDebug(warn, "Strict", "Girra Client", "An Employee's Name Does Not Exist!") --> Warns Name Does Not Exist!
	end

	return Employee :: Employee
end

--> SpawnSettings Function ↓
local function StartAlert() --> Spawn Settings Function
	Start:Fire({ Settings }) --> Fire the signal Start and give Settings varible
end

local function UpdateSettings(t: Settings) --> Getting The Settings
	if type(t) == "table" then --> Checking If Settings is table
		Settings = t --> Making the settings to T
		Runtime.RuntimeSettings = t --> Makes RuntimeSettings Globally

		return t --> Returning it
	end

	return Settings :: Settings --> Return The Settings!
end

local function Init(Instance: any) --> Initallize Jobs
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

function StartClient(
	GameLocation: Instance | number
): (Settings: Settings) -> Promise<any> --> Main Function Start The Module Refrence to GirraClient.Start() ({})
	if Started then --> Checks if The Framework is started
		return Promise.Reject(Messages.Started) --> Rejects a promise
	end

	GetLocation(GameLocation) --> Gets Location

	return function(UndefinedSettings: Settings)
		UpdateSettings(UndefinedSettings) --> Update Settings

		return Promise
			.new(function(Resolve: (any) -> ())
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
				StartAlert() --> Fires Start Signal
				HeartbeatJobs()
			end) --> Runs Job:Heartbeat()
			:Catch(function(Err: string) --> Catching Errors
				Debugger.InternalDebug(warn, "Strict", "Girra Client", Messages.InternalError, Err) --> Debug
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

	--[[ 
		0 Is just an example make sure you have a folder in 
		StarterPlayerScripts or PlayerScripts or ReplicatedFirst
		and has these children: {
		Employees: Folder,
		Jobs: Folder,
		Runtime: Script
	}
	]]
	```
]=]
function GirraClient.Start(
	GameLocation: Instance
): (Settings: Settings) -> Promise<any> --> Main Function Start The Module Refrence to GirraClient.Start() ({})
	return function(UndefinedSettings: Settings) --> Returns Function (Settings)
		local Run = StartClient(GameLocation) --> Starts Girra On The Client

		if UndefinedSettings then --> Checks if Settings is not equal to nil
			return Run(UndefinedSettings) --> Making and starting and executing the GirraClient
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
						NetworkDebugging = false,
						SignalDebugging = false,
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
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()

	Girra.OnStart(function()
		print("Started!")
	end)
	```
	Fires when Girra Framework Starts on Client!
	:::caution
	This function should be on top of and before .Start() function runs
	:::
]=]
function GirraClient.OnStart<T...>(Callback: (T...) -> ()): RBXScriptConnection
	return Start:Listen(function(...)
		Callback(...)
	end)
end --> Fires when Starting the Girra Client
--[=[
	@return Job
	Gets a Job From the Jobs Folder.
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()

	Girra.GetJob("MyJob"):DoSomething()
	```
]=]
function GirraClient.GetJob(Name: string): Job
	assert(Started, "Cannot Get Jobs While The Framework isn't started yet!") --> Assertation
	return Jobs[Name] --> Returning The Job from the Jobs Folder
end --> Getting The Job
--[=[
	@return Signal

	Creates a Signal that can be used to intract with scripts and modules
	Signals can be refrenced by string and thats (Recommended) for Jobs and just easier to navigate
	Also it can be used for Classes and that way you don't need to refrence a name here's an example:

	Non Refrenced Signal Object:
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()

	local Job = {} --> Example

	Job.Signal = Girra.CreateSignal()
	Job.Signal:Fire("Hello Other Job!")
	```
	Refrenced Signal Object:
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()

	local Job = {} --> Example

	Signal = Girra.CreateSignal("MySignal")
	Signal:Fire("Hello Other Job!")
	```

	:::note Debugging
	Currently Debugging will not work in Signal we will work on updates to make signal debugging
	:::
]=]
function GirraClient.CreateSignal(Name: string?): Signal.Signal?
	assert(Started, "Cannot Create Signal Before The Framework Starts!") --> If The Framework Started

	if Name then --> If Name Exists
		return Signal(Name, "Create") :: Signal.Signal --> Returns Signal Class
	else
		return Signal() :: Signal.Signal --> Returns Signal Class
	end
end --> Creates Signal

--[=[
	@return Signal?

	Gets a Signal that is refrenced by Name
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()

	local Job = {} --> Example

	Signal = Girra.GetSignal("MySignal")
	Signal:Listen(function(Msg) 
		print("Got A Message:", Msg)
	end)
	```
]=]
function GirraClient.GetSignal(Name: string): Signal.Signal?
	if Name then --> If Name Exists
		local SignalClass = Signal(Name, "Get")
		assert(SignalClass ~= nil, `Failed to get signal make sure signal is created!`)

		return SignalClass :: Signal.Signal --> Returns Signal Class
	else
		assert(Name ~= nil, `Cannot Get Signal while the name is nil!`) --> Warns Fails and Errors
	end

	return nil --> returns nil
end --> Gets Signal

--[=[
	@return Network?

	Gets a network that's created in server-side
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()

	local Network = Girra.GetNetwork("MyNetwork")
	Network:Fire("Hello From Client-Job!")
	```
]=]

function GirraClient.GetNetwork(Name: string, AutoIdentifier: boolean?): Network.Client<any>?
	if Started then --> If The Framework Started
		return Network.Client(Name, AutoIdentifier or false) :: Network.Client<any> --> Returns a Network Signal Class (Nsc)
	else
		Debugger.InternalDebug(
			warn,
			"Strict",
			"Girra Client",
			`Cannot Get Network: {Name} Before The Framework Starts!`
		) --> Warns a fail and error
	end

	return nil --> Fails and returns nil
end

--[=[
	@return (Job) -> Job

	Creates a Job
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()

	local MyJob = Girra.CreateJob() {
		Name = "MyJob"
	}
	```
	:::tip requiring() 
	You can create an empty table as a module and then return it and use the CreateJob function putting inside the callback the function
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()

	local MyJob = {
		Name = "MyJob"
	}
	Girra.CreateJob() (MyJob)

	return MyJob --> Can get required and used without .GetJob require(MyJob):DoSomething()
	```
	:::
]=]
function GirraClient.CreateJob(): (Job) -> JobPrivateDef
	return function(Job: any) --> Returns function with table varible
		return CreateJob(Job) :: JobPrivateDef --> Creates the Job
	end
end --> Creates Job

--[=[
	@return (Employee) -> ()
	Creates AN Employee class
	```lua
	local Girra = require(game.ReplicatedStorage.Girra):GetClient()

	local MyEmployee = Girra.CreateEmployee() ({
		Name = "MyEmployee"
	})
	```
	There's no need to external require as this uses default functions: OnHire(), OnWork()
]=]
function GirraClient.CreateEmployee(): (Employee) -> Employee
	return function(Employee) --> Returns function with table varible
		return CreateEmployee(Employee) :: Employee
	end
end --> Creates Employee

return table.freeze(GirraClient)
