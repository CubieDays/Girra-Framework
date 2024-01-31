---
sidebar_position: 6
---
Here is the fixed version of your markdown file:

# Debugger

Debugging in the Girra framework is very easy and effective. It allows you to monitor your game and see errors, logs, and warnings. You can delete a log or delete all logs, and send a log or warning. You can also see all logs in a table.

## Customization

When starting Girra, it gives you options to start it, most of which are related to debugging. They are:

- JobDebugging: Runs when a job is initialized and required.
- SignalDebugging: Runs when a signal is created, fired, or disconnected.
- NetworkDebugging: Same as SignalDebugging but for network.
- OutputDebugging: Things that developers debug and use the Girra’s framework Debugger.

Debugging has two modes: InGameDebugging and InStudioDebugging. InGameDebugging debugs things inside real-time games, while InStudioDebugging debugs things inside the studio.

```lua
Girra.Start(ServerScriptService) ({
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
})
```

## Debugging

Debugging is very simple. Use the `Debugger.Debug()` function, and that will debug. Make sure to enable debugging via the `OutputDebugging` configuration.

```lua
local Debugger = Girra.Libs.Debugger
Debugger.Debug(warn, "Log", "An error occurred")
```

I hope this helps! Let me know if you have any other questions.