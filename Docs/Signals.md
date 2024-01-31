---
sidebar_position: 4
---
# Signals

Our event connection methods are similar to RBXScriptSignal by Roblox. It’s a class that fires data, listens to a callback function, and transfers data from script to script or modulescript to script.

## Transferring Data (Firing)

To transfer data, we first need to create our signal. But before that, we should introduce you to `ReferencedSignal` and `UnreferencedSignal`.

### Referenced Signal

A referenced signal is a signal that you can use by name and get it by name. Creating it is by using Girra’s `.CreateSignal(Name: string?)`. Expect that you put a name in the arg1 as it’s not required not putting a name will create an unreferencedSignal.

```lua
local ReferencedSignal = Girra.CreateSignal("ReferencedSignal")
```

### Unreferenced Signal

An unreferencedSignal is a signal that does not have a name and should be stored somewhere to get it. Creating an unreferencedSignal is simple. Use Girra’s `.CreateSignal(Name: string?)`. Expect the opposite from ReferencedSignal. You don’t put anything on arg1 or nil.

```lua
local UnreferencedSignal = Girra.CreateSignal()
```

And then you can get it from other scripts by storing it in a table and then retrieving it from that table. Here is an example:

```lua
local mySignal = Girra.CreateSignal()

-- Store the signal in a table
local myTable = {}
myTable.mySignal = mySignal

-- Retrieve the signal from the table
local retrievedSignal = myTable.mySignal
```

## Why Referenced and Unreferenced?

When you are trying to get a signal by the fastest way without getting it from a stored table, you use strings, and that’s always better. But what’s about Unreferenced? UnreferencedSignal is always used for classes and should only be like if you are making a car. A good developer should know that classes will make his development easier and use classes. But a lot of developers use methods for classes. Only if you look at Roblox’s part instance, you should know it’s in scripting is just a table that stores properties, children, but Part instance has: methods, properties, RBXScriptSignals. Making a car class with signals will make you comfortable.
### Transfering Data (Firing)

To transfer data, you need to create a signal and then use the `:Fire(Content: any | { any })` method. With your data in `Content`, which is 1 argument and not a tuple. If you want to send multiple data, use a table.

```lua
local Girra = require("Path.To.Girra")

local Signal = Girra.CreateSignal()

Signal:Fire("Hello World!.");
Signal:Fire({
    "This is my data."
});
```

## Receiving Data (Listening)

To receive data, you need to get a signal or create one and then use the `:Listen(Callback: (Content: any | {any}))` method.

```lua
local Girra = require("Path.To.Girra")

local Signal = Girra.CreateSignal()

Signal:Listen(function(Content: {any} | any) {
    print(Content);
});
```

## Transferring on Creator Script

Transferring on creator script means creating a signal and transferring data in the same script. Before doing that, you should listen. If you fire before listening, data will not be sent to the listened callback function. So you should follow these instructions:

- Create Signal
- Wait for Listening
- Transfer Data

## Receiving on Creator Script

You shouldn’t worry about receiving on creator script, but you should be careful and wait a bit of time before listening after creating a signal. If the other scripts fire data, it will not receive. So you should follow these instructions:

- Create Signal
- Listen Immediately