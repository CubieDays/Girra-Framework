---
sidebar_position: 4
---

# Signals
Our Event Connection Methods is simillar to RBXScriptSignal by Roblox it's a class which fires data listens to a callback function and transfer data from script to script or modulescript to script. 

## Transfering Data ( Firing )
To transfer data first we need to create our signal but before that we should introduce you refrencedSignal and UnrefrencedSignal.

### Refrenced Signal
A refrenced signal is a signal that you can use by name and get it by name
creating it is by using the girra's .CreateSignal(Name: string?) expect that you put a name in the arg1 as it's not required not putting a name will create an unRefrencedSignal.
```lua
local RefrencedSignal = Girra.CreateSignal("RefrencedSignal")
```
### unRefrencedSignal
An unRefrencedSignal is a signal that does not have a name and should be stored somewhere to get it
Creating an unRefrencedSignal is simple use the girra's .CreateSignal(Name: string?) expect the opposite from RefrencedSignal you don't put anything on arg1 or nil.
```lua
local RefrencedSignal = Girra.CreateSignal("RefrencedSignal")
```
And Then you can get it from other scripts by girra's .GetSignal(Name: string)
```lua
local RefrencedSignal = Girra.GetSignal("RefrencedSignal")
```
## Why Refrenced and UnRefrenced?
When you are trying to get a signal by the fastest way without getting it from a stored table you use strings and thats always the better but what's about UnRefrenced? unrefrencedSignal is always used for ( Classes ) and should only be like if you are making a car a good developer should know that classes will make his development easier and use Classes but alot of developers use methods for classes only if you look at roblox's part instance you should know it's in scripting is just a table that stores properties, Childerens but Part instance have: Methods, Properties, RBXScriptSignals making a car class with signals will make you comfortable and looks like you created a custom instance that's cool with properties and methods and Signals.
### Transfering Data ( Firing )
To transfer data you need to CreateSignal and then use the :Fire(Content: any | { any }) Method.
With your data in content which is 1 argument and not a tuple if you want to send multiple data use Table.
```lua
local Girra = require("Path.To.Girra")

local Signal = Girra.CreateSignal()

Signal:Fire("Hello World!")
Signal:Fire({
    "This is my data"
})
```
## Receiving Data ( Listening )
To recieve data you need to GetSignal or Create then use the :Listen(Callback: (Content: any | {any}))
```lua
local Girra = require("Path.To.Girra")

local Signal = Girra.CreateSignal()

Signal:Listen(function(Content: {any} | any) 
    print(Content)
end)
```
## Transfering on creator script
Transfering on creator script means creating a signal and transfering data in the same script before doing that you should listen as if you fire before listening data will not send to the listened callback function so you do these instructions:
- Create Signal
- Wait for Listening
- Transfer Data
## Receiving on creator script
You shouldn't worry on Receiving on creatorscript but you should becareful on waiting a bit of time and listen after couple of seconds after creating signal as if the other scripts fire data it will not recieve so you do these instructions:
- Create Signal
- Listen Immediately