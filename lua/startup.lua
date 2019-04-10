print( "///////////////////////////////\n" )

config = TebexConfig:init()

RegisterCommand("tebex", function(ply, args, raw)

	if (args[1] == nil) then
		--Help!
		return
	end

	if (Tebex.commands[args[1]] == nil) then
		print( "Unknown command \"tebex " .. args[1] .. "\"" )
		return
	end

	Tebex.commands[args[1]](ply, args);

end, true)


Tebex.doCheck = function ()
	if ((os.time() - Tebex.lastCalled) > Tebex.nextCheck) then
		Tebex.lastCalled = os.time()
		Tebex.commands["forcecheck"](nil, {"forcecheck"})
	end
end



if (config:get("secret") == "") then
	Tebex.err( "You have not yet defined your secret key. Use tebex secret <secret> to define your key" )
	Citizen.CreateThread(function()
		Citizen.Wait(5000)
		Tebex.commands["info"](nil, {"info"})
	end)
end



Tebex.ok("Starting Tebex_FiveM 0.1")

Citizen.CreateThread(function()
	while true do
		if (config:get("secret") ~= "") then
			Tebex.doCheck()
		end
		Citizen.Wait(10000)
	end
end)


