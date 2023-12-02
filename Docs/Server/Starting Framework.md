# Starting Framework

To start the Girra Server-Side Framework on the server, we first need to know what the settings are. You can see the settings in the API [here](https://cubiedays.github.io/Girra/api/GirraServer/#Debugging), after that create a Server-Script defaulty I name it Runtime but you can name it anything else put it in your scripts folder / serverscriptservice and do the following:

## Starting:

### 1. Require Girra Server-Side Framework

```lua
local Girra = require(game.ReplicatedStorage.Packages.Girra):GetServer()
```

### 2. Start the Framework and Customize the Settings:

```lua
local Girra = require(game.ReplicatedStorage.Packages.Girra):GetServer()

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
    print("[ Server Framework ]: Successfully Started!")
end)
```
