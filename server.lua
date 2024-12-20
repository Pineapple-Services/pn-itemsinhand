local ox_inventory = exports.ox_inventory

ox_inventory:registerHook('swapItems', function(payload)
    if payload.toType == "player" then
        for itemName, prop in pairs(Config.Items) do
            if ox_inventory:Search(payload.source, "count", itemName) > 0 then
                return false
            end
        end
    end
end, {
    print = true,
    itemFilter = Config.Items,
})
