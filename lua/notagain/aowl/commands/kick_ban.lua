aowl.AddCommand("kick", function(ply, line, target, reason)
	local ent = easylua.FindEntity(target)

	if ent:IsPlayer() then
		local rsn = reason or "see you later"

		aowlMsg("kick", tostring(ply).. " kicked " .. tostring(ent) .. " for " .. rsn)
		hook.Run("AowlTargetCommand", ply, "kick", ent, rsn)

		return ent:Kick(rsn or "see you later")
	end

	return false, aowl.TargetNotFound(target)
end, "mods")

aowl.AddCommand("ban", function(ply, line, target, length, reason)
	local id = easylua.FindEntity(target)
	local ip

	if not length then length = 1440*3 end

	-- if length==0 then return false,"invalid ban length" end
	length = tonumber(length) or 1440*3

	local reason = ("You have been banned for %s.\n\n" ..
		"Welcome to the ban bubble. Duration of your stay: %s.")

		:format(
			reason or "being fucking annoying",
			(length == 0 and "two eternities") or string.NiceTime(length * 60)
		)

	if not id:IsPlayer() then return end

	ULib.ban(id, length, reason, ply)

end, "admins")