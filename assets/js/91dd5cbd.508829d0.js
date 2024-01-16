"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[741],{62210:e=>{e.exports=JSON.parse('{"functions":[{"name":"Start","desc":"Starts Girra on the Server-Side!\\n```lua\\nlocal Girra = require(game.ReplicatedStorage.Girra):GetServer()\\n\\nGirra.Start(0) {\\n\\tDebugging = {\\n\\t\\tInGameDebugging = { SignalDebugging = false }\\n\\t\\tInStudioDebugging = { SignalDebugging = true }\\n\\t}\\n}\\n\\n--\x3e 0 Means default GameLocation Location which is playerscripts\\n```","params":[{"name":"GameLocation","desc":"","lua_type":"Instance\\n"}],"returns":[{"desc":"","lua_type":"() -> (Settings)"}],"function_type":"static","yields":true,"source":{"line":702,"path":"lib/Server/Init.luau"}},{"name":"OnStart","desc":"Returns an RBXScriptConnection.\\n```lua\\nlocal Girra = require(game.ReplicatedStorage.Girra):GetServer()\\n\\nGirra.OnStart(function()\\n\\tprint(\\"Started!\\")\\nend)\\n```\\nRuns when Girra Framework Starts on Server!\\n:::caution\\nThis function should be on top of .Start() function\\n:::","params":[{"name":"callback","desc":"","lua_type":"(T...) -> ()"}],"returns":[{"desc":"","lua_type":"RBXScriptConnection"}],"function_type":"static","source":{"line":746,"path":"lib/Server/Init.luau"}},{"name":"GetJob","desc":"Gets a Job From the Jobs Folder.\\n```lua\\nlocal Girra = require(game.ReplicatedStorage.Girra):GetServer()\\n\\nGirra.GetJob(\\"MyJob\\"):DoSomething()\\n```","params":[{"name":"Name","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"Job"}],"function_type":"static","source":{"line":761,"path":"lib/Server/Init.luau"}},{"name":"CreateSignal","desc":"Creates a Signal that can be used to intract with Job to Job\\n```lua\\nlocal Girra = require(game.ReplicatedStorage.Girra):GetServer()\\n\\nlocal Job = {} --\x3e Example\\n\\nJob.Signal = Girra.CreateSignal()\\nJob.Signal:Fire(\\"Hello Other Job!\\")\\n```\\n:::note Debugging\\nCurrently Debugging will not work in Signal we will work on updates to make signal debugging\\n:::","params":[{"name":"Name","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"Signal"}],"function_type":"static","source":{"line":783,"path":"lib/Server/Init.luau"}},{"name":"GetSignal","desc":"Gets a Signal that is refrenced by Name\\n```lua\\nlocal Girra = require(game.ReplicatedStorage.Girra):GetServer()\\n\\nlocal Job = {} --\x3e Example\\n\\nSignal = Girra.GetSignal(\\"MySignal\\")\\nSignal:Listen(function(Msg) \\n\\tprint(\\"Got A Message:\\", Msg)\\nend)\\n```","params":[{"name":"Name","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"Signal?"}],"function_type":"static","source":{"line":807,"path":"lib/Server/Init.luau"}},{"name":"CreateNetwork","desc":"Creates a network that communicate between Server-Job and Client-Job\\n```lua\\nlocal Girra = require(game.ReplicatedStorage.Girra):GetServer()\\n\\nlocal Network = Girra.CreateNetwork(\\"MyNetwork\\")\\nNetwork:Fire([Player], \\"Hello From Server-Job!\\")\\n```","params":[{"name":"Name","desc":"","lua_type":"string"},{"name":"AutoIdentifier","desc":"","lua_type":"boolean?"}],"returns":[{"desc":"","lua_type":"Network"}],"function_type":"static","source":{"line":830,"path":"lib/Server/Init.luau"}},{"name":"CreateJob","desc":"Creates Job\\n```lua\\nlocal Girra = require(game.ReplicatedStorage.Girra):GetServer()\\n\\nlocal MyJob = Girra.CreateJob() {\\n\\tName = \\"MyJob\\"\\n}\\n```\\n\\n:::tip requiring() \\nYou can create an empty table as a module and then return it and use the CreateJob function putting inside the callback the function\\n```lua\\nlocal Girra = require(game.ReplicatedStorage.Girra):GetServer()\\n\\nlocal MyJob = {\\n\\tName = \\"MyJob\\"\\n}\\nGirra.CreateJob() (MyJob)\\n\\nreturn MyJob --\x3e Can get required and used without .GetJob require(MyJob):DoSomething()\\n```\\n:::","params":[],"returns":[{"desc":"","lua_type":"(Job) -> ()"}],"function_type":"static","source":{"line":870,"path":"lib/Server/Init.luau"}},{"name":"CreateEmployee","desc":"Creates Employee\\n```lua\\nlocal Girra = require(game.ReplicatedStorage.Girra):GetServer()\\n\\nlocal MyEmployee = Girra.CreateEmployee() ({\\n\\tName = \\"MyEmployee\\"\\n})\\n```","params":[],"returns":[{"desc":"","lua_type":"(Employee) -> ()"}],"function_type":"static","source":{"line":888,"path":"lib/Server/Init.luau"}}],"properties":[{"name":"Services","desc":"Refrence to Used Game Services example:\\n```lua\\nlocal Girra = require(game.ReplicatedStorage.Girra):GetServer()\\nlocal Services = Girra.Services\\n\\n--\x3e InputBegan Function:\\nServices.UserInputService.InputBegan:Connect(function()\\n\\nend)\\n```","lua_type":"Services","readonly":true,"source":{"line":138,"path":"lib/Server/Init.luau"}},{"name":"CplAccess","desc":"Used to refrence who can access and view serverJobs in ControlPanel by opening it ( Control + G )","lua_type":"{ number }","source":{"line":145,"path":"lib/Server/Init.luau"}}],"types":[{"name":"Debugging","desc":" \\nDebugging Settings","lua_type":"{InGameDebugging: {JobDebugging: boolean, SignalDebugging: boolean, NetworkDebugging: boolean}, InStudioDebugging: {JobDebugging: boolean, SignalDebugging: boolean, NetworkDebugging: boolean}}","source":{"line":63,"path":"lib/Server/Init.luau"}},{"name":"Settings","desc":":::note Used by Girra.Start()\\nThis Type Is used for Girra.Start() Function\\n:::\\n\\n\\t","lua_type":"{Debugging: Debugging}","source":{"line":73,"path":"lib/Server/Init.luau"}},{"name":"Job","desc":"Class Job of GirraServer Which Is Module.","fields":[{"name":"Name","lua_type":"string","desc":""},{"name":"OnInit","lua_type":"() -> ()","desc":""},{"name":"OnStart","lua_type":"() -> ()","desc":""},{"name":"OnStep","lua_type":"(deltaTime: number) -> ()","desc":""},{"name":"Heartbeat","lua_type":"(deltaTime: number) -> ()","desc":""},{"name":"Fire","lua_type":"(Name: string) -> ()","desc":""},{"name":"Hire","lua_type":"(Name: string) -> HiredEmployee","desc":""},{"name":"Employees","lua_type":"{ [any]: { Work: () } }","desc":""}],"source":{"line":89,"path":"lib/Server/Init.luau"}},{"name":"HiredEmployee","desc":"Class Employee of GirraServer Which Is Module.","fields":[{"name":"Job","lua_type":"Job","desc":""},{"name":"Work","lua_type":"()","desc":""}],"source":{"line":98,"path":"lib/Server/Init.luau"}},{"name":"Employee","desc":"Class Employee of GirraServer Which Is Module.","fields":[{"name":"Name","lua_type":"string,","desc":""},{"name":"OnWork","lua_type":"(self: any),","desc":""},{"name":"OnHire","lua_type":"(self: any)","desc":""}],"source":{"line":108,"path":"lib/Server/Init.luau"}},{"name":"Services","desc":"Type Services of GirraServer Which IsA Table Contains Game-Services.","fields":[{"name":"Players","lua_type":"Players","desc":""},{"name":"UserInputService","lua_type":"UserInputService","desc":""},{"name":"RunService","lua_type":"RunService","desc":""},{"name":"ReplicatedStorage","lua_type":"ReplicatedStorage","desc":""},{"name":"Workspace","lua_type":"Workspace","desc":""}],"source":{"line":120,"path":"lib/Server/Init.luau"}}],"name":"GirraServer","desc":"The Server-Side Of Girra Let\'s you Create Server Networks and Signals and Jobs.\\n\\nGetting Girra Server:\\n```lua\\nlocal Girra = require(game.ReplicatedStorage.Girra):GetServer()\\n\\n--\x3e Starting Girra:\\nGirra.Start(0) {\\n\\tDebugging = {\\n\\t\\tInGameDebugging = {\\n\\t\\t\\tJobDebugging = false,\\n\\t\\t\\tNetworkDebugging = false,\\n\\t\\t\\tSignalDebugging = false\\n\\t\\t};\\t\\n\\t\\tInStudioDebugging = {\\n\\t\\t\\tJobDebugging = true,\\n\\t\\t\\tNetworkDebugging = true,\\n\\t\\t\\tSignalDebugging = true,\\n\\t\\t}\\n\\t}\\n}\\n\\n--\x3e 0 Means The Default Jobs Folder Location: game.ServerScriptService.Jobs\\n```","realm":["Server"],"source":{"line":56,"path":"lib/Server/Init.luau"}}')}}]);