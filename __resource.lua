resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_script {
    'lua/server.lua',
    'lua/client/apiclient.lua',
    'lua/models/config.lua',
    'lua/commands/secret.lua',
    'lua/commands/info.lua',
    'lua/commands/forcecheck.lua',
    'lua/models/information.lua',
    'lua/models/commandrunner.lua',
    'lua/models/buycommand.lua',
    'lua/startup.lua',
}

server_only 'yes'