---
sidebar_position: 5
---
# Networking

Our network connection methods are similar to RemoteEvents, which fires data, listens to a callback function, and transfers data from localscript to serverscript.

## Creating a Network

To create a network, simply use `Girra.CreateNetwork(Name: string)` on the server. After that, you will notice that it returns a table with some methods like `Fire` and `Listen`, etc.

```lua
local MyNetwork = Girra.CreateNetwork("MyNetwork")
```

## Getting a Network

Getting a network is simple, but you should be careful and make sure that the network has been created successfully on the server. You use `Girra.GetNetwork(Name: string)` on the client, which returns a table with some methods or a nil value if it didn’t find a network.

```lua
local MyNetwork = Girra.GetNetwork("MyNetwork")
```

## Transferring Data From Client to Server (Client Firing)

To transfer data, you need to get the network and use `Network:Fire(Data: any | {any})` to transfer data. But before that, make sure the network is listening to any callback function.

```lua
local MyNetwork = Girra.GetNetwork("MyNetwork")
MyNetwork:Fire({Data})
```

## Transferring Data From Server to Client (Server Firing)

Transferring data from server to client cuts to 3. The first one is `Fire(Player, Data)`, the second is `FireAll(Data)`, and the last is `FireExcept(Players: {Player}, Data)`.

```lua
local MyNetwork = Girra.CreateNetwork("MyNetwork")
MyNetwork:Fire(Player, {Data})
MyNetwork:FireAll({Data})
MyNetwork:FireExcept({Player1, Player2}, {Data})
```

## Receiving Data From Client to Server

Although you shouldn’t worry about data races because Girra handles them, you should be careful that the network listens to the callback before any data transfer happens!

```lua
local MyNetwork = Girra.GetNetwork("MyNetwork")
MyNetwork:Listen(function(Content)
    print(Content)
end)
```

## Receiving Data From Server to Client

Same as client but for server, and you need to listen before any data transfer or firing method.
```lua
local MyNetwork = Girra.CreateNetwork("MyNetwork")
MyNetwork:Listen(function(Content)
    print(Content)
end)
```