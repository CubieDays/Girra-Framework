local TableKit = {}

function TableKit.DeepCopy<T>(tableToClone: { [unknown]: unknown }): T
	local clone = table.clone(tableToClone)
	for index, value in clone do
		if typeof(value) == "table" then
			clone[index] = TableKit.DeepCopy(value :: { [unknown]: unknown })
		end
	end
	return clone
end

function TableKit.MergeDictionary<dictionary1, dictionary2>(
	dictionary1: { [unknown]: unknown },
	dictionary2: { [unknown]: unknown }
): dictionary1 & dictionary2
	local newTable = table.clone(dictionary1)

	for key, value in dictionary2 do
		newTable[key] = value
	end

	return newTable
end

function TableKit.Keys(dictionary: { [unknown]: unknown }): { unknown }
	local keyArray = {}

	for key in dictionary do
		table.insert(keyArray, key)
	end

	return keyArray
end

function TableKit.Values<T>(dictionary: { [unknown]: T }): { T }
	local valueArray = {}

	for _, value in dictionary do
		table.insert(valueArray, value)
	end

	return valueArray
end

function TableKit.MergeArrays<a, b>(a: { unknown }, b: { unknown }): a & b
	local result = table.clone(a)
	table.move(b, 1, #b, #result + 1, result)
	return result
end

function TableKit.Reconcile(original: { [unknown]: unknown }, reconcile: { [unknown]: any })
	local tbl = table.clone(original)

	for key, value in reconcile do
		if tbl[key] == nil then
			if typeof(value) == "table" then
				tbl[key] = TableKit.DeepCopy(value)
			else
				tbl[key] = value
			end
		elseif typeof(reconcile[key]) == "table" then
			if typeof(value) == "table" then
				tbl[key] = TableKit.Reconcile(value, reconcile[key])
			else
				tbl[key] = TableKit.DeepCopy(reconcile[key])
			end
		end
	end

	return tbl
end

function TableKit.IsArray(mysteryTable: { [unknown]: unknown }): boolean
	local count = 0
	for _ in mysteryTable do
		count += 1
	end
	return count == #mysteryTable
end

function TableKit.IsDictionary(mysteryTable: { [unknown]: unknown }): boolean
	local count = 0
	for _ in mysteryTable do
		count += 1
	end
	return count ~= #mysteryTable
end

function TableKit.ToString(obj: { [unknown]: unknown }): string
	local result = {}
	for key, value in obj do
		local stringifiedKey
		if typeof(key) == "string" then
			stringifiedKey = `"{tostring(key)}"`
		else
			stringifiedKey = tostring(key)
		end

		local stringifiedValue
		local valueToString = tostring(value)
		if typeof(value) == "string" then
			stringifiedValue = `"{valueToString}"`
		else
			stringifiedValue = valueToString
		end

		local newline = `	[{stringifiedKey}] = {stringifiedValue}`
		table.insert(result, newline)
	end
	return "{\n" .. table.concat(result, "\n") .. "\n}"
end

function TableKit.ToArrayString(obj: { [number]: unknown }): string
	local result = {}
	for _, value in obj do
		local stringifiedValue
		local valueToString = tostring(value)
		if typeof(value) == "string" then
			stringifiedValue = `"{valueToString}"`
		else
			stringifiedValue = valueToString
		end

		table.insert(result, stringifiedValue)
	end
	return "{" .. table.concat(result, ", ") .. "}"
end

function TableKit.From(value: any): { any }
	local valueType = typeof(value)
	if valueType == "string" then
		return string.split(value, "")
	elseif valueType == "Color3" then
		return { value.R, value.G, value.B }
	elseif valueType == "Vector2" then
		return { value.X, value.Y }
	elseif valueType == "Vector3" then
		return { value.X, value.Y, value.Z }
	elseif valueType == "NumberSequence" then
		return value.Keypoints
	elseif valueType == "Vector3int16" then
		return { value.X, value.Y, value.Z }
	elseif valueType == "Vector2int16" then
		return { value.X, value.Y }
	else
		return { value }
	end
end

function TableKit.Filter<T>(arr: { [number]: T }, callback: (value: T) -> boolean)
	local tbl = {}

	for _, value in arr do
		if callback(value) then
			table.insert(tbl, value)
		end
	end

	return tbl
end

function TableKit.Some(tbl: { [unknown]: unknown }, callback: (value: unknown) -> boolean): boolean
	for _, value in tbl do
		if callback(value) == true then
			return true
		end
	end
	return false
end

function TableKit.IsFlat(tbl: { [unknown]: unknown }): boolean
	for _, v in tbl do
		if typeof(v) == "table" then
			return false
		end
	end
	return true
end

function TableKit.Every(tbl: { [unknown]: unknown }, callback: (unknown) -> boolean): (boolean, unknown?)
	for key, value in tbl do
		if not callback(value) then
			return false, key
		end
	end
	return true
end

function TableKit.HasKey(dictionary: { [any]: unknown }, key: any): boolean
	return dictionary[key] ~= nil
end

function TableKit.HasValue(tbl: { [unknown]: unknown }, value: unknown): boolean
	for _, v in tbl do
		if v == value then
			return true
		end
	end
	return false
end
function TableKit.IsEmpty(mysteryTable: { [unknown]: unknown }): boolean
	return next(mysteryTable) == nil
end

return table.freeze(TableKit)
