--!strict
local PATTERN = "[ Girra ]: "

local Output = {}

type allTypes = "string" | "number" | "function" | "table"

function Output.silent(...)
	--if RunService:IsStudio() then
	--print(`{PATTERN}{info}`)
	--end

	Output[...] = ...
end

function Output.log(...)
	Output[...] = ...
end

function Output.logAssert(...)
	Output[...] = ...
end

function Output.warn()
	--warn(`{PATTERN}{info}`)
end

function Output.warnAssert(...)
	Output[...] = ...
end

--[[
	PLEASE READ:

	If you were taken here by the stack trace, go a few traces down! BridgeNet2 sadly clutters the stack trace
	because it does thread reusage and because it has these logging utility functions.
]]

function Output.typecheck(expectedType: allTypes, funcName: string, paramName: string, param: unknown)
	local resultType: allTypes = typeof(param) :: allTypes

	if not (resultType == expectedType) then
		error(`{PATTERN}{funcName} parameter {paramName} takes {expectedType}, got {resultType}`, 0)
	end
end

function Output.fatal(info: string)
	warn(`[ Girra ]: {info}`)
end

function Output.fatalAssert(condition: boolean, info: string)
	if not condition then
		error(`{PATTERN}{info}`, 0)
	end
end

--[[
	PLEASE READ:
	
	If you were taken here by the stack trace, go a few traces down! BridgeNet2 sadly clutters the stack trace
	because it does thread reusage and because it has these logging utility functions.
]]

return Output
