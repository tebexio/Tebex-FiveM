print( "// CommandRunner v0.1        //" )

TebexCommandRunner = {}
TebexCommandRunner.deleteAfter = 3

TebexCommandRunner.doOfflineCommands = function()
    apiclient = TebexApiClient:init(config:get("baseUrl"), config:get("secret"))
    apiclient:get("/queue/offline-commands", function(response)
        commands = response.commands
        exCount = 0
        executedCommands = {}

        for key,cmd in pairs(commands) do
            commandToRun = TebexCommandRunner.buildCommand(cmd["command"], cmd["player"]["name"], cmd["player"]["uuid"])

            Tebex.warn("Run command " .. commandToRun)
            ExecuteCommand( commandToRun )

            table.insert(executedCommands, cmd["id"])
            exCount = exCount + 1

            if (exCount % TebexCommandRunner.deleteAfter == 0) then
                TebexCommandRunner.deleteCommands(executedCommands)
                executedCommands = {}
            end
        end

        Tebex.ok(exCount .. " offline commands executed")
        if (exCount % TebexCommandRunner.deleteAfter > 0) then
            TebexCommandRunner.deleteCommands(executedCommands)
            executedCommands = {}
        end
    end, function(body)
        print (body["error_code"] .. " " .. body["error_message"])
    end)
    apiclient = nil

end

TebexCommandRunner.doOnlineCommands = function(playerPluginId, playerName, playerId)
    Tebex.warn("Running online commands for " .. playerName .. " (" .. playerId .. ")");
    apiclient = TebexApiClient:init(config:get("baseUrl"), config:get("secret"))
    apiclient:get("/queue/online-commands/" .. playerPluginId, function(response)
        commands = response.commands
        exCount = 0
        executedCommands = {}

        for key,cmd in pairs(commands) do
            commandToRun = TebexCommandRunner.buildCommand(cmd["command"], playerName, playerId)

            Tebex.warn("Run command " .. commandToRun)
            ExecuteCommand( commandToRun )

            table.insert(executedCommands, cmd["id"])
            exCount = exCount + 1

            if (exCount % TebexCommandRunner.deleteAfter == 0) then
                TebexCommandRunner.deleteCommands(executedCommands)
                executedCommands = {}
            end
        end

        Tebex.ok(exCount .. " online commands executed for " .. playerName)
        if (exCount % TebexCommandRunner.deleteAfter > 0) then
            TebexCommandRunner.deleteCommands(executedCommands)
            executedCommands = {}
        end
    end, function(body)
        print (body["error_code"] .. " " .. body["error_message"])
    end)

    apiclient = nil

end


TebexCommandRunner.buildCommand = function(cmd, username, id)
    cmd = cmd:gsub("{id}", id);
    cmd = cmd:gsub("{username}", username);
    cmd = cmd:gsub("{hexid}", "steam:" .. Tebex.getHexSteamId(id));

    return cmd .. "\n";
end

TebexCommandRunner.deleteCommands = function(commandIds)
    endpoint = "/queue?"
    amp = ""
    for key,commandId in pairs(commandIds) do
        endpoint = endpoint .. amp .. "ids[]=" .. commandId;
        amp = "&"
    end

    apiclient = TebexApiClient:init(config:get("baseUrl"), config:get("secret"))
    apiclient:delete(endpoint, function(response)
    end, function(body)
        print (body["error_code"] .. " " .. body["error_message"])
    end)
    apiclient = nil
end