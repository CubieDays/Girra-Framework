---
sidebar_position: 5
---

# Networking
Girra Framework uses custom networking Library called: FastNet2
Creating networks and networking is so easy firstly create a Network ( from the server )
## Creating & Getting Networks
```lua
--> Server-Side
local Girra = require(game.ReplicatedStorage.Packages.Girra):GetServer()

local MyNetwork = Girra.CreateNetwork("MyNetwork" --[[ Name ]] )
```
After that get the network from the client-side of girra framework:
```lua
local Girra = require(game.ReplicatedStorage.Packages.Girra):GetClient()

local MyNetwork = Girra.GetNetwork("MyNetwork" --[[ Name ]] )
```
## Network Functions
You can see the network functions on the GirraClient, GirraServer Apis.

## Usage
### Server To Client
```lua
--> Server-Side
local Girra = require(game.ReplicatedStorage.Packages.Girra):GetServer()

local MyNetwork = Girra.CreateNetwork("MyNetwork")

repeat task.wait()

until MyNetwork:IsListening()

MyNetwork:FireAll("Hello From Server!") --> Fires for All Players
MyNetwork:Fire([Player], "Hello From Server for 1 Player") --> Fires for one player
MyNetwork:FireExcept({[Player1, Player2]}, "Hello From Server Except players  in table.") --> Fires for all except the players in the table {}
MyNetwork:InvokeAll(function()
    return 5
end) --> Invokes for all players

```
```lua
local Girra = require(game.ReplicatedStorage.Packages.Girra):GetClient()

local MyNetwork = Girra.GetNetwork("MyNetwork" --[[ Name ]] )

MyNetwork:Listen(function(msg)
    print("I Got:", msg)
end)

MyNetwork:Once(function()
    print(" This Connection will die after it gets fired  or Invoked"
end)
```
### Client To Server
```lua
--> Server-Side
local Girra = require(game.ReplicatedStorage.Packages.Girra):GetServer()

local MyNetwork = Girra.CreateNetwork("MyNetwork")

MyNetwork:Listen(function(msg)
    print("Server Got:", msg)
end)
```
```lua
local Girra = require(game.ReplicatedStorage.Packages.Girra):GetClient()

local MyNetwork = Girra.GetNetwork("MyNetwork" --[[ Name ]] )

repeat task.wait()

until MyNetwork:IsListening()

MyNetwork:Fire("Hello From Client")
```