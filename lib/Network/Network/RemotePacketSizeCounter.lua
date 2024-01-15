--!nocheck
local Index = script.Parent.__Index

return if Index["pysephwasntavailable_remotepacketsizecounter@2.4.1"]:FindFirstChild("girra-framework")
	then require(Index["pysephwasntavailable_remotepacketsizecounter@2.4.1"]["girra-framework"])
	else require(Index["pysephwasntavailable_remotepacketsizecounter@2.4.1"]["remotepacketsizecounter"])
