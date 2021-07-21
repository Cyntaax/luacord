---@class Guild
---@field Client RestClient
---@field ID string
Guild = setmetatable({}, Guild)

Guild.__call = function()
    return "Guild"
end

Guild.__index = Guild

function Guild.new(client, guildID)
    local _Guild = {
        Client = client,
        ID = guildID
    }

    return setmetatable(_Guild, Guild)
end

---@return LuaCord
function Guild:GetClient()
    return self.Client
end

---@param cb fun(emojis: Emoji[]): void
function Guild:GetEmojis(cb)
    self:GetClient():RestGet("/guilds/" .. self.ID .. "/emojis", function(data)
        ---@type Emoji[]
        local emojis = {}
        if type(data) == "table" then
            for k,v in pairs(data) do
                table.insert(emojis, Emoji.new(v))
            end
        end
        cb(emojis)
    end)
end

---@param cb fun(roles: GuildRole[]): void
function Guild:GetRoles(cb)
    self:GetClient():RestGet("/guilds/" .. self.ID .. "/roles", function(data)
        ---@type GuildRole[]
        local roles = {}
        if type(data) == "table" then
            for k,v in pairs(data) do
                table.insert(roles, GuildRole.new(client, v))
            end
        end

        cb(roles)
    end)
end

---@param snowflake string
---@param cb fun(member: GuildMember): void
function Guild:GetMember(snowflake, cb)
    self:GetClient():RestGet("/guilds/" .. self.ID .. "/members/" .. snowflake, function(data)
        if type(data) == "table" then
            data.Guild = self
            local member = GuildMember.new(self:GetClient(), data)
            cb(member)
        else
            cb()
        end
    end)
end

---@param cb fun(channels: GuildChannel[]): void
function Guild:GetChannels(cb)
    self:GetClient():RestGet("/guilds/" .. self.ID .. "/channels", function(data)
        ---@type GuildChannel[]
        local channels = {}
        if type(data) == "table" then
            for k,v in pairs(data) do
                v.Guild = self
                table.insert(channels, GuildChannel.new(self:GetClient(), v))
            end
        end
        cb(channels)
    end)
end

---@param cb fun(client, webhooks: GuildWebhook): void
function Guild:GetWebhooks(cb)
    self:GetClient():RestGet("/guilds/" .. self.ID .. "/webhooks", function(data)
        ---@type GuildWebhook
        local webhooks = {}
        if type(data) == "table" then
            for k,v in pairs(data) do
                v.Guild = self
                table.insert(webhooks, GuildWebhook.new(self:GetClient(), v))
            end
        end

        cb(webhooks)
    end)
end

---@param cb fun(channel: GuildChannel): void
function Guild:GetChannelByName(name, cb)
    self:GetChannels(client, function(channels)
        for k,v in pairs(channels) do
            if v.Name == name then
                cb(v)
                break
            end
        end
    end)
end

---@param cb fun(channel: GuildChannel): void
function Guild:GetChannelById(id, cb)
    self:GetChannels(function(channels)
        for k,v in pairs(channels) do
            if v.ID == id then
                cb(v)
                break
            end
        end
    end)
end

---@param cb fun(channel:GuildChannel[]): void
function Guild:GetCategories(cb)
    local tmpChans = {}
    self:GetChannels(function(channels)
        for k,v in pairs(channels) do
            if v.Type == GuildChannelType.Category then
                table.insert(tmpChans, v)
            end
        end
        cb(tmpChans)
    end)
end
