print( "// Config Library 0.1        //" )

TebexConfig = {}
TebexConfig.__index = TebexConfig

function TebexConfig:init()
    local config = {
        cfg = {
            buyEnabled = false,
            secret = "",
            buyCommand = "!donate",
            baseUrl = "https://plugin.tebex.io"
        }
    }

    configJson = LoadResourceFile(GetCurrentResourceName(), "./config.json")
    local tmpConfig = json.decode(configJson)

    if (tmpConfig.cfg.secret == nil) then
       print ( "No config exists, create" )
        configJson = json.encode(config)
        SaveResourceFile(GetCurrentResourceName(), "./config.json", configJson, -1)
    else
        config = tmpConfig
        print( "Config Loaded" )
    end

    setmetatable(config,TebexConfig)

    return config

end

function TebexConfig:get(key)
    if (self.cfg[key] == nil) then
        return false
    end

    return self.cfg[key]
end

function TebexConfig:set(key, value)
    self.cfg[key] = value
    configJson = json.encode(self)
    SaveResourceFile(GetCurrentResourceName(), "./config.json", configJson, -1)
end