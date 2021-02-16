---@class GuildChannelData
GuildChannelData = {
    id = "",
    name = "",
    type = 0,
    topic = "",
    bitrate = 0,
    user_limit = 0,
    rate_limit_per_user = 0,
    position = 0,
    permission_overwrites = 0,
    parent_id = "",
    nsfw = false
}

---@class GuildChannel
GuildChannel = setmetatable({}, GuildChannel)

GuildChannel.__call = function()
    return "GuildChannel"
end

GuildChannel.__index = GuildChannel

---@param data GuildChannelData
function GuildChannel.new(client, data)
    local _GuildChannel = {
        Client = client,
        ID = data.id,
        Guild = data.Guild,
        Name = data.name,
        Type = data.type,
        Topic = data.topic,
        Bitrate = data.bitrate,
        UserLimit = data.user_limit,
        RateLimitPerUser = data.rate_limit_per_user,
        Position = data.position,
        PermissionOverwrites = data.permission_overwrites,
        ParentID = data.parent_id,
        NSFW = data.nsfw
    }

    return setmetatable(_GuildChannel, GuildChannel)
end

---@return LuaCord
function GuildChannel:GetClient()
    return self.Client
end

---@param cb fun(webhook: GuildWebhook): void
function GuildChannel:GetWebhook(cb)
    self.Guild:GetWebhooks(self:GetClient(), function(hooks)
        for k,v in pairs(hooks) do
            if v.ChannelID == self.ID then
                cb(v)
                break
            end
        end
    end)
end

function GuildChannel:SendMessage(message, cb)
    self:GetWebhook(function(hook)
        if hook == nil then print("no webhook for this channel!") cb(false) return end
        hook:SendMessage(message, function()
            cb()
        end)
    end)
end

---@param name string
function GuildChannel:SetName(name, cb)
    self:GetClient():RestPatch("/channels/" .. self.ID, {
        name = name
    }, function(resp)
        self:InternalRefresh(resp)
        if type(cb) == "function" then
            cb(resp)
        end
    end)
end

function GuildChannel:SetPosition(pos, cb)
    pos = tonumber(pos)
    if pos == nil then cb(false) return end
    self:GetClient():RestPatch("/channels/" .. self.ID, {
        position = pos
    }, function(resp)
        self:InternalRefresh(resp)
        if type(cb) == "function" then
            cb(resp)
        end
    end)
end

---@param topic string
function GuildChannel:SetTopic(topic, cb)
    self:GetClient():RestPatch("/channels/" .. self.ID, {
        topic = topic
    }, function(resp)
        self:InternalRefresh(resp)
        if type(cb) == "function" then
            cb(resp)
        end
    end)
end

---@param nsfw boolean
function GuildChannel:SetNSFW(nsfw, cb)
    self:GetClient():RestPatch("/channels/" .. self.ID, {
        nsfw = nsfw
    }, function(resp)
        self:InternalRefresh(resp)
        if type(cb) == "function" then
            cb(resp)
        end
    end)
end

function GuildChannel:SetRateLimit(rateLimit, cb)
    rateLimit = tonumber(rateLimit)
    if rateLimit == nil then cb(false) return end
    self:GetClient():RestPatch("/channels/" .. self.ID, {
        rate_limit_per_user = rateLimit
    }, function(resp)
        self:InternalRefresh(resp)
        if type(cb) == "function" then
            cb(resp)
        end
    end)
end

function GuildChannel:SetParent(id, cb)
    self:GetClient():RestPatch("/channels/" .. self.ID, {
        parent_id = id
    }, function(resp)
        self:InternalRefresh(resp)
        if type(cb) == "function" then
            cb(resp)
        end
    end)
end

---@return Guild
function GuildChannel:GetGuild()
    return self.Guild
end

function GuildChannel:InternalRefresh(data)
    if type(data) == "table" then
        self.ID = data.id
        self.Guild = data.Guild
        self.Name = data.name
        self.Type = data.type
        self.Topic = data.topic
        self.Bitrate = data.bitrate
        self.UserLimit = data.user_limit
        self.RateLimitPerUser = data.rate_limit_per_user
        self.Position = data.position
        self.PermissionOverwrites = data.permission_overwrites
        self.ParentID = data.parent_id
        self.NSFW = data.nsfw
        return
    end
end

GuildChannelType = {
    Text = 0,
    DM = 1,
    Voice = 2,
    GroupDM = 3,
    Category = 4,
    News = 5,
    Store = 6
}