print( "// Command tebex secret      //" )


Tebex.commands["secret"] = function(ply, args)
    if (args[2] == nil) then
        Tebex.err( "No secret provided" )
    end

    config:set("secret", args[2])
    apiclient = TebexApiClient:init(config:get("baseUrl"), config:get("secret"))
    apiclient:get("/information", function(response)
        TebexInformation.id = response["account"]["id"]
        TebexInformation.domain = response["account"]["domain"]
        TebexInformation.gameType = response["account"]["game_type"]
        TebexInformation.name = response["account"]["name"]
        TebexInformation.currency = response["account"]["currency"]["iso_4217"]
        TebexInformation.currencySymbol = response["account"]["currency"]["symbol"]
        TebexInformation.serverId = response["server"]["id"]
        TebexInformation.serverName = response["server"]["name"]

        Tebex.ok("Your secret key has been validated! Webstore Name: " .. TebexInformation.name);
    end, function(body)
        Tebex.err (body["error_message"])
    end)

    apiclient = nil
end