--> Types:
type Settings = {
	Enabled: boolean,
	Prefix: string,
}

type Log = string

type Logs = {
	LogName: Log,
}

--> Varibles
local Resources = script.Parent.Parent --> Resources Folder
local Utilities = Resources.Utils --> Utilities Folder
local Runtime = Utilities.Runtime --> Runtime Folder

local Context = require(Runtime.Context) --> Context Module Contains RunServer Runtimes

--> Services:
local LogService = game:GetService("LogService")

--> Runtime
local Debugger = {}

Debugger.Logs = {} :: Logs

--> Properties
Debugger.Settings = {
	Enabled = true,
	Prefix = "[ Framework ]",
} :: Settings
--> Functions:
function Debugger.Debug(
	DebugHandler: (...any) -> (),
	Data: { any } | any,
	prefix: string,
	Type: number?
): number --> Debug Function
	local Settings = require(Runtime.Settings)

	local Statments = {
		Studio = Settings.RuntimeSettings.Debugging.InStudioDebugging and Context.RuntimeContext.Studio, --> InStudio and Debugging Enabled
		InGame = Settings.RuntimeSettings.Debugging.InGameDebugging and Context.RuntimeContext.Server, --> InGame and Debugging Enabled
	} --> Statments for easy understanding

	local Statments2 = {
		Studio = Settings.RuntimeSettings.Debugging.InStudioDebugging
			and Settings.RuntimeSettings.Debugging.InStudioDebugging.NetworkDebugging
			and Context.RuntimeContext.Studio, --> InStudio and Debugging Enabled
		InGame = Settings.RuntimeSettings.Debugging.InGameDebugging
			and Settings.RuntimeSettings.Debugging.InStudioDebugging.NetworkDebugging
			and Context.RuntimeContext.Server, --> InGame and Debugging Enabled
	}

	--[[local Statments3 = {
		Studio = Settings.RuntimeSettings.Debugging.InStudioDebugging
			and Settings.RuntimeSettings.Debugging.InStudioDebugging.SignalDebugging
			and Context.RuntimeContext.Studio, --> InStudio and Debugging Enabled
		InGame = Settings.RuntimeSettings.Debugging.InGameDebugging
			and Settings.RuntimeSettings.Debugging.InStudioDebugging.SignalDebugging
			and Context.RuntimeContext.Server, --> InGame and Debugging Enabled
	}]]

	prefix = prefix or Debugger.Settings.Prefix --> Prefix Or Default Prefix

	if Debugger.Settings.Enabled then -->  If Debugger is Enabled and AllowDebugging is true
		if Debugger.Logs[prefix] then --> If Log Exists
			if typeof(Debugger.Logs[prefix]) == "table" then --> If log is table
				for _, data in pairs(Data) do --> Loop Throught Data
					table.insert(Debugger.Logs[prefix], data) --> InsertData
				end
			else
				Debugger.Logs[prefix] = Data --> Catch DataLog
			end
		else
			Debugger.Logs[prefix] = Data --> Catch DataLog
		end

		if Type == nil then
			if Statments.Studio or Statments.InGame then --> If Statment if in studio or ingame
				if typeof(Data) == "table" then --> Checks if data is table
					DebugHandler("[ " .. prefix .. " ]" .. ":", table.unpack(Data)) --> Calls Debug Handler with Data
				else
					DebugHandler(prefix .. ":", Data) --> Calls Debug Handler with Data
				end
			end
		else
			if Statments2.Studio or Statments2.InGame then --> If Statment if in studio or ingame
				if typeof(Data) == "table" then --> Checks if data is table
					DebugHandler("[ " .. prefix .. " ]" .. ":", table.unpack(Data)) --> Calls Debug Handler with Data
				else
					DebugHandler(prefix .. ":", Data) --> Calls Debug Handler with Data
				end

				print(Settings)
			end
		end
	end

	return 0 --> Returns 0; Success
end

--> Debugs Network
function Debugger.DebugNetwork(
	NetworkName: string,
	NetworkFirstInit: number, -->
	NetworkLastInit: number,
	Runtimes: string,
	NetworkType: string
): ()
	return Debugger.Debug(print, {
		NetworkName .. " Fired In " .. NetworkLastInit - NetworkFirstInit .. ", Network Type: " .. NetworkType .. "()",
	}, Runtimes, 1) -->  Debugs Network
end

function Debugger.DebugNetworkInvoke(
	NetworkName: string,
	NetworkFirstInit: number,
	NetworkLastInit: number,
	Runtimes: string,
	NetworkType: string
): ()
	return Debugger.Debug(print, {
		NetworkName .. " Invoked In " .. NetworkLastInit - NetworkFirstInit,
		", Network Type: " .. NetworkType .. "()",
	}, Runtimes, 1)
end

function Debugger.DebugDisconnection(
	NetworkName: string,
	NetworkFirstInit: number,
	NetworkLastInit: number,
	Runtimes: string,
	NetworkType: string,
	Disconnection
): ()
	return Debugger.Debug(print, {
		NetworkName .. " " .. Disconnection .. " In",
		NetworkLastInit - NetworkFirstInit .. ", Network Type: " .. NetworkType .. "()",
	}, Runtimes, 1)
end

function Debugger.YieldNetwork(
	NetworkName: string,
	NetworkFirstInit: number,
	NetworkLastInit: number,
	Runtimes: string,
	NetworkType: string
): ()
	return Debugger.Debug(print, {
		NetworkName,
		"Yield" .. " In " .. NetworkLastInit - NetworkFirstInit .. ", Network Type: " .. NetworkType .. "()",
	}, Runtimes, 1)
end

function Debugger.Clear() --> Clear Function
	table.clear(Debugger.Logs) --> Clears Debugger Logs
	LogService:ClearOutput() --> Clears Output
end

function Debugger.GetLogs(): Logs --> Log Getter
	return Debugger.Logs --> Returns the Log
end

function Debugger.GetLogHistory(
): { { message: string, messageType: Enum.MessageType, timestamp: number } } --> Getting Log History
	return LogService:GetLogHistory() --> Returning Log History
end

return table.freeze(Debugger)
