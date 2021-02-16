---@class GuildWebhookData
GuildWebhookData = {
    id = "",
    type = 0,
    guild_id = "",
    channel_id = "",
    user = {},
    name = "",
    avatar = "",
    token = "",
    application_id = ""
}

---@class GuildWebhook
GuildWebhook = setmetatable({}, GuildWebhook)

GuildWebhook.__call = function()
    return "GuildWebhook"
end

GuildWebhook.__index = GuildWebhook

---@param data GuildWebhookData
function GuildWebhook.new(client, data)
    local _GuildWebhook = {
        Client = client,
        ID = data.id,
        Guild = data.Guild,
        Name = data.name,
        Type = data.type,
        GuildID = data.guild_id,
        ChannelID = data.channel_id,
        User = data.user,
        Avatar = data.avatar,
        Token = data.token,
        ApplicationID = data.application_id
    }

    return setmetatable(_GuildWebhook, GuildWebhook)
end

function GuildWebhook:GetClient()
    return self.Client
end

function GuildWebhook:SendMessage(message, cb)
    local body = {
        content = message
    }
    PerformHttpRequest("https://discord.com/api/webhooks/" .. self.ID .. "/" .. self.Token, function(err, data, headers)
        cb(data)
    end, "POST", json.encode(body), {["Content-Type"] = "application/json"})
end