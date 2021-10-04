-- replicated convars have to be created on both client and server
CreateConVar("ttt_tester_health_above_100", 200, {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED})
CreateConVar("ttt_tester_health_beneath_100", 125, {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED})
CreateConVar("ttt_tester_send_popup", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED})

hook.Add("TTTUlxDynamicRCVars", "ttt2_ulx_dynamic_tester_convars", function(tbl)
    tbl[ROLE_TESTER] = tbl[ROLE_TESTER] or {}

    table.insert(tbl[ROLE_TESTER], {
        cvar = "ttt_tester_health_above_100",
		slider = true,
		min = 0,
		max = 500,
		decimal = 0,
		desc = "ttt_tester_health_above_100 (def. 200)"
	})

    table.insert(tbl[ROLE_TESTER], {
        cvar = "ttt_tester_health_beneath_100",
		slider = true,
		min = 0,
		max = 500,
		decimal = 0,
		desc = "ttt_tester_health_beneath_100 (def. 125)"
	})

    table.insert(tbl[ROLE_TESTER], {
		cvar = "ttt_tester_send_popup",
		checkbox = true,
		desc = "ttt_tester_send_popup (def. 1)"
	})
end)