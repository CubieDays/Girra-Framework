# Starting Framework

To start the Girra Client-Side Framework on the client, we first need to know what the settings are. You can see the settings in the API [here](https://cubiedays.github.io/Girra/api/GirraClient/#Debugging), after that create a LocalScript defaulty I name it Runtime but you can name it anything else put it in ReplicatedFirst or StarterPlayerScripts / Your Scripts Folder and do the following:

## Starting:

### 1. Require Girra Client-Side Framework

```lua
local Girra = require(game.ReplicatedStorage.Packages.Girra):GetClient()
```

### 2. Start the Framework and Customize the Settings:

```lua
local Girra = require(game.ReplicatedStorage.Packages.Girra):GetClient()

Girra.Start() ({
    Debugging = {
        InStudioDebugging = { 
            JobDebugging = true,
            NetworkDebugging = true,
            SignalDebugging = false,
        }
    };
})

Girra.OnStart(function()
    print("[ Client Framework ]: Successfully Started!")
end)
```