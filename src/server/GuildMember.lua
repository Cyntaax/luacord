---@class GuildMemberData
GuildMemberData = {
    user = {},
    nick = "",
    roles = {},
    joined_at = "",
    premium_since = "",
    deaf = false,
    mute = false,
    pending = false,
    permissions = ""
}

---@class GuildMember
---@field Client RestClient
---@field Guild Guild
---@field User GuildMemberData
---@field Nick string
---@field Roles string[]
---@field JoinedAt string
---@field PremiumSince string
---@field Deaf boolean
---@field Mute boolean
---@field Pending boolean
---@field Permissions number
GuildMember = setmetatable({}, GuildMember)

GuildMember.__call = function()
    return "GuildMember"
end

GuildMember.__index = GuildMember

---@param data GuildMemberData
function GuildMember.new(client, data)
    local _GuildMember = {
        Client = client,
        Guild = data.Guild,
        User = data.user,
        Nick = data.nick,
        Roles = data.roles,
        JoinedAt = data.joined_at,
        PremiumSince = data.premium_since,
        Deaf = data.deaf,
        Mute = data.mute,
        Pending = data.pending,
        Permissions = data.permissions
    }

    return setmetatable(_GuildMember, GuildMember)
end

---@return LuaCord
function GuildMember:GetClient()
    return self.Client
end

---@param cb fun(roles: GuildRole[]): void
function GuildMember:GetRoles(cb)
    ---@type GuildRole[]
    local tmpRoles = {}
    self:GetGuild():GetRoles(self:GetClient(),function(roles)
        for k,v in pairs(roles) do
            for b,z in pairs(self.Roles) do
                if v.ID == z then
                    table.insert(tmpRoles, v)
                end
            end
        end

        cb(tmpRoles)
    end)
end

---@return Guild
function GuildMember:GetGuild()
    return self.Guild
end

---@param name string
---@param cb fun(hasRole: boolean): void
function GuildMember:HasRole(name, cb)
    self:GetRoles(function(roles)
        for k,v in pairs(roles) do
            print("checking", v.Name)
            if v.Name == name then
                cb(true)
                return
            end
        end
        cb(false)
    end)
end
