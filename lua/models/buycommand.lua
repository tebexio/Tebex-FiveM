print( "// Buy Command v0.1          //" )

AddEventHandler('chatMessage', function(ply, n, text)
    if ( string.lower( text ) == config:get("buyCommand") ) then
        --ply:ChatPrint( "To buy packages from our webstore, please visit: " .. TebexInformation.domain )
        --ply:SendLua("gui.OpenURL( '" .. TebexInformation.domain .. "' )")
        TriggerClientEvent('chatMessage', ply, "", {0,0,0}, "To buy packages from our webstore, please visit: " .. TebexInformation.domain )
        return ""
    end
end )
