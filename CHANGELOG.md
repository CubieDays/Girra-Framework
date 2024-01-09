## 1.5.0
- Redocumented and improved documentation
- # String Signals
Instead of storing Signals inside tables you can store them as string!
```lua
local Girra = require(Path.to.girra)

Girra.CreateSignal("MySignal")
Girra.GetSignal("MySignal")
```
- Improved source-code
- Debugger module

## 1.0.0
- ### Employes
We Added Employes to our structure an employ is an object that does one operation to get it you need to hire it via 
```lua
    Job.Hire(EmployName)
```
For more information Go to Docs/Employes
- Fixes and some improvements in performance

## 0.2.4
Looks we are coming to the stable release of girra framework! Here's what we got so far:
- Performance Optimizarions
- Stability  
Internal Errors will not happen alot as we tested the framework alot
- Structure
We didn't like the Plugins, Packages Structure so we mixed them  
To Jobs: Client-Jobs, Server-Jobs

Stay Tuned for our next update!

## 0.0.7
- Revamped and Refreshed the code and orgnaized it
- Intellisense Finished .Begin() function
- Girra uses promises now
- Added Signals

## 0.0.6
- Added Data Library which helps creating Player Data and saving them such as leaderstats
- Finished Documentation
- Updated OnStart function now it uses promise instead of regular callback
- Updated .Start() Function now it uses promises instead of regular functions
- New default loading screen can be enabled via Girra Client Settings

## 0.0.5
- Created Data Library

## 0.0.4
- Created Wally Package for easy setuping Girra

## 0.0.3
- Used FastNet2 Instead of Regular Connections.

## 0.0.2
- Improved Typechecking and code base

## 0.0.1
- Alpha choosed Plugins, Packages structure for Girra