---@class EmojiData
EmojiData = {
    id = "",
    name = "",
    roles = {},
    user = {},
    require_colons = false,
    managed = false,
    animated = false,
    available = true
}

---@class Emoji
Emoji = setmetatable({}, Emoji)

Emoji.__call = function()
    return "Emoji"
end

Emoji.__index = Emoji

---@param emojiData EmojiData
function Emoji.new(emojiData)
    local _Emoji = {
        ID = emojiData.id,
        Name = emojiData.name,
        Roles = emojiData.roles,
        User = emojiData.user,
        RequireColons = emojiData.require_colons,
        Managed = emojiData.managed,
        Animated = emojiData.animated,
        Available = emojiData.available
    }

    return setmetatable(_Emoji, Emoji)
end

function Emoji:URL()
    return "https://cdn.discordapp.com/emojis/" .. self.ID .. ".png"
end

function Emoji:Usage()
    if self.RequireColons == true then
        return ":" .. self.Name .. ":"
    else
        return self.Name
    end
end