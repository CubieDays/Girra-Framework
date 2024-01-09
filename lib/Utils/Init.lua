local Util = {}

function Util.GetUtil(Name: string)
	assert(script[Name] ~= nil, "Utility is nil or missing!")
	return require(script[Name])
end

return Util
