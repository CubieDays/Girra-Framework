# CHANGELOG
## 1.5.5
- Used Custom Network Library Instead of ours.
## 1.5.3

- Bug Fixes For Hiring And Firing an Employee.

## 1.5.2

- Fixed 1.5.0 Parental Errors

## 1.5.0

- Redocumented and improved documentation

- ## String Signals

Instead of storing Signals inside tables you can store them as string!

```lua
local Girra = require(Path.to.girra)

Girra.CreateSignal("MySignal")
Girra.GetSignal("MySignal")
```

- ## Debugging

Added debugging to girra framework.

```lua
local Girra = require(Path.to.girra)

Girra.Libs.Debugger.Debug(print, "[log]:", "Hello World!")
```

- Improved source-code
- Debugger module

## 1.0.0

- Stable Release
