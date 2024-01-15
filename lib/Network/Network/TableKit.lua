--!nocheck
local Index = script.Parent.__Index

return if Index["ffrostflame_tablekit@0.2.4"]:FindFirstChild("girra-framework")
	then require(Index["ffrostflame_tablekit@0.2.4"]["girra-framework"])
	else require(Index["ffrostflame_tablekit@0.2.4"]["tablekit"])
