local Tests = require("tests")   -- common tests
package.path = package.path .. ";../?.lua;"
local Deque = require("deque")  -- import Deque

function main()
    local my_deque = Deque:new()
    print("Created deque: my_deque")
    print("my_deque:is_empty()=" .. tostring(my_deque:is_empty()))
    print("String representation:" .. tostring(my_deque))
    print("\nAdding first: 1 to 5")
    for i = 1, 5 do
        my_deque:add_first(i)
    end
    print("my_deque=" .. tostring(my_deque))
    print("#my_deque=" .. tostring(#my_deque))
    print("my_deque:is_empty()=" .. tostring(my_deque:is_empty()))
    print("\nAdding last: 'a' to 'e'")
    for i = 97, 97+4 do
        my_deque:add_last(string.char(i))
    end
    print("my_deque=" .. tostring(my_deque))

    print("\nDeleting first: 3 times")
    for i = 1, 3 do
        print("DELETED: " .. tostring(my_deque:delete_first(i)))
    end
    print("my_deque=" .. tostring(my_deque))

    print("\nDeleting last: 3 times")
    for i = 1, 3 do
        print("DELETED: " .. tostring(my_deque:delete_last(i)))
    end
    print("my_deque=" .. tostring(my_deque))

    print("\nAdd_first 500,000 items test")
    local new_deque = Deque:new()
    local add_first_500k_items = Tests.time_test(
        function()
           for i = 1, 500000 do
                new_deque:add_first(i)
            end 
        end
    )
    print("Elapsed time: " .. add_first_500k_items .. " seconds")

    print("\nAdd_last 500,000 items test")
    local add_last_500k_items = Tests.time_test(
        function()
           for i = 1, 500000 do
                new_deque:add_last(i)
            end 
        end
    )
    print("Elapsed time: " .. add_last_500k_items .. " seconds")

    print("\nDelete_first 500,000 items test")
    local delete_first_500k_items = Tests.time_test(
        function()
           for i = 1, 500000 do
                new_deque:delete_first(i)
            end 
        end
    )
    print("Elapsed time: " .. delete_first_500k_items .. " seconds")

    print("\nDelete_last 500,000 items test")
    local delete_last_500k_items = Tests.time_test(
        function()
            for i = 1, 500000 do
                new_deque:delete_last(i)
            end 
        end
    )
    print("Elapsed time: " .. delete_last_500k_items .. " seconds")

    print("\nTotal time to add 1,000,000 items: " .. 
        add_first_500k_items + add_last_500k_items
        .. " seconds"
    )
    print("Total time to delete 1,000,000 items: " .. 
        delete_first_500k_items + delete_last_500k_items
        .. " seconds"
    )
    print("Total time: "
        .. add_first_500k_items
        + add_last_500k_items
        + delete_first_500k_items
        + delete_last_500k_items
        .. " seconds"
    )
end

if ... == nil then
    main()
end