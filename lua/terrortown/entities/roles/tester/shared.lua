if SERVER then
    AddCSLuaFile()

	util.AddNetworkString("ttt2_test_role_popup")
end

function ROLE:PreInitialize()
    self.color                      = Color(209, 98, 90, 255)

	self.abbr                       = "test"
	self.surviveBonus               = 0
	self.score.killsMultiplier      = 2
	self.score.teamKillsMultiplier  = -8
	self.preventFindCredits         = false
	self.preventKillCredits         = false
	self.preventTraitorAloneCredits = false
	self.preventWin                 = false
	self.unknownTeam                = false

	self.defaultTeam                = TEAM_TRAITOR

	self.conVarData = {
		pct          = 0.15, -- necessary: percentage of getting this role selected (per player)
		maximum      = 1, -- maximum amount of roles in a round
		minPlayers   = 7, -- minimum amount of players until this role is able to get selected
		credits      = 2, -- the starting credits of a specific role
		shopFallback = SHOP_FALLBACK_DETECTIVE, -- granting the role access to the shop
		togglable    = true, -- option to toggle a role for a client if possible (F1 menu)
		random       = 33
	}
end

function ROLE:Initialize()
    roles.SetBaseRole(self, ROLE_TRAITOR)
end

if SERVER then
	
	hook.Add("PlayerDeath", "ttt2_heal_up_tester", function( victim, inflictor, attacker)
		if victim:GetSubRole() == ROLE_TESTER then return end
		if SpecDM and (victim.IsGhost() and victim:IsGhost()) then return end
		if victim:GetTeam() ~= TEAM_TRAITOR then return end

		-- cache ConVar values
		local hp_above = GetConVar("ttt_tester_health_above_100"):GetInt()
		local hp_below = GetConVar("ttt_tester_health_beneath_100"):GetInt()
		local cv_send_popup = GetConVar("ttt_tester_send_popup"):GetBool()

		local plys = player.GetAll()

		for i = 1, #plys do
			local ply = plys[i]

			if ply:GetSubRole() == ROLE_TESTER and ply:Alive() then

				-- is the player's health beneath 100, he gains an amount of hp
				if ply:Health() < ply:GetMaxHealth() then

					ply:SetHealth(hp_below)

					-- if convar is set, players receive the pop-up
					if cv_send_popup then
						net.Start("ttt2_test_role_popup")
						net.Broadcast()
					end

				else	 -- is the player's health above 100, he gains another amount of hp

					ply:SetHealth(hp_above)

					-- if convar is set, players receive the pop-up
					if cv_send_popup then
						net.Start("ttt2_test_role_popup")
						net.Broadcast()
					end

				end
			end
		end	
	end)
end

if CLIENT then
	net.Receive("ttt2_test_role_popup", function()
		EPOP:AddMessage({text = LANG.GetTranslation("ttt2_role_tester_epop"), color = TESTER.ltcolor}, "", 10)
	end)
end