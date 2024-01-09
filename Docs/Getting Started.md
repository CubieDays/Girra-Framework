# Getting Started
Girra Framework is fast and very good supports intellisense with good debugging and great custom structure simillar to services but not really required. This framework has great things that makes development easier like built-in remote-signals by strings and very great network system that uses bridgenet2.

## Starting Framework
Starting Girra Framework in client and server are the same Girra Client and Server have .Start() function which starts the framework althought using it like this Girra.Start() with nothing inside will not do anything you need to setup girra configurations and booleans you can see it in the api or in the debug page whoever you should add a location to your source folder too so it's like Girra.Start(SourceFolder: Instance)
```lua
Girra.Start(ServerScriptService) ({
    Debugging = {
        InGameDebugging = {
            SignalDebugging = true,
            NetworkDebugging = true,
            JobDebugging = false,
            OutputDebugging = false,
        }
        InStudioDebugging = {
            SignalDebugging = true,
            NetworkDebugging = true,
            JobDebugging = true,
            OutputDebugging = true,
        }
    }
})
```
Horray!! we started our framework!
However SourceFolder Should contain various of things.
And they are:
- ### Jobs Folder
- ### Employees Folder
What Jobs? Jobs are things the game is focused on like DataJob or MinigameJob etc.
Why Jobs? Simply our country dosen't have alot of jobs and its hard for you to get hired inthere so I just named my structure as Jobs and Employees why not?
What Employees? Employees Used by jobs that can do not more than one operation they are used in heartbeats and steps alot but you can use them in sync or any ways and they simplify for you reading jobs

## Jobs In General
Jobs shouldn't be alot because they are the core things of the game and you create them For necessity
like if you started your game and you need to create a data for the player you create A dataJob that stores and handles data you mustn't spam Jobs and place alot of methods instead you can create a 2 jobs that classes can use or employees that the 2 jobs can use.
## Creating Job
To create job you use the Girra.CreateJob() (table: {any}) and place some default and custom methods and properties for properties you must put a name for the job in the table for the methods you can use OnInit for initallizing job and OnStart for Starting job and u can use onstep for loops or onheart for loops but for heartbeat and if you are on client u can use OnRender which all have argument of DeltaTime.
```lua
local Job = Girra.CreateJob() ({ Name = "MyJob" })
return Job
```
Althought this way is not great and bad for intellisense you can use a better and easy trick to get intellisense
```lua
local Job = { Name = "MyJob" }
Girra.CreateJob() (Job)
return Job
```
Now! this can work with require() and give intellisense!
For functions we can put them like this:
```lua
local Job = { Name = "MyJob" }

function Job:OnInit() --> Runs when job initallizes
    Job.Hire("MyEmploy")
end

function Job:OnStart() --> Runs when job starts
    Job.Employees.MyEmploy.Work()
end

function Job:OnStep(DeltaTime: number) --> Runs every step
    print(DeltaTime)
end

function Job:OnHeart(DeltaTime: number) --> Runs every heartbeat
    print(DeltaTime)
end

function Job:OnRender(DeltaTime: number) --> Runs every RenderStep
    print(DeltaTime, "Client Only")
end

Girra.CreateJob() (Job)
return Job
```
Great now we put methods and describe them now lets go into Employees.

## Employees in General
Employees, Employees follows jobs they can't do anything with out jobs, you can describe jobs and employees as high classes an employee should get hired from a job and then the job can make him work with .Work() currently Employees arent ready for real use or its rare to find a usecase for them but, we plan for updates on them like giving employees taskes to work on them or something like that
## Creating Employees
Same as creating job but this time you don't need to use intellisense way since Employees have only 2 functions and they are OnHire() and OnWork()
```lua
local Employee = Girra.CreateEmployee() ({ 
    Name = "MyJob" 
})

function Employee:OnWork()
    print("I am working!")
end

function Employee:OnHire()
    print("I Got Hired!")
end

return Employee
```
### In Job-side
Hiring and Firing in Job-Side to Hire an employee you simply do Job.Hire(EmployName) and to fire an employee and remove it you do Job.Fire(EmployName).
```lua
local Job = { Name = "MyJob" }

function Job:OnInit() --> Runs when job initallizes
    Job.Hire("MyEmploy") --> Hiring employe
end

function Job:OnStart() --> Runs when job starts
    Job.Employees.MyEmploy.Work() --> First way
    task.wait(5)

    Job.Fire("MyEmploy")
end

function Job:OnStep(DeltaTime: number) --> Runs every step
    print(DeltaTime)
end

Girra.CreateJob() (Job)
return Job
```
Horray, this is the first way to get a job and hire it but the second one is easier.
```lua
local Job = { Name = "MyJob" }
local Employees = {

}

function Job:OnInit() --> Runs when job initallizes
   Employees.MyEmployee = Job.Hire("MyEmploy") --> Hiring employe
end

function Job:OnStart() --> Runs when job starts
    Employees.MyEmployee.Work() --> First way
    task.wait(5)

    Job.Fire("MyEmploy")
end

function Job:OnStep(DeltaTime: number) --> Runs every step
    print(DeltaTime)
end

Girra.CreateJob() (Job)
return Job
```