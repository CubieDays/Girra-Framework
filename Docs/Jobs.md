# Jobs 
## What are the Jobs?
Jobs Defines into two: Server-Jobs And Client-Jobs.

## Client Jobs
### Folder Location                                                          
The Best Locations of Client-Jobs Folder are:
- StarterPlayerScripts
- ReplicatedFirst
## Server Jobs
### Folder Locations
The Best Locations of Server-Jobs Folder are:
- ServerStorage
- ServerScriptService
:::danger 
Server Jobs should be always hidden from the client or the source code maybe leaked to exploiters!
:::
  
## Creating Job:
Creating Job is so easy require Girra Framework
and then CreateJob using: .CreateJob() { Name: STRING }
## Example:
```lua
--> Game Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--> Varibles:
local Girra = require(ReplicatedStorage.Packages.Girra):GetClient() --> Or GetServer()

--> Init:
local MyJob = Girra.CreateJob() {
    Name = "MyJob"
}

--> Job Functions:
function MyJob:OnInit() --> Runs when the Job initallized. used for creating events and properties.
end

function MyJob:OnStart() --> Safe for getting other Jobs!

end

function MyJob:OnStep() --> Runs every Step after The Job Initallized

end

function MyJob:Render() --> Runs every frame after the Job Initallized For Client Only!

end

return 0; --> you can use return MyJob; 0 means Jobs cant get required externally from other scripts
```
:::caution
Job Name is necessary! { "MyJob" }
:::

## Client-Job Functions:
Client-Jobs contains 4 main functions that can be used but are not necessary:
### :OnInit() 
- Runs when the Job first initallized 
- Used for creating events and properties.
- Not Save for getting any Job!

:::caution
Don't get Job on this function! .GetJob( name: STRING )
:::
### :OnStart() 
- Runs when the Job started and ready to go
- Used for communicating Job to Job and Client-Job to Server-Job
- Save for getting Jobs!
### :OnStep() 
- Runs every Step: RunService.Stepped
- Used for looping
### :OnRender() 
- Runs every Frame: RunService.RenderStepped
- Used for looping renders like Camera Loops etc and rendering.
- :::tip Client Only!
This function will not be used from Girra if it's on a Server-Job
:::
## Job - Job Communication:
Job Communication is too easy simply we will put 2 Jobs example:
### Job 1:
```lua
--> Init:
local Job1 = Girra.CreateJob() {
    Event = Girra.CreateSignal()
    Name = "Job1"
}

--> Job Functions:
function Job1:OnInit()
    Job1.Event:Listen(function()
        print("Yay!", "I got fired by Other Job!")
    end)
end

function Job1:OnStart()
    local Job2 = Girra.GetJob("Job2")

    Job2:Print("I Love IceCream!")
end

return 0;
```
### Job 2:
```lua
local Job2 = Girra.CreateJob() {
    Name = "MyJob2"
}

--> Job Functions:
function Job2:Print(...: string)
    print("Invoked and Printed:", ...)
end

function Job2:OnStart()
    local Job1 = Girra.GetJob("Job1")
    Job1.Event:Fire()
end

return 0;
```

```md title="Input"
    Invoked and Printed: I Love IceCream
    Yay! I got fired by Other Job!
```

As we can see in this example we created a `signal` and a `function`, `Job1` Invokes Print() function and `Job2` Fires a `signal`. We got the jobs using Girra.GetJob() and this will remove the intellisense because of the way luau works however you can use require(module) instead and this will fix  the intellisense but you  need to start the framework with the `begin` method and instead of creating the job .CreateJob() you just place a normal table with a name and the default functions!

### Creating Signal:
```lua
Girra.CreateSignal()
```
### Creating function:
```lua
function Job:MyFunction() end