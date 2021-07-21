---@class LuaCord
LuaCord = setmetatable({}, LuaCord)

LuaCord.__call = function()
    return "LuaCord"
end

LuaCord.__index = LuaCord

function LuaCord.new(token)
    if type(token) ~= "string" then
        token = GetConvar("luacord_token", "")
    end
    if token == "" then
        print("^2[luacord]^7: ^1no token specified, please specify a token in the Luacord.new function or as a convar `luacord_token`^7")
    end
    local _LuaCord = {
        Token = token,
        BaseURL = "https://discord.com/api/v8"
    }

    return setmetatable(_LuaCord, LuaCord)
end

function LuaCord:CreateURL(url)
    return string.format("%s/%s", self.BaseURL, url)
end

function LuaCord:RestPost(url, data, cb)
    RestClient:Post(self:CreateURL(url), data, {
        Headers = { Authorization = "Bot " .. self.Token }
    }, function(response)
        cb(response:JSON())
    end)
end

function LuaCord:RestGet(url, cb)
    RestClient:Get(self:CreateURL(url), {
        Headers = {
            Authorization = "Bot " .. self.Token
        }
    }, function(response)
        cb(response:JSON())
    end)
end

function LuaCord:RestPut(url, data, cb)
    RestClient:Put(self:CreateURL(url), data, {
        Headers = { Authorization = "Bot " .. self.Token }
    }, function(response)
        cb(response:JSON())
    end)
end

function LuaCord:RestDelete(url, data, cb)
    RestClient:Delete(self:CreateURL(url), data, {
        Headers = { Authorization = "Bot " .. self.Token }
    }, function(response)
        cb(response:JSON())
    end)
end

function LuaCord:RestPatch(url, data, cb)
    RestClient:Patch(self:CreateURL(url), data, {
        Headers = { Authorization = "Bot " .. self.Token }
    }, function(response)
        print("^2[" .. response._Error .. "]^7")
        cb(response:JSON())
    end)
end