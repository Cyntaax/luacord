RestClient = {}

---@class RestClientOptions
RestClientOptions = {
    Headers = {}
}

---@param url string
---@param options RestClientOptions
---@param cb fun(response: RestResponse): void
function RestClient:Get(url, options, cb)
    PerformHttpRequest(url, function(err, data, headers)
        local response = RestResponse.new(err, data, headers)
        cb(response)
    end, "GET", "", options.Headers or {})
end

---@param url string
---@param body table
---@param options RestClientOptions
---@param cb fun(response: RestResponse): void
function RestClient:Post(url, body, options, cb)
    if type(body) == "table" then body = json.encode(body) end
    options.Headers = options.Headers or {}
    if not options.Headers["Content-Type"] then
        options.Headers["Content-Type"] = "application/json"
    end
    PerformHttpRequest(url, function(err, data, headers)
        local response = RestResponse.new(err, data, headers)
        cb(response)
    end, "POST", body, options.Headers)
end

function RestClient:Patch(url, body, options, cb)
    if type(body) == "table" then body = json.encode(body) end
    options.Headers = options.Headers or {}
    if not options.Headers["Content-Type"] then
        options.Headers["Content-Type"] = "application/json"
    end
    PerformHttpRequest(url, function(...)
        local respStuff = { ... }
        local err = respStuff[1]
        local data = respStuff[2]
        local headers = respStuff[3]
        for k,v in pairs(respStuff) do
            print(k,v)
            if type(v) == "table" then
                print(json.encode(v))
            end
        end
        local response = RestResponse.new(err, data, headers)
        cb(response)
    end, "PATCH", body, options.Headers)
end

function RestClient:Delete(url, body, options, cb)
    if type(body) == "table" then body = json.encode(body) end
    options.Headers = options.Headers or {}
    if not options.Headers["Content-Type"] then
        options.Headers["Content-Type"] = "application/json"
    end
    PerformHttpRequest(url, function(err, data, headers)
        local response = RestResponse.new(err, data, headers)
        cb(response)
    end, "DELETE", body, options.Headers)
end

function RestClient:Put(url, body, options, cb)
    if type(body) == "table" then body = json.encode(body) end
    options.Headers = options.Headers or {}
    if not options.Headers["Content-Type"] then
        options.Headers["Content-Type"] = "application/json"
    end
    PerformHttpRequest(url, function(err, data, headers)
        local response = RestResponse.new(err, data, headers)
        cb(response)
    end, "PUT", body, options.Headers)
end

---@class RestResponse
RestResponse = setmetatable({}, RestResponse)

RestResponse.__call = function()
    return "RestResponse"
end

RestResponse.__index = RestResponse

function RestResponse.new(error, data, headers)
    local _RestResponse = {
        _Error = error,
        _Data = data,
        _Headers = headers
    }

    return setmetatable(_RestResponse, RestResponse)
end

function RestResponse:JSON()
    if self._Data == nil then
        return {}
    end
    return json.decode(self._Data)
end