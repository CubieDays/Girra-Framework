local Framework = require(game.ReplicatedStorage.Girra):GetClient()

local SpeedEmploy = Framework.CreateEmployee()({
	Name = "Employee",
})

function SpeedEmploy:OnHire()
	--> Varibles
	local Data = "Result Of:"
	local Num1 = 5
	local Num2 = 5

	local Mathematic = Num1 + Num2
	local NonMathematic = Num1 .. " + " .. Num2 .. " ="

	--> Action
	print(Data, NonMathematic, Mathematic)

	return function()
		print("Fired")
	end
end

function SpeedEmploy:OnWork()
	print("Hello World", "From Employ With a Success!")
end

return SpeedEmploy
