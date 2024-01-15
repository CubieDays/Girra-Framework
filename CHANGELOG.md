## 1.5.0.1
- Fixed 1.5.0 Parental Errors
## 1.5.0
- Redocumented and improved documentation
- # String Signals
Instead of storing Signals inside tables you can store them as string!
```lua
local Girra = require(Path.to.girra)

Girra.CreateSignal("MySignal")
Girra.GetSignal("MySignal")
```
- # Debugging
Added debugging to girra framework.
```lua
local Girra = require(Path.to.girra)

Girra.Libs.Debugger.Debug(warn, "[log]:", "an error happend")
```

- Improved source-code
- Debugger module

## 1.0.0
- Stable Release