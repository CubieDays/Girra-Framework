---
sidebar_position: 5
---

# Networking
Our Network Connection Methods is simillar to RemoteEvents which fires data listens to a callback function and transfer data from localscript to Serverscript

## Creating a Network
To create a network simply you use Girra.CreateNetwork(Name: string) on Server after that you notice it returns a table with some methods like Fire and Listen etc.
```lua
local MyNetwork = Girra.CreateNetwork("MyNetwork")
```
## Getting a Network
Getting network is simple but you should becarful and make sure that networks has been created successfully in the server. You use Girra.GetNetwork(Name: string) on Client which returns a table with some methods or nil value if it didn't find a Network
```lua
local MyNetwork = Girra.GetNetwork("MyNetwork")
```
## Transfering Data From Client to Server ( Client Firing )
To Transfer Data you need to GetNetwork and Use Network:Fire(Data: any | {any}) to Transfer Data but before that make sure the network is listening to any callback function.
```lua
local MyNetwork = Girra.GetNetwork("MyNetwork")
MyNetwork:Fire({Data})
```
## Transfering Data From Server to Client ( Server Firing )
Transfering Data From Server to Client cuts to 3 the first one is Fire(Player, Data) the second is FireAll(Data) and the last is FireExcept(Players: {Player}, Data)
```lua
local MyNetwork = Girra.CreateNetwork("MyNetwork")
MyNetwork:Fire(Player, {Data})
MyNetwork:FireAll({Data})
MyNetwork:FireExcept({Player1, Player2}, {Data})
```
## Receiving Data From Client To Server
Althought you shouldn't worry about data races because girra handles them, but you should be careful that the Network Listens to callback before any Data Transfer happens!
```lua
local MyNetwork = Girra.GetNetwork("MyNetwork")
MyNetwork:Listen(function(Content)
    print(Content)
end)
```
## Receiving Data From Server To Client
Same as client but for server and you need to listen before any Data Transfer or firing method.
```lua
local MyNetwork = Girra.CreateNetwork("MyNetwork")
MyNetwork:Listen(function(Content)
    print(Content)
end)
```