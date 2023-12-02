# Employes
## Employes In General
An Employ is an object that does not more than one operation.
Employ is like a dependency for a job that can be used to operate something or save something.

## How to Get / Make Employes?
Somewhere there's functions and properties inside your job that automaticly created 
```lua
Job: {
    Fire: (Name: string) -> ()
    Hire: (Name: string) -> Employ
    Employes: { [any]: Employ }
    --> Some Other Methods And Objects
}
```
:::note
Employ's Functions Are not the Same
When Hiring an Employ it will return this table
{ Work: (), Job: {} }

```lua
local Job = Girra.CreateJob() {
    Name = "Test"
}

local Employ = Job.Hire("Employ").Work()
print(Employ.Job.Name) --> Test
```
:::

#### When you can Hire and What Can you hire?
You can hire if the employ is not already working on another job like:
```lua
Job1.Hire("MyEmploy") --> Success Will Continue and Return The Employ
Job2.Hire("MyEmploy") --> Fails and Errors
```
You can only Hire Employes that are required by the default `.Start()` Function and Stored Inside Employes Local Table.

Making Employes is not diffcult or new it's just like creating a job but it has some unique functions different than job functions + passing some functions will be useless
```lua
local Employ = Girra.CreateEmploy() {
    Name = "Employ"
}

function Employ:OnWork()
    print("Worked") --> Working
end

function Employ:OnHire()
    print("Hired") --> Hired
    return function()
        print("Fired") --> Fired
    end
end
```