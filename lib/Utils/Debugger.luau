--> Types:
type Settings = {
	Enabled: boolean,
	Prefix: string,
}

type Logs<T> = {
	LogName: T,
}

--> Varibles
local Framework = script.Parent.Parent --> Resources Folder
local Utilities = Framework.Utils --> Utilities Folder
local Runtime = Utilities.Runtime --> Runtime Folder

local Context = require(Runtime.Context) --> Context Module Contains RunServer Runtimes

--> Services:
local LogService = game:GetService("LogService")
local RunService = game:GetService("RunService")
--> Runtime
local Debugger = {}

Debugger.Logs = {}

--> Properties
Debugger.Settings = {
	Enabled = true,
	Prefix = "Framework",
} :: Settings

--> Functions:
function Debugger.InternalDebug<T...>(
	DebugHandler: (Prefix: string, T...) -> (),
	Type: "Default" | "Signal" | "Strict" | "Network",
	Prefix: string,
	...: T...
)
	local Settings = require(Runtime.Settings)
	Prefix = Prefix or Debugger.Settings.Prefix

	local RuntimeContext = {
		Studio = Settings.RuntimeSettings.Debugging.InStudioDebugging and Context.RuntimeContext.Studio, --> InStudio and Debugging Enabled
		InGame = Settings.RuntimeSettings.Debugging.InGameDebugging and Context.RuntimeContext.Server, --> InGame and Debugging Enabled
	} --> Statments for easy understanding

	local NetworkContext = {
		Studio = Settings.RuntimeSettings.Debugging.InStudioDebugging
			and Settings.RuntimeSettings.Debugging.InStudioDebugging.NetworkDebugging
			and Context.RuntimeContext.Studio, --> InStudio and Debugging Enabled
		InGame = Settings.RuntimeSettings.Debugging.InGameDebugging
			and Settings.RuntimeSettings.Debugging.InStudioDebugging.NetworkDebugging
			and Context.RuntimeContext.Server, --> InGame and Debugging Enabled
		InServer = Settings.RuntimeSettings.Debugging.InGameDebugging.NetworkDebugging and RunService:IsServer(),
	}

	local SignalContext = {
		Studio = Settings.RuntimeSettings.Debugging.InStudioDebugging
			and Settings.RuntimeSettings.Debugging.InStudioDebugging.SignalDebugging
			and Context.RuntimeContext.Studio, --> InStudio and Debugging Enabled
		InGame = Settings.RuntimeSettings.Debugging.InGameDebugging
			and Settings.RuntimeSettings.Debugging.InStudioDebugging.SignalDebugging
			and Context.RuntimeContext.Server, --> InGame and Debugging Enabled
		InServer = Settings.RuntimeSettings.Debugging.InGameDebugging.SignalDebugging and RunService:IsServer(),
	}

	if Debugger.Settings.Enabled then
		if Type == "Default" or Type == nil then
			if RuntimeContext.Studio or RuntimeContext.InGame then
				DebugHandler(`[ {Prefix} ]:`, ...)
			end
		elseif Type == "Signal" then
			if SignalContext.Studio or SignalContext.InGame or NetworkContext.InServer then
				DebugHandler(`[ {Prefix} ]:`, ...)
			end
		elseif Type == "Network" then
			if NetworkContext.Studio or NetworkContext.InGame or NetworkContext.InServer then
				DebugHandler(`[ {Prefix} ]:`, ...)
			end
		elseif Type == "Strict" then
			DebugHandler(`[ {Prefix} ]:`, ...)
		end

		if Debugger.Logs[Prefix] then
			for _, Message in table.pack(...) do
				table.insert(Debugger.Logs[Prefix].Message, Message)
			end
		else
			Debugger.Logs[Prefix] = {
				IsInternal = true,
				Message = table.pack(...),
			}
		end
	end
end

function Debugger.Debug<T...>(DebugHandler: (Prefix: string, T...) -> (), Prefix: string, ...: T...)
	local Settings = require(Runtime.Settings).RuntimeSettings.Debugging
	Prefix = Prefix or Debugger.Settings.Prefix

	if
		(Settings.InStudioDebugging.OutputDebugging and Context.RuntimeContext.Studio)
		or Settings.InGameDebugging.OutputDebugging
	then
		DebugHandler(Prefix, ...)

		if Debugger.Logs[Prefix] then
			for _, Message in table.pack(...) do
				table.insert(Debugger.Logs.Message, Message)
			end
		else
			Debugger.Logs[Prefix] = {
				IsInternal = false,
				Message = table.pack(...),
			}
		end
	end
end

function Debugger.GetCallstack(instance): { Source: string, DefinedLine: number }
	local info = debug.info(2, "n")

	return {
		Source = `{instance:GetFullName()}{if info and info ~= "" then string.format(" @ %s", info) else ""}`,
		DefinedLine = debug.info(2, "l"),
	}
end

function Debugger.Clear() --> Clear Function
	table.clear(Debugger.Logs) --> Clears Debugger Logs
	LogService:ClearOutput() --> Clears Output
end

function Debugger.GetLogs(): Logs<any> --> Log Getter
	return Debugger.Logs --> Returns the Log
end

function Debugger.GetLogHistory(
): { { message: string, messageType: Enum.MessageType, timestamp: number } } --> Getting Log History
	return LogService:GetLogHistory() --> Returning Log History
end

return table.freeze(Debugger)
