local luacord = LuaCord.new()

RegisterCommand('lctest', function()
    local guild = Guild.new(luacord, "513933862938869770")

    guild:GetChannelById("732605771627364434", function(channel)
        guild:GetCategories(function(categories)
            for k,v in pairs(categories) do
                if string.lower(v.Name) == "issues" then
                    channel:SetParent(v.ID)
                end
            end
        end)
    end)
end)