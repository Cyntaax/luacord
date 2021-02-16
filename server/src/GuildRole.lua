---@class GuildRoleData
GuildRoleData = {
    id = "",
    name = "",
    color = 0,
    hoist = false,
    position = 0,
    permissions = "",
    managed = false,
    mentionable = true,
    tags = {}
}

---@class GuildRole
GuildRole = setmetatable({}, GuildRole)

GuildRole.__call = function()
    return GuildRole
end

GuildRole.__index = GuildRole

---@param guildRoleData GuildRoleData
function GuildRole.new(client, guildRoleData)
    local _GuildRole = {
        Client = client,
        ID = guildRoleData.id,
        Name = guildRoleData.name,
        Color = guildRoleData.color,
        Hoist = guildRoleData.hoist,
        Position = guildRoleData.position,
        Permissions = guildRoleData.permissions,
        Managed = guildRoleData.managed,
        Mentionable = guildRoleData.mentionable,
        Tags = guildRoleData.tags
    }

    return setmetatable(_GuildRole, GuildRole)
end

---@return LuaCord
function GuildRole:GetClient()
    return self.Client
end

function GuildRole:HexColor()
    return DecToHex(self.Color)
end