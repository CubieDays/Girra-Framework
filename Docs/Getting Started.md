---
sidebar_position: 3
---
## Getting Started
Girra is a Roblox game framework that uses a unique structure called **Jobs & Employees**. A job is like a core script of the game, and an employee will help a specific job or multiple jobs. Helping multiple jobs is called a **Shared Employee**, and helping one job is called a **Solo Employee**.

To get started with Girra, you need to call the `Girra.Start(ServerScriptService)({...})` method In your main script. The `...` parameter is a table that contains the following configurations:

```lua
Debugging = {
    InGameDebugging = {
        SignalDebugging = true,
        NetworkDebugging = true,
        JobDebugging = false,
        OutputDebugging = false,
    },
    InStudioDebugging = {
        SignalDebugging = true,
        NetworkDebugging = true,
        JobDebugging = true,
        OutputDebugging = true,
    }
}
```
## Creating an Employee

To create an employee, use the `Girra.CreateEmployee() ({...})` method. The employee should have the following properties and functions:
- `OnHire()`: This function returns a function called `Cleanup`.
- `OnWork()`: This function is used specifically for loops but can be used in real-time. You can spawn it via `Employee.Work(void)`.
The properties are:
- `EmployeeName`: The name of the employee.
## Hiring an Employee

To make an employee help a job, use the `Job.Hire(EmployeeName)` function.

I hope this helps! Let me know if you have any other questions.
## Creating a Job

To create a job, use the `Girra.CreateJob() ({...})` method. A job should have the following properties and functions:
- `OnInit()`: This function is used for initializing the game for future use, such as creating a network or getting it, creating a signal, or adding some properties to the job.
- `OnStart()`: This function is used for doing some future purposes, such as hiring an employee, using a job’s function, or creating a class.
- `OnStep()` \[ Optional ]: This function is used for loops but can be used in real-time.
- `OnRender` \[ Client ], \[ Optional ]: This function is used for rendering on the client-side.
- `OnHeart()` \[ Optional ]: This function is used for heartbeats.

The properties are:

- `Name`: The name of the job.
- `Any` \[ Any ]: Any value, including strings, numbers, booleans, and threads.

## Communicating with Jobs

To communicate with jobs, you can use `Girra.GetJob(Name)` or require the module. However, you shouldn’t make the module like this for requiring the module:

```lua
local Job = Girra.CreateJob () ({
    Name = "Job"
})
return Job
```

Instead, you should use:

```lua
local Job = { Name = "Job" }
Girra.CreateJob() (Job)
return Job 
```


Here's examples for creating Jobs & Employees.
### Creating a  job

```lua
local SomeJob = { Name = "SomeJob" }

function SomeJob:OnInit()
  print("Initialized!")
end

function SomeJob:OnStart()
  print("Started!")
end

function SomeJob:OnStep()
  print("Loop")
end

function SomeJob:OnRender() --> Render Looping
  print("Render Loop (RenderStepped)")
end

function SomeJob:OnHeart()
  print("Heartbeated")
end

Girra.CreateJob() (SomeJob)
return SomeJob
```

### Creating an employee.

```lua
local SomeEmployee = Girra.CreateEmployee() {
  Name = "SomeEmployee"
}

function SomeEmployee:OnHire()
  local Connection = SomeConnection
  return function()
    Connection:Disconnect()
  end
end

function SomeEmployee:OnWork()
  print("Worked")
end 

return SomeEmployee
```

Lastly, getting jobs is not preferred, and you can instead use classes that help jobs with multiple tasks, unlike employees, or use modules.