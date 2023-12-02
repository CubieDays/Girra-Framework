--[=[
    @class Data
    Data Library simplifies creating player datas such as: leaderstats, cash etc.
    Data Library uses ProfileService to create DataStores
]=]

--[=[
    @interface Profile
    @within Data
    .Player {Data: {...: any}}
]=]

--[=[
@interface DataStore
@within Data
.Get (self: Data, Player: Player, Key: string) -> ()
.Set (self: Data, Player: Player, Key: string, Value: any) -> ()
.Update (self: Data, Player: Player, Key: string, Callback: (OldData) -> ())
]=]

--> Game Services:
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

--> Services:
local ProfileService = require(script.Service)
local TableService = require(script.Parent.Table)

--> Data Table:
local Data = {}

--> Metamethods:
Data.__index = Data

--> Types:
type Data = {
	Get: (self: any, Player: Player, Key: string) -> (),
	Set: (self: any, Player: Player, Key: string, Value: any) -> (),
	GetProfile: (self: any, Player: Player) -> (),
	Update: (self: any, Player: Player, Key: string, Callback: (OldData: string) -> ()) -> (),
}

type Profile = {
	any: any,
}

--> Local Functions:
local function GetProfile(Player: Player, Profile)
	if Player:IsA("Player") then
		assert(Data[Profile][Player.Name], "[ Data ]: Profile Does not exist")

		return Data[Profile][Player.Name]
	end
end

function recurseTable(tbl, func)
	for index, value in pairs(tbl) do
		if type(value) == "table" then
			recurseTable(value, func)
		else
			func(index, value)
		end
	end
end

--> Functions:
--[=[
@within Data
@return Data
This is the main function which creates a new data with the given name and the given table
```lua
local Data = Framework:GetData()
local NewData = Data.new("leaderstats", {
    ["Cash"] = 15,
})
```
It Returns a metatable of empty table and Data which have .__index metamethod.
]=]
function Data.new(Name: string, DataTable: { any: any }): typeof(Data)
	Data[Name .. "Profiles"] = {}

	local self = setmetatable({}, Data)

	local ProfileStore = ProfileService.GetProfileStore(Name .. "Store", DataTable)

	local function PlayerAdded(Player: Player)
		local Stats = Instance.new("Folder")

		Stats.Parent = Player
		Stats.Name = Name

		TableService.TableToFolder(DataTable, Stats)

		Player:SetAttribute("Ready", true)

		local Profile = ProfileStore:LoadProfileAsync("User=" .. Player.UserId)

		if Profile then
			Profile:AddUserId(Player.UserId)
			Profile:Reconcile()

			Profile:ListenToRelease(function()
				Data[Name .. "Profiles"][Player.Name] = nil

				Player:Kick()
			end)

			if not Player:IsDescendantOf(Players) then
				Profile:Release()
			else
				Data[Name .. "Profiles"][Player.Name] = Profile
			end
		else
			Player:Kick()
		end

		local function Update(Table)
			for _, Currency in Table do
				if type(Currency) == "table" then
					Update(Currency)
				else
					for _, Object in Stats:GetDescendants() do
						if Object.Name == Name then
							Object.Value = Currency
						end
					end
				end
			end
		end

		RunService.Heartbeat:Connect(function()
			Update(Profile.Data)
		end)
	end

	Players.PlayerAdded:Connect(PlayerAdded)

	for _, Player in Players:GetPlayers() do
		if not Player:GetAttribute("Ready") then
			PlayerAdded(Player)
		end
	end

	Players.PlayerRemoving:Connect(function(Player: Player)
		if Data[Name .. "Profiles"][Player.Name] then
			Data[Name .. "Profiles"][Player.Name]:Release()
		end
	end)

	self.Name = Name .. "Profiles"

	return self
end
--[=[
@within Data
@return Data
This function Gets created data From The Data Library
```lua
local Data = Framework:GetData()
local NewData = Data.new("leaderstats", {
    ["Cash"] = 15,
})

Data:GetData("leaderstats"):Set([Player], "Cash", 200)
```
It Returns a metatable of empty table and Data which have .__index metamethod.
]=]
function Data.GetData(Name: string)
	local self = setmetatable(Data[Name .. "Profiles"], Data)

	assert(self, "Couldn't find Data:" .. Name)

	self.Name = Name .. "Profiles"

	return self
end

--[=[
    @within Data
    This function returns the profile of the player
    ```lua
    local Data = Framework:GetData()
    local MyData = Data.new("leaderstats", {})

    local PlayerData = MyData:GetProfile("[PlayerName]")
    ```
    @yields
]=]
function Data:GetProfile(Player: Player)
	local Profile = GetProfile(Player, self.Name)

	return Profile.Data :: Profile
end

--[=[
    @within Data
    ```lua
    local Data = Framework:GetData()
    local MyData = Data.new("leaderstats", {Cash = 15})

    local Cash = MyData:Get("[PlayerName]", "Cash") --> 15
    ```
    This function returns the profilekey of the player Profile
]=]
function Data:Get(Player: Player, Key: string)
	local Profile = GetProfile(Player, self.Name)

	assert(Profile.Data[Key], string.format("Data Does not exist for key: %s", Key))

	return Profile.Data[Key]
end

--[=[
    @within Data
    Same as Get Function but it sets the ProfileKey of the Player Profile
    ```lua
    local Data = Framework:GetData()
    local MyData = Data.new("leaderstats", {Cash = 15})

    local Cash = MyData:Set("[PlayerName]", "Cash", 20) --> 20
    ```
]=]
function Data:Set(Player: Player, Key: string, Value: any)
	print(self)

	local Profile = GetProfile(Player, self.Name)

	assert(Profile.Data[Key], string.format("Data Does not exist for key: %s", Key))
	assert(type(Profile.Data[Key]) == type(Value), "Value Type is not correct for " .. Key)

	Profile.Data[Key] = Value
end

--[=[
    @within Data
    Updates the ProfileKey with The return of the Given Callback function with argument of OldData
    ```lua
    local Data = Framework:GetData()
    local MyData = Data.new("leaderstats", {Cash = 15})

    MyData:Update("[PlayerName]", "Cash", function(Old)
        return Cash + 10 --> 25
    end)

    print(MyData:Get("[PlayerName]", "Cash")) --> 25
    ```
]=]
function Data:Update(Player: Player, Key: string, Callback: (OldData: any) -> ())
	if Player and Player:IsA("Player") then
		local OldData = self:Get(Player, Key)
		local NewData = Callback(OldData)

		self:Set(Player, Key, NewData)
	else
		warn("[ Data ]: Player has left or it's nil")
	end
end

return Data
