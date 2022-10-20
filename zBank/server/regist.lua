if register_item then 
    itemsbank = {
        {name = carditem, label = carditemlabel, weight = 0.1, rare = 0, can_remove = 1},
    }

    Citizen.CreateThread(function()
            
            for _,i in pairs(itemsbank) do
                MySQL.Async.execute('DELETE FROM items WHERE name = @name',
                {['name'] = i.name},
                function(affectedRows)
                    if affectedRows ~= 0 then
                        print("^2Item: ^1Deleted ^7item "..i.name)
                    end

                    MySQL.Sync.execute("INSERT INTO items (items.name, items.label, items.weight, items.rare, items.can_remove) VALUES (@name, @label, @weight, @rare, @can_remove)", {
                        ['@name'] = i.name, 
                        ["@label"] = i.label, 
                        ["@weight"] = i.weight, 
                        ["@rare"] = i.rare, 
                        ["@can_remove"] = i.can_remove,
                    })
                    print("^2Item: ^7Added item "..i.name, i.label)
                end)

            end
    end)
end