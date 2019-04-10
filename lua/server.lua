if not Tebex then
	Tebex = {}
	Tebex.commands = {}

	Tebex.nextCheck = 15 * 60
	Tebex.lastCalled = os.time() - 14 * 60

	Tebex.warn = function ( msg )
		print (msg)
	end

	Tebex.err = function ( msg )
		print (msg)
	end

	Tebex.ok = function ( msg )
		print (msg)
	end

	Tebex.getSteamId = function ( hexSteamId )
		return tonumber(hexSteamId,16)
	end

	Tebex.getHexSteamId = function ( steamId )
		return string.format("%x", steamId)
	end

	Tebex.getPlayerByName = function ( name )
		local players = GetPlayers()

		for id, _ in pairs(players) do
			if name == GetPlayerName(id) then
				return id
			end
		end
		return false
	end

	Tebex.getPlayerBySteamId = function ( steamId )
		local players = GetPlayers()
		local steamHash = Tebex.getHexSteamId(steamId);
		for id, _ in pairs(players) do
			for idx, value in pairs(GetPlayerIdentifiers(id)) do
				if value == "steam:" .. steamHash then
					return id
				end
			end
		end
		return false
	end

	print( "\n///////////////////////////////" )
	print( "//      TebexFiveM v0.1      //" )
	print( "//   https://www.tebex.io/   //" )
	print( "///////////////////////////////" )
	print( "// Loading...                //" )


end
