aowl.AddCommand("rank", function(player, line, target, rank)
	local ent = easylua.FindEntity(target)

	if not ent:IsPlayer() then
		return false, "player not found"
	end

	if not rank then
		return false, "specify rank (ie: user)"
	end

	if ent:IsPlayer() and rank then
		rank = rank:lower():Trim()
		ent:SetUserGroup(rank, true)
		hook.Run("AowlTargetCommand", player, "rank", ent, rank)
		local s = ("set '%s' (%s) rank to %s"):format( ent:Name(), ent:SteamID64(), rank )
		aowlMsg("rank", s)
	end
end, "owners")