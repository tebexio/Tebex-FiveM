print( "// API Client 0.1            //" )

TebexApiClient = {}
TebexApiClient.__index = TebexApiClient

function TebexApiClient:init(baseUrl, secret, timeout)
    local apiclient = {}

    setmetatable(apiclient,TebexApiClient)

    apiclient.baseUrl = baseUrl
    apiclient.secret = secret;

    if (timeout == nil) then
        timeout = 5000
    end

    apiclient.timeout = timeout

    return apiclient

end

function TebexApiClient:get(endpoint, success, failure)
    PerformHttpRequest(self.baseUrl .. endpoint, function(code, body, headers)
        if (body == nil) then
            Tebex.err("There was a problem sending this request. Please try again " .. code)
            return
        end
        tBody = json.decode(body)
        if (code == 200 or code == 204) then
            success(tBody)
            return
        end
        failure(tBody)
    end, 'GET', '', { ['X-Buycraft-Secret'] = apiclient.secret })
end

function TebexApiClient:delete(endpoint, success, failure)
    PerformHttpRequest(self.baseUrl .. endpoint, function(code, body, headers)
        if (body == nil) then
            Tebex.err("There was a problem sending this request. Please try again")
            return
        end
        tBody = json.decode(body)
        if (code == 200 or code == 204) then
            success(tBody)
            return
        end
        failure(tBody)
    end, 'DELETE', '', { ['X-Buycraft-Secret'] = apiclient.secret })
end