return function(JobsFolder, Jobs)
	if Jobs then
		for _, Job in JobsFolder:GetDescendants() do
			if Job:IsA("ModuleScript") then
				local sc, er = pcall(function()
					require(Job)
				end)

				if not sc then
					warn("[", Job.Name, "]", "Throwed Error:", "\n", "  ", er)
					Jobs[Job.Name] = nil
					task.wait()
					Job = nil
				end
			end
		end
	end

	return {
		Wait = function()
			repeat
				task.wait()

			until Jobs
		end,
	}
end
