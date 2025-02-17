aowl.AddCommand("rcon", function(ply, line)
	line = line or ""

	if false and ply:IsUserGroup("developers") then
		for key, value in pairs(rcon_whitelist) do
			if not str:find(value, nil, 0) then
				return false, "cmd not in whitelist"
			end
		end

		for key, value in pairs(rcon_blacklist) do
			if str:find(value, nil, 0) then
				return false, "cmd is in blacklist"
			end
		end
	end

	game.ConsoleCommand(line .. "\n")

end, "developers")

aowl.AddCommand("cvar",function(pl,line,a,b)

	if b then
		local var = GetConVar(a)
		if var then
			local cur = var:GetString()
			RunConsoleCommand(a,b)
			timer.Simple(0.1,function()
				local new = var:GetString()
				pl:ChatPrint("ConVar: "..a..' '..cur..' -> '..new)
			end)
			return
		else
			return false,"ConVar "..a..' not found!'
		end
	end

	pcall(require,'cvar3')

	if not cvars.GetAllConVars then
		local var = GetConVar(a)
		if var then
			local val = var:GetString()
			if not tonumber(val) then val=string.format('%q',val) end

			pl:ChatPrint("ConVar: "..a..' '..tostring(val))
		else
			return false,"ConVar "..a..' not found!'
		end
	end
end,"developers")

aowl.AddCommand("cexec", function(ply, line, target, str,extra)
	local ent = easylua.FindEntity(target)

	if extra then return false,"too many parameters" end

	if ent:IsPlayer() then
		ent:SendLua(string.format("LocalPlayer():ConCommand(%q,true)", str))
		Msg("[cexec] ") print("from ",ply," to ",ent) print(string.format("LocalPlayer():ConCommand(%q,true)", str))
		hook.Run("AowlTargetCommand", ply, "cexec", ent, str)
		return
	end

	return false, aowl.TargetNotFound(target)
end, "developers")

aowl.AddCommand({"retry", "rejoin"}, function(ply, line, target)
	target = target and easylua.FindEntity(target) or nil

	if not IsValid(target) or not target:IsPlayer() then
		target = ply
	end

	target:SendLua("LocalPlayer():ConCommand('retry')")
end)