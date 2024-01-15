--!nocheck
local Index = script.Parent.__Index

return if Index["ffrostflame_wally-instance-manager@0.1.0"]:FindFirstChild("girra-framework")
	then require(Index["ffrostflame_wally-instance-manager@0.1.0"]["girra-framework"])
	else require(Index["ffrostflame_wally-instance-manager@0.1.0"]["wally-instance-manager"])
