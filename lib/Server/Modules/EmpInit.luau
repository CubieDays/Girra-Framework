return function(EmployesFolder, Employes)
	if Employes then
		for _, Emp in EmployesFolder:GetDescendants() do
			if Emp:IsA("ModuleScript") then
				local sc, er = pcall(function()
					require(Emp)
				end)

				if not sc then
					warn("[", Emp.Name, "]", "Throwed Error:", "\n", "  ", er)
					Employes[Emp.Name] = nil
					task.wait()
					Emp = nil
				end
			end
		end
	end

	return {
		Wait = function()
			repeat
				task.wait()

			until Employes
		end,
	}
end
