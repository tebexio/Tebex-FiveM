print( "// Command tebex forcecheck  //" )


Tebex.commands["forcecheck"] = function(ply, args)
    Tebex.warn("Checking for commands to be executed...");
    apiclient = TebexApiClient:init(config:get("baseUrl"), config:get("secret"))
    apiclient:get("/queue", function(response)

        if (response["meta"]["next_check"] > 0) then
            Tebex.nextCheck = response["meta"]["next_check"]
        end

        if (response["meta"]["execute_offline"] == true) then
            TebexCommandRunner.doOfflineCommands()
        end

        players = response["players"]

        for key,plr in pairs(players) do
            steamId = plr["uuid"]
            targetPlayer = Tebex.getPlayerBySteamId(steamId);

            if (targetPlayer and GetPlayerPing(targetPlayer)) then
                Tebex.warn("Execute commands for " .. GetPlayerName(targetPlayer) .. "(ID: " .. steamId .. ")");
                TebexCommandRunner.doOnlineCommands(plr["id"], GetPlayerName(targetPlayer), steamId);
            end

        end
    end)

    apiclient = nil
end