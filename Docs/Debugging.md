# Debugger
Debugging in the Girra framework is very easy and effective. Debugging makes you monitor your game and see errors, logs and warnings. You can either delete a log or delete all logs and send a log or warning. You can also see all logs in a table.

## Customization
When Starting Girra it gives you an options to start it most of them related to Debugging and they are:

JobDebugging: Runs when a job initallized and required
SignalDebugging: Runs when a signal is created or when a signal is fired or when a signal disconnected
NetworkDebugging: Same as SignalDebugging but for Network
OutputDebugging: Things that Developer Debugs and used the girra's framework Debugger

Debugging has cut to two the first one is InGameDebugging and the second is InStudioDebugging 
InGameDebugging Debugs things inside real-time game while InStudioDebugging Debug things inside studio.
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
## Debugging
Debugging is very simple use the Debugger.Debug() function and that will debug make sure to enable debugging via OutputDebugging Configuration.
```lua
local Debugger = Girra.Libs.Debugger
Debugger.Debug(warn, "Log", "An error occurred")
```